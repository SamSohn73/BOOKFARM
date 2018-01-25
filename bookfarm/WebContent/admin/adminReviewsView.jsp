<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.dao.ReviewDAO" %>
<%@ page import="gq.bookfarm.dao.CustomerDAO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
	ReviewVO	reviewVO		=	(ReviewVO)request.getAttribute("reviewVO");
	String		name			=	(String)request.getAttribute("name");
	int			current_page	=	Integer.parseInt(request.getParameter("page"));
	int			idx				=	Integer.parseInt(request.getParameter("idx"));
	int			products_idx	=	Integer.parseInt(request.getParameter("p"));
	int			parent_idx		=	Integer.parseInt(request.getParameter("par"));
	int			category_idx	=	Integer.parseInt(request.getParameter("cat"));
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
<title>Insert title here</title>
</head>
<body>
<form action="./adminReviewsModify.do?type=m" method="post">
<table>
		<caption>리뷰 보기</caption>
	<tr>
		<td class="left">글쓴이</td>
		<td class="right"><input type="text" name="review_writer" size="15" required="required"
		readonly="readonly"value=<%=name %>></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		readonly="readonly" value=<%=reviewVO.getReview_title() %>></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		readonly="readonly"><%=reviewVO.getReview_text() %></textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="btn_align">
		<input class="btn" type="button" value="뒤로가기" onclick="javascript:history.back()">
		
		<a href="./adminReviewsList.do">
		<input class="btn" type="button" value="목록보기"></a>
		
		<input class="btn" type="submit" value="수정하기"/>
		
		<a href="./adminReviewsDelete.do?idx=<%=idx%>&p=<%=products_idx%>
		&par=<%=parent_idx%>&cat=<%=category_idx%>">
		<input class="btn" type="button" value="삭제하기"></a>
		</td>
	</tr>
</table>
<input type="hidden" name="page" value="<%=current_page %>">
<input type="hidden" name="idx" value="<%=idx %>">
<input type="hidden" name="p" value="<%=products_idx %>">
<input type="hidden" name="par" value="<%=parent_idx %>">
<input type="hidden" name="cat" value="<%=category_idx %>">
</form>
</body>
</html>