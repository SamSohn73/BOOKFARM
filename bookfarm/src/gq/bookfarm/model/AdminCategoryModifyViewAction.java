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
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CategoryVO;

public class AdminCategoryModifyViewAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;

	public AdminCategoryModifyViewAction(String path) 
	{
		super();
		this.path = path;
		log.debug("AdminCategoryModifyViewAction Constructor. Destination path = " + path);
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("AdminCategoryModifyViewAction execute Start.");

		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCategoryModifyViewAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
			return new ActionForward(path, false);
		}
		
		int curPage						= Integer.parseInt(req.getParameter("page"));
		int idx							= Integer.parseInt(req.getParameter("idx"));
		
		CategoryDAO			dao			= new CategoryDAO();
		Vector<CategoryVO>	categories	= dao.categoryList();
		CategoryVO			category	= dao.categoryGetRow(idx);
		
		if (categories != null && category != null) {
			req.setAttribute("categories", categories);
			req.setAttribute("category", category);
			path += "?page=" + curPage;
		}
		// if result failed change path here
		else {
			log.debug("AdminCategoryModifyViewAction execute Failed!!!!!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		log.debug("AdminCategoryModifyViewAction execute End.");
		return new ActionForward(path, false);
	}
}

