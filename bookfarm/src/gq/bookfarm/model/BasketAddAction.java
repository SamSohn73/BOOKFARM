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
		options				= req.getParameter("options");
		int		curPage		= Integer.parseInt(req.getParameter("page"));
		int		result		= 0;
		
		HttpSession			session		= req.getSession();
		CustomerVO			customerVO	= (CustomerVO)			session.getAttribute("loggedInUserVO");
		ProductVO			productVO	= (ProductVO)			session.getAttribute("productVO");
		Vector<BasketVO>	baskets		= (Vector<BasketVO>)	session.getAttribute("baskets");
		Vector<ProductVO>	products	= (Vector<ProductVO>)	session.getAttribute("products");

/*		Enumeration enum_app=session.getAttributeNames();
		while(enum_app.hasMoreElements()){
			String ls_name=enum_app.nextElement().toString();
			String ls_value=session.getAttribute(ls_name).toString();
			log.debug("BasketAddAction Session Key:Value = "+ls_name + ":" + ls_value);
		}*/
		
		if (productVO == null) {
			log.error("BasketAddAction Product null Error");
			path="error.html";
			return new ActionForward(path, false);
		}
		
		if (baskets == null)	baskets		= new Vector<BasketVO>();
		if (products == null)	products	= new Vector<ProductVO>();
		BasketVO				basketVO	= new BasketVO();
		BasketDAO				dao			= new BasketDAO();
		
		if (customerVO != null)		basketVO.setCustomer_idx(customerVO.getIdx());
		else						basketVO.setCustomer_idx(0);
		
		basketVO.setIdx(2147483001 + baskets.size());
		basketVO.setProduct_idx(productVO.getIdx());
		basketVO.setQuantity(quantity);
		basketVO.setOptions(options);
		basketVO.setFinal_price(productVO.getProduct_price() * quantity);
		
		if (customerVO != null)		result	=	dao.basketInsert(basketVO);

		if (customerVO == null || (customerVO != null && result > 0)) {
			baskets.add(basketVO);			session.setAttribute("baskets", baskets);
			products.add(productVO);		session.setAttribute("products", products);
		} else {
			log.error("BasketAddAction execute Failed!!!!!!!!!!!!!!!!!!!!");
			path="error.html";
		}

		log.debug("BasketAddAction execute End.");
		return new ActionForward(path, true);
	}
}
