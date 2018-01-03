<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="xyz.bookfarm.vo.CustomerVO" %>
<%
	CustomerVO	vo			=	(CustomerVO)request.getAttribute("LoginedUserVO");
	
		
		
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<table class="클래스_테이블1">
			<caption>주문자 정보</caption>
			<tr class="클래스_tr_top1">
				<td class="left">주문하신 분</td>
				<td colspan="3" class="right">user_name</td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right">user_tel1</td>										
				<td class="left">이메일</td>
				<td class="right">user_email</td>
			</tr>
</table>
		<table class="클래스_테이블1">
			<caption>구매 내역 확인</caption>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >수량</th>
				<th >주문금액</th>
				<th >날짜</th>
			</tr>
<%		for(/*VO가져온것 돌리기*/int i=0;i<=0;i++){	%>
			<tr class="클래스_tr_top1">
				<td class="클래스_td_align1">purchase_num</td>
				<td align="left"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">
				purchase_info</a></td>	
				<td>purchase_count</td>									
				<td>purchase_price</td>
				<td>purchase_date</td>
			</tr>
<%}%>
</table>
		<table class="클래스_테이블1">
			<tr class="클래스_tr_top1">
				<td class="left">받으실 분</td>
				<td colspan="3" class="right">receive_name</td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right">user_tel1</td>										
				<td class="left">전화번호</td>
				<td class="right">user_tel2</td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">주소</td>
				<td colspan="3" class="right">receive_addr</td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">결제 금액</td>
				<td colspan="3" class="right">total_price</td>
			</tr>
</table>
</body>
</html>