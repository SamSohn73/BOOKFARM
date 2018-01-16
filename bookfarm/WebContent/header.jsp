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
	<%if(session.getAttribute("loggedInUserVO")!=null) {%>
	<h2 align="right"><%=cVo.getFirstname()%> 님이 로그인 하셨습니다.</h2>
	<a href="./member/mypage.jsp" target="_top">myPage</a>
	<a href="qCustomerLogout.do" target="_top">logout</a>
	<%}else{ %>
	<h2 align="right">비회원 로그인 입니다.</h2>
	<a href="./member/regist_v2.jsp?type=insert" target="_top">회원가입</a>
	<%} %>
	
</body>
</html>