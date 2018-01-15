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

public class AdminReviewsInsertAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public AdminReviewsInsertAction(String path)
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
			log.info("AdminReviewsInsertAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		int		page			=	Integer.parseInt(req.getParameter("page"));
		String	review_title	=	req.getParameter("review_title");
		String	review_text		=	req.getParameter("review_text");
		int		parent_idx		=	Integer.parseInt(req.getParameter("parent_idx"));
		int		category_idx	=	Integer.parseInt(req.getParameter("category_idx"));
		int		products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
		if (products_idx == 0) {
			log.info("AdminReviewsInsertAction can not optain product_idx !!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		int		result			=	0;
		
		ReviewDAO dao			=	new ReviewDAO();
		ReviewVO vo				=	new ReviewVO();
		
									vo.setReview_text(review_text);
									vo.setReview_title(review_title);
									vo.setProducts_idx(products_idx);
									vo.setCustomers_idx(0);
				result			=	dao.insert(vo);
			
		if(result>0) {
				path			+=	"?page="+page+"&parent_idx"+parent_idx+"&category_idx"+category_idx
									+"&products_idx="+products_idx;
		} else {
									log.debug("AdminReviewsWriteAction write error");
		}
		
		return new ActionForward(path, false);
	}

}
