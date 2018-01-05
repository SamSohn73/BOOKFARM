package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.ReviewDAO;

public class ReviewsDeleteAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private	String	path;
	public ReviewsDeleteAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
			int		page			=	(int)req.getAttribute("page");
			int		idx				=	(int)req.getAttribute("idx");
			String	type			=	(String)req.getAttribute("type");
			String	typeView		=	(String)req.getAttribute("typeView");
			
			ReviewDAO	dao			=	new	ReviewDAO();
			int		result			=	dao.delete(idx);
			
			if(result>0)
			{
										req.setAttribute("type", type);
			}
			else
			{
										log.error("QQQQQQQQ ReviewsDeleteAction error");
					path			=	"";
			}	
		
		return new ActionForward(path, false);
	}

}
