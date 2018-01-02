package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		int			idx			=	0;
		String		type		=	req.getParameter("type");
		
		if(req.getAttribute("type")!=null)
					type		=	(String)req.getAttribute("type");
		
		CustomerDAO	dao			=	new	CustomerDAO();
					idx			=	dao.pwdCheck(username, password);
					
			if(idx>0)
			{
		CustomerVO	vo			=	new	CustomerVO();
					vo			=	dao.getRow(idx);
									req.setAttribute("LoginedUserVO", vo);
									req.setAttribute("customer_idx", idx);
									
				if(vo==null)
				{
									log.error("QQQQQQQQ CustomerIdPwdCheckAction error :"
									+ " DB can not get customer data");
				}
				
				if(type=="modify")
					path		=	"./member/regist_v2.jsp?type=modify";
				else if(type=="login")
				{
				int	result		=	dao.login(idx);
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
			}
			else
			{
									log.error("QQQQQQQQ CustomerIdPwdCheckAction error : "
									+ "DB can not get idx");
					path		=	"";	//에러페이지로 이동, 에러값 가지고
			}
			
		return new ActionForward(path, true);
	}

}
