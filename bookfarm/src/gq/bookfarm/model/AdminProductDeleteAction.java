package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.AdminVO;

public class AdminProductDeleteAction implements Action
{
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			String				path;
	
	public AdminProductDeleteAction(String path) {
		super();
		log.debug("AdminProductDeleteAction create Start.");
		this.path  = path;
		log.debug("AdminProductDeleteAction create End. path=" + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		log.debug("AdminProductDeleteAction execute Start.");
		
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminOrdersList execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.html";
			return new ActionForward(path, false);
		}
		
		String		current_page	=	req.getParameter("page");
		int			idx				=	Integer.parseInt(req.getParameter("idx"));
		
		ProductDAO	dao				=	new ProductDAO();
		int			result			=	dao.productDelete(idx);

		if(result <= 0) {
			log.debug("AdminProductDeleteAction execute Failed.");
			path="error.html"; 
		}else {
			path+="?page="+current_page;
		}
		log.debug("AdminProductDeleteAction execute End.");
		
		return new ActionForward(path, false);
	}

}
