package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.vo.AdminVO;

public class AdminCategoryAddAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;

	public AdminCategoryAddAction(String path) 
	{
		super();
		this.path = path;
		log.debug("AdminCategoryAddAction Constructor. Destination path = " + path);
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("AdminCategoryAddAction execute Start.");

		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCategoryAddAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		int		curPage			= Integer.parseInt(req.getParameter("page"));
		int		parent_idx		= Integer.parseInt(req.getParameter("partent_idx"));
		String	category_name	= req.getParameter("category_name");
		int		result			= 0;
		
		CategoryDAO	dao			=	new CategoryDAO();

		result					=	dao.categoryInsert(parent_idx, category_name);
			
		if(result>0) {
			path += "?page=" + curPage;
		}
		else {
			log.debug("AdminCategoryAddAction execute Failed!!!!!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}

		log.debug("AdminCategoryAddAction execute End.");
		return new ActionForward(path, false);
	}
}
