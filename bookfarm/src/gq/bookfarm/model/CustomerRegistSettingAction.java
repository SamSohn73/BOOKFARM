package gq.bookfarm.model;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		log.info(" CustomerRegistSettingAction started... path : "+path);
		
		HttpSession		session		=	req.getSession();
		String			type		=	req.getParameter("type");
		CustomerVO		vo			=	new CustomerVO();
		int				year		=	0;
		int				month		=	0;
		int				day			=	0;
		int				dayLimit	=	0;
		
		if(session.getAttribute("loggedInUserVO")!=null){
						vo			=	(CustomerVO)session.getAttribute("loggedInUserVO");
		//SimpleDateFormat format		=	new SimpleDateFormat("yyyy-MM-dd");
		Date			date		=	vo.getBirthday();
		
		SimpleDateFormat dy			=	new SimpleDateFormat("yyyy");
						year		=	Integer.parseInt(dy.format(date));
		
		SimpleDateFormat dm			=	new SimpleDateFormat("MM");
						month		=	Integer.parseInt(dm.format(date));
									
		SimpleDateFormat dd			=	new SimpleDateFormat("dd");
						day			=	Integer.parseInt(dd.format(date));
		}
		if(req.getParameter("username")!=null)
										vo.setUsername(req.getParameter("username"));
		if(req.getParameter("password")!=null)
										vo.setPassword(req.getParameter("password"));
		if(req.getParameter("firstname")!=null)
										vo.setFirstname(req.getParameter("firstname"));
		if(req.getParameter("postcode")!=null)
										vo.setPostcode(req.getParameter("postcode"));
		if(req.getParameter("address1")!=null)
										vo.setAddress1(req.getParameter("address1"));
		if(req.getParameter("address2")!=null)
										vo.setAddress2(req.getParameter("address2"));
		if(req.getParameter("phone1")!=null)
										vo.setPhone1(req.getParameter("phone1"));
		if(req.getParameter("email1")!=null)
										vo.setEmail1(req.getParameter("email1"));
		if(req.getParameter("user_gender")!=null)
										vo.setGender(req.getParameter("user_gender"));
		if(req.getParameter("year")!=null)
						year		=	Integer.parseInt(req.getParameter("year"));
		if(req.getParameter("month")!=null)
						month		=	Integer.parseInt(req.getParameter("month"));
		if(req.getParameter("day")!=null)
						day			=	Integer.parseInt(req.getParameter("day"));
		
		
		if((month==1) || (month==3) || (month==5) || (month==7) || (month==8) || (month==10) || (month==12)){
						dayLimit	=	31;
		}else if((month==4) || (month==6) || (month==9) || (month==11)){
						dayLimit	=	30;
		}else if(month==2){
			if((year%4==0) && (year%100!=0) || (year%400==0))
						dayLimit	=	29;
			else
						dayLimit	=	28;
		}
		
										req.setAttribute("vo",vo);
										req.setAttribute("year", year);
										req.setAttribute("month", month);
										req.setAttribute("day", day);
										req.setAttribute("dayLimit", dayLimit);
						path		+=	"?type="+type;
						log.info(" CustomerRegistSettingAction started... path : "+path);
		return new ActionForward(path,false);
	}

}
