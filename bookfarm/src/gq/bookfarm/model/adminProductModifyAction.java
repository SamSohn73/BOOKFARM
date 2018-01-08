package gq.bookfarm.model;

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
		
		//���� �������� ���� ���� �ʿ�
		String current_page = req.getParameter("page");
		
		//board_view.jsp���� �Ѿ���� board_num ��������
		int idx=Integer.parseInt(req.getParameter("idx"));
		//board_num �� �̿��ؼ� ���� ��������
		adminProductDAO dao=new adminProductDAO();
		ProductVO vo=dao.getRow(idx);
		//������ ���� request �� ��� ������ �̵�
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
		return new ActionForward(path, false);
	}

}
