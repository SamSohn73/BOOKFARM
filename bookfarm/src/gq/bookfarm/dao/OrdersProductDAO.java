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

import gq.bookfarm.vo.OrdersProductVO;

public class OrdersProductDAO
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
	
	
	public int ordersProductInsert(int orders_idx, int products_idx, int products_quantity, float	final_price)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Connection			con		= getConnection();
	
		try {
			log.debug("execute ordersProductInsert DB work Start.");
			con.setAutoCommit(false);
			
			String sql		= "insert into orders_product (orders_idx, products_idx, products_quantity, final_price)" + 
								"values (?,?,?,?)";
			pstmt			= con.prepareStatement(sql);
			
			pstmt.setInt		(1, orders_idx);
			pstmt.setInt		(2, products_idx);
			pstmt.setInt		(3, products_quantity);
			pstmt.setFloat		(4, final_price); 
			
			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.debug("execute ordersProductInsert DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute ordersProductInsert DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute ordersProductInsert DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(con, pstmt);
		}
		log.debug("execute ordersProductInsert DB work End.");
		return result;
	}
	
	
	public int ordersProductDelete(int idx)
	{
		int					result	= 0;
		Connection			con		= getConnection();
		PreparedStatement	pstmt	= null;

		try {
			log.debug("execute ordersDelete DB work Start.");
			String sql = "delete from orders_product where idx = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			
			result = pstmt.executeUpdate();
			log.debug("execute ordersDelete DB work End.");
		} catch (Exception e) {
			log.fatal("execute ordersDelete DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return result;
	}
	
	
	public Vector<OrdersProductVO> ordersProductList(int page, int limit)
	{
		// Calc start record through page;
		Vector<OrdersProductVO> ordersProductList	= new Vector<OrdersProductVO>();
		
		int start									= (page - 1) * 10; 
		
		Connection			con						= getConnection();
		ResultSet			result					= null;
		PreparedStatement	pstmt					= null;
		
		try {
			log.debug("execute ordersProductList DB work Start.");
			String sql	= "select * from orders_product order by idx desc limit ?,?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setInt(1, start);
			pstmt		.setInt(2, limit);
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				OrdersProductVO list = new OrdersProductVO(result.getInt("idx"), 
											result.getInt("orders_idx"), 
											result.getInt("products_idx"), 
											result.getInt("products_quantity"),
											result.getFloat("final_price"));

				ordersProductList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute ordersProductList DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt, result);
		}
		log.debug("execute ordersProductList DB work End.");
		return ordersProductList;
	}
	
	
	public OrdersProductVO ordersProductGetRow(int idx)
	{
		OrdersProductVO		vo		= null;
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute ordersProductGetRow DB work Start.");
			String sql	= "select * from orders_product where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, idx);
			result			= pstmt.executeQuery();			
			if (result.next()) {
				vo = new OrdersProductVO(result.getInt("idx"), 
										result.getInt("orders_idx"), 
										result.getInt("products_idx"), 
										result.getInt("products_quantity"),
										result.getFloat("final_price"));
			}
		} catch (Exception e) {
			log.fatal("execute ordersProductGetRow DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt, result);
		}
		log.debug("execute ordersProductGetRow DB work End.");
		
		return vo;
	}
	
	
	public Vector<OrdersProductVO> ordersProductGetRowsbyOrders(int orders_idx)
	{
		Vector<OrdersProductVO> ordersProductList	= new Vector<OrdersProductVO>();
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute ordersProductGetRowsbyOrders DB work Start.");
			String sql	= "select * from orders_product where orders_idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, orders_idx);
			result			= pstmt.executeQuery();			
			while (result.next()) {
				OrdersProductVO list = new OrdersProductVO(result.getInt("idx"), 
											result.getInt("orders_idx"), 
											result.getInt("products_idx"), 
											result.getInt("products_quantity"),
											result.getFloat("final_price"));

				ordersProductList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute ordersProductGetRowsbyOrders DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt, result);
		}
		log.debug("execute ordersProductGetRowsbyOrders DB work End.");
		
		return ordersProductList;
	}
	
	
	public Vector<OrdersProductVO> ordersProductGetRowsbyProduct(int products_idx)
	{
		Vector<OrdersProductVO> ordersProductList	= new Vector<OrdersProductVO>();
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute ordersProductGetRowsbyOrders DB work Start.");
			String sql	= "select * from orders_product where products_idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, products_idx);
			result			= pstmt.executeQuery();			
			while (result.next()) {
				OrdersProductVO list = new OrdersProductVO(result.getInt("idx"), 
											result.getInt("orders_idx"), 
											result.getInt("products_idx"), 
											result.getInt("products_quantity"),
											result.getFloat("final_price"));

				ordersProductList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute ordersProductGetRowsbyOrders DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt, result);
		}
		log.debug("execute ordersProductGetRowsbyOrders DB work End.");
		
		return ordersProductList;
	}
	
	
	public int totalRows()
	{
		log.debug("execute ordersProduct total_rows DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql		= "select count(*) from orders_product";
			pstmt	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute ordersProduct total_rows DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		log.debug("execute ordersProduct total_rows DB work End. total_rows= " + total_rows);
		
		return total_rows;
	}
	
	
	public int SingleOrderTotalRows(int orders_idx)
	{
		log.debug("execute ordersProduct Single_Order's_total_rows DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql		= "select count(*) from orders_product where orders_idx=?";
			pstmt	= con.prepareStatement(sql);
			pstmt.setInt(1, orders_idx);
			rs		= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute ordersProduct total_rows DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		log.debug("execute ordersProduct total_rows DB work End. total_rows= " + total_rows);
		
		return total_rows;
	}
	
	
	public Vector<OrdersProductVO> ordersProductGetRowsbyOrders(int orders_idx, int page, int limit)
	{
		Vector<OrdersProductVO> ordersProductList	= new Vector<OrdersProductVO>();
		
		int start									= (page - 1) * 10; 
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute ordersProductGetRowsbyOrders DB work Start.");
			String sql	= "select * from orders_product where orders_idx = ? order by idx desc limit ?,?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt(1, orders_idx);
			pstmt.setInt(2, start);
			pstmt.setInt(3, limit);
			result			= pstmt.executeQuery();			
			while (result.next()) {
				OrdersProductVO list = new OrdersProductVO(result.getInt("idx"), 
											result.getInt("orders_idx"), 
											result.getInt("products_idx"), 
											result.getInt("products_quantity"),
											result.getFloat("final_price"));

				ordersProductList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute ordersProductGetRowsbyOrders DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt, result);
		}
		log.debug("execute ordersProductGetRowsbyOrders DB work End.");
		
		return ordersProductList;
	}
}
