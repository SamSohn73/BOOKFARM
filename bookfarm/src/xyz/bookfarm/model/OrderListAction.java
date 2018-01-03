package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.vo.CustomerVO;

public class OrderListAction implements Action {
	private String path;
	
	public OrderListAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		CustomerVO	vo			=	(CustomerVO)req.getAttribute("LoginedUserVO");
		
		
		return new ActionForward(path, false);
	}

}
