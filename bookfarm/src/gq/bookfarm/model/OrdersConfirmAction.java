package gq.bookfarm.model;

import java.sql.Date;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.OrdersDAO;
import gq.bookfarm.dao.OrdersProductDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.OrdersProductVO;
import gq.bookfarm.vo.OrdersVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;

public class OrdersConfirmAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public OrdersConfirmAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession		session		=	req.getSession();
		CustomerVO		cVo			=	(CustomerVO) session.getAttribute("LoginedUserVO");
		int				customer_idx=	cVo.getIdx();
		
		String			type		=	"";
		if(req.getParameter("type")!=null)
						type		=	req.getParameter("type");
		int				page		=	1;
		OrdersDAO		dao			=	new OrdersDAO();
		OrdersProductDAO opDao		=	new OrdersProductDAO();
		ProductDAO		pDao		=	new ProductDAO();
		ProductVO		pVo			=	new ProductVO();
		Vector<String>	cs			=	null;
		
		
		if(type.equals("myPage"))
		{
			Vector<OrdersVO>		list	=	dao.singleCustomerordersList(customer_idx, 1, 5);
			
			for(OrdersVO vo:list)
			{
			Vector<OrdersProductVO>	opList	=	opDao.ordersProductGetRowsbyOrders(vo.getIdx());
			OrdersProductVO			opVo	=	opList.get(1);
			int						opLCount=	opList.size() - 1;
			String					addTag	=	"";
			if(opLCount > 0)
									addTag	=	" �� "+opLCount;
									pVo		=	pDao.productGetRow(opVo.getProducts_idx());
			
			String					c1		=	pVo.getProduct_name()+"  "/*+pVo.getProduct_image()+" "*/+addTag;
												cs.addElement(c1);
			}
				if(list!=null) 
				{
												req.setAttribute("cs", cs);
												req.setAttribute("list", list);
									path	+=	"?type="+type;
				}
				else
				{ 
												log.error("QQQQQQQQ OrdersConfirmAction - 'myPage' error");
												//path="";
				}
		}
		else if(type.equals("myList"))
		{
			if(req.getParameter("page")!=null)
				page		=	Integer.parseInt(req.getParameter("page"));
			PageVO					info	=	new PageVO();
			Vector<OrdersVO>		olist	=	dao.singleCustomerordersList(customer_idx);
			Vector<OrdersProductVO>	opList	=	null;
			int					totalRows	=	0;
				for(OrdersVO vo:olist)
				{
					int				id		=	vo.getIdx();
					Date			date	=	vo.getDate_purchased();
									opList	=	opDao.ordersProductGetRowsbyOrders(vo.getIdx());
					for(OrdersProductVO oVo:opList)
					{
												//vo ���� ����� �ű⿡ ���ʴ�� ���
										/*	=	id;
											=	date;
											=	pDao.productGetRow(oVo.getProducts_idx()).getProduct_name();
											=	oVo.getProducts_quantity();
											=	oVo.getFinal_price();*/
					}
								totalRows	+=	opDao.SingleOrderTotalRows(vo.getIdx());
				}
			int						limit	=	10;
			int					totalPages	=	(int)((double)totalRows/limit+0.95);
			int					startPage	=	((int)((double)page/10+0.9)-1)*10+1;
			int					endPage		=	startPage+10-1;
					
				if(endPage>totalPages)
								endPage		=	totalPages;		
				
												info.setPage(page);
												info.setTotalPages(totalPages);
												info.setTotalRows(totalRows);
												info.setStartPage(startPage);
												info.setEndPage(endPage);
			
			Vector<OrdersVO>		list	=	dao.singleCustomerordersList(customer_idx, endPage, limit);
				if(list!=null) 
				{
												req.setAttribute("list", list);
												req.setAttribute("info", info);
									path	+=	"?type="+type;
				}
				else
				{ 
												log.error("QQQQQQQQ OrdersConfirmAction - 'myList' error");
												//path="";
				}
		}
		
		
		
		else
		{
												log.error("QQQQQQQQ OrdersConfirmAction - type error : "+type);
												//path="";
		}
		
		
		return new ActionForward(path, false);
	}

}
