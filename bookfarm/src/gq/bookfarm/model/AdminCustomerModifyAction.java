package gq.bookfarm.model;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.AdminVO;
import gq.bookfarm.vo.CustomerVO;

public class AdminCustomerModifyAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public AdminCustomerModifyAction(String path)
	{
		super();
		this.path  = path;
		log.debug("AdminCustomerModifyAction Constructor. Destination path = " + path);
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		log.debug("AdminCustomerModifyAction execute Start.");
		
		HttpSession	session		= req.getSession();
		AdminVO		adminVO		= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO	= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminCustomerModifyAction execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.html";
			return new ActionForward(path, false);
		}
		
		String current_page 			=	req.getParameter("page");
		int		idx						=	Integer.parseInt(req.getParameter("idx"));
		
		
		CustomerVO	vo				=	new CustomerVO();
		CustomerDAO	dao				=	new	CustomerDAO();
		
										vo.setUsername	(req.getParameter("username"));
										vo.setPassword	(req.getParameter("password"));
										vo.setFirstname	(req.getParameter("name"));
										vo.setPostcode	(req.getParameter("postcode"));
										vo.setAddress1	(req.getParameter("address1"));
										vo.setAddress2	(req.getParameter("address2"));
										vo.setPhone1	(req.getParameter("phone1"));
										vo.setEmail1	(req.getParameter("email1"));
										vo.setGender	(req.getParameter("gender"));
		String		date_s			=	req.getParameter("birthday");
		SimpleDateFormat format		=	new SimpleDateFormat("yyyy-MM-dd");
		Date		parsed			=	format.parse(date_s);
		java.sql.Date	sql			=	new java.sql.Date(parsed.getTime());
										vo.setBirthday(sql);
		int			result			=	dao.updateRow(idx, vo);
	
		
		if(result <= 0) {
			log.debug("AdminCustomerModifyAction execute Failed.");
			path="error.html";
		}else {
		path+="?idx="+ idx +"&page="+current_page;
		}
		
		log.debug("AdminCustomerModifyAction execute End.");
		return new ActionForward(path, false);
	}

}

