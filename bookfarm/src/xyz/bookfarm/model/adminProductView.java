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
		
		//현재 페이지로 가기 위해 필요
		String current_page = req.getParameter("page");
		
		System.out.println(" view : "+current_page);
		
		//qna_board_list.jsp 넘어오는 값 가져오기
		//board_num 가져오기
		int idx=Integer.parseInt(req.getParameter("idx"));
		
		adminProductDAO dao=new adminProductDAO();
			
		//board_num과 일치하는 DB 내용 가져오기
		ProductVO vo=dao.getRow(idx);
		//가져온 내용 담고 페이지 이동
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
	}
}
