<%@page import="xyz.bookfarm.vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CustomerVO		cVo			=	(CustomerVO) session.getAttribute("LoginedUserVO");
	String			product1	=	"1";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=cVo.getFirstname()%> 님이 로그인 하셨습니다.</h1>
	<a href="mypage.jsp">myPage</a>
	<a href="../qCustomerLogout.do">logout</a>
	<a href="../qReviewsLists.do?type=list&products_idx=<%=product1 %>"><%=product1 %></a>
	product's review2
	product's review3

</body>
</html>