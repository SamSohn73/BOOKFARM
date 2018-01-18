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

public class AdminCustomerDeleteAction implements Action
{
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public AdminCustomerDeleteAction(String path)
	{
		super();
		this.path  = path;
		log.debug("AdminCustomerDeleteAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		log.debug("AdminCustomerDeleteAction execute Start.");
		
		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCustomerDeleteAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.html";
			return new ActionForward(path, false);
		}
		
		String current_page = req.getParameter("page");
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		CustomerDAO dao=new CustomerDAO();
		int result=dao.delete(idx);

		if(result <= 0) {
			log.debug("AdminCustomerDeleteAction execute Failed.");
			path="error.html"; 
		}else {
			path+="?page="+current_page;
		}
		log.debug("AdminCustomerDeleteAction execute End.");
		return new ActionForward(path, false);
	}

}
