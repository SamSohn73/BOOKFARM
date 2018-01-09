<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gq.bookfarm.vo.AdminVO"%>
<% AdminVO adminVO = (AdminVO)session.getAttribute("adminVO"); %>    
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
	
	function customer_list(){
		location.href="../adminCustomerList.do";
	}
	function product_list(){
		location.href="../adminProductList.do";
	}
	function category_list(){
		location.href="../adminCategoryList.do";
	}
	function orders_list(){
		location.href="../adminOrdersList.do";
	}
	function review_list(){
		location.href="../adminReviewList.do";
	}
	function logout(){
		location.href="../adminLogout.do";
	}
</script>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<form method="post" action="../adminLogin.do">
<%if(adminVO==null){%>
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
	<%=adminVO.getUser_name()%> 님 반갑습니다.

	<table>
		<td>
			<tr class="button_cell">
				<td colspan='2'>
					<input type='button' value="고객관리"		onClick="customer_list()">
					<input type='button' value="상품관리"		onClick="product_list()">
					<input type="button" value="주문관리"		onClick="orders_list()">
					<input type="button" value="카테고리관리"	onClick="category_list()">
					<input type="button" value="리뷰관리"		onClick="review_list()">
					<input type="button" value="로그아웃"		onClick="logout()">
				</td>
			</tr>
		</td>
	</table>
<%}%>
</body>
</html>


