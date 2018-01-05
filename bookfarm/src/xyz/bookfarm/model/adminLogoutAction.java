package adminProductmodel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import adminDAO.adminProductDAO;
import adminVO.AdministratorVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminLogoutAction implements Action
{
	private String path;
	
	public adminLogoutAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		HttpSession		session	=	req.getSession();
		AdministratorVO		vo		=	(AdministratorVO)session.getAttribute("LoginedUserVO");
		int				idx		=	vo.getIdx();
						session	=	req.getSession(false);
		if(session.getAttribute("LoginedUserVO") != null)
		{			
			adminProductDAO	dao		=	new	adminProductDAO();
									dao.logout(idx);
									session.invalidate();
		}
		else
		{
						path	=	"";
		}
		
		return new ActionForward(path, false);
	}
}
