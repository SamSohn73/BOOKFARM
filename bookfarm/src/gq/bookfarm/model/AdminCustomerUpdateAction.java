package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CustomerVO;

public class AdminCustomerUpdateAction implements Action {
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public AdminCustomerUpdateAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminCustomerUpdateAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminCustomerUpdateAction execute Start.");
		
		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCustomerUpdateAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		String current_page 			=	req.getParameter("page");
		int		idx						=	Integer.parseInt(req.getParameter("idx"));
		
		CustomerDAO 			dao		=	new CustomerDAO();
		CustomerVO 				vo		=	new CustomerVO();
		
		int						result	=	dao.updateRow(idx, vo);

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
