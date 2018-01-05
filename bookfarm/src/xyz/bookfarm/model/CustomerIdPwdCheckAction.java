package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.CustomerDAO;
import xyz.bookfarm.vo.CustomerVO;

public class CustomerIdPwdCheckAction implements Action {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
		
	public CustomerIdPwdCheckAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String		username	=	req.getParameter("username");
		String		password	=	req.getParameter("password");
		String		type		=	req.getParameter("type");
		int			result		=	0;
		/*if(req.getAttribute("type")!=null)
					type		=	(String)req.getAttribute("type");*/		
		HttpSession	session		=	req.getSession();
		CustomerDAO	dao			=	new	CustomerDAO();
		CustomerVO	vo			=	new	CustomerVO();
					
		
		if(type=="modify")
		{
					vo			=	(CustomerVO) session.getAttribute("LoginedUserVO");
									req.setAttribute("vo", vo);
					path		=	"./member/regist_v2.jsp?type=modify";
					
					
					
		}
		else if(type=="login")
		{
					vo			=	dao.pwdCheck(username, password);
			if(vo != null)
			{
									session.setAttribute("LoginedUserVO", vo);
					result		=	dao.login(vo.getIdx());
				if(result>0)
				{
									log.info("Successfully logined...");
				}
				else
				{
									log.error("QQQQQQQQ CustomerIdPwdCheckAction error :"
									+ " DB can not get customer data");
					path		=	"";	//에러페이지로 이동, 에러값 가지고
				}
			}
			else
			{
									log.error("QQQQQQQQ CustomerIdPwdCheckAction error :"
									+ " DB can not get customer data");
					path		=	"view/error.jsp?type=login";
			}
		}
			
		return new ActionForward(path, true);
	}

}
