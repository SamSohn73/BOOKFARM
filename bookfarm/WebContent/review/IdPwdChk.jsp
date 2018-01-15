<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	int		currentPage		=	Integer.parseInt(request.getParameter("page"));	
	String	type			=	request.getParameter("type");
	String	typeView		=	request.getParameter("typeView");
	int		idx				=	Integer.parseInt(request.getParameter("idx"));
	int		products_idx	=	Integer.parseInt(request.getParameter("products_idx"));
	
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
<title>로그인 정보 확인</title>
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
<form name="pwdCheck" method="post" action="../qReviewsIdPassChk.do">
	<table>
		<caption>아이디 비밀번호 입력</caption>
		
		<tr>
			<td>
				<input type="text" size="20" name="username" required="required">
			</td>
			<td rowspan="2">
				<input type="submit" class="login_btn" value="제출">
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" size="20" name="password" required="required">				
			</td>
		</tr>
	</table>
	<input type="hidden" name="page" value="<%=currentPage %>">
	<input type="hidden" name="type" value="<%=type %>">
	<input type="hidden" name="idx" value="<%=idx %>">
	<input type="hidden" name="typeView" value="<%=typeView %>">
</form>
</body>
</html>