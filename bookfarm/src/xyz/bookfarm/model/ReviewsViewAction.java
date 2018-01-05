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
		int		page				=	(int)req.getAttribute("page");
		int		idx					=	(int) req.getAttribute("idx");
		int		products_idx		=	0;
		String		type			=	(String)req.getAttribute("type");
		String		typeView		=	(String)req.getAttribute("typeView");
		
		if(typeView.equals("insert"))
		{
				products_idx		=	(int) req.getAttribute("products_idx");
										req.setAttribute("products_idx", products_idx);
		}
		else
		{
		ReviewDAO 	dao				=	new ReviewDAO();
		ReviewVO	vo				=	dao.getRow(idx);
			
			if(vo!=null) 
			{
										req.setAttribute("vo", vo);
										req.setAttribute("idx", idx);
					path			+=	"?type="+type+"&typeView="+typeView+"&page="+page;
				
			}
			else
			{
										log.error("QQQQQQQQ ReviewsViewAction error : vo is empty");
					path			=	"";
			}
		}
		
		
		return new ActionForward(path, false);
	}

}
