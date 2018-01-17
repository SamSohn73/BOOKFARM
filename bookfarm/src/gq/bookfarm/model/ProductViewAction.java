package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.ProductVO;

public class ProductViewAction implements Action
{

	private String path;
	
	public ProductViewAction(String path) {
		this.path=path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		int		current_page	= 1;
		if(req.getParameter("page")!=null)
				current_page	= Integer.parseInt(req.getParameter("page"));
		int		idx				= Integer.parseInt(req.getParameter("idx"));
		
		HttpSession	session		= req.getSession();
		ProductDAO	dao			= new ProductDAO();
		ProductVO	productVO	= dao.productGetRow(idx);
		
		if(productVO != null) {
			req.setAttribute("productVO", productVO);
			path+= "?page=" + current_page;
			//req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
		//return new ActionForward(path, true);
	}
}