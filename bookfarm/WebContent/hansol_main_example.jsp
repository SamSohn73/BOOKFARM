<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CustomerVO		cVo			=	(CustomerVO) session.getAttribute("loggedInUserVO");
	String			product1	=	"1";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면(테스트)</title>
</head>
<body>
	<h1><%=cVo.getFirstname()%> 님이 로그인 하셨습니다.</h1>
	<a href="./member/mypage.jsp">myPage</a>
	<a href="qCustomerLogout.do">logout</a>
	<a href='productList.do'> 상품 목록 </a>
</body>
</html>