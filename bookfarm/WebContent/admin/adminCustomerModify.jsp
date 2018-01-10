<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.AdminVO"%>
<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%	
	CustomerVO 			customer	= (CustomerVO)	request.getAttribute("vo");
	String current_page 			=	request.getParameter("page");
%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<table>
	<form action="adminCustomerModify.do" method="post" >
	<caption>회원 정보 수정</caption>
		<tr>
			<td class="td_left">password</td>					
			<td class="td_right">
			<input type='text' name='password' size="64" readonly value="<%=customer.getPassword() %>">								
			</td>
		</tr>
		<tr>
			<td class="td_left">아이디</td>					
			<td class="td_right">
			<input type='text' name='username' size="64" value="<%=customer.getUsername() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">이름</td>					
			<td class="td_right">
			<input type='text' name='name' size="64" value="<%=customer.getFirstname() %>">	
			</td>
		</tr>		
		<tr>
			<td class="td_left">우편 번호</td>					
			<td class="td_right">
			<input type='text' name='postcode' size="64" value="<%=customer.getPostcode() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">주소 1</td>					
			<td class="td_right">
			<input type='text' name='address1' size="64" value="<%=customer.getAddress1() %>">	
			</td>
		<tr/>
		<tr>
			<td class="td_left">주소 2</td>					
			<td class="td_right">
			<input type='text' name='address2' size="64" value="<%=customer.getAddress2() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">전화 번호 1</td>					
			<td class="td_right">
			<input type='text' name='phone1' size="64" value="<%=customer.getPhone1() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">이메일 1</td>					
			<td class="td_right">
			<input type='text' name='email1' size="64" value="<%=customer.getEmail1() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">성별</td>					
			<td class="td_right">
			<input type='text' name='gender' size="64" value="<%=customer.getGender() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">생일</td>					
			<td class="td_right">
			<input type='text' name='birthday' size="64" value="<%=customer.getBirthday() %>">	
			</td>
		</tr>
		<tr>
			<td class="td_left">마지막 로그인</td>					
			<td class="td_right">
			<input type='text' name='last_login' size="64" value="<%=customer.getLast_login() %>">	
			</td>
		<tr class="button_cell">
			<td colspan='2'>			
			<input type='submit' value="수정"> 
			<input type='button' value='뒤로' onClick="javascript:history.go(-1);">				
			</td>
		</tr>
	<input type="hidden" name="idx" value=<%=customer.getIdx() %>>
	<input type="hidden" name="page" value=<%=current_page %>>	
	</form>	
	</table>	
</html>