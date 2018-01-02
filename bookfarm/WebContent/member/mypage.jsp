<%@page import="xyz.bookfarm.vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	CustomerVO		cVo			=	(CustomerVO) request.getAttribute("LoginedUserVO");
	int				customer_idx=	Integer.parseInt((String)request.getAttribute("customer_idx"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1><%=cVo.getFirstname() %> 님의 마이페이지 입니다</h1>
		<table class="myPage_table1">
			<caption>회원 정보</caption>
			<tr class="myPage_tr_top1">
				<td class="left">아이디</td>
				<td class="right"><%=cVo.getUsername() %></td>
				<td class="left">이름</td>
				<td class="right"><%=cVo.getFirstname() %></td>
			</tr>
			<tr class="myPage_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right"><%=cVo.getPhone1() %></td>
				<td class="left">이메일</td>
				<td class="right"><%=cVo.getEmail1() %></td>
			</tr>
			<tr class="myPage_tr_top1">
				<td class="left" rowspan="2">주소</td>
				<td colspan="3" class="right"><%=cVo.getAddress1() %></td>
			</tr>
			<tr class="myPage_tr_top1">
				<td colspan="3" class="right"><%=cVo.getAddress2() %></td>
			</tr>
			<tr>
				<td align="right"><a href="qCustomerIdPwdCheck.do?type=modify">
				내정보 수정</a></td>
			</tr>
		</table>

		<table class="클래스_테이블1">
			<caption>구매 내역 확인</caption>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >주문금액</th>
				<th >날짜</th>
			</tr>
		<%for(/*VO가져온것 돌리기*/int i=0;i<=0;i++)
		{%>
			<tr class="클래스_tr_top1">
				<td class="클래스_td_align1"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">
				purchase_num</a></td>
				<td align="left"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">
				purchase_info</a></td>										
				<td>purchase_price</td>
				<td>purchase_date</td>
			</tr>
		<%}%>
			<tr>
				<td align="right"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">
				더보기</a></td>
			</tr>
		</table>
		
		<iframe src="qReviewsLists.do?type=myPage&customers_idx=<%=customer_idx%>"
				height="450" width="800"></iframe>
		
		<a href="/qCustomerLogout.do">logout</a>
</body>
</html>