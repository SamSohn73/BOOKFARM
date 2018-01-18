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
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;

public class AdminCategorySearchAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private String path;
	
	public AdminCategorySearchAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminCategorySearchAction Constructor. Destination path = " + path);
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("AdminCategorySearchAction execute SearchAction Start.");
		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCategorySearchAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.html";
			return new ActionForward(path, false);
		}
		
		String	criteria	= req.getParameter("criteria");
		String	searchWord	= req.getParameter("searchWord");
		log.debug("AdminCategorySearchAction execute SearchAction criteria= " + criteria);
		log.debug("AdminCategorySearchAction execute SearchAction searchword= " + searchWord);
		
		// get Page number
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		int limit			= 10;

		CategoryDAO dao		= new CategoryDAO();
		
		int totalRows		= dao.categoryCountSearchingRows(criteria, searchWord);
		int totalPages		= (int) ((double)totalRows / limit + 0.99999);
		int startPage		= (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
		int endPage			= startPage + 10 - 1;
		if (endPage > totalPages)	endPage = totalPages;
		
		log.debug("AdminCategorySearchAction execute SearchAction (double)totalRows / limit + 0.99999= " + (double)totalRows / limit + 0.99999);
		log.debug("AdminCategorySearchAction execute SearchAction totalPages= " + totalPages);
		log.debug("AdminCategorySearchAction execute SearchAction startPage= " + startPage);
		log.debug("AdminCategorySearchAction execute SearchAction endPage= " + endPage);
		log.debug("AdminCategorySearchAction execute SearchAction page= " + page);
		
		Vector<CategoryVO> categories;
		categories = dao.categorySearch(criteria, searchWord, page, limit);
		
		PageVO pageInfo	= new PageVO();
		pageInfo		.setPage(page);
		pageInfo		.setStartPage(startPage);
		pageInfo		.setEndPage(endPage);
		pageInfo		.setTotalRows(totalRows);
		pageInfo		.setTotalPages(totalPages);
		
		req				.setAttribute("pageInfo", pageInfo);
		req				.setAttribute("criteria", criteria);
		req				.setAttribute("searchWord", searchWord);
		
		if (categories != null)		req.setAttribute("categories", categories);
		// if result failed change path here
		else {
			log.fatal("AdminCategorySearchAction execute SearchAction categories vector null.");
			path="error.html";
		}
		
		log.debug("AdminCategorySearchAction execute SearchAction End.");
		return new ActionForward(path, false);
	}
}
