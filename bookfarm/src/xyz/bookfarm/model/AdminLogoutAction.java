package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;

public class AdminLogoutAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	private String path;
	
	public AdminLogoutAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminLogoutAction execute Start.");
		HttpSession	session	=	req.getSession(false);
		
		session.invalidate();
		log.debug("AdminLogoutAction execute End.");
		return new ActionForward(path, false);
	}
}
