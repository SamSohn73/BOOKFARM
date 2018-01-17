package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.CustomerDAO;
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
			return new ActionForward(path, false);
		}
		
		int		products_idx	=	Integer.parseInt(req.getParameter("p"));
		int		parent_idx		=	Integer.parseInt(req.getParameter("par"));
		int		category_idx	=	Integer.parseInt(req.getParameter("cat"));
		int		page			=	Integer.parseInt(req.getParameter("page"));
		int		idx				=	Integer.parseInt(req.getParameter("idx"));
		String	type			=	req.getParameter("type");
		ReviewDAO dao			=	new ReviewDAO();
		ReviewVO vo				=	new ReviewVO();
		
		String	review_title	=	null;
		String	review_text		=	null;
		
		
		if(type.equals("u")) {
				review_title	=	req.getParameter("review_title");
				review_text		=	req.getParameter("review_text");
				System.out.println("리뷰 수정 2번째 : "+review_title);
		
									vo.setReview_text(review_text);
									vo.setReview_title(review_title);
		int		result			=	dao.updateRow(idx, review_title, review_text);
			if(result>0) {
				path			+=	"?idx="+idx+"&page="+page+"&par="+parent_idx+"&cat="
									+category_idx+"&p="+products_idx;
			}
		}else if(type.equals("m")){
				vo				=	dao.getRow(idx);
		CustomerDAO	cDao		=	new CustomerDAO();
		String		name		=	null;
		String	name_temp		=	null;
		
			if(vo.getCustomers_idx()==0) {
					name		=	"관리자";
			}else {
				name_temp	=	cDao.getName(vo.getCustomers_idx());
									System.out.println(name_temp);
				if(name_temp==null)
					name		=	"이름 없음";
				else
					name		=	name_temp;
			}
									req.setAttribute("vo", vo);
									req.setAttribute("name", name);
				path			=	"./admin/adminReviewsModify.jsp?idx="+idx+"&page="+page+"&par="
									+parent_idx+"&cat="+category_idx+"&p="+products_idx;
		}
		
		return new ActionForward(path, false);
	}

}
