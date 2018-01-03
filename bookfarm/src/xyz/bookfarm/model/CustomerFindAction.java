package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.CustomerDAO;
import xyz.bookfarm.vo.CustomerVO;

public class CustomerFindAction implements Action {
	private String path;
	public CustomerFindAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String	phone1		=	req.getParameter("phone1");
		String	firstname	=	req.getParameter("firstname");
		
		CustomerVO	vo		=	new	CustomerVO();
		CustomerDAO	dao		=	new	CustomerDAO();
					vo		=	dao.find(phone1, firstname);
					
								req.setAttribute("username", vo.getUsername());
								
		
		
		
		return new ActionForward(path, false);
	}

}
