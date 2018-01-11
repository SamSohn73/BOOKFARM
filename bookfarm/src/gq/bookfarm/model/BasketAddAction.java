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

		int		idx				= Integer.parseInt(req.getParameter("idx"));
		int		result			= 0;
		
		HttpSession			session		= req.getSession();
		CustomerVO			customerVO	= (CustomerVO) session.getAttribute("loggedInUserVO");
		Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
		
		
		/*QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ*/
		
		BasketVO		basketVO	= new BasketVO();
		BasketDAO		dao			= new BasketDAO();

		result						=	dao.basketInsert(basketVO);
			
		if(result <= 0) {
			log.debug("BasketAddAction execute Failed!!!!!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}

		log.debug("BasketAddAction execute End.");
		return new ActionForward(path, false);
	}
}
