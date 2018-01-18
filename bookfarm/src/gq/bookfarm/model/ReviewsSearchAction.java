package gq.bookfarm.model;

import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ReviewVO;

public class ReviewsSearchAction implements Action 
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	public ReviewsSearchAction(String path) 
	{
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception 
	{
			int		page		=	1;
			
			HttpSession	session	=	req.getSession();
			CustomerVO	vo		=	(CustomerVO)session.getAttribute("loggedInUserVO");
			int		customers_idx=	vo.getIdx();
		
			String	type		=	req.getParameter("type");
			String	searchCondition=req.getParameter("searchCondition");
			String	searchWord	=	req.getParameter("searchWord");
			Vector<CustomerVO> VcVo	=	new Vector<CustomerVO>();
			if(searchCondition.equals("customers_idx")){
				CustomerDAO cDao	=	new CustomerDAO();
				VcVo				=	cDao.findIdx(searchWord);
			}
		
			int		products_idx=	0;
			if(req.getParameter("products_idx")!=null)	
				products_idx=	Integer.parseInt(req.getParameter("products_idx"));
			else if(req.getAttribute("products_idx")!=null)
				products_idx=	(int)req.getAttribute("products_idx");


				
		if(req.getParameter("page")!=null)
			page		=	Integer.parseInt(req.getParameter("page"));
					
		ReviewDAO dao		=	new ReviewDAO();
		PageVO	info		=	new PageVO();
		
		if(type.equals("list")){
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
			Vector<ReviewVO> list	=	new Vector<ReviewVO>();
			
			if(searchCondition.equals("customers_idx")){
				list	=	dao.getProductSearchList(products_idx, page, limit, searchCondition, VcVo);
			}else{
				list	=	dao.getProductSearchList(products_idx, page, limit, searchCondition, searchWord);
			}
			
			CustomerDAO cDao	=	new CustomerDAO();
			Vector<String>nameList= new Vector<String>();
			for(ReviewVO rVo:list) {
				if(rVo.getCustomers_idx()==0) {
										nameList.add("관리자");
				}else {
					String	name	=	cDao.getName(rVo.getCustomers_idx());
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
				req.setAttribute("nameList", nameList);
				req.setAttribute("searchCondition", searchCondition);
				req.setAttribute("searchWord", searchWord);
				path		+=	"?type="+type+"&products_idx="+products_idx;
			}else{ 
				log.error("ReviewsSearchAction - 'list' error");
				path="";
			}
		}
		else if(type.equals("myList")){
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
			Vector<ReviewVO> list	=	dao.getCustomerSearchList(customers_idx, page, limit, searchCondition, searchWord);
			
			CustomerDAO cDao	=	new CustomerDAO();
			Vector<String>nameList= new Vector<String>();
			for(ReviewVO rVo:list) {
				if(rVo.getCustomers_idx()==0) {
										nameList.add("관리자");
				}else {
					String	name	=	cDao.getName(rVo.getCustomers_idx());
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
				req.setAttribute("nameList", nameList);
				req.setAttribute("searchCondition", searchCondition);
				req.setAttribute("searchWord", searchWord);
				path		+=	"?type="+type+"&customers_idx="+customers_idx;
			}else{ 
				log.error("ReviewsSearchAction - 'myList' error");
				path="error.html";
			}
		}
		return new ActionForward(path, false);
	}

}
