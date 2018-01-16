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
			return new ActionForward(path, false);
		}
		
		int		idx				=	Integer.parseInt(req.getParameter("idx"));
		int		products_idx	=	Integer.parseInt(req.getParameter("p"));
		int		parent_idx		=	Integer.parseInt(req.getParameter("par"));
		int		category_idx	=	Integer.parseInt(req.getParameter("cat"));
		
		ReviewDAO	dao			=	new	ReviewDAO();
		int		result			=	dao.delete(idx);
		
		if(result>0) {
				path			+=	"?products_idx="+products_idx
									+"&parent_idx="+parent_idx+"&category_idx="+category_idx;
		} else {
									log.error("ReviewsDeleteAction error");
				path			=	"";
		}	
		
		return new ActionForward(path, false);
	}

}
