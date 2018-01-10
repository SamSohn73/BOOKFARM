package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.CustomerVO;

public class AdminCustomerUpdateAction implements Action {
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public AdminCustomerUpdateAction(String path) {
		super();
		log.debug("AdminCustomerUpdateAction create Start.");
		this.path  = path;
		log.debug("AdminCustomerUpdateAction create End. path=" + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminCustomerUpdateAction execute Start.");
		String current_page 			=	req.getParameter("page");
		log.debug("AdminCustomerUpdateAction execute Page=" + current_page);
		int		idx						=	Integer.parseInt(req.getParameter("idx"));
		
		CustomerDAO 			dao		=	new CustomerDAO();
		CustomerVO 				vo		=	new CustomerVO();
		
		int						result	=	dao.updateRow(idx, vo);
/*		if(result>0)
		{
								req.setAttribute("idx", idx);
								req.setAttribute("page", current_page);
		}*/
		if(result==0) {
			log.debug("AdminCustomerUpdateAction execute Failed.");
			path="error.jsp"; 
		}else {
			path+="?page="+current_page;
		}
		
		
		log.debug("AdminCustomerUpdateAction execute End.");
		return new ActionForward(path, false);
	}

}
