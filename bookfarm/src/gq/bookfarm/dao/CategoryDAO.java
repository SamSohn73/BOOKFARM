package gq.bookfarm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import gq.bookfarm.vo.CategoryVO;

public class CategoryDAO
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
	
	
	public int categoryInsert(int parent_idx, String category_name)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		
		try {
			log.debug("execute categoryInsert do the DB work Start.");
			con.setAutoCommit(false);
			
			String sql		= "insert into category (parent_idx, category_name) values (?,?)";
			pstmt			= con.prepareStatement(sql);

			pstmt.setInt		(1, parent_idx);
			pstmt.setString		(2, category_name);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.debug("execute categoryInsert do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute categoryInsert do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute categoryInsert do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute categoryInsert do the DB work End.");
		return result;
	}
	
	
	public int categoryDelete(int idx)
	{
		int					result	= 0;
		Connection			con		= getConnection();
		PreparedStatement	pstmt	= null;

		try {
			log.debug("execute categoryDelete do the DB work Start.");
			String sql = "delete from category where idx = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			
			result = pstmt.executeUpdate();
			log.debug("execute categoryDelete do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute categoryDelete do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return result;
	}
	
	
	public int categoryUpdate(int idx, int parent_idx, String category_name)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		String sql					= null;
		
		try {
			log.debug("execute categoryUpdate do the DB work Start.");
			con.setAutoCommit(false);

			sql = "update category set parent_idx = ?, category_name = ? where idx = ?";
			pstmt	= con.prepareStatement(sql);
			pstmt.setInt	(1, parent_idx);
			pstmt.setString	(2, category_name);
			pstmt.setInt	(3, idx);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
			log.debug("execute categoryUpdate do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute categoryUpdate do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute categoryUpdate do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute categoryUpdate do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}

		return result;
	}
	
	
	public Vector<CategoryVO> categoryList(int page, int limit)
	{
		// Calc start record through page;
		int start						= (page - 1) * 10; 
		
		Vector<CategoryVO> categoryList	= new Vector<CategoryVO>();
		
		Connection			con			= getConnection();
		ResultSet			result		= null;
		PreparedStatement	pstmt		= null;
		
		try {
			log.debug("execute categoryList do the DB work Start.");
			String sql	= "select * from category order by idx desc, parent_idx desc limit ?,?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setInt(1, start);
			pstmt		.setInt(2, limit);
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				CategoryVO list = new CategoryVO(result.getInt("idx"),
											result.getInt("parent_idx"),
											result.getString("category_name"));
				
				categoryList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute categoryList do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute categoryList do the DB work End.");
		return categoryList;
	}
	
	public int categoryCountSearchingRows(String criteria, String searchWord)
	{
		log.debug("execute categoryCountSearchingRows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql	= "select count(*) from category " +
//					"where " +  criteria + " like '%" + searchWord + "%' " +
					"where " +  criteria + " like ? " +
					"order by idx desc";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setString(1, "%" + searchWord + "%");
			rs			= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute categoryCountSearchingRows do the DB work failed!!!!!!!!!!");
			e.printStackTrace();
		}
		
		log.debug("categoryCountSearchingRows DB work End. total_rows= " + total_rows);
		return total_rows;	
	}
	
	
	public Vector<CategoryVO> categorySearch(String criteria, String searchWord, int page, int limit)
	{
		Vector<CategoryVO>	categoryList	= new Vector<CategoryVO>();
		
		Connection			con				= getConnection();
		ResultSet			result			= null;
		PreparedStatement	pstmt			= null;
		
		// Calc start record through page;
		int start					= (page - 1) * 10; 
		
		try {
			log.debug("execute categorySearch DB work Start.");

			String sql	= "select * " +
							"where " +  criteria + " like ? " +
							"order by idx desc limit ?, ?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setString(1, "%" + searchWord + "%");
			pstmt		.setInt(2, start);
			pstmt		.setInt(3, limit);
			
			log.debug("execute categorySearch DB work... pstmt.toString()" + pstmt.toString());
			
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				CategoryVO list = new CategoryVO(result.getInt("idx"),
											result.getInt("parent_idx"),
											result.getString("category_name"));

				categoryList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute categorySearch DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute categorySearch DB work End.");
		return categoryList;
	}
	
	
	public CategoryVO categoryGetRow(int idx)	
	{
		CategoryVO			vo		= null;
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute categoryGetRow DB work Start.");
			String sql	= "select * from category where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, idx);
			result			= pstmt.executeQuery();		
			
			if (result.next()) {
				vo = new CategoryVO(result.getInt("idx"),
								result.getInt("parent_idx"),
								result.getString("category_name"));
			}
		} catch (Exception e) {
			log.fatal("execute categoryGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute categoryGetRow DB work End.");
		
		return vo;
	}
	
	
	public int totalRows()
	{
		log.debug("execute category totalRows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql		= "select count(*) from category";
			pstmt	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute category totalRows do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		}
		
		log.debug("execute category totalRows do the DB work End. total_rows= " + total_rows);
		
		return total_rows;
	}
}
