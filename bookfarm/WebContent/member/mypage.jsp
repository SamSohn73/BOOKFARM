<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		//입력 필요한 변수들
		//Servlet에서 담아놓은 정보 가져오기
		//vo						//VO새로 만들고 거기에 옮기기
		//다른 추가정보도 받음

		String	type				= "";	//
		String	review_num			= "";
		String	review_re_lev		= "";
		String	review_subject		= "";
		String	review_writer		= "";
		String	review_count		= "";
		
		String	user_id				= "1";
		String	user_name			= "1";
		String	user_addr1			= "1";
		String	user_tel1			= "1";
		String	user_email			= "1";
		
		String	purchase_num		= "";
		String	purchase_info		= "";
		String	purchase_price		= "";
		String	purchase_date		= "";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<table class="클래스_테이블1">
			<caption>회원 정보</caption>
			<tr class="클래스_tr_top1">
				<td class="left">아이디</td>
				<td class="right">user_id</td>										
				<td class="left">이름</td>
				<td class="right">user_name</td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right">user_tel1</td>										
				<td class="left">이메일</td>
				<td class="right">user_email</td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">주소</td>
				<td colspan="3" class="right">user_addr1</td>
			</tr>
			<tr>
				<td align="right"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">
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
		<table class="클래스_테이블1">
			<caption>
			<%	if(type.equals("list"))
			{%>
				리뷰 게시판
			<%}else{ %>
				내 리뷰 목록
			<%}%>
			</caption>
			<tr class="클래스_tr타이틀1">
				<th >번호</th>
				<th >제목</th>
				<th >작성자</th>
				<th >날짜</th>
				<th >조회수</th>
			</tr>
			<%for(/*VO가져온것 돌리기*/int i=0;i<=0;i++)
			{%>
			<tr class="클래스_tr_top1">
				<td class="클래스_td_align1">글번호</td>
				<td align="left"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">					
				글제목</a></td>										
				<td>작성자</td>
				<td>날짜</td>
				<td>조회수</td>
			</tr>
			<tr>
				<td align="right"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">
				더보기</a></td>
			</tr>
			<%}%>
</table>
</body>
</html>