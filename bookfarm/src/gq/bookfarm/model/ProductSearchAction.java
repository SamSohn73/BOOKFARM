package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.ProductVO;

public class ProductSearchAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private String path;
	
	public ProductSearchAction(String path) {
		super();
		this.path  = path;
		log.debug("ProductSearchAction Constructor. Destination path = " + path);
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("ProductSearchAction execute SearchAction Start.");
		
		HttpSession			session		= req.getSession();
		Vector<CategoryVO>	categories	= (Vector<CategoryVO>) session.getAttribute("categories");
		if (categories == null) {
			Vector<CategoryVO>	tmpCategories	= new Vector<CategoryVO>();
			CategoryDAO			categoryDAO		= new CategoryDAO();
			tmpCategories						= categoryDAO.categoryList();
			categories							= tmpCategories;
			session								.setAttribute("categories", categories);
		}
		
		String	criteria	= req.getParameter("criteria");
		String	searchWord	= req.getParameter("searchWord");

		log.debug("ProductSearchAction execute SearchAction criteria= " + criteria);
		log.debug("ProductSearchAction execute SearchAction searchword= " + searchWord);
		
		// get Page number
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		int limit			= 9;

		ProductDAO dao		= new ProductDAO();
		
		int totalRows		= dao.productCountSearchingRows(criteria, searchWord);
		int totalPages		= (int) ((double)totalRows / limit + 0.99999);
		int startPage		= (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
		int endPage			= startPage + 10 - 1;
		if (endPage > totalPages)	endPage = totalPages;
		
		log.debug("ProductSearchAction execute SearchAction (double)totalRows / limit + 0.99999= " + (double)totalRows / limit + 0.99999);
		log.debug("ProductSearchAction execute SearchAction totalPages= " + totalPages);
		log.debug("ProductSearchAction execute SearchAction startPage= " + startPage);
		log.debug("ProductSearchAction execute SearchAction endPage= " + endPage);
		log.debug("ProductSearchAction execute SearchAction page= " + page);
		
		Vector<ProductVO> products = dao.productSearch(criteria, searchWord, startPage, limit);
		
		PageVO pageInfo	= new PageVO();
		pageInfo		.setPage(page);
		pageInfo		.setStartPage(startPage);
		pageInfo		.setEndPage(endPage);
		pageInfo		.setTotalRows(totalRows);
		pageInfo		.setTotalPages(totalPages);
		
		req				.setAttribute("pageInfo", pageInfo);
		req				.setAttribute("criteria", criteria);
		req				.setAttribute("searchWord", searchWord);
		
		if (products != null)		req.setAttribute("products", products);
		else {
			log.fatal("ProductSearchAction execute SearchAction page= " + page);
			path="error.html";
		}
		
		log.debug("ProductSearchAction execute SearchAction End.");
		return new ActionForward(path, false);
	}
}

