<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.dao.ReviewDAO" %>
<%@ page import="gq.bookfarm.dao.CustomerDAO" %>
<%@ page import="gq.bookfarm.dao.CategoryDAO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		//CustomerVO	userVO		=	(CustomerVO)session.getAttribute("adminVO");
		Vector<ReviewVO> list	=	(Vector<ReviewVO>)request.getAttribute("list");
		PageVO	info			=	(PageVO)request.getAttribute("info");
		Vector<CategoryVO> catVo1=	(Vector<CategoryVO>)request.getAttribute("catVo1");
		Vector<CategoryVO> catVo2=	(Vector<CategoryVO>)request.getAttribute("catVo2");
		Vector<ProductVO> VpVo	=	(Vector<ProductVO>)request.getAttribute("VpVo");
		int		totalPages		=	info.getTotalPages();
		int		currentPage		=	info.getPage();
		int		startPage		=	info.getStartPage();
		int		endPage			=	info.getEndPage();
		int		totalRows		=	info.getTotalRows();
		
		
		CustomerDAO cDao		=	new CustomerDAO();
		String	searchCondition	=	(String)request.getAttribute("searchCondition");
		String	searchWord		=	(String)request.getAttribute("searchWord");
		
		
		int		products_idx	=	0;
		int		category_idx	=	0;
		int		parent_idx		=	0;
			if(request.getParameter("products_idx")!=null)	
				products_idx	=	Integer.parseInt((String)request.getParameter("products_idx"));
			if(request.getParameter("category_idx")!=null)	
				category_idx	=	Integer.parseInt((String)request.getParameter("category_idx"));
			if(request.getParameter("parent_idx")!=null)	
				parent_idx		=	Integer.parseInt((String)request.getParameter("parent_idx"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰창</title>
	<script>
		function search()
		{
			if(searchform.searchWord.value=="")
			{
				alert('검색어를 넣으세요');
				searchform.searchWord.focus();
				return;
			}
				searchform.submit();
		}
	</script>
</head>
<body>
<table	class="클래스_bottom_table1">
			<tr>
				<td class="클래스_btn_align1">
					<form action="adminReviewsList.do?" method="post">
						<select class="btn" name="parent_idx">
							<option value="0">전체</option>
						<% for(CategoryVO cat_Vo1 :catVo1){ %>
							<option value="<%=cat_Vo1.getIdx()%>"
							<%if(parent_idx==cat_Vo1.getIdx()){%> selected<%}%>>
							<%= cat_Vo1.getCategory_name()%></option>
							<%} %>
						</select>
						<%if(parent_idx!=0){ %>
						<select class="btn" name="category_idx">
							<option value="0">전체</option>
						<% for(CategoryVO cat_Vo2 :catVo2){ %>
							<option value="<%=cat_Vo2.getIdx()%>"
							<%if(category_idx==cat_Vo2.getIdx()){%> selected<%}%>>
							<%= cat_Vo2.getCategory_name()%></option>
							<%} %>
						</select>
						<%} 
						  if(category_idx!=0){%>
						<select class="btn" name="products_idx">
							<option value="0">전체</option>
						<% for(ProductVO pVo :VpVo){ %>
							<option value="<%=pVo.getIdx()%>"
							<%if(products_idx==pVo.getIdx()){%> selected<%}%>>
							<%= pVo.getProduct_name()%></option>
							<%} %>
						<%} %>
						</select>
						<input type="submit" class="클래스_btn1" value="검색">
					</form>
				</td>
				<td class="클래스_btn_align1">
					<form action="adminReviewsSearch.do?page=<%=currentPage%>&products_idx=<%=products_idx %>
					&parent_idx=<%=parent_idx %>&category_idx=<%=category_idx %>"
					method="post" name="searchform">
						<select class="btn" name="searchCondition">
							<option value="customers_idx"
							<%if(searchCondition!=null && searchCondition.equals("customers_idx")){%>
							selected<%}%>>작성자</option>
							<option value="review_title"
							<%if(searchCondition!=null && searchCondition.equals("review_title")){%>
							selected<%}%>>제목</option>
							<option value="review_text"
							<%if(searchCondition!=null && searchCondition.equals("review_text")){%>
							selected<%}%>>글내용</option>
						</select>
						<input type="text" class="클래스_btn1" size="10" name="searchWord" required="required"
						<%if(searchWord!=null){%> value="<%=searchWord%>"<%}%>/>
						<input type="button" class="클래스_btn1" value="검색" onclick="search()">
					</form>
				</td>
			</tr>
</table>
		<table class="클래스_테이블1">
			<caption>
			리뷰게시판
			</caption>
			<tr class="클래스_tr타이틀1">
				<th >날짜</th>
				<th >제목</th>
				<th >작성자</th>
				<th >조회수</th>
			</tr>
			<%for(ReviewVO vo:list)
				{%>
				<tr class="클래스_tr_top1">
					<td><%=vo.getDate_added()%></td>
					<td align="left"><a href="adminReviewsView.do?idx=<%=vo.getIdx()%>
					&page=<%=currentPage%>&p=<%=products_idx%>&par=<%=parent_idx%>
					&cat=<%=category_idx%>&con=<%=searchCondition%>&word=<%=searchWord%>">
					<%=vo.getReview_title()%></a></td>
					<td><%=cDao.getName(vo.getCustomers_idx())%></td>
					<td><%=vo.getReviews_read()%></td>
				</tr>
				<%}%>
<tr>
	<td colspan="4" align="center">
		<%	if(searchWord == null)
			{
				if(currentPage<=1)
				{
						out.print("");
				}
				else
				{
						out.print("<a href=./adminReviewsList.do?page="+(currentPage-1)+
								"&products_idx="+products_idx
								+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
						out.print("[이전]</a>");
				}
				for(int i=startPage;i<=endPage;i++)
				{
					if(i==currentPage)
					{
						out.print("["+i+"]");
					}
					else
					{					
						out.print("<a href=./adminReviewsList.do?page="+i+
								"&products_idx="+products_idx
								+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
						out.print(i+"</a>");
					}
				}
				if(currentPage>=totalPages)
				{
						out.print("");
				}
				else
				{
						out.print("<a href=./adminReviewsList.do?page="+(currentPage+1)+
								"&products_idx="+products_idx
								+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
						out.print("[다음]</a>");
				}
			}
			else
			{
				if(currentPage<=1)
				{
					out.print("");
				}
				else
				{
					out.print("<a href=./adminReviewsSearch.do?page="+(currentPage-1)+
							"&searchCondition="+searchCondition+
							"&searchWord="+searchWord+
							"&products_idx="+products_idx
							+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
					out.print("[이전]</a>");
				}
				for(int i=startPage;i<=endPage;i++)
				{
					if(i==currentPage)
					{
						out.print("["+i+"]");
					}
					else
					{					
						out.print("<a href=./adminReviewsSearch.do?page="+i+
								"&searchCondition="+searchCondition+
								"&searchWord="+searchWord+
								"&products_idx="+products_idx
								+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
						out.print(i+"</a>");
					}
				}
				if(currentPage>=totalPages)
				{
						out.print("");
				}
				else
				{
						out.print("<a href=./adminReviewsSearch.do?page="+(currentPage+1)+
								"&searchCondition="+searchCondition+
								"&searchWord="+searchWord+
								"&products_idx="+products_idx
								+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
						out.print("[다음]</a>");
				}
			}%>
	</td>
</tr>
			<tr align="right">
				<td align="right" colspan="4">
				<a href="./admin/adminReviewsWrite.jsp?page=<%=currentPage%>
				&products_idx=<%=products_idx %>&parent_idx=<%=parent_idx %>
				&category_idx=<%=category_idx %>">[글쓰기]</a>
				<a href="./admin/adminLogin.jsp">[메인으로]</a>
				</td>
			</tr>
</table>
</body>
</html>