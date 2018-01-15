package gq.bookfarm.model;

import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.BasketDAO;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.BasketVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.ProductVO;

public class BasketAddAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;

	public BasketAddAction(String path) 
	{
		super();
		this.path = path;
		log.debug("BasketAddAction Constructor. Destination path = " + path);
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("BasketAddAction execute Start.");

		int		quantity	= 1;
		String	options		= "";
		
		quantity			= Integer.parseInt(req.getParameter("quantity"));
		log.debug("BasketAddAction execute Start.111111 quantity="+quantity);
		options				= req.getParameter("options");
		log.debug("BasketAddAction execute Start.22222 options="+options);
		int		curPage		= Integer.parseInt(req.getParameter("page"));
		log.debug("BasketAddAction execute Start.333333 curPage="+curPage);
		int		result		= 0;
		
		HttpSession			session		= req.getSession();
		CustomerVO			customerVO	= (CustomerVO) session.getAttribute("loggedInUserVO");
		if (customerVO == null)			log.debug("BasketAddAction execute Start.customerVO null");
		ProductVO			productVO	= (ProductVO) session.getAttribute("productVO");
		if (productVO == null)			log.debug("BasketAddAction execute Start.productVO null");
		Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
		if (baskets == null)			log.debug("BasketAddAction execute Start.baskets null");
		
		
		
		
		
		Enumeration enum_app=session.getAttributeNames();
		while(enum_app.hasMoreElements()){
			String ls_name=enum_app.nextElement().toString();
			String ls_value=session.getAttribute(ls_name).toString();
	
			log.debug("QQQQQ Session Key: "+ls_name);
			log.debug("QQQQQ Session Value: "+ls_value);
		}
		
		
		
		
		
		
		
		if (baskets == null)			baskets = new Vector<BasketVO>();
		if (productVO == null) {
			log.error("BasketAddAction Product null Error");
			path="error.jsp";
			return new ActionForward(path, false);
		}
		
		BasketVO			basketVO	= new BasketVO();
		BasketDAO			dao			= new BasketDAO();

		if (customerVO != null)		basketVO.setCustomer_idx(customerVO.getIdx());
		else						basketVO.setCustomer_idx(0);
		
		basketVO.setProduct_idx(productVO.getIdx());
		basketVO.setQuantity(quantity);
		basketVO.setOptions(options);
		basketVO.setFinal_price(productVO.getProduct_price());
		
		if (customerVO != null)		result	=	dao.basketInsert(basketVO);
		baskets.addElement(basketVO);
		
		if(result <= 0) {
			log.debug("BasketAddAction execute Failed!!!!!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}

		log.debug("BasketAddAction execute End.");
		return new ActionForward(path, false);
	}
}