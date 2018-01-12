package gq.bookfarm.model;

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
		log.debug("BasketAddAction execute Start.111111");
		options				= req.getParameter("options");
		log.debug("BasketAddAction execute Start.22222");
		int		curPage		= Integer.parseInt(req.getParameter("page"));
		log.debug("BasketAddAction execute Start.333333");
		int		result		= 0;
		
		HttpSession			session		= req.getSession();
		CustomerVO			customerVO	= (CustomerVO) session.getAttribute("loggedInUserVO");
		log.debug("BasketAddAction execute Start.4444444");
		ProductVO			productVO	= (ProductVO) session.getAttribute("productVO");
		log.debug("BasketAddAction execute Start.55555555");
		Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
		log.debug("BasketAddAction execute Start.666666666");
		
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
