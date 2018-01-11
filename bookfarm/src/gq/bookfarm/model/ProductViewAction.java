package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String current_page=req.getParameter("page");
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		ProductDAO dao=new ProductDAO();
			
		ProductVO vo=dao.productGetRow(idx);
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
	}
}