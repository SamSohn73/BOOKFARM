package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ProductDAO;

public class AdminProductDeleteAction implements Action
{
	
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public AdminProductDeleteAction(String path) {
		super();
		log.debug("AdminProductDeleteAction create Start.");
		this.path  = path;
		log.debug("AdminProductDeleteAction create End. path=" + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		log.debug("AdminProductDeleteAction execute Start.");
		String		current_page	=	req.getParameter("page");
		log.debug("AdminProductDeleteAction execute Page=" + current_page);
		int			idx				=	Integer.parseInt(req.getParameter("idx"));
		
		ProductDAO	dao				=	new ProductDAO();
		
		int			result			=	dao.productDelete(idx);

		if(result==0) {
			log.debug("AdminProductDeleteAction execute Failed.");
			path="error.jsp"; 
		}else {
			path+="?page="+current_page;
		}
		log.debug("AdminProductDeleteAction execute End.");
		
		return new ActionForward(path, false);
	}

}
