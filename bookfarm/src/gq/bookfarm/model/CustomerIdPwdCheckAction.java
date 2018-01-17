package gq.bookfarm.model;

import java.util.Iterator;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.BasketDAO;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.BasketVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.ProductVO;

public class CustomerIdPwdCheckAction implements Action
{
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
		
	public CustomerIdPwdCheckAction(String path)
	{
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		String		username	=	req.getParameter("username");
		String		password	=	req.getParameter("password");
		String		type		=	req.getParameter("type");
		int			result		=	0;
		
		CustomerDAO	dao			=	new	CustomerDAO();
		CustomerVO	customerVO	=	new	CustomerVO();
		CustomerVO	LoginedVO	=	null;
		HttpSession	session		=	req.getSession();
		
		if(type.equals("modify")) {
			LoginedVO	=	(CustomerVO)session.getAttribute("loggedInUserVO");
			customerVO	=	dao.pwdCheck(username, password);
			if(LoginedVO.getIdx()==customerVO.getIdx()) {
				path	=	"./CustomerRegistSetting.do?type=modify";
				result	=	customerVO.getIdx();
			}
		}
		else if(type.equals("login")) {
			customerVO	=	dao.pwdCheck(username, password);
			if(customerVO != null) {
				session	.setAttribute("loggedInUserVO", customerVO);
				result	= dao.login(customerVO.getIdx());
				/*QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ Start*/
				log.debug("CustomerIdPwdCheckAction basket management start.");
				Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
				Vector<ProductVO>	products	= (Vector<ProductVO>) session.getAttribute("products");
				
				BasketDAO			basketDAO	= new BasketDAO();
				if (baskets != null) {
					log.debug("CustomerIdPwdCheckAction Customer " + customerVO.getUsername() + " with something in the basket in the session before login. start to update DB.");
					// Insert baskets to DB
					for (BasketVO basket:baskets) {
						basket.setCustomer_idx(customerVO.getIdx());
						basketDAO.basketInsert(basket);
					}
				}
				// getting baskets from DB
				baskets = basketDAO.basketListbyCustomer_idx(customerVO.getIdx());
				session.setAttribute("baskets", baskets);
				
				// getting products from DB
				products = new Vector<ProductVO>();
				for (BasketVO basket:baskets) {
					ProductVO	tempVO		= new ProductVO();
					ProductDAO	productDAO	= new ProductDAO();
					
					tempVO = productDAO.productGetRow(basket.getProduct_idx());
					if (tempVO != null)		products.add(tempVO);
				}
				session.setAttribute("products", products);
				log.debug("CustomerIdPwdCheckAction basket management End.");
				/*QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ End*/
			} else {
				log.error("CustomerIdPwdCheckAction error : DB can not get customer data");
				path	=	"error.jsp?type=login";
			}
		}
		
		//result check
		if(result>0) {
			log.info("Successfully logined...or modify check is Ok!!!!!!");
		}
		else {
			log.error("CustomerIdPwdCheckAction error :"
			+ " DB can not get customer data or customer's id,pass were wrong..");
			path		=	"error.jsp";	
		}
			
		return new ActionForward(path, true);
	}

}
