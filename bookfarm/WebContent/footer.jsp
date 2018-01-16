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
	<h2 align="right">여기는  footer입니다.</h2>
	<a href='./admin/adminLogin.jsp' target="_top"> 관리자모드 </a>
</body>
</html>