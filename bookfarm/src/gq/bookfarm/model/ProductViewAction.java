package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CategoryDAO;
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
		ProductDAO	dao			= new ProductDAO();
		
		if(req.getParameter("page")!=null)
				current_page	= Integer.parseInt(req.getParameter("page"));
		int		idx				= Integer.parseInt(req.getParameter("idx"));
		String criteria			= req.getParameter("cri");
		String searchWord		= req.getParameter("word");
		if(req.getParameter("cri")==null || req.getParameter("word")==null) {
				criteria		= "category_idx";
				searchWord		= dao.productGetRow(idx).getCategory_idx()+"";
		}
		
		ProductVO	productVO	= dao.productGetRow(idx);
		
		System.out.println("정한솔 ㅈㄷㄱㅈㄹㅈㄷ: "+criteria+"//"+searchWord);
		
		if(productVO != null) {
			req.setAttribute("productVO", productVO);
			path+= "?page=" + current_page+"&cri="+criteria+"&word="+searchWord;
			//req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
		//return new ActionForward(path, true);
	}
}