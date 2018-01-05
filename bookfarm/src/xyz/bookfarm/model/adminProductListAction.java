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
		// DAO getList() 호출한
		// 사용자가 선택한 페이지 번호에 맞는 게시판 목록 가져오기

		// 1. 사용자가 선택한 페이지 번호 가져오기
		int page = 1;

		if (req.getParameter("page") != null)
			page = Integer.parseInt(req.getParameter("page"));

		adminProductDAO dao = new adminProductDAO();
		// 2. 전체 게시물 수 가져오기
		int total_rows = dao.total_rows();

		// 3. 한페이지에 보여줄 목록 갯수 정하기
		int limit = 10;

		// 4. list페이지 하단에 total_page 결정
		int total_page = (int) ((double) total_rows / limit + 0.95);

		// 5. 현재 화면에서 보여줄 start 페이지 구하기
		int startPage = ((int) ((double) page / 10 + 0.9) - 1) * 10 + 1;

		// 6. 현재 화면에서 보여줄 end 페이지 구하기
		int endPage = startPage + 10 - 1;

		if (endPage > total_page)
			endPage = total_page;

		pageVO info = new pageVO();
		info.setPage(page);
		info.setTotalPage(total_page);
		info.setTotalRows(total_rows);
		info.setStartPage(startPage);
		info.setEndPage(endPage);

		// page 변수값에 따라 목록 가져오기

		// 가져온 목록을 request에 담고 페이지 이동
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
