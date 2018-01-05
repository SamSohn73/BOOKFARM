package xyz.bookfarm.model;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.CustomerDAO;
import xyz.bookfarm.vo.CustomerVO;

public class CustomerRegistAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public CustomerRegistAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String		type			=	req.getParameter("type");
										System.out.println(type);
		CustomerVO	vo				=	new CustomerVO();
		CustomerDAO	dao				=	new	CustomerDAO();
				
		int			result			=	0;
		
										vo.setUsername(req.getParameter("username"));
										vo.setPassword(req.getParameter("password"));
										vo.setFirstname(req.getParameter("firstname"));
										vo.setPostcode(req.getParameter("postcode"));
										vo.setAddress1(req.getParameter("address1"));
										vo.setAddress2(req.getParameter("address2"));
										vo.setPhone1(req.getParameter("phone1"));
										vo.setEmail1(req.getParameter("email1"));
										vo.setGender(req.getParameter("user_gender"));
										
		String		date_s			=	req.getParameter("birthday");
		SimpleDateFormat format		=	new SimpleDateFormat("yyyyMMdd");
		Date		parsed			=	format.parse(date_s);
		java.sql.Date	sql			=	new java.sql.Date(parsed.getTime());
										vo.setBirthday(sql);
										System.out.println(sql);
										
		if(type.equals("insert"))
		{
					result			=	dao.insert(vo);
		}
		else if(type.equals("modify"))
		{
		HttpSession	session			=	req.getSession();
		CustomerVO	vo1				=	(CustomerVO)session.getAttribute("LoginedUserVO");
					result			=	dao.updateRow(vo1.getIdx(), vo);
					
										log.info("DB개인정보 갱신 후 세션도 갱신...시작 //바뀐 비번 : "+vo1.getPassword());
					vo				=	dao.pwdCheck(vo1.getUsername(), vo1.getPassword());
										session.setAttribute("LoginedUserVO", vo);
					path			=	"./member/mypage.jsp";
			
		}
		else if(type.equals("view"))
		{
			
		}
		else
		{
										log.error("QQQQQQQQ CustomerRegistAction error :"
										+ " type can not be recogized => "+type);
					path			=	"";	//에러페이지로 이동, 에러값 가지고
		}
		
		
		//result check
		if(result>0)
										log.info("Successfully inserted...");
		else
		{
										log.error("QQQQQQQQ CustomerRegistAction error :"
										+ " customerDB was not updated.. ");
					path			=	"";	//에러페이지로 이동, 에러값 가지고
		}
		
		return new ActionForward(path, true);
	}
}
