package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.AdminVO;
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
		log.debug("AdminProductListAction Constructor. Destination path = " + path);
	}
	
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res)
	{
		log.debug("AdminProductListAction execute Start.");
		
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminProductListAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
			return new ActionForward(path, false);
		}
		
		int page = 1;
		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));
		
		ProductDAO			dao		= new ProductDAO();
		
		int totalRows				= dao.totalRows();
		int limit					= 10;
		
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
		
		log.debug("AdminProductListAction execute totalRows= "		+ totalRows);
		log.debug("AdminProductListAction execute totalPages= "		+ totalPages);
		log.debug("AdminProductListAction execute startPage= "		+ startPage);
		log.debug("AdminProductListAction execute endPage= "		+ endPage);
		log.debug("AdminProductListAction execute page= "			+ page);

		Vector<ProductVO>	products	= dao.productList(page, limit);
		if (products != null)			req.setAttribute("products", products);
		else {
			log.debug("AdminProductListAction execute products Vector value null");
			path="error.jsp";
		}
		
		log.debug("AdminProductListAction execute End.");
		return new ActionForward(path, false);
	}
}
