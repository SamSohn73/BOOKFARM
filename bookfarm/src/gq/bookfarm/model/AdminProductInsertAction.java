package gq.bookfarm.model;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.AdminDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.vo.AdminVO;

public class AdminProductInsertAction implements Action
{
	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public AdminProductInsertAction(String path) {
		super();
		this.path  = path;
		log.debug("AdminProductModifyAction Constructor. Destination path = " + path);
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception 
	{
		//getting values from qna_board_write.jsp
		//Because of the fileupload function, basic request can't do the work.
		log.debug("AdminProductInsertAction execute Start.");
		
		HttpSession	session	= req.getSession();
		AdminVO		adminVO	= (AdminVO) session.getAttribute("adminVO");
		AdminDAO	adminDAO= new AdminDAO();
		if (adminDAO.isAdmin(adminVO) == null) {
			log.info("AdminOrdersList execute Authorization Fail!!!!!!!!!!!!!!!!");
			path="error.html";
			return new ActionForward(path, false);
		}
		
		String uploadPath=req.getServletContext().getRealPath("/image");
		
		int size = 10 * 1024 * 1024;	// 10MB
		
		int		category_idx	= 0;
		int		product_quantity= 0;
		float	product_price	= 0;
		int 	curPage			= 0;
		String	product_name	= "";
		String	product_image	= "";
		String	product_desc	= "";
		int		result			= 0;
		
		try {
			MultipartRequest multi = new MultipartRequest(req, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			category_idx	=	Integer.parseInt(multi.getParameter("category_idx"));
			product_quantity=	Integer.parseInt(multi.getParameter("product_quantity"));
			product_price	=	Float.parseFloat(multi.getParameter("product_price"));
			product_name	=	multi.getParameter("product_name");
			product_desc	=	multi.getParameter("product_desc");
			curPage			=	Integer.parseInt(multi.getParameter("page"));

			Enumeration files = multi.getFileNames();
			if (files.hasMoreElements()) {
				String file1	= (String)files.nextElement();
				product_image	= "image/" + multi.getFilesystemName(file1);
				String origfileName	= multi.getOriginalFileName(file1);
				log.debug("AdminProductInsertAction MultipartRequest Error.product_image="+product_image);
				log.debug("AdminProductInsertAction MultipartRequest Error.origfileName="+origfileName);
			}
			ProductDAO dao	= new ProductDAO();
			
			result			= dao.productInsert(category_idx, product_quantity, product_name, product_image, product_price, product_desc);

		} catch(Exception e) {
			log.debug("AdminProductInsertAction MultipartRequest Error.");
			e.printStackTrace();
		}

		// if result failed change path here
		if (result <= 0)	path="view/error.html";
		else				path+= "?page=" + curPage;
		
		log.debug("AdminProductInsertAction execute End.");

		return new ActionForward(path, true);
	}

}