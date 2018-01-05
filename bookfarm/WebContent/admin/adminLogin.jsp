<%@page import="xyz.bookfarm.vo.AdminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% AdminVO vo = (AdminVO)session.getAttribute("vo"); %>    
<!DOCTYPE html>
<html>
<head>

<script>
	function check(form){
		if(form.user_name.value.length==0){
			alert('아이디를 확인해 주세요');
			form.user_name.focus();
			return;
		}else if(form.user_pass.value.length==0){
			alert('비밀번호를 확인해 주세요');
			form.user_pass.focus();
			return;
		}else{
			form.submit();
		}
	}

</script>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<form method="post" action="../AdminLogin.do">
<%if(vo==null){%>
	<table>
		<tr>
			<td><input type="text"  name="user_name" placeholder="아이디" required></td>

			<td><input type="password"  name="user_pass" placeholder="비밀번호" required></td>
		</tr>
		<tr>
			<td rowspan="2">
				<button type="button" onclick="check(this.form);">로그인</button>
			</td>
		</tr>
	</table>
</form>
<%}else{%>
	<%=vo.getUser_name()%> 님 반갑습니다.

<%}%>
</body>
</html>


