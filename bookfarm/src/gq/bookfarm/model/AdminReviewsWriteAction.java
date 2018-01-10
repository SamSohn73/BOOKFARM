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
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.ReviewVO;

public class AdminReviewsWriteAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public AdminReviewsWriteAction(String path)
	{
		super();
		this.path = path;
		log.debug("AdminReviewsWriteAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminReviewsWriteAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		String	type			=	req.getParameter("type");
		int		page			=	Integer.parseInt(req.getParameter("page"));
		String	review_title	=	req.getParameter("review_title");
		String	review_text		=	req.getParameter("review_text");
		String	typeView		=	req.getParameter("typeView");
		int		idx				=	0;
		int		products_idx	=	0;
		int		result			=	0;
		
		CustomerVO cVo			=	(CustomerVO)session.getAttribute("loggedInUserVO");
		ReviewDAO dao			=	new ReviewDAO();
		ReviewVO vo				=	new ReviewVO();
		
		if(typeView.equals("insert")) {				
			products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
			vo.setReview_text(review_text);
			vo.setReview_title(review_title);
			vo.setProducts_idx(products_idx);
			vo.setCustomers_idx(cVo.getIdx());
			result			=	dao.insert(vo);
				
			if(result>0) {
				path			+=	"?type="+type+"&products_idx="+products_idx+"&page="+page;
			} else {
				System.out.println("���ٷ��ڤӤä�������������");
			}
		} else if(typeView.equals("modify")) {
				idx				=	Integer.parseInt(req.getParameter("idx"));
				result			=	dao.updateRow(idx, review_title, review_text);
				
			if(result>0) {
				typeView		=	"view";
				req.setAttribute("idx", idx);
				req.setAttribute("type", type);
				req.setAttribute("page", page);
				req.setAttribute("typeView", typeView);
				path			=	"qReviewsView.do";
			} else {
				System.out.println("���ٷ��ڤӤä�������������");
			}
		}
		
		return new ActionForward(path, false);
	}

}
