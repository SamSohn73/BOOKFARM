package gq.bookfarm.model;

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
		//���� �������� ���� ���� �ʿ�
		String current_page = req.getParameter("page");
		
		//board_num ��������
		int idx=Integer.parseInt(req.getParameter
				("board_num"));
		
		//�ش� board_num�� ��ġ�ϴ� ���ڵ� �����ϱ�
		adminProductDAO dao=new adminProductDAO();
		int result=dao.Producdelete(idx);
		//���� �� ����Ʈ�� �̵�
		if(result==0) {
			path=""; //����������
		}else {
			path+="?page="+current_page;
		}
		return new ActionForward(path, true);
	}

}
