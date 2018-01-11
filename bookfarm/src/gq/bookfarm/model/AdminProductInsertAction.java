package gq.bookfarm.model;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.ProductDAO;

public class AdminProductInsertAction implements Action
{
	private final Logger log = Logger.getLogger(this.getClass());
	private String path;

	public AdminProductInsertAction(String path) 
	{
		super();
		log.debug("AdminProductInsertAction create Start.");
		this.path = path;
		log.debug("AdminProductInsertAction create End. path=" + path);
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.debug("AdminProductInsertAction execute Start.");
		String saveDir="/image";
		String uploadPath=req.getServletContext().getRealPath(saveDir);
		
		
		int size=5*1024*1024;
		
		MultipartRequest multi;
		
		try {
						multi				=	new MultipartRequest(req,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
;
			int			category_idx		=	Integer.parseInt(multi.getParameter("category_idx"));
			int			product_quantity	=	Integer.parseInt(multi.getParameter("product_quantity"));
			String		product_image		=	multi.getParameter("product_image");
			String		product_name		=	multi.getParameter("product_name");
			float		product_price		=	Float.parseFloat(multi.getParameter("product_price"));
			String		product_desc		=	multi.getParameter("product_desc");
			
			ProductDAO 	dao					=	new ProductDAO();

			int 		result				=	dao.productInsert(category_idx, product_quantity, product_name, product_image, product_price, product_desc);
			
			if(result==0) {
				log.debug("AdminProductInsertAction execute Failed.");
				path="error.jsp"; 
			}
		} catch (IOException e) {			
			e.printStackTrace();
		}
		log.debug("AdminProductInsertAction execute End.");
		return new ActionForward(path, true);
	}

}
