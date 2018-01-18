package gq.bookfarm.model;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.OrdersDAO;
import gq.bookfarm.dao.OrdersProductDAO;
import gq.bookfarm.vo.BasketVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.ProductVO;

public class OrderFinishAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public OrderFinishAction(String path)
	{
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		Vector<BasketVO> VbVo			=	(Vector<BasketVO>)req.getAttribute("VbVo");
		Vector<ProductVO> VpVo			=	(Vector<ProductVO>)req.getAttribute("VpVo");
		int				result			=	0;
		int				result1			=	0;
		
		String			username		=	req.getParameter("username");
		String			firstname		=	req.getParameter("firstname");
		String			phone			=	req.getParameter("phone");
		String			email			=	req.getParameter("email");
		String			postcode		=	req.getParameter("postcode");
		String			add1			=	req.getParameter("add1");
		String			add2			=	req.getParameter("add2");
		int				total			=	Integer.parseInt(req.getParameter("total"));
		
		OrdersDAO		oDao			=	new OrdersDAO();
		OrdersProductDAO opDao			=	new OrdersProductDAO();
		
		HttpSession		session			=	req.getSession();
		if(session.getAttribute("loggedInUserVO")!=null) {
		CustomerVO		cVo				=	(CustomerVO)session.getAttribute("loggedInUserVO");
											
						result			=	oDao.ordersInsert(cVo.getIdx(), cVo.getFirstname(),
											cVo.getPostcode(), cVo.getAddress1(), cVo.getAddress2(),
											cVo.getPhone1(), cVo.getPhone2(), cVo.getPhone3(),
											cVo.getEmail1(), cVo.getEmail2(), firstname,
											postcode, add1, add2, phone, "", "", email,
											"", "", total);
		}else {
						result			=	oDao.ordersInsert(0, firstname, postcode, add1, add2,
											phone, "", "", email, "", firstname, postcode, add1, add2,
											phone, "", "", email, "", "", total);
		}
		
		
		System.out.println("구매직전 정한솔 idx확인 : "+oDao.getMaxIdx());
		
		for(BasketVO bVo:VbVo) {
						result1			=	opDao.ordersProductInsert(oDao.getMaxIdx(),
											bVo.getProduct_idx(), bVo.getQuantity(), bVo.getFinal_price());
			if(result1>0) {
											log.error("OrderFinishAction Error!!!!구매직전 에러->OrderProductDB에 삽입 안됨!!");
						path			=	"error.jsp";
			}
		}
		
		if(result>0) {
			
		}else {
											log.error("OrderFinishAction Error!!!!구매직전 에러->OrderDB에 삽입 안됨!!");
						path			=	"error.jsp";
		}
		
		
		return new ActionForward(path, false);
	}

}
