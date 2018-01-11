package gq.bookfarm.model;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.ProductVO;


public class AdminProductModifyAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public AdminProductModifyAction(String path) {
		super();
		log.debug("AdminProductModifyAction create Start.");
		this.path  = path;
		log.debug("AdminProductModifyAction create End. path=" + path);
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception 
	{
		//qna_board_modify.jsp에서 넘어온 데이터 가져오기
		//파일 업로드와 관련된 준비
		String saveDir="/boardUpload";
		String uploadPath=req.getServletContext().getRealPath(saveDir);
		
		int size=5*1024*1024;
		MultipartRequest multi;
		//board_subject,board_content,board_file
		//board_num,board_pass
		try {
			multi = new MultipartRequest(req, uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
			
			log.debug("AdminProductModifyAction execute Start.");
			int		current_page			=	Integer.parseInt(multi.getParameter("page"));
			log.debug("AdminProductModifyAction execute Page=" + current_page);
			
			int			idx					=	Integer.parseInt(multi.getParameter("idx"));	
			int			category_idx		=	Integer.parseInt(multi.getParameter("category_idx"));
			int			product_quantity	=	Integer.parseInt(multi.getParameter("product_quantity"));
			String		product_name		=	multi.getParameter("product_name");
			float		product_price		=	Integer.parseInt(multi.getParameter("product_price"));
			String		product_desc		=	multi.getParameter("product_desc");
			
			Enumeration<String> names		=	multi.getFileNames();				
			String product_image=null;
			//수정하는 페이지에서 파일 삽입이 안들어오는 경우
			if(names.hasMoreElements()) {
						product_image		=	multi.getOriginalFileName(names.nextElement());				
			}			
			//수정하는 페이지에서 파일 삽입을 하는 경우에는
			//이렇게 하면 됨
			//String board_file=multi.getOriginalFileName
			//((String)multi.getFileNames().nextElement());
			//이미 파일삽입을 한 상태라면 
			//java.util.NoSuchElementException 뜸
			
			ProductDAO	dao					=	new ProductDAO();
			
			dao.productUpdate(idx, category_idx, product_quantity, product_name, product_image, product_price, product_desc);
			/*if(product_image!=null) {
				dao.productUpdate(idx, category_idx, product_quantity, product_name, product_image, product_price, product_desc);
			}else {
				dao.productUpdate(idx, category_idx, product_quantity, product_name, product_price, product_desc);
			}*/
				//페이지 이동
			path+="?idx="+idx+"&page="+current_page;
		} catch (IOException e) {			
			e.printStackTrace();
		}
/*		
		if(vo != null) {
			req.setAttribute("vo", vo);
			req.setAttribute("page", current_page);
		}*/
		return new ActionForward(path, true);
	}

}
