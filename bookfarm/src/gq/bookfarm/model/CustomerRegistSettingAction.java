package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.vo.CustomerVO;

public class CustomerRegistSettingAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	
	public CustomerRegistSettingAction(String path)
	{
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String			type		=	req.getParameter("type");
		CustomerVO		vo			=	new CustomerVO();
		CustomerDAO		dao			=	new	CustomerDAO();
		int				year		=	0;
		int				month		=	0;
		int				day			=	0;
										vo.setUsername(req.getParameter("username"));
										vo.setPassword(req.getParameter("password"));
										vo.setFirstname(req.getParameter("firstname"));
										vo.setPostcode(req.getParameter("postcode"));
										vo.setAddress1(req.getParameter("address1"));
										vo.setAddress2(req.getParameter("address2"));
										vo.setPhone1(req.getParameter("phone1"));
										vo.setEmail1(req.getParameter("email1"));
										vo.setGender(req.getParameter("user_gender"));
										
		if(req.getParameter("year")!=null)
						year		=	Integer.parseInt(req.getParameter("year"));
		if(req.getParameter("month")!=null)
						month		=	Integer.parseInt(req.getParameter("month"));
		if(req.getParameter("day")!=null)
						day			=	Integer.parseInt(req.getParameter("day"));
		
		if(type.equals("dateInsert")) {
						type		=	"insert";
		}else if(type.equals("dateModi")) {
						type		=	"modify";
		}else {
			
		}
										req.setAttribute("workingUserVO",vo);
										req.setAttribute("year", year);
										req.setAttribute("month", month);
										req.setAttribute("day", day);
						path		+=	"?type="+type;
		
		return new ActionForward(path,false);
	}

}
