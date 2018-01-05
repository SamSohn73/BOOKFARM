package adminDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import adminVO.AdministratorVO;
import adminaction.Action;
import adminaction.ActionForward;

public class adminDAO
{
	private 	Connection 			con 	= null;
	private 	PreparedStatement 	pstmt 	= null;
	private 	ResultSet 			rs 		= null;
	DataSource 						ds		= null;

	// Connection 얻기
	public Connection getConnection()
	{
		Context ctx;
		try {
			ctx 			= new InitialContext();
			DataSource ds 	= (DataSource) ctx.lookup("java:comp/env/jdbc/MySQL");
			con 			= ds.getConnection();
		} catch (Exception e) {
			System.out.println("DB 커넥션 실패" + e);
		}
		return con;
	}
	
	public void close(Connection con)
	{
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	public void close(PreparedStatement pstmt)
	{
			try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void close(ResultSet rs)
	{
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//로그인 확인하기
	public AdministratorVO isLogin(String user_name,String user_password) 
	{
		Connection con=getConnection();
		String sql="select id,name from users where user_name=? and user_password=?";		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		AdministratorVO vo=null;
		try 
		{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_name);
			pstmt.setString(2, user_password);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				vo=new AdministratorVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setUser_name(rs.getString("user_name"));				
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally 
		{
			try {
				con.close();
				pstmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return vo;		
	}

}