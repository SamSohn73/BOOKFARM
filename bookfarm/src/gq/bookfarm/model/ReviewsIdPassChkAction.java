package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ReviewDAO;

public class ReviewsIdPassChkAction implements Action 
{
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	public ReviewsIdPassChkAction(String path) 
	{
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception 
	{
		int		page			=	Integer.parseInt(req.getParameter("page"));
		int		idx				=	Integer.parseInt(req.getParameter("idx"));
		String	type			=	req.getParameter("type");
		String	typeView		=	req.getParameter("typeView");
		
		String	username		=	req.getParameter("username");
		String	password		=	req.getParameter("password");
		
		ReviewDAO dao			=	new ReviewDAO();
		int		customer_idx	=	dao.getReviewWriterIdx(idx);
		int 	result			=	dao.pwdCheck(customer_idx, username, password);
		if(result>0){
									req.setAttribute("idx", idx);
									req.setAttribute("page", page);
									req.setAttribute("typeView", typeView);
									req.setAttribute("type", type);
			if(typeView.equals("delete")){
		int		products_idx	=	dao.getProduct_idx(idx);
									req.setAttribute("products_idx", products_idx);
				path			=	"qReviewsDelete.do";	// ?/?
			}
		}else{
				path			=	"";
		}
		
		return new ActionForward(path, false);
	}

}
