package adminProductmodel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminDAO.adminProductDAO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductDeleteAction implements Action
{
	private String path;
	
	public adminProductDeleteAction(String path) {
		this.path=path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//현재 페이지로 가기 위해 필요
		String current_page = req.getParameter("page");
		
		//board_num 가져오기
		int idx=Integer.parseInt(req.getParameter
				("board_num"));
		
		//해당 board_num과 일치하는 레코드 삭제하기
		adminProductDAO dao=new adminProductDAO();
		int result=dao.Producdelete(idx);
		//삭제 후 리스트로 이동
		if(result==0) {
			path=""; //에러페이지
		}else {
			path+="?page="+current_page;
		}
		return new ActionForward(path, true);
	}

}
