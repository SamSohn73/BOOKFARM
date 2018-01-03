package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewDAO;
import xyz.bookfarm.vo.ReviewVO;

public class ReviewsInsertAction implements Action {
	private String path;
	public ReviewsInsertAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String	type			=	req.getParameter("type");
		String	typeView		=	req.getParameter("typeView");
		int		page			=	Integer.parseInt(req.getParameter("page"));
		int		products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
		
		String	username		=	(String)req.getAttribute("username");
		String	password		=	(String)req.getAttribute("password");
		
		String	review_title	=	req.getParameter("review_title");
		String	review_text		=	req.getParameter("review_text");
		
		ReviewDAO dao			=	new ReviewDAO();
		ReviewVO vo			=	new ReviewVO();
									vo.setReview_text(review_text);
									vo.setReview_title(review_title);
									vo.setProducts_idx(products_idx);
									vo.setCustomers_idx(dao.getCustomerIdx(username, password));
		
		int		result			=	dao.insert(vo);
		if(result>0)
		{
				path			+=	"?type="+type+"&products_idx="+products_idx+"page="+page;
		}
		
		return new ActionForward(path, true);
	}

}
