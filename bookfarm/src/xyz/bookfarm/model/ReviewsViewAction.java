package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewDAO;
import xyz.bookfarm.vo.ReviewVO;

public class ReviewsViewAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public ReviewsViewAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String		page			=	(String)req.getAttribute("page");
		int			idx				=	Integer.parseInt((String)req.getAttribute("idx"));
		int			customers_idx	=	Integer.parseInt((String)req.getAttribute("customers_idx"));
		int			products_idx	=	Integer.parseInt((String)req.getAttribute("products_idx"));
		String		type			=	(String)req.getAttribute("type");
		String		typeView		=	(String)req.getAttribute("typeView");
		
		ReviewDAO 	dao				=	new ReviewDAO();
			
		ReviewVO	vo				=	dao.getRow(idx);
		
		if(vo!=null) 
		{
										req.setAttribute("vo", vo);
										req.setAttribute("page", page);
										req.setAttribute("type", type);
										req.setAttribute("typeView", typeView);
										req.setAttribute("idx", idx);
			if(req.getParameter("customers_idx")!=null)
										req.setAttribute("customers_idx", customers_idx);
			else if(req.getParameter("products_idx")!=null)
										req.setAttribute("products_idx", products_idx);
			else
			{
										log.error("QQQQQQQQ ReviewsViewAction no"
												+ " products or customers idx error");
			}
		}
		else
		{
										log.error("QQQQQQQQ ReviewsViewAction error : vo is empty");
					path			=	"";
		}
		
		return new ActionForward(path, false);
	}

}
