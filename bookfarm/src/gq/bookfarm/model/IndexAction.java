package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;

public class IndexAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public IndexAction(String path) {
		super();
		log.debug("IndexAction create Start.");
		this.path  = path;
		log.debug("IndexAction create End. path=" + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("IndexAction execute Start.");

		HttpSession		session		= req.getSession();
		CategoryDAO		catDAO		= new CategoryDAO();
		ProductDAO		pdtDAO		= new ProductDAO();
		
		Vector<CategoryVO>	categories	= catDAO.categoryList();
		if (categories != null) {
			session.setAttribute("categories", categories);
			session.setMaxInactiveInterval(60*30);
		}
		// if result failed change path here
		else {
			log.error("IndexAction execute categories Vector value null");
			path="error.html";
		}
		
		Vector<ProductVO>	best6Products	= pdtDAO.best6ProductList();
		if (best6Products != null)			session.setAttribute("best6Products", best6Products);
		else {
			log.error("IndexAction execute products Vector value null");
			path="error.html";
		}
		
		log.debug("IndexAction execute End.");
		return new ActionForward(path, false);
	}

}
