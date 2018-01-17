package gq.bookfarm.model;


import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.CustomerVO;

public class CustomerRegistAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public CustomerRegistAction(String path)
	{
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		String		type			=	req.getParameter("type");
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
		
		int				year		=	Integer.parseInt(req.getParameter("year"));
		int				month		=	Integer.parseInt(req.getParameter("month"));
		int				day			=	Integer.parseInt(req.getParameter("day"));
		
		
		String			date_s		=	year+"-"+month+"-"+day;
		SimpleDateFormat format		=	new SimpleDateFormat("yyyy-MM-dd");
		Date			parsed		=	format.parse(date_s);
		java.sql.Date	sql			=	new java.sql.Date(parsed.getTime());
										vo.setBirthday(sql);
										
		if(type.equals("insert")) {
						result		=	dao.insert(vo);
		}
		else if(type.equals("modify")) {
			HttpSession	session		=	req.getSession();
			CustomerVO	vo1			=	(CustomerVO)session.getAttribute("loggedInUserVO");
						result		=	dao.updateRow(vo1.getIdx(), vo);
						vo			=	dao.pwdCheck(vo1.getUsername(), vo1.getPassword());
										session.setAttribute("loggedInUserVO", vo);
						path		=	"./member/mypage.jsp";
			
		} else if(type.equals("view")) {
			
		} else {
										log.error("CustomerRegistAction error :"
										+ " type can not be recogized => "+type);
						path		=	"error.jsp";
		}
		
		//result check
		if(result>0)
										log.info("Successfully inserted...");
		else {
										log.error("CustomerRegistAction error :customerDB was not updated.. ");
						path		=	"error.jsp";
		}
		
		return new ActionForward(path, true);
	}
}
