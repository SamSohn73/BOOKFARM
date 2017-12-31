package xyz.bookfarm.model;

import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewsDAO;
import xyz.bookfarm.vo.PageVO;
import xyz.bookfarm.vo.ReviewsVO;

public class ReviewsSearchAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	public ReviewsSearchAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
			int		page		=	1;
		
			String	type		=	req.getParameter("type");
			String	searchCondition=req.getParameter("searchCondition");
			String	searchWord	=	req.getParameter("searchWord");
		
			int		products_idx=	0;
			int		customers_idx=	0;
		if(req.getParameter("products_idx")!=null)	
					products_idx=	Integer.parseInt(req.getParameter("products_idx"));
		if(req.getParameter("customers_idx")!=null)	
					customers_idx=	Integer.parseInt(req.getParameter("customers_idx"));			
				
		if(req.getParameter("page")!=null)
					page		=	Integer.parseInt(req.getParameter("page"));
					
			ReviewsDAO dao		=	new ReviewsDAO();
			PageVO	info		=	new PageVO();
		
			if(type.equals("list"))
			{
			int		totalRows	=	dao.searchOneProductList(products_idx, searchCondition, searchWord);
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
		Vector<ReviewsVO> list	=	dao.getProductSearchList(products_idx, page, limit, searchCondition, searchWord);
				if(list!=null) 
				{
									req.setAttribute("list", list);
									req.setAttribute("info", info);
									req.setAttribute("type", type);
									req.setAttribute("searchCondition", searchCondition);
									req.setAttribute("searchWord", searchWord);
					path		+=	"?products_idx="+products_idx;
									
				}
				else
				{ 
									log.error("QQQQQQQQ ReviewsSearchAction - 'list' error");
									path="";
				}
			}
			else if(type.equals("myList"))
			{
			int		totalRows	=	dao.searchOneCustomerList(customers_idx, searchCondition, searchWord);
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
		Vector<ReviewsVO> list	=	dao.getCustomerSearchList(customers_idx, page, limit, searchCondition, searchWord);
				if(list!=null) 
				{
									req.setAttribute("list", list);
									req.setAttribute("info", info);
									req.setAttribute("type", type);
									req.setAttribute("searchCondition", searchCondition);
									req.setAttribute("searchWord", searchWord);
					path		+=	"?customers_idx="+customers_idx;
				}
				else
				{ 
									log.error("QQQQQQQQ ReviewsSearchAction - 'myList' error");
									path="";
				}
			}													
		return new ActionForward(path, true);
	}

}
