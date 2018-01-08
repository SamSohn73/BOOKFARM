package gq.bookfarm.model;

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
		
		//qna_board_modify.jsp���� �Ѿ�� ������ ��������
		//���� ���ε�� ���õ� �غ�
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
			//���� �������� ���� ���� �ʿ�
			String 	current_page 	= multi.getParameter("page");
			
			Enumeration<String> names=multi.getFileNames();
			String board_file=null;
			//�����ϴ� ���������� ���� ������ �ȵ����� ���
			if(names.hasMoreElements()) {
				board_file=multi.getOriginalFileName
						(names.nextElement());
			}			
			//�����ϴ� ���������� ���� ������ �ϴ� ��쿡��
			//�̷��� �ϸ� ��
			//String board_file=multi.getOriginalFileName
			//((String)multi.getFileNames().nextElement());
			//�̹� ���ϻ����� �� ���¶�� 
			//java.util.NoSuchElementException ��
			
			adminProductDAO dao=new adminProductDAO();
			//�����ϱ� ��ư�� Ŭ���� ��쿡�� ��ȸ�� ������Ʈ ����
			//��й�ȣ üũ 
			int result=dao.pwdCheck(idx,board_pass);
			//��й�ȣ�� �´ٸ� ����	
			
			if(result>0) 
			{//��й�ȣ�� �´´ٸ� ������Ʈ �� ������ ���� �����ֱ�
				if(board_file!=null) 
				{
					dao.updateRow(idx,category_idx,product_name,product_image, product_price, product_desc);
				}
				else
				{
					dao.updateRow(idx,category_idx,product_name,product_image, product_price, product_desc);
				}
				//������ �̵�
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
