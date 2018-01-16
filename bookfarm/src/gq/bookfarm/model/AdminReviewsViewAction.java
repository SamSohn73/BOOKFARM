package gq.bookfarm.model;

import java.util.Vector;

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

public class AdminReviewsViewAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public AdminReviewsViewAction(String path)
	{
		super();
		this.path = path;
		log.debug("AdminReviewsViewAction Constructor. Destination path = " + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminReviewsViewAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
			return new ActionForward(path, false);
		}
		
		int		page				=	Integer.parseInt(req.getParameter("page"));
		int		idx					=	Integer.parseInt(req.getParameter("idx"));
		int		products_idx		=	Integer.parseInt(req.getParameter("p"));
		int		parent_idx			=	Integer.parseInt(req.getParameter("par"));
		int		category_idx		=	Integer.parseInt(req.getParameter("cat"));
		
		ReviewDAO 	dao				=	new ReviewDAO();
		ReviewVO	reviewVO		=	dao.getRow(idx);
		
		CustomerDAO	cDao			=	new CustomerDAO();
		String		name			=	null;
			if(reviewVO.getCustomers_idx()==0) {
					name			=	"관리자";
			}else {
				String	name_temp	=	cDao.getName(reviewVO.getCustomers_idx());
				System.out.println(name_temp);
				if(name_temp==null)
					name			=	"이름 없음";
				else
					name			=	name_temp;
			}

			
		if(reviewVO!=null) {
			req.setAttribute("reviewVO", reviewVO);
			req.setAttribute("name", name);
			path			+=	"?idx="+idx+"&page="+page+"&p="+products_idx+"&par="+parent_idx
								+"&cat="+category_idx;
				
		} else {
			log.error("ReviewsViewAction error : vo is empty");
			path			=	"";
		}
		
		return new ActionForward(path, false);
	}

}
