package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewsDAO;

public class ReviewsDeleteAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private	String	path;
	public ReviewsDeleteAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
			int		page			=	1;
			String	type			=	(String)req.getAttribute("type");
			int		idx				=	Integer.parseInt((String)req.getAttribute("idx"));
			int		products_idx	=	0;
			int		customers_idx	=	0;
			
			if(((String)req.getAttribute("products_idx"))!=null)	
					products_idx	=	Integer.parseInt((String)req.getAttribute("products_idx"));
			if(((String)req.getAttribute("customers_idx"))!=null)	
					customers_idx	=	Integer.parseInt((String)req.getAttribute("customers_idx"));			
			if(((String)req.getAttribute("page"))!=null)
					page			=	Integer.parseInt((String)req.getAttribute("page"));
	
			ReviewsDAO	dao			=	new	ReviewsDAO();
			int		result			=	dao.delete(idx);
			
			if(result>0)
			{
										req.setAttribute("page", page);
										req.setAttribute("type", type);
										req.setAttribute("products_idx", products_idx);
										req.setAttribute("customers_idx", customers_idx);
			}
			else
			{
										log.error("QQQQQQQQ ReviewsDeleteAction error");
					path			=	"";
			}	
		
		return new ActionForward(path, false);
	}

}
