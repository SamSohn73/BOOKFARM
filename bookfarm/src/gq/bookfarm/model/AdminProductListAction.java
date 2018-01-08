package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;

public class AdminProductListAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;

	public AdminProductListAction(String path) 
	{
		super();
		this.path = path;
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("AdminProductListAction execute Start.");
		// get Page number
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		
		ProductDAO			dao		= new ProductDAO();
		
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
		pageInfo					.setPage(page);
		pageInfo					.setStartPage(startPage);
		pageInfo					.setEndPage(endPage);
		pageInfo					.setTotalRows(totalRows);
		pageInfo					.setTotalPages(totalPages);
		req							.setAttribute("pageInfo", pageInfo);
		
		log.debug("AdminProductListAction execute totalRows= "		+ totalRows);
		log.debug("AdminProductListAction execute totalPages= "		+ totalPages);
		log.debug("AdminProductListAction execute startPage= "		+ startPage);
		log.debug("AdminProductListAction execute endPage= "		+ endPage);
		log.debug("AdminProductListAction execute page= "			+ page);
		
		Vector<ProductVO>	products	= dao.productList(page, limit);
		if (products != null)			req.setAttribute("products", products);
		// if result failed change path here
		else					path="error.jsp";
		
		log.debug("AdminProductListAction execute End.");
		return new ActionForward(path, false);
	}
}
