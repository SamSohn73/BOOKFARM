package gq.bookfarm.model;

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
		String current_page = req.getParameter("page");
		
		//board_num ��������
		int board_num=Integer.parseInt(req.getParameter("board_num"));
		
		adminProductDAO dao=new adminProductDAO();
			
		ProductVO vo=dao.getRow(board_num);
		if(vo!=null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}
	
		return new ActionForward(path, false);
	}
	

}
