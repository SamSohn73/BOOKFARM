<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String	type	=	"login";
	if(request.getParameter("type")!=null)
			type	=	request.getParameter("type");

	//CSS
	/*
	login_btn
	btn
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script>
	function register_check(form){
	
		if(form.username.value.length==0){
			alert('아이디를 확인해 주세요');
			form.username.focus();
			return;
		}else if(form.password.value.length==0){
			alert('비밀번호를 확인해 주세요');
			form.password.focus();
			return;
		}else{
			form.submit();
		}
	}
</script>
</head>
<body onload="pwdCheck.pwd.focus()">
<form name="pwdCheck" method="post" action="../qCustomerIdPwdCheck.do?type=<%=type %>" target="_top">
	<table>
		<caption>아이디 비밀번호 입력</caption>
		
		<tr>
			<td>
				<input type="text" size="20" name="username" required="required">
			</td>
			<td rowspan="2">				
				<%if(type.equals("login")){ %>
				<input type="submit" class="login_btn" value="로그인">
				<%}else if(type.equals("modify")){ %>
				<input type="submit" class="login_btn" value="확인">
				<%} %>
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" size="20" name="password" required="required">
			</td>
		</tr>
		<%if(type.equals("login")){ %>
		<tr>
			<td>
				<a href="regist_v2.jsp?type=insert" target="_top">
				<input type="button" class="btn" value="회원가입"></a>
				<a href="findChk.jsp" target="_top">
				<input type="button" class="btn" value="아이디/비번 확인"></a>
			</td>			
		</tr>
		<%} %>
	</table>
</form>
</body>
</html>