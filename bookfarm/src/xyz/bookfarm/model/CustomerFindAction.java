package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.dao.CustomerDAO;
import xyz.bookfarm.vo.CustomerVO;

public class CustomerFindAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	public CustomerFindAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String	phone1		=	req.getParameter("phone1");
		String	firstname	=	req.getParameter("firstname");
		
		CustomerVO	vo		=	null;
		CustomerDAO	dao		=	new	CustomerDAO();
					vo		=	dao.find(phone1, firstname);
		if(vo!=null)
								req.setAttribute("username", vo.getUsername());
		else
		{
								log.error("QQQQQQQQ CustomerFindAction error :"
								+ " There is no search customer in DB who has same phone, "
								+ "firstname which you typed....");
				path		=	"view/error.jsp?type=find";
		}
		
		return new ActionForward(path, false);
	}

}
