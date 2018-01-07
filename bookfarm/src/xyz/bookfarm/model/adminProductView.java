package adminProductmodel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminDAO.adminProductDAO;
import adminVO.ProductVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductView implements Action
{
	private String path;
	
	public adminProductView(String path) {
		this.path=path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String current_page = req.getParameter("page");
		
		System.out.println(" view : "+current_page);
		
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		adminProductDAO dao=new adminProductDAO();
			
		ProductVO vo=dao.getRow(idx);
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
	}
}
