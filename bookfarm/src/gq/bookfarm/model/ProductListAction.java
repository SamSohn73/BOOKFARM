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
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;

public class ProductListAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	private String path;

	public ProductListAction(String path) 
	{
		super();
		this.path = path;
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("ProductListAction execute Start.");
		
		HttpSession			session		= req.getSession();
		Vector<CategoryVO>	categories	= (Vector<CategoryVO>) session.getAttribute("categories");
		if (categories == null) {
			Vector<CategoryVO>	tmpCategories	= new Vector<CategoryVO>();
			CategoryDAO			categoryDAO		= new CategoryDAO();
			tmpCategories						= categoryDAO.categoryList();
			categories							= tmpCategories;
			session								.setAttribute("categories", categories);
		}
		
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		
		ProductDAO			dao		= new ProductDAO();
		
		int totalRows				= dao.totalRows();
		int limit					= 9;
		
		int totalPages				= (int) ((double) totalRows / limit + 0.999999);
		int startPage				= (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
		int endPage					= startPage + 10 -1;
		if (endPage > totalPages)	endPage = totalPages;
		
		PageVO pageInfo				= new PageVO();
		pageInfo					.setPage(page);
		pageInfo					.setStartPage(startPage);
		pageInfo					.setEndPage(endPage);
		pageInfo					.setTotalRows(totalRows);
		pageInfo					.setTotalPages(totalPages);
		req							.setAttribute("pageInfo", pageInfo);
		
		log.debug("ProductListAction execute totalRows= "		+ totalRows);
		log.debug("ProductListAction execute totalPages= "		+ totalPages);
		log.debug("ProductListAction execute startPage= "		+ startPage);
		log.debug("ProductListAction execute endPage= "			+ endPage);
		log.debug("ProductListAction execute page= "			+ page);
		
		Vector<ProductVO>	products	= dao.productList(page, limit);
		if (products != null)			req.setAttribute("products", products);
		else {
			log.debug("ProductListAction execute products Vector value null");
			path="error.html";
		}
		
		log.debug("ProductListAction execute End.");
		return new ActionForward(path, false);
	}
}
