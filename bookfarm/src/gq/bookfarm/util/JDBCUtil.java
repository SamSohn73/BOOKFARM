package gq.bookfarm.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;


public class JDBCUtil {
	private final static Logger log = Logger.getLogger(JDBCUtil.class);
	//자바 JDBC를 이용한 커넥션 연결, 종료 담당
	public static Connection getConnection()
	{
		Connection con = null;
		try {
			log.debug("DB getConnection Start.");
			Context ctx		= new InitialContext();
			Context envctx	= (Context) ctx.lookup("java:comp/env");
			DataSource ds	= (DataSource) envctx.lookup("jdbc/MySQL");
			
			con = ds.getConnection();
		} catch (Exception e) {
			log.fatal("DB getConnection Failed !!!!!!!!!!");
			e.printStackTrace();
		}
		log.debug("DB getConnection End.");
		return con;
	}
	
	public static void close(PreparedStatement pstmt, Connection con)
	{
		log.debug("DB close Start.");
		try {
			if (pstmt!=null)	pstmt.close();
			if (con!=null)		con.close();
		} catch(Exception e) {
			log.fatal("DB close Failed !!!!!!!!!!");
			e.printStackTrace();
		}
		log.debug("DB close End.");
	}
	
	public static void close(ResultSet rs,PreparedStatement pstmt, Connection con)
	{
		log.debug("DB close Start.");
		try {
			if(rs!=null)		rs.close();
			if(pstmt!=null)		pstmt.close();
			if(con!=null)		con.close();
		} catch(Exception e) {
			log.fatal("DB close Failed !!!!!!!!!!");
			e.printStackTrace();
		}
		log.debug("DB close End.");
	}
}
