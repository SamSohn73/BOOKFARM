package adminProductmodel;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import adminDAO.adminProductDAO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminProductUpdateAction implements Action
{

	private String path;
	
	public adminProductUpdateAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//qna_board_modify.jsp에서 넘어온 데이터 가져오기
		//파일 업로드와 관련된 준비
		String saveDir="/boardUpload";
		String uploadPath=req.getServletContext().getRealPath(saveDir);
		
		int size=5*1024*1024;
		MultipartRequest multi;
		//board_subject,board_content,board_file
		//board_num,board_pass
		try 
		{
			multi 					= new MultipartRequest(req, uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
			int		idx					= Integer	.parseInt(multi.getParameter("idx"));
			int 	category_idx		= Integer.parseInt(multi.getParameter("category_idx"));
			int 	product_quantity	= Integer.parseInt(multi.getParameter("product_quantity"));
			String 	product_name 		= multi.getParameter("product_name");
			String 	product_image 		= multi.getParameter("product_image");
			float 	product_price 		= Integer.parseInt(multi.getParameter("product_name"));
			String 	product_desc 		= multi.getParameter("product_desc");
			//현재 페이지로 가기 위해 필요
			String 	current_page 	= multi.getParameter("page");
			
			Enumeration<String> names=multi.getFileNames();
			String board_file=null;
			//수정하는 페이지에서 파일 삽입이 안들어오는 경우
			if(names.hasMoreElements()) {
				board_file=multi.getOriginalFileName
						(names.nextElement());
			}			
			//수정하는 페이지에서 파일 삽입을 하는 경우에는
			//이렇게 하면 됨
			//String board_file=multi.getOriginalFileName
			//((String)multi.getFileNames().nextElement());
			//이미 파일삽입을 한 상태라면 
			//java.util.NoSuchElementException 뜸
			
			adminProductDAO dao=new adminProductDAO();
			//수정하기 버튼을 클릭한 경우에는 조회수 업데이트 안함
			//비밀번호 체크 
			int result=dao.pwdCheck(idx,board_pass);
			//비밀번호가 맞다면 수정	
			
			if(result>0) 
			{//비밀번호가 맞는다면 업데이트 후 수정된 내용 보여주기
				if(board_file!=null) 
				{
					dao.updateRow(idx,category_idx,product_name,product_image, product_price, product_desc);
				}
				else
				{
					dao.updateRow(idx,category_idx,product_name,product_image, product_price, product_desc);
				}
				//페이지 이동
				path+="?board_num="+idx+"&page="+current_page;
			}
		} 
		catch (IOException e) 
		{			
			e.printStackTrace();
		}		
		return new ActionForward(path, true);
	}
	
}
