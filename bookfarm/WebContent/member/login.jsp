<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	String	review_num			= "";

	//출력 변수
	String	user_passwd			= "";
	String	user_id				= "";
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
	
		if(form.user_id.value.length==0){
			alert('아이디를 확인해 주세요');
			form.user_id.focus();
			return;
		}else if(form.user_passwd.value.length==0){
			alert('비밀번호를 확인해 주세요');
			form.user_passwd.focus();
			return;
		}else{
			form.submit();
		}
	}
	function regist(){
		location.href="../qRegist.do";
	}
	function find(){
		location.href="../qFind.do";
	}
</script>
</head>
<body onload="pwdCheck.pwd.focus()">
<form name="pwdCheck" method="post" action="../qPwdCheck.do">
	<table>
		<caption>아이디 비밀번호 입력</caption>
		
		<tr>
			<td>
				<input type="text" size="20" name="user_id" required="required">
			</td>
			<td rowspan="2">
				<input type="submit" class="login_btn" value="로그인">
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" size="20" name="user_passwd" required="required">				
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" class="btn" value="회원가입" onclick="regist()">
				<input type="button" class="btn" value="아이디/비번 확인" onclick="find()">
				<input type="button" class="btn" value="돌아가기" onclick="javascript:history.back()">
			</td>			
		</tr>
	</table>
	<input type="hidden" name="review_num" value="<%=review_num %>">
</form>
</body>
</html>