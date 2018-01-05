package adminProductmodel;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminDAO.adminProductDAO;
import adminVO.ProductVO;
import adminVO.pageVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductListAction implements Action
{
	private String path;

	public adminProductListAction(String path)
	{
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception
	{
		// DAO getList() ȣ����
		// ����ڰ� ������ ������ ��ȣ�� �´� �Խ��� ��� ��������

		// 1. ����ڰ� ������ ������ ��ȣ ��������
		int page = 1;

		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));

		adminProductDAO dao = new adminProductDAO();
		// 2. ��ü �Խù� �� ��������
		int total_rows = dao.total_rows();

		// 3. ���������� ������ ��� ���� ���ϱ�
		int limit = 10;

		// 4. list������ �ϴܿ� total_page ����
		int total_page = (int) ((double) total_rows / limit + 0.95);

		// 5. ���� ȭ�鿡�� ������ start ������ ���ϱ�
		int startPage = ((int) ((double) page / 10 + 0.9) - 1) * 10 + 1;

		// 6. ���� ȭ�鿡�� ������ end ������ ���ϱ�
		int endPage = startPage + 10 - 1;

		if (endPage > total_page)
			endPage = total_page;

		pageVO info = new pageVO();
		info.setPage(page);
		info.setTotalPage(total_page);
		info.setTotalRows(total_rows);
		info.setStartPage(startPage);
		info.setEndPage(endPage);

		// page �������� ���� ��� ��������

		// ������ ����� request�� ��� ������ �̵�
		Vector<ProductVO> list = dao.getList(page, limit);
		if (list != null) {
			req.setAttribute("list", list);
			req.setAttribute("info", info);
		} else {
			path = "";
		}

		return new ActionForward(path, false);
	}

}
