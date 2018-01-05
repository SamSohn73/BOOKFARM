package adminProductmodel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminDAO.adminProductDAO;
import adminVO.ProductVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductReviewAction implements Action
{

	private String path;
	
	public adminProductReviewAction(String path)
	{
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		//���� �������� ���� ���� �ʿ�
		String current_page = req.getParameter("page");
		
		System.out.println(" view : "+current_page);
		
		//qna_board_list.jsp �Ѿ���� �� ��������
		//board_num ��������
		int board_num=Integer.parseInt(req.getParameter("board_num"));
		
		adminProductDAO dao=new adminProductDAO();
			
		//board_num�� ��ġ�ϴ� DB ���� ��������
		ProductVO vo=dao.getRow(board_num);
		//������ ���� ��� ������ �̵�
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
	}
	

}
