<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%
	CustomerVO		cVo			=	new CustomerVO();
	
	if(session.getAttribute("loggedInUserVO")!=null)
					cVo			=	(CustomerVO) session.getAttribute("loggedInUserVO");
	
%>
<%! private final Logger log = Logger.getLogger(this.getClass()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to BookFarm</title>
<script >

</script>
</head>
<body>
	<form>
		<table>
			<caption>Welcome to BookFarm!!!</caption>
			<tr>
			<% if(session.getAttribute("loggedInUserVO")!=null){%>
				<td>
					<p><%=cVo.getFirstname() %> 님 환영합니다</p>
				</td>
			</tr>
			<tr>
				<td>
					<a href="hansol_main_example.jsp">메인으로</a>
				</td>
			<%}else{ %>
				<td>
					<iframe src="./member/login.jsp"></iframe>
				</td>
				<td>
					<a href="hansol_main_example.jsp">비회원 로그인</a>
				</td>
			<%} %>
			</tr>
		
		</table>
	<a href='./productList.do'> 상품 목록 </a>
	</form>
</body>
</html>