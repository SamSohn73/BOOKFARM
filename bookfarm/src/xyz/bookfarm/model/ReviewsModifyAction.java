package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewsDAO;
import xyz.bookfarm.vo.ReviewsVO;

public class ReviewsModifyAction implements Action {
	private String path;
	public ReviewsModifyAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String	type			=	req.getParameter("type");
		String	typeView		=	"view";
		int		page			=	Integer.parseInt(req.getParameter("page"));
		int		products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
		int		customers_idx	=	Integer.parseInt(req.getParameter("customers_idx"));
		int		idx				=	Integer.parseInt(req.getParameter("idx"));
		
		String	review_title	=	req.getParameter("review_title");
		String	review_text		=	req.getParameter("review_text");
		
		ReviewsDAO dao			=	new ReviewsDAO();
		ReviewsVO vo			=	new ReviewsVO();
									vo.setReview_text(review_text);
									vo.setReview_title(review_title);
									vo.setProducts_idx(products_idx);
									
		int		result			=	dao.updateRow(idx, review_title, review_text);
		if(result>0)
		{
									req.setAttribute("idx", idx);
									req.setAttribute("type", type);
									req.setAttribute("products_idx", products_idx);
									req.setAttribute("customers_idx", customers_idx);
									req.setAttribute("page", page);
									req.setAttribute("typeView", typeView);
		}
			
		return new ActionForward(path, false);
	}

}
