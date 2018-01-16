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
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;
import gq.bookfarm.vo.ReviewVO;

public class AdminReviewsListAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private	String	path;
	
	public AdminReviewsListAction(String path)
	{
		super();
		this.path = path;
		log.debug("AdminReviewsListAction Constructor. Destination path = " + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminReviewsListAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
			return new ActionForward(path, false);
		}
		
		int		page		=	1;
		int		products_idx=	0;
		int		parent_idx	=	0;
		int		category_idx=	0;
		Vector<ReviewVO> list=	new Vector<ReviewVO>();
		
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
		
		if(req.getParameter("page")!=null)
			page		=	Integer.parseInt(req.getParameter("page"));
		ReviewDAO dao		=	new ReviewDAO();
		PageVO	info		=	new PageVO();
		
		int		limit		=	10;
		int		totalRows	=	0;
		
		
		if(parent_idx!=0 && category_idx!=0 && (parent_idx != catDao.categoryGetRow(category_idx).getParent_idx()))
			category_idx=0;
		if(category_idx!=0 && products_idx!=0 && (category_idx != pDao.productGetRow(products_idx).getCategory_idx()))
			products_idx=0;
		
		if(parent_idx!=0) {
			if(category_idx!=0) {
				if(products_idx!=0) {
					list		=	dao.getList(products_idx, page, limit);
					totalRows	=	dao.oneProductsTotalRows(products_idx);
				}
				else {
					Vector<ProductVO> VpVo1 = pDao.productTotalIdx(category_idx);
					list		=	dao.getList(VpVo1, page, limit);
					totalRows	=	dao.fewProductsTotalRows(VpVo1);
				}
			}
			else {
				Vector<CategoryVO> VcatVo1 = catDao.categoryGetTotalRow(parent_idx);
				Vector<ProductVO> VpVo1	=	new Vector<ProductVO>();
				for(CategoryVO catVo3 : VcatVo1) {
					VpVo1.addAll(pDao.productTotalIdx(catVo3.getIdx()));
				}
					list		=	dao.getList(VpVo1, page, limit);
					totalRows	=	dao.fewProductsTotalRows(VpVo1);
			}
		} else {
					list		=	dao.getList(page, limit);
					totalRows	=	dao.totalRows();
		}
		
		int		totalPages	=	(int)((double)totalRows/limit+0.95);
		int		startPage	=	((int)((double)page/10+0.9)-1)*10+1;
		int		endPage		=	startPage+10-1;
			
		if(endPage>totalPages)
				endPage		=	totalPages;
		info.setPage(page);
		info.setTotalPages(totalPages);
		info.setTotalRows(totalRows);
		info.setStartPage(startPage);
		info.setEndPage(endPage);
		
		CustomerDAO cDao	=	new CustomerDAO();
		Vector<String>nameList= new Vector<String>();
		for(ReviewVO vo:list) {
			if(vo.getCustomers_idx()==0) {
									nameList.add("관리자");
			}else {
				String	name	=	cDao.getName(vo.getCustomers_idx());
				System.out.println(name);
				if(name==null)
									nameList.add("이름 없음");
				else
									nameList.add(name);
			}
		}
							
		if(list!=null) {
			req.setAttribute("list", list);
			req.setAttribute("info", info);
			req.setAttribute("VpVo", VpVo);
			req.setAttribute("catVo1", catVo1);
			req.setAttribute("catVo2", catVo2);
			req.setAttribute("nameList", nameList);
			path		+=	"?products_idx="+products_idx
							+"&parent_idx="+parent_idx+"&category_idx="+category_idx;
		} else { 
			log.error("ReviewsListAction - 'list' error");
			//path="";
		}
			
		return new ActionForward(path, false);
	}

}
