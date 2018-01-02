<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	String	review_num			= "";

	//출력 변수
			review_num			= "";
			
	//CSS
	/*
	login_btn
	btn
	*/

	//리뷰 수정시 ? 리뷰 번호 가져오기
	review_num = request.getParameter("review_num");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<form name="pwdCheck" method="post" action="../qCustomerIdPwdCheck.do?type=login">
	<table>
		<caption>아이디 비밀번호 입력</caption>
		
		<tr>
			<td>
				<input type="text" size="20" name="username" required="required">
			</td>
			<td rowspan="2">
				<input type="submit" class="login_btn" value="로그인">
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" size="20" name="password" required="required">
			</td>
		</tr>
		<tr>
			<td>
				<a href="regist_v2.jsp" target="_top">
				<input type="button" class="btn" value="회원가입"></a>
				<a href="IdPassFind.jsp" target="_top">
				<input type="button" class="btn" value="아이디/비번 확인"></a>
			</td>			
		</tr>
	</table>
	<input type="hidden" name="review_num" value="<%=review_num %>">
</form>
</body>
</html>