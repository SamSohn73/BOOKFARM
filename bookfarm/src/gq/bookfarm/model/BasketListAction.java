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
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.BasketVO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;

public class BasketListAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;


	public BasketListAction(String path) 
	{
		super();
		this.path = path;
		log.debug("BasketListAction Constructor. Destination path = " + path);
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("BasketListAction execute Start.");

		HttpSession			session		= req.getSession();
		CustomerVO			customerVO	= (CustomerVO) session.getAttribute("loggedInUserVO");
		Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
		Vector<ProductVO>	products	= (Vector<ProductVO>) session.getAttribute("products");
		
/*		if (customerVO != null && baskets == null) {
			log.debug("Customer " + customerVO.getUsername() + " with empty basket in the session. start to check from DB");
			BasketDAO			basketDAO	= new BasketDAO();
			Vector<BasketVO>	basketsDB	= basketDAO.basketListbyCustomer_idx(customerVO.getIdx());
			baskets							= basketsDB;
			session							.setAttribute("baskets", baskets);
			
			for (BasketVO basket:baskets) {
				ProductVO	tempVO		= new ProductVO();
				ProductDAO	productDAO	= new ProductDAO();
				
				tempVO = productDAO.productGetRow(basket.getProduct_idx());
				products.add(tempVO);
			}
			session.setAttribute("products", products);
		}*/

		log.debug("BasketListAction execute End.");
		return new ActionForward(path, false);
	}
}

