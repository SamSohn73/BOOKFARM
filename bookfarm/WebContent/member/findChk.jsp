<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 찾기</title>
<script>
function register_check(form){
	if(form.firstname.value.length==0){
		alert('이름을 확인해 주세요');
		form.firstname.focus();
		return;
	}else if(form.phone1.value.length==0){
		alert('연락처를 확인해 주세요');
		form.phone1.focus();
		return;
	}else{
		form.submit();
	}
}
</script>
</head>
<body>
<form action="../qCustomerFind.do" method="post">
<table>
	<tr>
		<td><label>연락처1</label>
		<td><input type="text" name="phone1" placeholder="연락처1"></td>
	</tr>
	<tr>
		<td><label>이름</label>
		<td><input type="text" name="firstname" placeholder="이름"></td>
	</tr>
	<tr>
		<td><input type="submit" class="btn" value="회원 정보 찾기"></td>
		<td ><a href="../index.jsp"><input type="button" class="btn" value="뒤로가기"></a></td>
	</tr>
</table>
</form>
</body>
</html>