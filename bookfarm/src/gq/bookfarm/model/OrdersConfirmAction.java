package gq.bookfarm.model;

import java.sql.Date;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.dao.OrdersDAO;
import gq.bookfarm.dao.OrdersProductDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.OrdersProductVO;
import gq.bookfarm.vo.OrdersVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;
import gq.bookfarm.vo.ReviewVO;

public class OrdersConfirmAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public OrdersConfirmAction(String path)
	{
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		HttpSession		session		=	req.getSession();
		CustomerVO		cVo			=	(CustomerVO) session.getAttribute("loggedInUserVO");
		int				customer_idx=	cVo.getIdx();
		
		String			type		=	"";
		if(req.getParameter("type")!=null)
			type					=	req.getParameter("type");
		
		int				idx			=	0;
		if(req.getParameter("idx")!=null)
			idx						=	Integer.parseInt(req.getParameter("idx"));
		
		int				page		=	1;
		OrdersDAO		dao			=	new OrdersDAO();
		OrdersProductDAO opDao		=	new OrdersProductDAO();
		ProductDAO		pDao		=	new ProductDAO();
		ProductVO		pVo			=	new ProductVO();
		Vector<String>	cs			=	new Vector<String>();
		
		
		if(type.equals("myPage"))
		{
			Vector<OrdersVO>		list	=	dao.singleCustomerordersList(customer_idx, 1, 5);
			
			for(OrdersVO vo:list) {
				Vector<OrdersProductVO>	opList	=	opDao.ordersProductGetRowsbyOrders(vo.getIdx());
				OrdersProductVO			opVo	=	opList.get(0);
				int						opLCount=	opList.size() - 1;
				String					addTag	=	"";
				if(opLCount > 0)
					addTag		=	" 그 외 "+opLCount;
				pVo			=	pDao.productGetRow(opVo.getProducts_idx());
			
				String	c1	=	pVo.getProduct_name()+"  "+addTag;
				cs.add(c1);
			}
				if(list!=null) {
					req.setAttribute("cs", cs);
					req.setAttribute("list", list);
					path	+=	"?type="+type;
				} else { 
					log.error("OrdersConfirmAction - 'myPage' error");
					path="error.jsp";
				}
		}
		else if(type.equals("singleList"))
		{
			if(req.getParameter("page")!=null)
				page		=	Integer.parseInt(req.getParameter("page"));
			PageVO					info	=	new PageVO();
			int						limit	=	10;

			OrdersVO				oList	=	dao.ordersGetRow(idx);
			Vector<OrdersProductVO>	opList	=	opDao.ordersProductGetRowsbyOrders(oList.getIdx(),page,limit);
				
			int					totalRows	=	opDao.SingleOrderTotalRows(oList.getIdx());
			int					totalPages	=	(int)((double)totalRows/limit+0.95);
			int					startPage	=	((int)((double)page/10+0.9)-1)*10+1;
			int					endPage		=	startPage+10-1;
	
			if(endPage>totalPages)
				endPage		=	totalPages;
			
			info.setPage(page);
			info.setTotalPages(totalPages);
			info.setTotalRows(totalRows);
			info.setStartPage(startPage);
			info.setEndPage(endPage);
			
			Vector<String>nameList= new Vector<String>();
			for(OrdersProductVO opVo:opList) {
				if(pDao.productGetRow(opVo.getProducts_idx()).getProduct_name()!=null)
					nameList.add(pDao.productGetRow(opVo.getProducts_idx()).getProduct_name());
				else
					nameList.add("상품 명칭 미등록");
			}
			
			if(opList!=null) {
				req.setAttribute("oList", oList);
				req.setAttribute("opList", opList);
				req.setAttribute("info", info);
				req.setAttribute("nameList", nameList);
				path	+=	"?type="+type;
			} else { 
				log.error("OrdersConfirmAction - 'singleList' error");
				//path="";
			}
		}
		else if(type.equals("myList"))
		{
			if(req.getParameter("page")!=null)
				page		=	Integer.parseInt(req.getParameter("page"));
			PageVO					info	=	new PageVO();
			int						limit	=	10;
			
			Vector<OrdersVO>		list	=	dao.singleCustomerordersList(customer_idx, page, limit);
			
			for(OrdersVO vo:list) {
				Vector<OrdersProductVO>	opList	=	opDao.ordersProductGetRowsbyOrders(vo.getIdx());
				OrdersProductVO			opVo	=	opList.get(0);
				int						opLCount=	opList.size() - 1;
				String					addTag	=	"";
				if(opLCount > 0)
					addTag	=	" 그 외 "+opLCount;
				pVo		=	pDao.productGetRow(opVo.getProducts_idx());
				
				String					c1		=	pVo.getProduct_name()+"  "+addTag;
				cs.add(c1);
			}
			
			
			int	totalRows	=	dao.singleCustomertotalRows(customer_idx);
			int	totalPages	=	(int)((double)totalRows/limit+0.95);
			int	startPage	=	((int)((double)page/10+0.9)-1)*10+1;
			int	endPage		=	startPage+10-1;
	
			if(endPage>totalPages)
				endPage		=	totalPages;
			
			info.setPage(page);
			info.setTotalPages(totalPages);
			info.setTotalRows(totalRows);
			info.setStartPage(startPage);
			info.setEndPage(endPage);
			if(list!=null) {
				req.setAttribute("cs", cs);
				req.setAttribute("list", list);
				req.setAttribute("info", info);
				path	+=	"?type="+type;
			} else { 
				log.error("OrdersConfirmAction - 'myPage' error");
				//path="";
			}
		} else {
			log.error("OrdersConfirmAction - type error : "+type);
			//path="";
		}
		
		return new ActionForward(path, false);
	}

}
