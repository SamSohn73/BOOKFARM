package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ReviewVO;

public class ReviewsListAction implements Action 
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private	String	path;
	public ReviewsListAction(String path) 
	{
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception 
	{
			int		page		=	1;
			int		products_idx=	0;
			String	type		=	req.getParameter("type");
			HttpSession	session	=	req.getSession();
			CustomerVO	vo		=	(CustomerVO)session.getAttribute("LoginedUserVO");
			int		customers_idx=	vo.getIdx();
			
		if(req.getParameter("products_idx")!=null)	
					products_idx=	Integer.parseInt(req.getParameter("products_idx"));
		else if(req.getAttribute("products_idx")!=null)
					products_idx=	(int)req.getAttribute("products_idx");
					
		if(req.getParameter("page")!=null)
					page		=	Integer.parseInt(req.getParameter("page"));
						
			ReviewDAO dao		=	new ReviewDAO();
			PageVO	info		=	new PageVO();
			
		if(type.equals("list")){
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
		Vector<ReviewVO> list	=	dao.getList(products_idx, page, limit);
				if(list!=null) {
									req.setAttribute("list", list);
									req.setAttribute("info", info);
					path		+=	"?type="+type+"&products_idx="+products_idx;
				}else{ 
									log.error("QQQQQQQQ ReviewsListAction - 'list' error");
									//path="";
				}
		}else if(type.equals("myList")){
			int		totalRows	=	dao.oneCustomersTotalRows(customers_idx);
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
		Vector<ReviewVO> list	=	dao.getMyList(customers_idx, page, limit);
				if(list!=null) {
									req.setAttribute("list", list);
									req.setAttribute("info", info);
					path		+=	"?type="+type+"&products_idx="+products_idx;
				}else{ 
									log.error("QQQQQQQQ ReviewsListAction - 'myList' error :����Ʈ�� null");
									//path="";
				}
		}else if(type.equals("myPage")){
			int		limit		=	5;
			
		Vector<ReviewVO> list	=	dao.getMyPageList(customers_idx, limit);
				if(list!=null) {
									req.setAttribute("list", list);
					path		+=	"?type="+type;
				}else{ 
									log.error("QQQQQQQQ ReviewsListAction - 'myPage' error");
									//path="";
				}
		}		
		return new ActionForward(path, false);
	}

}
