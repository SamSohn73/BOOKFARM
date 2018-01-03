<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String username	=	(String)request.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
당신의 아이디는 <%=username%> 입니다.<br>
<a href="./index.jsp">돌아가기</a>

</body>
</html>