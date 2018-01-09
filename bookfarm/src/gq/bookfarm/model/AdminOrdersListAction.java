package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.OrdersDAO;
import gq.bookfarm.vo.OrdersVO;
import gq.bookfarm.vo.PageVO;

public class AdminOrdersListAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;

	public AdminOrdersListAction(String path) 
	{
		super();
		this.path = path;
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("AdminOrdersList execute Start.");
		// get Page number
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		
		OrdersDAO			dao		= new OrdersDAO();
		
		// get Total rows & number of writings in a page
		int totalRows				= dao.totalRows();
		int limit					= 10;
		
		// Calc total page number
		int totalPages				= (int) ((double) totalRows / limit + 0.999999);
		// Calc Start page number
		int startPage				= (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
		// Calc End page number
		int endPage					= startPage + 10 -1;
		if (endPage > totalPages)	endPage = totalPages;
		
		PageVO pageInfo				= new PageVO();
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		req.setAttribute("pageInfo", pageInfo);
		
		log.debug("AdminCustomerListAction execute totalRows= "		+ totalRows);
		log.debug("AdminCustomerListAction execute totalPages= "	+ totalPages);
		log.debug("AdminCustomerListAction execute startPage= "		+ startPage);
		log.debug("AdminCustomerListAction execute endPage= "		+ endPage);
		log.debug("AdminCustomerListAction execute page= "			+ page);
		
		Vector<OrdersVO>	orders	= dao.ordersList(page, limit);

		if (orders != null)			req.setAttribute("orders", orders);
		// if result failed change path here
		else {
			log.debug("AdminCustomerListAction execute orders Vector value null");
			path="error.jsp";
		}
		
		log.debug("AdminOrdersList execute End.");
		return new ActionForward(path, false);
	}
}

