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

import gq.bookfarm.vo.ProductImageVO;
import gq.bookfarm.vo.ProductVO;

public class ProductImageDAO
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
	

	public int productImageInsert(int product_idx, String image_path)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		
		try {
			log.debug("execute productImageInsert do the DB work Start.");
			con.setAutoCommit(false);
			
			String sql			= "insert into product_image (product_idx, image_path) values (?,?)";
			pstmt				= con.prepareStatement(sql);

			pstmt.setInt		(1, product_idx);
			pstmt.setString		(2, image_path);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.debug("execute productImageInsert do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute productImageInsert do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute productImageInsert do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute productImageInsert do the DB work End.");
		return result;
	}
	
	
	public int productImageDelete(int idx)
	{
		int					result	= 0;
		Connection			con		= getConnection();
		PreparedStatement	pstmt	= null;

		try {
			log.debug("execute productImageDelete do the DB work Start.");
			String sql = "delete from product_image where idx = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			
			result = pstmt.executeUpdate();
			log.debug("execute productImageDelete do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute productImageDelete do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return result;
	}
	
	
	public int productImageUpdate(int idx, int product_idx, String image_path)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		String sql					= null;
		
		try {
			log.debug("execute productImageUpdate do the DB work Start.");
			con.setAutoCommit(false);

			sql = "update product_image set product_idx = ?, image_path = ? where idx = ?";
			pstmt	= con.prepareStatement(sql);
			pstmt.setInt	(1, product_idx);
			pstmt.setString	(2, image_path);
			pstmt.setInt	(3, idx);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.fatal("execute productImageUpdate do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute productImageUpdate do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute productImageUpdate do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute productImageUpdate do the DB work End.");
		return result;
	}
	
	
	public Vector<ProductImageVO> productImageList(int page, int limit)
	{
		// Calc start record through page;
		int start						= (page - 1) * 10; 
		
		Vector<ProductImageVO> productImageList	= new Vector<ProductImageVO>();
		
		Connection			con					= getConnection();
		ResultSet			result				= null;
		PreparedStatement	pstmt				= null;
		
		try {
			log.debug("execute productImageList do the DB work Start.");
			String sql	= "select * from product_image order by idx desc, limit ?,?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setInt(1, start);
			pstmt		.setInt(2, limit);
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				ProductImageVO list = new ProductImageVO(result.getInt("idx"),
											result.getInt("product_idx"),
											result.getString("image_path"));

				productImageList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute productImageList do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute productImageList do the DB work End.");
		return productImageList;
	}
	
	
	public ProductImageVO productImageGetRow(int idx)
	{
		ProductImageVO		vo		= null;
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute productImageGetRow DB work Start.");
			String sql	= "select * from product_image where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, idx);
			result			= pstmt.executeQuery();			
			if (result.next()) {
				vo = new ProductImageVO(result.getInt("idx"),
										result.getInt("product_idx"),
										result.getString("image_path"));
			}
		} catch (Exception e) {
			log.fatal("execute productImageGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute productImageGetRow DB work End.");
		
		return vo;
	}
	
	
	public Vector<ProductImageVO> productImageGetRowsByProduct(int product_idx)
	{
		Vector<ProductImageVO> productImageList	= new Vector<ProductImageVO>();
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute productImageGetRow DB work Start.");
			String sql	= "select * from product_image where product_idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, product_idx);
			result			= pstmt.executeQuery();			
			while (result.next()) {
				ProductImageVO list = new ProductImageVO(result.getInt("idx"),
											result.getInt("product_idx"),
											result.getString("image_path"));

				productImageList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute productImageGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute productImageGetRow DB work End.");
		
		return productImageList;
	}
	
	
	public int totalRows()
	{
		log.debug("execute productImage total_rows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql		= "select count(*) from product_image";
			pstmt	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute productImage total_rows do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		}
		
		log.debug("execute productImage total_rows do the DB work End. total_rows= " + total_rows);
		
		return total_rows;
	}
}
