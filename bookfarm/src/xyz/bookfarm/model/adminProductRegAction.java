package adminProductmodel;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import adminDAO.adminProductDAO;
import adminVO.ProductVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductRegAction implements Action
{

private String path;	
	
	public adminProductRegAction(String path) {
		super();
		this.path = path;
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//qna_board_write.jsp에서 넘긴 값들 가져오기
		//파일업로드 기능을 구현했기 때문에 일반
		//request로 받아올 수 없음
		System.out.println("확인");
		//파일 업로드와 관련된 부분
		String saveDir="#";
		String uploadPath=req.getServletContext().getRealPath(saveDir);
		
		//파일 업로드 사이즈 제한
		int size=5*1024*1024;
		
		MultipartRequest multi;
		
		try {
			multi=new MultipartRequest(req,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
			
			//adminGoodsReg에서 넘긴 값 가져오기
			ProductVO vo = new ProductVO();
			vo.setCategory_idx		(Integer.parseInt	(multi.getParameter	("categories")));
			vo.setProduct_quantity	(Integer.parseInt	(multi.getParameter("products_quantity")));
			vo.setProduct_name		(multi.getParameter	("product_name"));
			//첨부된 파일 가져오기		
			vo.setProduct_image		(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
			vo.setProduct_price		(Integer.parseInt	(multi.getParameter("products_price")));
						
			
			//DAO 작업			
			adminProductDAO dao=new adminProductDAO();
			//DAO 메소드 호출 =>insert 작업하기
			int result=dao.insertProduc(vo);
			if(result==0) {
				path="#";
			}
		} catch (IOException e) {			
			e.printStackTrace();
		}
		
		//insert 성공하면 select.do 호출
		return new ActionForward(path, true);
	}

}
