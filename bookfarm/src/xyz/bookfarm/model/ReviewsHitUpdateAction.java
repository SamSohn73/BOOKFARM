package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewsDAO;

public class ReviewsHitUpdateAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;	
	
	public ReviewsHitUpdateAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String		current_page	=	req.getParameter("page");
		int			idx				=	Integer.parseInt(req.getParameter("idx"));
		int			customers_idx	=	Integer.parseInt(req.getParameter("customers_idx"));
		int			products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
		String		type			=	req.getParameter("type");
		
		ReviewsDAO	dao				=	new ReviewsDAO();		
		int 		result			=	dao.hitUpdate(idx);
		if(result>0)
		{
			
			if(req.getParameter("customers_idx")!=null)
					path			+=	"?idx="+idx+"&customers_idx="+customers_idx+"type="+type;
			else if(req.getParameter("products_idx")!=null)
					path			+=	"?idx="+idx+"&products_idx="+products_idx+"type="+type;
			else
			{
										log.error("QQQQQQQQ ReviewsHitUpdateAction no"
												+ " products or customers idx error");
			}
		}
		else
		{
										log.error("QQQQQQQQ ReviewsHitUpdateAction error");
					path			=	"";
		}
		return new ActionForward(path, true);
	}

}
