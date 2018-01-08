package gq.bookfarm.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import gq.bookfarm.vo.OrdersVO;
import gq.bookfarm.vo.ProductVO;

public class ProductDAO
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
		try {
			log.debug("DB close Start.");
			if (rs != null)		rs.close();
			close(con, pstmt);
			log.debug("DB close End.");
		} catch (SQLException e) {
			log.fatal("DB close Failed !!!!!!!!!!");
			e.printStackTrace();
		}
	}
	
		
	public int productInsert(int category_idx, int product_quantity, String product_model, String product_image,
			float product_price, String product_desc)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		
		try {
			log.debug("execute productInsert do the DB work Start.");
			con.setAutoCommit(false);
			
			String sql		= "insert into product (category_idx, product_quantity, product_model, product_image, " + 
							"product_price, product_desc) values (?,?,?,?,?,?)";
			pstmt			= con.prepareStatement(sql);

			pstmt.setInt		(1, category_idx);
			pstmt.setInt		(2, product_quantity);
			pstmt.setString		(3, product_model);
			pstmt.setString		(4, product_image);
			pstmt.setFloat		(5, product_price);
			pstmt.setString		(6, product_desc);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.debug("execute productInsert do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute productInsert do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute productInsert do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute productInsert do the DB work End.");
		return result;
	}
	
	
	public int productDelete(int idx)
	{
		int result = 0;
		Connection			con		= getConnection();
		PreparedStatement	pstmt	= null;

		try {
			log.debug("execute productDelete do the DB work Start.");
			String sql = "delete from product where idx = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			
			result = pstmt.executeUpdate();
			log.debug("execute productDelete do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute productDelete do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return result;
	}
	
	
	public int productUpdate(int idx, int category_idx, int product_quantity, String product_name, String product_image,
			float product_price, String product_desc)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		String sql					= null;
		
		try {
			log.debug("execute productUpdate do the DB work Start.");
			con.setAutoCommit(false);

			sql = "update product set category_idx = ?, product_quantity = ? product_name = ? product_image = ? product_price = ? product_desc = ? where idx = ?";
			pstmt	= con.prepareStatement(sql);
			pstmt.setInt	(1, category_idx);
			pstmt.setInt	(2, product_quantity);
			pstmt.setString	(3, product_name);
			pstmt.setString	(4, product_image);
			pstmt.setFloat	(5, product_price);
			pstmt.setString	(6, product_desc);
			pstmt.setInt	(7, idx);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.fatal("execute productUpdate do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute productUpdate do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute productUpdate do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute productUpdate do the DB work End.");
		return result;
	}
	
	
	public Vector<ProductVO> productList(int page, int limit)
	{
		// Calc start record through page;
		int start						= (page - 1) * 10; 
		
		Vector<ProductVO> productList	= new Vector<ProductVO>();
		
		Connection			con			= getConnection();
		ResultSet			result		= null;
		PreparedStatement	pstmt		= null;
		
		try {
			log.debug("execute productList do the DB work Start.");
			String sql	= "select * from product order by idx desc limit ?,?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setInt(1, start);
			pstmt		.setInt(2, limit);
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				ProductVO list = new ProductVO(result.getInt("idx"),
											result.getInt("category_idx"),
											result.getInt("product_quantity"),
											result.getString("product_name"),
											result.getString("product_image"),
											result.getFloat("product_price"),
											result.getString("product_desc"));
				
				productList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute productList do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute productList do the DB work End.");
		return productList;
	}
	
	public int productCountSearchingRows(String criteria, String searchWord)
	{
		log.debug("execute productCountSearchingRows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql	= "select count(*) from product " +
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
			log.fatal("execute productCountSearchingRows do the DB work failed!!!!!!!!!!");
			e.printStackTrace();
		}
		
		log.debug("productCountSearchingRows DB work End. total_rows= " + total_rows);
		return total_rows;	
	}
	
	
	public Vector<ProductVO> productSearch(String criteria, String searchWord, int page, int limit)
	{
		Vector<ProductVO>	productList	= new Vector<ProductVO>();
		
		Connection			con			= getConnection();
		ResultSet			result		= null;
		PreparedStatement	pstmt		= null;
		
		// Calc start record through page;
		int start					= (page - 1) * 10; 
		
		try {
			log.debug("execute productSearch DB work Start.");

			String sql	= "select * " +
							"where " +  criteria + " like ? " +
							"order by idx desc limit ?, ?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setString(1, "%" + searchWord + "%");
			pstmt		.setInt(2, start);
			pstmt		.setInt(3, limit);
			
			log.debug("execute productSearch DB work... pstmt.toString()" + pstmt.toString());
			
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				ProductVO list = new ProductVO(result.getInt("idx"),
											result.getInt("category_idx"),
											result.getInt("product_quantity"),
											result.getString("product_name"),
											result.getString("product_image"),
											result.getFloat("product_price"),
											result.getString("product_desc"));
				
				productList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute productSearch DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute productSearch DB work End.");
		return productList;
	}
	
	
	public ProductVO productGetRow(int idx)	
	{
		ProductVO			vo		= null;
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute productGetRow DB work Start.");
			String sql	= "select * from product where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, idx);
			result			= pstmt.executeQuery();			
			if (result.next()) {
				vo = new ProductVO(result.getInt("idx"),
									result.getInt("category_idx"),
									result.getInt("product_quantity"),
									result.getString("product_name"),
									result.getString("product_image"),
									result.getFloat("product_price"),
									result.getString("product_desc"));
			}
		} catch (Exception e) {
			log.fatal("execute productGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(result);
			close(con, pstmt);
		}
		log.debug("execute productGetRow DB work End.");
		
		return vo;
	}
	
	
	public int totalRows()
	{
		log.debug("execute product total_rows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql		= "select count(*) from product";
			pstmt	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute product total_rows do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(con, pstmt);
		}
		
		log.debug("execute product total_rows do the DB work End. total_rows= " + total_rows);
		
		return total_rows;
	}
}
