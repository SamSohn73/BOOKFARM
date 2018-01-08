package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.CustomerVO;

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
		
		CustomerDAO	dao			=	new	CustomerDAO();
		CustomerVO	vo			=	new	CustomerVO();
		CustomerVO	LoginedVO	=	null;
		HttpSession	session		=	req.getSession();
		
		if(type.equals("modify"))
		{
					LoginedVO	=	(CustomerVO)session.getAttribute("LoginedUserVO");
					vo			=	dao.pwdCheck(username, password);
			if(LoginedVO.getIdx()==vo.getIdx())
			{
									//req.setAttribute("vo", vo);
					path		=	"./member/regist_v2.jsp";
					result		=	vo.getIdx();	//�ƹ� ���� �־���-> ���������� ������ �� Ȯ��
			}
		}
		else if(type.equals("login"))
		{
					vo			=	dao.pwdCheck(username, password);
			if(vo != null)
			{
									session.setAttribute("LoginedUserVO", vo);
					result		=	dao.login(vo.getIdx());
			}
			else
			{
									log.error("QQQQQQQQ CustomerIdPwdCheckAction error :"
									+ " DB can not get customer data");
					path		=	"view/error.jsp?type=login";
			}
					
		}
		
		
		//result check
		if(result>0)
		{
							log.info("Successfully logined...or modify check is Ok!!!!!!");
		}
		else
		{
							log.error("QQQQQQQQ CustomerIdPwdCheckAction error :"
							+ " DB can not get customer data or customer's id,pass were wrong..");
			path		=	"";	//������������ �̵�, ������ ������
		}
			
		return new ActionForward(path, true);
	}

}
