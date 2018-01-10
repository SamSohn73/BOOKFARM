package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.vo.AdminVO;

public class AdminLoginAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public AdminLoginAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminLoginAction Constructor. Destination path = " + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("AdminLoginAction execute Start.");
		String	user_name	= req.getParameter("user_name");
		String	user_pass	= req.getParameter("user_pass");

		AdminDAO	dao		= new AdminDAO();
		AdminVO		adminVO	= dao.isAdmin(user_name, user_pass);

		if(adminVO != null) {
			HttpSession session	= req.getSession();
			session				.setAttribute("adminVO", adminVO);
			session				.setMaxInactiveInterval(60*30);
		}else {
			log.debug("AdminLoginAction execute Admin user_name, password not found. username, password=" + user_name + "," + user_pass);
			path="error.jsp";
		}

		log.debug("AdminLoginAction execute End.");
		return new ActionForward(path,true);
	}

}

