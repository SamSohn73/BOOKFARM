package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.ProductVO;
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
		
		int		page			=	Integer.parseInt(req.getParameter("page"));
		int		parent_idx		=	0;
		int		category_idx	=	0;
		int		products_idx	=	0;
		if(req.getParameter("products_idx")!=null)	
			products_idx=	Integer.parseInt(req.getParameter("products_idx"));
		if(req.getParameter("parent_idx")!=null)	
			parent_idx	=	Integer.parseInt(req.getParameter("parent_idx"));
		if(req.getParameter("category_idx")!=null)	
			category_idx=	Integer.parseInt(req.getParameter("category_idx"));
		
		CategoryDAO catDao		=	new CategoryDAO();
		ProductDAO	pDao		=	new ProductDAO();
		Vector<CategoryVO> catVo1=	catDao.categoryGetTotalRow(0);
		Vector<ProductVO> VpVo	=	new Vector<ProductVO>();
		Vector<CategoryVO> catVo2=	new Vector<CategoryVO>();
		if(category_idx!=0)
			VpVo		=	pDao.productTotalIdx(category_idx);
		if(parent_idx!=0)
			catVo2		=	catDao.categoryGetTotalRow(parent_idx);
		
		ReviewDAO dao			=	new ReviewDAO();
		
			
									req.setAttribute("VpVo", VpVo);
									req.setAttribute("catVo1", catVo1);
									req.setAttribute("catVo2", catVo2);
				path			+=	"?page="+page+"&parent_idx="+parent_idx+"&category_idx="+category_idx
									+"&products_idx="+products_idx;
		
		return new ActionForward(path, false);
	}

}
