package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewsDAO;
import xyz.bookfarm.vo.ReviewsVO;

public class ReviewsViewAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public ReviewsViewAction(String path) {
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
		
		ReviewsDAO 	dao				=	new ReviewsDAO();
			
		ReviewsVO	vo				=	dao.getRow(idx);
		
		if(vo!=null) 
		{
										req.setAttribute("vo", vo);
										req.setAttribute("page", current_page);
										req.setAttribute("type", type);
			if(req.getParameter("customers_idx")!=null)
					path			+=	"?customers_idx="+customers_idx;
			else if(req.getParameter("products_idx")!=null)
					path			+=	"?products_idx="+products_idx;
			else
			{
										log.error("QQQQQQQQ ReviewsViewAction no"
												+ " products or customers idx error");
			}
		}
		else
		{
										log.error("QQQQQQQQ ReviewsViewAction error");
					path			=	"";
		}
		
		return new ActionForward(path, true);
	}

}
