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
	HttpSession	sess			=	request.getSession();
	String	type				=	request.getParameter("type");
	CustomerVO	cVo				=	(CustomerVO)sess.getAttribute("LoginedUserVO");
	ReviewVO	vo				=	(ReviewVO)request.getAttribute("vo");
	CustomerDAO	cDao			=	new CustomerDAO();
	int			idx				=	vo.getIdx();
	int			currentPage		=	Integer.parseInt(request.getParameter("page"));
	int			products_idx	=	vo.getProducts_idx();

	
	/*CSS	
	left
	right
	file_t
	btn
	*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function returnList2(){
		location.href="./qAdminReviewsLists.do?page=<%=currentPage%>&type=<%=type%>&products_idx=<%=products_idx%>";
</script>
</head>
<body>
<form action="qAdminReviewsModify.do" method="post">
<table>
		<caption>리뷰 수정</caption>
	<tr>
		<td class="left">글쓴이</td>
		<td class="right"><input type="text" name="review_writer" size="15" required="required"
		readonly="readonly"value=<%=cDao.getName(vo.getCustomers_idx()) %>></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		value=<%=vo.getReview_title() %>></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		><%=vo.getReview_text() %></textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="btn_align">
		<input class="btn" type="submit" value="수정">
		<input class="btn" type="button" value="목록보기"onclick="returnList2()">
		</td>
	</tr>
</table>
<input type="hidden" name="page" value="<%=currentPage%>">
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="products_idx" value="<%=products_idx%>">
<input type="hidden" name="idx" value="<%=idx %>">
</form>
</body>
</html>