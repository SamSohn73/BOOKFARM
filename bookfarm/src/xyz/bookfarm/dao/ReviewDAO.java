package xyz.bookfarm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import xyz.bookfarm.vo.ReviewVO;
import org.apache.log4j.Logger;

public class ReviewDAO {
	
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private			Connection			con		= null;
	private			PreparedStatement	pstmt	= null;
	private			ResultSet			rs		= null;
	
	public Connection getConnection()
	{
		Context	ctx;
		try
		{
						ctx	=	new				InitialContext();
			DataSource	ds	=	(DataSource)	ctx.lookup("java:comp/env/jdbc/MySQL");
						con	=					ds.getConnection();
		}
		catch(Exception e)
		{
			log.error("ReviewsDAO	getConnection error : "+e);
		}
		return con;
	}
	
	public void close(Connection con)
	{
		try
		{
			if(con != null)
				con.close();
		}
		catch(Exception e)
		{
			log.error("ReviewsDAO	close(Connection con) error : "+e);
		}
	}
	
	public void close(PreparedStatement pstmt)
	{
		try
		{
			if(pstmt != null)
				pstmt.close();
		}
		catch(Exception e)
		{
			log.error("ReviewsDAO	close(PreparedStatement pstmt) error : "+e);
		}
	}
	
	public void close(ResultSet rs)
	{
		try
		{
			if(rs != null)
				rs.close();
		}
		catch(Exception e)
		{
			log.error("ReviewsDAO	close(ResultSet rs) error : "+e);
		}
	}
	
	public int insert(ReviewVO vo)
	{
		int		result	=	0;
		String	sql		=	"insert into review (products_idx, customers_idx, reviews_rating, "
							+"review_title, review_text, date_added, last_modified) "
							+"values(?,?,?,?,?,now(), now())";
		try
		{
				con		=	getConnection();
				pstmt	=	con.prepareStatement(sql);
							con.setAutoCommit(false);
				
							pstmt.setInt(1, vo.getProducts_idx());
							pstmt.setInt(2, vo.getCustomers_idx());
							pstmt.setInt(3, 1);
							pstmt.setString(4, vo.getReview_title());
							pstmt.setString(5, vo.getReview_text());	
				
				result	=	pstmt.executeUpdate();
				
				if(result>0)
							con.commit();			
		}
		catch(Exception e)
		{
							log.error("ReviewsDAO	"
									+ "insert(reviewVO vo) error : "+e);
			try
			{
							con.rollback();
			}
			catch(SQLException e1)
			{
							log.error("ReviewsDAO	SQLException error,"
									+ " con.rollback() is not worked : "+e1);
			}
		}
		finally
		{
							close(rs);
							close(pstmt);
							close(con);
		}
		return result;
	}
	
	public int totalRows()
	{
		String	sql			=	"select count(*) from review";		
		int		total_rows	=	0;
		try
		{
				con			=	getConnection();
				pstmt		=	con.prepareStatement(sql);
				rs			=	pstmt.executeQuery();
			if(rs.next())
				total_rows	=	rs.getInt(1);
		}
		catch(SQLException e)
		{
								log.error("ReviewsDAO	"
										+ "totalRows() error : "+e);
		}
		finally
		{
								close(rs);
								close(pstmt);
								close(con);
		}
		return total_rows;
	}
	
	public int getReviewWriterIdx(int idx)
	{
		int		result		=	0;
		String	sql			=	"select customers_idx from review where idx=?";
		try
		{
				con			=	getConnection();
				pstmt		=	con.prepareStatement(sql);
								pstmt.setInt(1, idx);
				rs			=	pstmt.executeQuery();
			if(rs.next())
				result		=	rs.getInt(1);
		}
		catch(SQLException e)
		{
								log.error("ReviewsDAO	"
										+ "getReviewWriterIdx error : "+e);
		}
		finally
		{
								close(rs);
								close(pstmt);
								close(con);
		}
		return result;
		
	}
	
	public int oneProductsTotalRows(int products_idx)
	{
		String	sql			=	"select count(*) from review where products_idx=?";		
		int		total_rows	=	0;
		try
		{
				con			=	getConnection();
				pstmt		=	con.prepareStatement(sql);
								pstmt.setInt(1, products_idx);
				rs			=	pstmt.executeQuery();
			if(rs.next())
				total_rows	=	rs.getInt(1);
		}
		catch(SQLException e)
		{
								log.error("ReviewsDAO	"
										+ "oneProductsTotalRows error : "+e);
		}
		finally
		{
								close(rs);
								close(pstmt);
								close(con);
		}
		return total_rows;
	}
	
	public int oneCustomersTotalRows(int customers_idx)
	{
		String	sql			=	"select count(*) from review where customers_idx=?";		
		int		total_rows	=	0;
		try
		{
				con			=	getConnection();
				pstmt		=	con.prepareStatement(sql);
								pstmt.setInt(1, customers_idx);
				rs			=	pstmt.executeQuery();
			if(rs.next())
				total_rows	=	rs.getInt(1);
		}
		catch(SQLException e)
		{
								log.error("ReviewsDAO	"
										+ "oneCustomersTotalRows error : "+e);
		}
		finally
		{
								close(rs);
								close(pstmt);
								close(con);
		}
		return total_rows;
	}
	
	public Vector<ReviewVO> getList(int products_idx, int page, int limit)
	{
		int					start	=			(page-1)*10;
		Vector<ReviewVO>	list	=	new		Vector<ReviewVO>();
		StringBuffer		sql		=	new		StringBuffer();
												sql.append("select *  from review ");
												sql.append("where products_idx=? ");
												sql.append("order by date_added desc, ");
												sql.append("last_modified desc, ");
												sql.append("reviews_read asc limit ?,?");
		try
		{
							con		=			getConnection();
							pstmt	=			con.prepareStatement(sql.toString());
												pstmt.setInt(1, products_idx);
												pstmt.setInt(2, start);
												pstmt.setInt(3, limit);
							rs		=			pstmt.executeQuery();
			while(rs.next())
			{
				ReviewVO	vo		=	new		ReviewVO();
												vo.setIdx(rs.getInt(1));
												vo.setProducts_idx(rs.getInt(2));
												vo.setCustomers_idx(rs.getInt(3));
												vo.setReviews_rating(rs.getInt(4));
												vo.setReview_title(rs.getString(5));
												vo.setReview_text(rs.getString(6));
												vo.setDate_added(rs.getDate(7));
												vo.setLast_modified(rs.getDate(8));
												vo.setReviews_read(rs.getInt(9));				
												list.add(vo);
			}
		}catch (SQLException e) {			
												log.error("ReviewsDAO	"
														+ "getList() error : "+e);
		}finally {			
												close(rs);
												close(pstmt);
												close(con);			
		}	
		
		return list;
		
	}
	
	public Vector<ReviewVO> getMyList(int customers_idx, int page, int limit)
	{
		int					start	=			(page-1)*10;
		Vector<ReviewVO>	list	=	new		Vector<ReviewVO>();
		StringBuffer		sql		=	new		StringBuffer();
												sql.append("select *  from review ");
												sql.append("where customers_idx=? ");
												sql.append("order by date_added desc, ");
												sql.append("last_modified desc, ");
												sql.append("reviews_read asc limit ?,?");
		try
		{
							con		=			getConnection();
							pstmt	=			con.prepareStatement(sql.toString());
												pstmt.setInt(1, customers_idx);
												pstmt.setInt(2, start);
												pstmt.setInt(3, limit);
							rs		=			pstmt.executeQuery();
			while(rs.next())
			{
				ReviewVO	vo		=	new		ReviewVO();
												vo.setIdx(rs.getInt(1));
												vo.setProducts_idx(rs.getInt(2));
												vo.setCustomers_idx(rs.getInt(3));
												vo.setReviews_rating(rs.getInt(4));
												vo.setReview_title(rs.getString(5));
												vo.setReview_text(rs.getString(6));
												vo.setDate_added(rs.getDate(7));
												vo.setLast_modified(rs.getDate(8));
												vo.setReviews_read(rs.getInt(9));				
												list.add(vo);
			}
		}catch (SQLException e) {			
												log.error("ReviewsDAO	"
														+ "getMyList error : "+e);
		}finally {			
												close(rs);
												close(pstmt);
												close(con);			
		}	
		
		return list;
		
	}

	public Vector<ReviewVO> getMyPageList(int customers_idx, int limit)
	{
		Vector<ReviewVO>	list	=	new		Vector<ReviewVO>();
		String				sql		=	"select * from review where customers_idx=? order by "
										+ "date_added desc, last_modified desc, reviews_read asc limit 0,?";
		try
		{
							con		=			getConnection();
							pstmt	=			con.prepareStatement(sql);
												pstmt.setInt(1, customers_idx);
												pstmt.setInt(2, limit);
							rs		=			pstmt.executeQuery();
			while(rs.next())
			{
				ReviewVO	vo		=	new		ReviewVO();
												vo.setIdx(rs.getInt(1));
												vo.setProducts_idx(rs.getInt(2));
												vo.setCustomers_idx(rs.getInt(3));
												vo.setReviews_rating(rs.getInt(4));
												vo.setReview_title(rs.getString(5));
												vo.setReview_text(rs.getString(6));
												vo.setDate_added(rs.getDate(7));
												vo.setLast_modified(rs.getDate(8));
												vo.setReviews_read(rs.getInt(9));				
												list.add(vo);
			}
		}catch (SQLException e) {			
												log.error("ReviewsDAO	"
														+ "getMyPageList error : "+e);
		}finally {			
												close(rs);
												close(pstmt);
												close(con);			
		}	
		
		return list;
		
	}
	
	public ReviewVO getRow(int idx)
	{
		ReviewVO	vo		=		null;
		
		try
		{
			String 	sql		=		"select * from review where idx=?";
					con		=		getConnection();
					pstmt	=		con.prepareStatement(sql);
									pstmt.setInt(1, idx);
					rs		=		pstmt.executeQuery();
			if(rs.next())
			{
					vo		=	new	ReviewVO();
									vo.setIdx(rs.getInt("idx"));
									vo.setProducts_idx(rs.getInt("products_idx"));
									vo.setCustomers_idx(rs.getInt("customers_idx"));
									vo.setReviews_rating(rs.getInt("reviews_rating"));
									vo.setReview_title(rs.getString("review_title"));
									vo.setReview_text(rs.getString("review_text"));
									vo.setDate_added(rs.getDate("date_added"));
									vo.setLast_modified(rs.getDate("last_modified"));
									vo.setReviews_read(rs.getInt("reviews_read"));									
			}
		}
		catch (SQLException e)
		{			
									log.error("ReviewsDAO	"
											+ "getRow() error : "+e);
		}
		finally
		{
									close(rs);
									close(pstmt);
									close(con);
		}		
		return vo;	
	}
	
	public int getProduct_idx(int idx)
	{
			int		p_idx	=		0;
		
		try
		{
			String 	sql		=		"select products_idx from review where idx=?";
					con		=		getConnection();
					pstmt	=		con.prepareStatement(sql);
									pstmt.setInt(1, idx);
					rs		=		pstmt.executeQuery();
			if(rs.next())
			{
					p_idx	=		rs.getInt("products_idx");
			}
		}
		catch (SQLException e)
		{			
									log.error("ReviewsDAO	"
											+ "getProduct_idx("+idx+") error : "+e);
		}
		finally
		{
									close(rs);
									close(pstmt);
									close(con);
		}		
		return p_idx;	
	}
	
	public int hitUpdate(int idx)
	{
		int			result	=	0;
		String		sql		=	"update review set reviews_read=reviews_read+1";
					sql		+=	" where idx=?";
		try
		{
					con		=	getConnection();
					pstmt	=	con.prepareStatement(sql);
								pstmt.setInt(1, idx);
					result	=	pstmt.executeUpdate();			
		}
		catch(Exception e)
		{
								log.error("ReviewsDAO	"
										+ "hitUpdate() error : "+e);
		}finally {
			close(pstmt);
			close(con);
		}		
		return result;
	}
	
	//Actually pwdCheck is not needed but, just in case I wrote this. 
	//This one is use for customerTB search....not for reviewsTB.. 
	public int pwdCheck(int idx, String username, String password)
	{
			int		result	=	0;
		try
		{
			String	sql		=	"select idx from customer where "
								+ "username=? and password=?";
					con		=	getConnection();
					pstmt	=	con.prepareStatement(sql);
								pstmt.setString(1, username);
								pstmt.setString(2, password);
					rs		=	pstmt.executeQuery();
			if(rs.next())
			{
			ReviewVO	vo	=	new	ReviewVO();
								vo.setIdx(rs.getInt(1));
			int		idx_i	=	vo.getIdx();
			
					System.out.println("에러확인idx : "+idx);
					System.out.println("에러확인idx_i : "+idx_i);
				if(idx_i==idx)
					result	=	1;
				else
								log.error("QQQQQQQQ reviewDAO	"
										+ "pwdCheck error : text's writer is not currect");
			}
		}
		catch(Exception e)
		{
								log.error("ReviewsDAO	"
										+ "pwdCheck error : "+e);
		}
		finally
		{
								close(rs);
								close(pstmt);
								close(con);
		}		
		return result;
	}

	public int getCustomerIdx(String username, String password)
	{
			int		result	=	0;
		try
		{
			String	sql		=	"select idx from customer where "
								+ "username=? and password=?";
					con		=	getConnection();
					pstmt	=	con.prepareStatement(sql);
								pstmt.setString(1, username);
								pstmt.setString(2, password);
					rs		=	pstmt.executeQuery();
			if(rs.next())
			{
			ReviewVO	vo	=	new	ReviewVO();
								vo.setIdx(rs.getInt(1));
					result	=	1;				
			}
		}
		catch(Exception e)
		{
								log.error("QQQQQQQQ reviewDAO	"
										+ "getCustomerIdx error : "+e);
		}
		finally
		{
								close(rs);
								close(pstmt);
								close(con);
		}		
		return result;
	}
	
	public int delete(int idx)
	{
			int		result	=	0;
		try {
					con		=	getConnection();
			String	sql		=	"delete from review where idx=?";
					pstmt	=	con.prepareStatement(sql);
								pstmt.setInt(1, idx);
					result	=	pstmt.executeUpdate();			
		}catch (SQLException e) {			
								log.error("ReviewsDAO	"
										+ "delete error : "+e);
		}finally {
								close(pstmt);				
								close(con);			
		}		
		return result;
	}

	public int updateRow(int idx, String review_title, String review_text)
	{
			String	sql		=	"update review set review_title=?,"
									+ " review_text=?, last_modified=now() "
									+ "where idx=?";
			int		result	=	0;
		try {
					con		=	getConnection();
					pstmt	=	con.prepareStatement(sql);
								pstmt.setString(1, review_title);
								pstmt.setString(2, review_text);
								pstmt.setInt(3, idx);
					result	=	pstmt.executeUpdate();
		}
		catch (SQLException e)
		{			
								log.error("ReviewsDAO	"
										+ "updateRow error : "+e);
		}
		finally
		{
								close(pstmt);
								close(con);
		}
		return result;
	}
	
	public int searchList(String searchCondition, String searchWord)
	{
			String		sql		=	"select count(*) from review where ";
						sql		+=	searchCondition + " like ? order by";
						sql		+=	" date_added desc,last_modified desc,";
						sql		+=	" reviews_read asc";	
			int			result	=	0;
		try
		{
						con		=	getConnection();
						pstmt	=	con.prepareStatement(sql);
									pstmt.setString(1, "%"+searchWord+"%");
						rs		=	pstmt.executeQuery();
			if(rs.next())
			{
						result	=	rs.getInt(1);				
			}
		}
		catch (SQLException e)
		{
									log.error("ReviewsDAO	"
											+ "searchList error : "+e);
		}
		finally
		{
			close(rs);
			close(pstmt);
			close(con);
		}		
		
		return result;		
	}
	
	public int searchOneProductList(int products_idx, String searchCondition, String searchWord)
	{
			String		sql		=	"select count(*) from review where ";
						sql		+=	"products_idx=? and ";
						sql		+=	searchCondition + " like ? order by";
						sql		+=	" date_added desc,last_modified desc,";
						sql		+=	" reviews_read asc";	
			int			result	=	0;
		try
		{
						con		=	getConnection();
						pstmt	=	con.prepareStatement(sql);
									pstmt.setInt(1, products_idx);
									pstmt.setString(2, "%"+searchWord+"%");
						rs		=	pstmt.executeQuery();
			if(rs.next())
			{
						result	=	rs.getInt(1);				
			}
		}
		catch (SQLException e)
		{
									log.error("ReviewsDAO	"
											+ "searchOneProductList error : "+e);
		}
		finally
		{
			close(rs);
			close(pstmt);
			close(con);
		}		
		
		return result;		
	}
	
	public int searchOneCustomerList(int customers_idx, String searchCondition, String searchWord)
	{
			String		sql		=	"select count(*) from review where ";
						sql		+=	"customers_idx=? and ";
						sql		+=	searchCondition + " like ? order by";
						sql		+=	" date_added desc,last_modified desc,";
						sql		+=	" reviews_read asc";	
			int			result	=	0;
		try
		{
						con		=	getConnection();
						pstmt	=	con.prepareStatement(sql);
									pstmt.setInt(1, customers_idx);
									pstmt.setString(2, "%"+searchWord+"%");
						rs		=	pstmt.executeQuery();
			if(rs.next())
			{
						result	=	rs.getInt(1);				
			}
		}
		catch (SQLException e)
		{
									log.error("QQQQQQQQ reviewDAO	"
											+ "searchOneCustomerList error : "+e);
		}
		finally
		{
			close(rs);
			close(pstmt);
			close(con);
		}		
		
		return result;		
	}
	
	public Vector<ReviewVO> getSearchList(int page, int limit, String searchCondition, String searchWord)
	{
				Vector<ReviewVO>	list	=	new		Vector<ReviewVO>();
				int					start	=			(page-1)*10;
		
				String				sql		=	"select * from review where ";
									sql		+=	searchCondition;
									sql		+=	" like ? order by date_added desc, ";
									sql		+=	"last_modified desc, ";
									sql		+=	"reviews_read asc limit ?,?";		
		try 
		{
									con		=	getConnection();
									pstmt	=	con.prepareStatement(sql);
												pstmt.setString(1, "%"+searchWord+"%");
												pstmt.setInt(2, start);
												pstmt.setInt(3, limit);
									rs		=	pstmt.executeQuery();
			while(rs.next()) 
			{
				ReviewVO			vo		=	new	ReviewVO();
												vo.setIdx(rs.getInt(1));
												vo.setProducts_idx(rs.getInt(2));
												vo.setCustomers_idx(rs.getInt(3));
												vo.setReviews_rating(rs.getInt(4));
												vo.setReview_title(rs.getString(5));
												vo.setReview_text(rs.getString(6));
												vo.setDate_added(rs.getDate(7));
												vo.setLast_modified(rs.getDate(8));
												vo.setReviews_read(rs.getInt(9));				
												list.add(vo);
			}
		}
		catch (SQLException e)
		{
												log.error("ReviewsDAO	"
														+ "getSearchList error : "+e);
		}
		finally
		{
												close(rs);
												close(pstmt);
												close(con);
		}		
		return list;		
	}
	
	public Vector<ReviewVO> getProductSearchList(int products_idx, int page, int limit, String searchCondition, String searchWord)
	{
				Vector<ReviewVO>	list	=	new		Vector<ReviewVO>();
				int					start	=			(page-1)*10;
		
				String				sql		=	"select * from review where ";
									sql		+=	"products_idx=? and ";
									sql		+=	searchCondition;
									sql		+=	" like ? order by date_added desc, ";
									sql		+=	"last_modified desc, ";
									sql		+=	"reviews_read asc limit ?,?";		
		try 
		{
									con		=	getConnection();
									pstmt	=	con.prepareStatement(sql);
												pstmt.setInt(1, products_idx);
												pstmt.setString(2, "%"+searchWord+"%");
												pstmt.setInt(3, start);
												pstmt.setInt(4, limit);
									rs		=	pstmt.executeQuery();
			while(rs.next()) 
			{
				ReviewVO			vo		=	new	ReviewVO();
												vo.setIdx(rs.getInt(1));
												vo.setProducts_idx(rs.getInt(2));
												vo.setCustomers_idx(rs.getInt(3));
												vo.setReviews_rating(rs.getInt(4));
												vo.setReview_title(rs.getString(5));
												vo.setReview_text(rs.getString(6));
												vo.setDate_added(rs.getDate(7));
												vo.setLast_modified(rs.getDate(8));
												vo.setReviews_read(rs.getInt(9));				
												list.add(vo);
			}
		}
		catch (SQLException e)
		{
												log.error("ReviewsDAO	"
														+ "getProductSearchList error : "+e);
		}
		finally
		{
												close(rs);
												close(pstmt);
												close(con);
		}		
		return list;		
	}
	
	public Vector<ReviewVO> getCustomerSearchList(int customers_idx, int page, int limit, String searchCondition, String searchWord)
	{
				Vector<ReviewVO>	list	=	new		Vector<ReviewVO>();
				int					start	=			(page-1)*10;
		
				String				sql		=	"select * from review where ";
									sql		+=	"customers_idx=? and ";
									sql		+=	searchCondition;
									sql		+=	" like ? order by date_added desc, ";
									sql		+=	"last_modified desc, ";
									sql		+=	"reviews_read asc limit ?,?";		
		try 
		{
									con		=	getConnection();
									pstmt	=	con.prepareStatement(sql);
												pstmt.setInt(1, customers_idx);
												pstmt.setString(2, "%"+searchWord+"%");
												pstmt.setInt(3, start);
												pstmt.setInt(4, limit);
									rs		=	pstmt.executeQuery();
			while(rs.next()) 
			{
				ReviewVO			vo		=	new	ReviewVO();
												vo.setIdx(rs.getInt(1));
												vo.setProducts_idx(rs.getInt(2));
												vo.setCustomers_idx(rs.getInt(3));
												vo.setReviews_rating(rs.getInt(4));
												vo.setReview_title(rs.getString(5));
												vo.setReview_text(rs.getString(6));
												vo.setDate_added(rs.getDate(7));
												vo.setLast_modified(rs.getDate(8));
												vo.setReviews_read(rs.getInt(9));				
												list.add(vo);
			}
		}
		catch (SQLException e)
		{
												log.error("QQQQQQQQ reviewDAO	"
														+ "getCustomerSearchList error : "+e);
		}
		finally
		{
												close(rs);
												close(pstmt);
												close(con);
		}		
		return list;		
	}
	
}
