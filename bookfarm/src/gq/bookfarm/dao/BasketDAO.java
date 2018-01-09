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

import gq.bookfarm.vo.BasketVO;


public class BasketDAO
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
	

	public int basketInsert(int customer_idx, int product_idx, int quantity, String options, float final_price)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		
		try {
			log.debug("execute basketInsert do the DB work Start.");
			con.setAutoCommit(false);
			
			String sql		= "insert into basket (customer_idx, product_idx, quantity, options, final_price, date_added) values (?,?,?,?,?,?)";
			pstmt			= con.prepareStatement(sql);

			pstmt.setInt		(1, customer_idx);
			pstmt.setInt		(2, product_idx);
			pstmt.setInt		(3, quantity);
			pstmt.setString		(4, options);
			pstmt.setFloat		(5, final_price);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
		} catch (Exception e) {
			log.debug("execute basketInsert do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute basketInsert do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute basketInsert do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute basketInsert do the DB work End.");
		return result;
	}
	
	
	public int basketInsert(BasketVO basketVO)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		
		try {
			log.debug("execute basketInsert do the DB work Start.");
			con.setAutoCommit(false);
			
			String sql			= "insert into basket (customer_idx, product_idx, quantity, options, final_price, date_added) values (?,?,?,?,?,?)";
			pstmt				= con.prepareStatement(sql);

			pstmt.setInt		(1, basketVO.getCustomer_idx());
			pstmt.setInt		(2, basketVO.getProduct_idx());
			pstmt.setInt		(3, basketVO.getQuantity());
			pstmt.setString		(4, basketVO.getOptions());
			pstmt.setFloat		(5, basketVO.getFinal_price());

			result				= pstmt.executeUpdate();
			if (result > 0)		con.commit();
			
		} catch (Exception e) {
			log.debug("execute basketInsert do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute basketInsert do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute basketInsert do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}
		log.debug("execute basketInsert do the DB work End.");
		return result;
	}	
	
	
	public int basketDeleteByCustomer_idx(int customer_idx)
	{
		int					result	= 0;
		Connection			con		= getConnection();
		PreparedStatement	pstmt	= null;

		try {
			log.debug("execute basketDeleteByCustomer_idx do the DB work Start.");
			String	sql	= "delete from Basket where customer_idx = ?";
			pstmt		= con.prepareStatement(sql);
			
			pstmt		.setInt(1, customer_idx);
			
			result		= pstmt.executeUpdate();
			log.debug("execute basketDeleteByCustomer_idx do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute basketDeleteByCustomer_idx do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return result;
	}
	
	
	public int basketDeleteByIdx(int idx)
	{
		int					result	= 0;
		Connection			con		= getConnection();
		PreparedStatement	pstmt	= null;

		try {
			log.debug("execute basketDeleteByIdx do the DB work Start.");
			String	sql	= "delete from Basket where idx = ?";
			pstmt		= con.prepareStatement(sql);
			
			pstmt		.setInt(1, idx);
			
			result		= pstmt.executeUpdate();
			log.debug("execute basketDeleteByIdx do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute basketDeleteByIdx do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		
		return result;
	}
	
	public int basketUpdate(int idx, int quantity, float final_price)
	{
		int					result	= 0;
		PreparedStatement	pstmt	= null;
		Statement			stmt	= null;
		Connection			con		= getConnection();
		String sql					= null;
		
		try {
			log.debug("execute basketUpdate do the DB work Start.");
			con.setAutoCommit(false);

			sql				= "update basket set quantity = ?, final_price = ? where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, quantity);
			pstmt.setFloat	(2, final_price);
			pstmt.setInt	(3, idx);

			result			= pstmt.executeUpdate();
			if (result > 0)	con.commit();
			
			log.debug("execute basketUpdate do the DB work End.");
		} catch (Exception e) {
			log.fatal("execute basketUpdate do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
			try {
				log.debug("execute basketUpdate do the DB work rollbacked!!!!!!!!!!");
				con.rollback();
			} catch (SQLException e1) {
				log.fatal("execute basketUpdate do the DB work rollback failed!!!!!!!!!!");
				e1.printStackTrace();
			}
		} finally {
			close(stmt);
			close(con, pstmt);
		}

		return result;
	}
	
	
	public Vector<BasketVO> basketList()
	{
		Vector<BasketVO>	basketList	= new Vector<BasketVO>();
		
		Connection			con			= getConnection();
		ResultSet			result		= null;
		PreparedStatement	pstmt		= null;
		
		try {
			log.debug("execute basketList do the DB work Start.");
			String sql	= "select * from basket order by idx desc, customer_idx desc";
			pstmt		= con.prepareStatement(sql);
			result		= pstmt.executeQuery();

			while (result.next()) {
				BasketVO list = new BasketVO(result.getInt("idx"),
											result.getInt("customer_idx"),
											result.getInt("product_idx"),
											result.getInt("quantity"),
											result.getString("options"),
											result.getFloat("final_price"),
											result.getDate("date_added"));
				
				basketList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute categoryList do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute categoryList do the DB work End.");
		return basketList;
	}
	
	
	public Vector<BasketVO> basketListbyCustomer_idx(int customer_idx)
	{
		log.debug("execute basketListbyCustomer_idx do the DB work Start.");
		Vector<BasketVO>	basketList	= new Vector<BasketVO>();
		
		Connection			con			= getConnection();
		ResultSet			result		= null;
		PreparedStatement	pstmt		= null;
		
		try {
			log.debug("execute categoryList do the DB work Start.");
			String sql	= "select * from category where customer_idx = ? order by idx desc, parent_idx desc";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setInt	(1, customer_idx);
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				BasketVO list = new BasketVO(result.getInt("idx"),
												result.getInt("customer_idx"),
												result.getInt("product_idx"),
												result.getInt("quantity"),
												result.getString("options"),
												result.getFloat("final_price"),
												result.getDate("date_added"));
				
				basketList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute basketListbyCustomer_idx do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute basketListbyCustomer_idx do the DB work End.");
		return basketList;
	}
	
	
	public int basketCountSearchingRows(String criteria, String searchWord)
	{
		log.debug("execute basketCountSearchingRows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql	= "select count(*) from basket " +
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
			log.fatal("execute basketCountSearchingRows do the DB work failed!!!!!!!!!!");
			e.printStackTrace();
		}
		
		log.debug("basketCountSearchingRows DB work End. total_rows= " + total_rows);
		return total_rows;	
	}
	
	
	public Vector<BasketVO> basketSearch(String criteria, String searchWord, int page, int limit)
	{
		Vector<BasketVO>	basketList		= new Vector<BasketVO>();
		
		Connection			con				= getConnection();
		ResultSet			result			= null;
		PreparedStatement	pstmt			= null;
		
		// Calc start record through page;
		int start					= (page - 1) * 10; 
		
		try {
			log.debug("execute basketSearch DB work Start.");

			String sql	= "select * from basket" +
							"where " +  criteria + " like ? " +
							"order by idx desc limit ?, ?";
			pstmt		= con.prepareStatement(sql);
			pstmt		.setString(1, "%" + searchWord + "%");
			pstmt		.setInt(2, start);
			pstmt		.setInt(3, limit);
			
			log.debug("execute basketSearch DB work... pstmt.toString()" + pstmt.toString());
			
			result		= pstmt.executeQuery();
			
			while (result.next()) {
				BasketVO list = new BasketVO(result.getInt("idx"),
											result.getInt("customer_idx"),
											result.getInt("product_idx"),
											result.getInt("quantity"),
											result.getString("options"),
											result.getFloat("final_price"),
											result.getDate("date_added"));

				basketList.add(list);
			}
		} catch (Exception e) {
			log.fatal("execute basketSearch DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute basketSearch DB work End.");
		return basketList;
	}
	
	
	public BasketVO basketGetRowByIdx(int idx)	
	{
		BasketVO			vo		= null;
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute basketGetRowByIdx DB work Start.");
			String sql		= "select * from basket where idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, idx);
			result			= pstmt.executeQuery();		
			
			if (result.next()) {
				vo = new BasketVO(result.getInt("idx"),
									result.getInt("customer_idx"),
									result.getInt("product_idx"),
									result.getInt("quantity"),
									result.getString("options"),
									result.getFloat("final_price"),
									result.getDate("date_added"));
			}
		} catch (Exception e) {
			log.fatal("execute basketGetRowByIdx DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute basketGetRowByIdx DB work End.");
		
		return vo;
	}
	
	
	public BasketVO basketGetRowByCustomer_idx(int customer_idx)	
	{
		BasketVO			vo		= null;
		
		Connection			con		= getConnection();
		ResultSet			result	= null;
		PreparedStatement	pstmt	= null;
		
		try {
			log.debug("execute basketGetRowByCustomer_idx DB work Start.");
			String sql		= "select * from basket where customer_idx = ?";
			pstmt			= con.prepareStatement(sql);
			pstmt.setInt	(1, customer_idx);
			result			= pstmt.executeQuery();		
			
			if (result.next()) {
				vo = new BasketVO(result.getInt("idx"),
									result.getInt("customer_idx"),
									result.getInt("product_idx"),
									result.getInt("quantity"),
									result.getString("options"),
									result.getFloat("final_price"),
									result.getDate("date_added"));
			}
		} catch (Exception e) {
			log.fatal("execute basketGetRowByCustomer_idx DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		log.debug("execute basketGetRowByCustomer_idx DB work End.");
		
		return vo;
	}
	
	
	
	public int totalRows()
	{
		log.debug("execute basket totalRows do the DB work Start.");
		int					total_rows	= 0;
		Connection			con			= getConnection();
		PreparedStatement	pstmt		= null;
		ResultSet			rs			= null;
		String				sql			= null;
		
		try {
			sql		= "select count(*) from basket";
			pstmt	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			if(rs.next())	
				total_rows	= rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.fatal("execute basket totalRows do the DB work Failed!!!!!!!!!!");
			e.printStackTrace();
		}
		
		log.debug("execute basket totalRows do the DB work End. total_rows= " + total_rows);
		
		return total_rows;
	}
}
