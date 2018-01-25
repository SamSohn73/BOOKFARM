<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String username	=	(String)request.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
<title>아이디 찾기</title>
</head>
<body>
당신의 아이디는 <%=username%> 입니다.<br>
<a href="./index.jsp">돌아가기</a>

</body>
</html>