package gq.bookfarm.model;

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
		String saveDir="#";
		String uploadPath=req.getServletContext().getRealPath(saveDir);
		
		int size=5*1024*1024;
		
		MultipartRequest multi;
		
		try {
			multi=new MultipartRequest(req,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
			
			ProductVO vo = new ProductVO();
			vo.setCategory_idx		(Integer.parseInt	(multi.getParameter	("categories")));
			vo.setProduct_quantity	(Integer.parseInt	(multi.getParameter("products_quantity")));
			vo.setProduct_name		(multi.getParameter	("product_name"));
			vo.setProduct_image		(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
			vo.setProduct_price		(Integer.parseInt	(multi.getParameter("products_price")));
						
			
			adminProductDAO dao=new adminProductDAO();
			//DAO �޼ҵ� ȣ�� =>insert �۾��ϱ�
			int result=dao.insertProduc(vo);
			if(result==0) {
				path="#";
			}
		} catch (IOException e) {			
			e.printStackTrace();
		}
		
		return new ActionForward(path, true);
	}

}
