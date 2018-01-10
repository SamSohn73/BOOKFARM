package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;

public class AdminCustomerDeleteAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public AdminCustomerDeleteAction(String path) {
		super();
		log.debug("AdminCustomeDeleteAction create Start.");
		this.path  = path;
		log.debug("AdminCustomeDeleteAction create End. path=" + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminCustomerDeleteAction execute Start.");
		String current_page = req.getParameter("page");
		log.debug("AdminCustomerDeleteAction execute Page=" + current_page);
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		CustomerDAO dao=new CustomerDAO();
		int result=dao.delete(idx);

		if(result==0) {
			log.debug("AdminCustomerDeleteAction execute Failed.");
			path="error.jsp"; 
		}else {
			path+="?page="+current_page;
		}
		log.debug("AdminCustomerDeleteAction execute End.");
		return new ActionForward(path, false);
	}

}
