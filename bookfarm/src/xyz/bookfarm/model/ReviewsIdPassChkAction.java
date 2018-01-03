package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewDAO;

public class ReviewsIdPassChkAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	public ReviewsIdPassChkAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String	page			=	req.getParameter("page");
		int		idx				=	Integer.parseInt(req.getParameter("idx"));
		int		customers_idx	=	Integer.parseInt(req.getParameter("customers_idx"));
		int		products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
		String	type			=	req.getParameter("type");
		String	typeView		=	(String)req.getAttribute("typeView");
		
		String	username		=	req.getParameter("username");
		String	password		=	req.getParameter("password");
		
		ReviewDAO dao			=	new ReviewDAO();
		int 	result			=	dao.pwdCheck(customers_idx, username, password);
		if(result>0) {
									req.setAttribute("idx", idx);
									req.setAttribute("page", page);
									req.setAttribute("typeView", typeView);
									req.setAttribute("type", type);
									
			if(req.getParameter("products_idx")!=null)
									req.setAttribute("products_idx", products_idx);
			else if(req.getParameter("customers_idx")!=null)
									req.setAttribute("customers_idx", customers_idx);
			
			if(typeView.equals("delete"))
				path			=	"qReviewsDelete.do";	// ?/?
		}
		
		return new ActionForward(path, false);
	}

}
