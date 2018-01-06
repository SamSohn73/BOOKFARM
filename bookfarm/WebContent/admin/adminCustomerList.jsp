<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="xyz.bookfarm.vo.AdminVO"%>
<%@page import="xyz.bookfarm.vo.CustomerVO"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객 관리</title>
</head>
<body>
<%
	Vector<CustomerVO> customers = (Vector<CustomerVO>) request.getAttribute("customers");
%>

	<table>
		<caption>회원 목록</caption>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>우편번호</th>
			<th>주소1</th>
			<th>주소2</th>
			<th>전화번호 1</th>
			<th>전화번호 2</th>
			<th>전화번호 3</th>
			<th>이메일 1</th>
			<th>이메일 2</th>
			<th>성별</th>
			<th>생일</th>
			<th>등급</th>
			<th>마지막 로그인</th>
			<th>로그인 카운트</th>
			<th>계정 생성일</th>
		</tr>

<%		for(CustomerVO customer: customers) {%>
		<tr>
			<td><%=customer.getUsername()%></td>
			<td><%=customer.getLastname()%><%=customer.getFirstname()%></td>
			<td><%=customer.getPostcode()%></td>
			<td><%=customer.getAddress1()%></td>
			<td><%=customer.getAddress2()%></td>
			<td><%=customer.getPhone1()%></td>
			<td><%=customer.getPhone2()%></td>
			<td><%=customer.getPhone3()%></td>
			<td><%=customer.getEmail1()%></td>
			<td><%=customer.getEmail2()%></td>
			<td><%=customer.getGender()%></td>
			<td><%=customer.getBirthday()%></td>
			<td><%=customer.getGrade()%></td>
			<td><%=customer.getLast_login()%></td>
			<td><%=customer.getLogin_cnt()%></td>
			<td><%=customer.getAccount_created()%></td>
		</tr>
<%		} %>
	</table>
	<h2><a href="adminLogin.jsp">처음으로</a></h2>
</body>
</html>