package gq.bookfarm.model;

import java.util.Iterator;
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

public class BasketDeleteAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public BasketDeleteAction(String path)
	{
		super();
		this.path  = path;
		log.debug("BasketDeleteAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("BasketDeleteAction execute Start.");
		
		int idx							=Integer.parseInt(req.getParameter("idx"));
		
		HttpSession			session		= req.getSession();
		CustomerVO			customerVO	= (CustomerVO) session.getAttribute("loggedInUserVO");
		Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
		Vector<ProductVO>	products	= (Vector<ProductVO>) session.getAttribute("products");
		
		int result						= 0;
		
		if (baskets == null) {
			log.error("BasketDeleteAction execute Failed. No basket information.");
			path="error.html"; 
			return new ActionForward(path, false);
		}
		
		//for (BasketVO basket:baskets) { // You SHOULD use Iterator for removing element on iteration
		for(Iterator<BasketVO> itr = baskets.iterator(); itr.hasNext();) {
			BasketVO basket = itr.next();
			if (idx == basket.getIdx()) {
				if (customerVO != null && idx < 2147483001) {
					BasketDAO basketDao	= new BasketDAO();
					result				= basketDao.basketDeleteByIdx(idx);
					
					if(result <= 0) {
						log.error("BasketDeleteAction execute Failed.");
						path="error.html"; 
					}
				}
				baskets.remove(basket);
				break;
			}
		}
		session.setAttribute("baskets", baskets);

		log.debug("BasketDeleteAction execute End.");
		return new ActionForward(path, false);
	}

}
