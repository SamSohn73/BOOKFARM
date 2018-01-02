package xyz.bookfarm.model;


import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		CustomerVO	vo				=	new CustomerVO();
		int			idx				=	Integer.parseInt((String)req.getAttribute("customer_idx"));
		int			result			=	0;
		
										vo.setUsername(req.getParameter("username"));
										vo.setPassword(req.getParameter("password"));
										vo.setFirstname(req.getParameter("firstname"));
										vo.setAddress1(req.getParameter("address1"));
										vo.setAddress2(req.getParameter("address2"));
										vo.setPhone1(req.getParameter("phone1"));
										vo.setEmail1(req.getParameter("email1"));
										//vo.setBirthday((Date)Integer.parseInt(req.getParameter("birthday")));
										//vo.isGender(req.getParameter("user_gender"));
												
		CustomerDAO	dao				=	new	CustomerDAO();
		
		if(type.equals("insert"))
		{
					result			=	dao.insert(vo);
		}
		else if(type.equals("modify"))
		{
					result			=	dao.updateRow(idx, vo);
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
		
			if(result>0)
										log.info("Successfully inserted...");
			else
			{
										log.error("QQQQQQQQ CustomerRegistAction error :"
										+ " customerDB was not updated.. ");
						path		=	"";	//에러페이지로 이동, 에러값 가지고
			}
		
		return new ActionForward(path, false);
	}
}
