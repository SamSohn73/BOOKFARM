package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;
import gq.bookfarm.vo.ReviewVO;

public class AdminReviewsListAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private	String	path;
	public AdminReviewsListAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
			int		page		=	1;
			int		products_idx=	0;
			int		customers_idx=	0;
			int		parent_idx	=	0;
			int		category_idx=	0;
			Vector<ReviewVO> list=	new Vector<ReviewVO>();
			//HttpSession	session	=	req.getSession();
			//CustomerVO	vo		=	(CustomerVO)session.getAttribute("adminVO");
			
			
			
			if(req.getParameter("customers_idx")!=null)	
					customers_idx=	Integer.parseInt(req.getParameter("customers_idx"));
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
			System.out.println("여기 확인 : "+parent_idx);
			
			
		if(req.getParameter("page")!=null)
					page		=	Integer.parseInt(req.getParameter("page"));
			ReviewDAO dao		=	new ReviewDAO();
			PageVO	info		=	new PageVO();
			
			int		totalRows	=	dao.oneProductsTotalRows(products_idx);
			int		limit		=	10;
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
									
		if(products_idx!=0 && customers_idx==0)
					list		=	dao.getList(products_idx, page, limit);
		else if(products_idx==0 && customers_idx!=0)
					list		=	dao.getListByCustomer(customers_idx, endPage, limit);
		else if(products_idx!=0 && customers_idx!=0)
					list		=	dao.getList(products_idx, customers_idx, endPage, limit);
		else
					list		=	dao.getList(page, limit);
		
		
			if(list!=null) 
			{
									req.setAttribute("list", list);
									req.setAttribute("info", info);
									req.setAttribute("VpVo", VpVo);
									req.setAttribute("catVo1", catVo1);
									req.setAttribute("catVo2", catVo2);
					path		+=	"?products_idx="+products_idx+"&customers_idx="+customers_idx
									+"&parent_idx="+parent_idx+"&category_idx="+category_idx;
			}
			else
			{ 
									log.error("QQQQQQQQ ReviewsListAction - 'list' error");
									//path="";
			}
			
		return new ActionForward(path, false);
	}

}
