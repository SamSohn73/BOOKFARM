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
import gq.bookfarm.vo.ReviewVO;

public class AdminReviewsModifyAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public AdminReviewsModifyAction(String path)
	{
		super();
		this.path = path;
		log.debug("AdminReviewsModifyAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminReviewsModifyAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		String	type			=	req.getParameter("type");
		String	typeView		=	"view";
		int		page			=	Integer.parseInt(req.getParameter("page"));
		int		idx				=	Integer.parseInt(req.getParameter("idx"));
		
		String	review_title	=	req.getParameter("review_title");
		String	review_text		=	req.getParameter("review_text");
		
		ReviewDAO dao			=	new ReviewDAO();
		ReviewVO vo				=	new ReviewVO();
									vo.setReview_text(review_text);
									vo.setReview_title(review_title);
	
		int		result			=	dao.updateRow(idx, review_title, review_text);
		if(result>0) {
			req.setAttribute("idx", idx);
			req.setAttribute("type", type);
			req.setAttribute("page", page);
			req.setAttribute("typeView", typeView);
		}
			
		return new ActionForward(path, false);
	}

}
