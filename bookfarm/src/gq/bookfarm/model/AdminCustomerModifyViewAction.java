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

public class AdminCustomerModifyViewAction implements Action {
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public AdminCustomerModifyViewAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminCustomerModifyViewAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminCustomerModifyViewAction execute Start.");
		
		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCustomerModifyViewAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.jsp";
		}
		
		int		current_page			=	Integer.parseInt(req.getParameter("page"));
		int		idx						=	Integer.parseInt(req.getParameter("idx"));
		
		CustomerDAO 			dao		=	new CustomerDAO();
		CustomerVO 				vo		=	dao.getRow(idx);

		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
			path+="?page="+current_page;
		} else {
			log.debug("AdminCustomerModifyViewAction execute Failed.");
			path="error.jsp"; 
		}
		
		/*if(result==0) {
			log.debug("AdminCustomerModifyAction execute Failed.");
			path="error.jsp"; 
		}else {
			path+="?page="+current_page;
		}*/
		
		
		log.debug("AdminCustomerModifyViewAction execute End.");
		return new ActionForward(path, false);
	}

}

