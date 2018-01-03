package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.CustomerDAO;

public class CustomerLogoutAction implements Action {
	private String path;
	
	public CustomerLogoutAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		int			idx		=	Integer.parseInt((String)req.getAttribute("customer_idx"));
		CustomerDAO	dao		=	new	CustomerDAO();
								dao.logout(idx);
		
		HttpSession	session	=	req.getSession(false);
		if(session.getAttribute("LoginedUserVO") != null)
		{
								session.invalidate();
		}
		else
		{
					path	=	"";
		}
		
		return new ActionForward(path, false);
	}

}
