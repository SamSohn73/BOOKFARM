<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.Logger"%>

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
				<td>
					<iframe src="./member/login.jsp"></iframe>
				</td>
				<td>
					비회원 로그인
				</td>
			</tr>
		
		</table>
	<a href='./productList.do'> 상품 목록 </a>
	</form>
</body>
</html>