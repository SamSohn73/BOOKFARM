package xyz.bookfarm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import xyz.bookfarm.vo.AdminVO;
import xyz.bookfarm.vo.ProductVO;


public class AdminDAO
{
	private final Logger log = Logger.getLogger(this.getClass());
	
	public Connection getConnection()
	{
		Connection con = null;
		
		try {
			log.debug("DB getConnection Start.");
			Context ctx		= new InitialContext();
			Context envctx	= (Context) ctx.lookup("java:comp/env");
			DataSource ds	= (DataSource) envctx.lookup("jdbc/MySQL");
			
			con = ds.getConnection();
			log.debug("DB getConnection End.");
		} catch (Exception e) {
			log.fatal("DB getConnection Failed !!!!!!!!!!");
			e.printStackTrace();
		}
		
		return con;
	}

	public void close(Connection con)
	{
		try {
			log.debug("DB con close Start.");
			if (con != null)		con.close();
			log.debug("DB con close End.");
		} catch (SQLException e) {
			log.fatal("DB con close Failed.");
			e.printStackTrace();
		}
	}
	
	public void close(PreparedStatement pstmt)
	{
		try {
			log.debug("DB pstmt close Start.");
			if (pstmt != null)		pstmt.close();
			log.debug("DB pstmt close End.");
		} catch (SQLException e) {
			log.fatal("DB pstmt close Failed.");
			e.printStackTrace();
		}
	}
	
	
	public void close(Statement stmt)
	{
		try {
			log.debug("DB stmt close Start.");
			if (stmt != null)		stmt.close();
			log.debug("DB stmt close End.");
		} catch (SQLException e) {
			log.fatal("DB stmt close Failed.");
			e.printStackTrace();
		}
	}
	
	
	public void close(ResultSet rs)
	{
		try {
			log.debug("DB rs close Start.");
			if (rs != null)		rs.close();
			log.debug("DB rsclose End.");
		} catch (SQLException e) {
			log.fatal("DB rs close Failed !!!!!!!!!!");
			e.printStackTrace();
		}
	}
	
	public void close(Connection con , PreparedStatement pstmt)
	{
			try {
				log.debug("DB close Start.");
				if (pstmt != null)		pstmt.close();
				if (con != null)		con.close();
				log.debug("DB close End.");
			} catch (SQLException e) {
				log.fatal("DB close Failed.");
				e.printStackTrace();
			}
	}
	
	
	public void close(Connection con , PreparedStatement pstmt, ResultSet rs)
	{
		close(con, pstmt);
		
		try {
			log.debug("DB close Start.");
			if (rs != null)		rs.close();
			log.debug("DB close End.");
		} catch (SQLException e) {
			log.fatal("DB close Failed !!!!!!!!!!");
			e.printStackTrace();
		}
	}
		
	
	public AdminVO adminGetRow(int idx)
	{
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		AdminVO				vo		= null;
		try {
			log.debug("execute adminGetRow DB work Start.");
			String sql	= "select * from admin where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt			.setInt(1, idx);
			result			= pstmt.executeQuery();			
			if (result.next()) {
				vo = new AdminVO(result.getInt("idx"),
								result.getString("user_name"),
								result.getString("user_password"));
			}
		} catch (Exception e) {
			log.fatal("execute adminGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute adminGetRow DB work End.");
		
		return vo;
	}

	
	public AdminVO isLogin(String user_name,String user_pass)
	{
		Connection con=getConnection();
	
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		AdminVO				vo		= null;
		
		try {
			String sql	= "select * from admin where user_name=? and user_pass=?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setString(1, user_name);
			pstmt		.setString(2, user_pass);
			result		= pstmt.executeQuery();
			
			if (result.next()) {
				vo = new AdminVO(result.getInt("idx"),
								result.getString("user_name"),
								result.getString("user_pass"));
			}
		} catch (Exception e) {
			log.fatal("execute adminGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute adminGetRow DB work End.");
		
		return vo;
	}
}