package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;

public class AdminCustomerSearchAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private String path;
	
	public AdminCustomerSearchAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminCustomerSearch Constructor. Destination path = " + path);
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("AdminCustomerSearch execute SearchAction Start.");
		String	criteria	= req.getParameter("criteria");
		String	searchWord	= req.getParameter("searchWord");
		if (criteria.equals("gender")) {
			/*QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ Why ?????*/
			log.debug("AdminCustomerSearch execute SearchAction criteria= " + criteria);
			log.debug("AdminCustomerSearch execute SearchAction searchword= \"" + searchWord + "\"");
			searchWord = searchWord.equals("남") ? "m":"f";
			searchWord = searchWord.equals("남성") ? "m":"f";
			searchWord = searchWord.equals("남자") ? "m":"f";
		}
		log.debug("AdminCustomerSearch execute SearchAction criteria= " + criteria);
		log.debug("AdminCustomerSearch execute SearchAction searchword= " + searchWord);
		
		// get Page number
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		int limit			= 10;

		CustomerDAO dao		= new CustomerDAO();
		
		int totalRows		= dao.customerCountSearchingRows(criteria, searchWord);
		int totalPages		= (int) ((double)totalRows / limit + 0.99999);
		int startPage		= (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
		int endPage			= startPage + 10 - 1;
		if (endPage > totalPages)	endPage = totalPages;
		
		log.debug("AdminCustomerSearch execute SearchAction (double)totalRows / limit + 0.99999= " + (double)totalRows / limit + 0.99999);
		log.debug("AdminCustomerSearch execute SearchAction totalPages= " + totalPages);
		log.debug("AdminCustomerSearch execute SearchAction startPage= " + startPage);
		log.debug("AdminCustomerSearch execute SearchAction endPage= " + endPage);
		log.debug("AdminCustomerSearch execute SearchAction page= " + page);
		
		Vector<CustomerVO> customers;
		if (criteria.equals("address") )	customers = dao.customerSearchByAddr(searchWord, page, limit);
		else if (criteria.equals("phone"))	customers = dao.customerSearchByPhone(searchWord, page, limit);
		else if (criteria.equals("email"))	customers = dao.customerSearchByEmail(searchWord, page, limit);
		else								customers = dao.customerSearch(criteria, searchWord, page, limit);
		
		PageVO pageInfo	= new PageVO();
		pageInfo		.setPage(page);
		pageInfo		.setStartPage(startPage);
		pageInfo		.setEndPage(endPage);
		pageInfo		.setTotalRows(totalRows);
		pageInfo		.setTotalPages(totalPages);
		
		req				.setAttribute("pageInfo", pageInfo);
		req				.setAttribute("criteria", criteria);
		req				.setAttribute("searchWord", searchWord);
		
		if (customers != null)		req.setAttribute("customers", customers);
		// if result failed change path here
		else {
			log.fatal("AdminCustomerSearch execute SearchAction page= " + page);
			path="error.jsp";
		}
		
		log.debug("AdminCustomerSearch execute SearchAction End.");
		return new ActionForward(path, false);
	}
}
