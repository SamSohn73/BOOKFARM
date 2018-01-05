package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewDAO;
import xyz.bookfarm.vo.CustomerVO;
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
		int		page			=	Integer.parseInt(req.getParameter("page"));
		String	review_title	=	req.getParameter("review_title");
		String	review_text		=	req.getParameter("review_text");
		String	typeView		=	req.getParameter("typeView");
		int		idx				=	0;
		int		products_idx	=	0;
		int		result			=	0;
		
		HttpSession session		=	req.getSession();
		CustomerVO cVo			=	(CustomerVO)session.getAttribute("LoginedUserVO");
		
		ReviewDAO dao			=	new ReviewDAO();
		ReviewVO vo				=	new ReviewVO();
		
		if(typeView.equals("insert"))
		{				
				products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
									vo.setReview_text(review_text);
									vo.setReview_title(review_title);
									vo.setProducts_idx(products_idx);
									vo.setCustomers_idx(dao.getCustomerIdx(cVo.getUsername(), cVo.getPassword()));
				result			=	dao.insert(vo);
				
			if(result>0)
			{
				path			+=	"?type="+type+"&products_idx="+products_idx+"&page="+page;
			}
			else
			{
				System.out.println("ㅈ다러자ㅣㅓㄹㄷ저러ㅏㅈ더");
			}
		}
		else if(typeView.equals("modify"))
		{
				idx				=	Integer.parseInt(req.getParameter("idx"));
				result			=	dao.updateRow(idx, review_title, review_text);
				
				
			if(result>0)
			{
				typeView		=	"view";
										req.setAttribute("idx", idx);
										req.setAttribute("type", type);
										req.setAttribute("page", page);
										req.setAttribute("typeView", typeView);
				path			=	"qReviewsView.do";
			}
			else
			{
				System.out.println("ㅈ다러자ㅣㅓㄹㄷ저러ㅏㅈ더");
			}
		}
		
		return new ActionForward(path, false);
	}

}
