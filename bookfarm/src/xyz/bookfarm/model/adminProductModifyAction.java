package adminProductmodel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminDAO.adminProductDAO;
import adminVO.ProductVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductModifyAction implements Action
{
	private String path;
	
	public adminProductModifyAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//현재 페이지로 가기 위해 필요
		String current_page = req.getParameter("page");
		
		//board_view.jsp에서 넘어오는 board_num 가져오기
		int idx=Integer.parseInt(req.getParameter("idx"));
		//board_num 값 이용해서 내용 가져오기
		adminProductDAO dao=new adminProductDAO();
		ProductVO vo=dao.getRow(idx);
		//가져온 내용 request 에 담고 페이지 이동
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
		return new ActionForward(path, false);
	}

}
