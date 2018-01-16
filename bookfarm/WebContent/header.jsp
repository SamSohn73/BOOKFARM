<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CustomerVO		cVo			=	(CustomerVO) session.getAttribute("loggedInUserVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면(테스트)</title>
</head>
<body>
	<h1><%=cVo.getFirstname()%> 님이 로그인 하셨습니다.</h1>
	<a href="./member/mypage.jsp" target="_top">myPage</a>
	<a href="qCustomerLogout.do" target="_top">logout</a>
</body>
</html>