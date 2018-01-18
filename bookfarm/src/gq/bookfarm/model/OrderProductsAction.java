package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.BasketVO;
import gq.bookfarm.vo.ProductVO;

public class OrderProductsAction implements Action {

	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public OrderProductsAction(String path)
	{
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		int			product_idx			=	0;
		int			quantity			=	0;
		
		HttpSession	session				=	req.getSession();
		Vector<BasketVO> VbVo			=	new Vector<BasketVO>();
		Vector<ProductVO> VpVo			=	new Vector<ProductVO>();
		ProductDAO	pDao				=	new ProductDAO();
		ProductVO	pVo					=	new ProductVO();
		
		if(req.getParameter("product_idx")!=null) {
					product_idx			=	Integer.parseInt(req.getParameter("product_idx"));
					quantity			=	Integer.parseInt(req.getParameter("quantity"));
					
					pDao				=	new ProductDAO();
					pVo					=	pDao.productGetRow(product_idx);
		
											req.setAttribute("pVo", pVo);
											req.setAttribute("quantity", quantity);
		}else if(session.getAttribute("baskets")!=null){
					VbVo				=	(Vector<BasketVO>)session.getAttribute("baskets");
					for(BasketVO bVo:VbVo) {
					pVo					=	pDao.productGetRow(bVo.getProduct_idx());
											VpVo.add(pVo);
					}
											req.setAttribute("VpVo", VpVo);
		}
		return new ActionForward(path, false);
	}

}
