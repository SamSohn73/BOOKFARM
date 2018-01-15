package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.AdminVO;

public class AdminReviewsDeleteAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private	String	path;
	
	public AdminReviewsDeleteAction(String path)
	{
		super();
		this.path = path;
		log.debug("AdminReviewsDeleteAction Constructor. Destination path = " + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminReviewsDeleteAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		int		page			=	(int)req.getAttribute("page");
		int		idx				=	(int)req.getAttribute("idx");
		String	type			=	(String)req.getAttribute("type");
		int		products_idx	=	(int)req.getAttribute("products_idx");
		
		ReviewDAO	dao			=	new	ReviewDAO();
		int		result			=	dao.delete(idx);
		
		if(result>0) {
			req.setAttribute("products_idx",products_idx);
			req.setAttribute("type", type);
		} else {
			log.error("ReviewsDeleteAction error");
			path			=	"";
		}	
		
		return new ActionForward(path, false);
	}

}
