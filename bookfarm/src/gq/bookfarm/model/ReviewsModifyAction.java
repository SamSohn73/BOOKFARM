package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.ReviewVO;

public class ReviewsModifyAction implements Action 
{
	private String path;
	public ReviewsModifyAction(String path) 
	{
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception 
	{
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
		if(result>0){
			req.setAttribute("idx", idx);
			req.setAttribute("type", type);
			req.setAttribute("page", page);
			req.setAttribute("typeView", typeView);
		}
			
		return new ActionForward(path, false);
	}

}
