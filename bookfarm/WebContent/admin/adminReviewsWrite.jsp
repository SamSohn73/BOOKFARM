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
	CustomerVO	cVo				=	(CustomerVO)sess.getAttribute("loggedInUserVO");
	int			products_idx	=	Integer.parseInt(request.getParameter("products_idx"));

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
	function returnList1(){
		location.href="../qReviewsLists.do?&type=<%=type%>&products_idx=<%=products_idx%>";
	}
</script>
</head>
<body>
<form action="../qReviewsInsert.do" method="post">
<table>
		<caption>리뷰 등록</caption>
	<tr>
		<td class="left">글쓴이</td>
		<td class="right"><input type="text" name="review_writer" size="15" required="required"
		readonly="readonly"value=<%=cVo.getUsername() %>></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		placeholder="리뷰 제목"></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		placeholder="리뷰 내용"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="btn_align">
		<input class="btn" type="submit" value="등록">
		<input class="btn" type="button" value="취소" onclick="javascript:history.back()">
		<input class="btn" type="button" value="목록보기"onclick="returnList1()">
		</td>
	</tr>
</table>
<input type="hidden" name="type" value="<%=type %>">
<input type="hidden" name="products_idx" value="<%=products_idx %>">
</form>
</body>
</html>