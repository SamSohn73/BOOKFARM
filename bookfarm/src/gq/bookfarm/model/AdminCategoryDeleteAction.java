package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CategoryDAO;

public class AdminCategoryDeleteAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public AdminCategoryDeleteAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminCategoryDeleteAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminCategoryDeleteAction execute Start.");
		String current_page = req.getParameter("page");
		log.debug("AdminCategoryDeleteAction execute Page=" + current_page);
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		CategoryDAO dao	= new CategoryDAO();
		int result		= dao.categoryDelete(idx);

		if(result==0) {
			log.debug("AdminCategoryDeleteAction execute Failed.");
			path="error.jsp"; 
		}else {
			path+="?page="+current_page;
		}
		log.debug("AdminCategoryDeleteAction execute End.");
		return new ActionForward(path, false);
	}

}
