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
<header>
<iframe src="header.do" height="150" width="800"></iframe>
</header>
<body>


<a href='productList.do'> 상품 목록 </a>
<a href='index.jsp'>처음으로</a>


</body>
<footer>
<iframe src="footer.do" height="150" width="800"></iframe>
</footer>
</html>