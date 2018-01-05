package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewDAO;

public class ReviewsHitUpdateAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;	
	
	public ReviewsHitUpdateAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		int			page			=	Integer.parseInt(req.getParameter("page"));
		int			idx				=	Integer.parseInt(req.getParameter("idx"));		
		String		type			=	req.getParameter("type");
		String		typeView		=	req.getParameter("typeView");
		
		ReviewDAO	dao				=	new ReviewDAO();		
		int 		result			=	dao.hitUpdate(idx);
		if(result>0)
		{
			if(type.equals("myPage"))
			{
										req.setAttribute("idx", idx);
										req.setAttribute("page", page);
										req.setAttribute("type", type);
										req.setAttribute("typeView", typeView);
					//path			+=	"?idx="+idx+"&customers_idx="+customers_idx+"type="+type;
			}
			else if(type.equals("myList"))
			{
										req.setAttribute("idx", idx);
										req.setAttribute("page", page);
										req.setAttribute("type", type);
										req.setAttribute("typeView", typeView);
					//path			+=	"?idx="+idx+"&customers_idx="+customers_idx+"type="+type;
			}
			else if(type.equals("list"))
			{
										req.setAttribute("idx", idx);
										req.setAttribute("page", page);			
										req.setAttribute("type", type);
										req.setAttribute("typeView", typeView);
					//path			+=	"?idx="+idx+"&products_idx="+products_idx+"type="+type;
			}
			else
			{
										log.error("QQQQQQQQ ReviewsHitUpdateAction no"
										+ " type 형태가 틀림 : "+type);				
			}
			System.out.println("중간idx확인 : "+idx);
		}
		else
		{
										log.error("QQQQQQQQ ReviewsHitUpdateAction error");
					path			=	"";
		}
		return new ActionForward(path, false);
	}

}
