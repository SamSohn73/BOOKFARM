<%@ page import="xyz.bookfarm.vo.OrdersVO" %>
<%@ page import="java.util.Vector" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		//입력 필요한 변수들
									//Servlet에서 담아놓은 정보 가져오기
		//vo						//VO새로 만들고 거기에 옮기기
									//다른 추가정보도 받음
		
		String	type				= "myList";	//list, myPage, myList
		if(request.getParameter("type")!=null)
				type				=	request.getParameter("type");
		Vector<OrdersVO> list		= null;
		int		purchase_num		= 0;
		int		purchase_num_count	= 1;
		
		
		
		
		
		String	purchase_info		= "";
		String	purchase_price		= "";
		String	purchase_date		= "";
		int		purchase_board_num	= 0;
		int		total_page			= 0;
		int		current_page		= 0;
		int		start_page			= 0;
		int		end_page			= 0;
		int		total_Rows			= 0;
		
		//출력하는 변수들
		String	searchCondition		= "";
		String	searchword			= "";
		String	review_content		= "";
		
		//불러올 CSS
		/*
		클래스_테이블1
		클래스_tr타이틀1
		클래스_tr_top1
		클래스_td_align1
		클래스_bottom_table1
		클래스_td_align1
		클래스_btn_align1
		클래스_btn1
		*/
		int		id_num			= total_Rows-(current_page-1)*10;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="클래스_테이블1">
		<caption>구매 내역 확인</caption>
		<% if(type.equals("myPage")){%>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >주문금액</th>
				<th >날짜</th>
			</tr>
			<%for(/*VO가져온것 돌리기*/int i=0;i<=0;i++){%>
				<tr class="클래스_tr_top1">
					<td class="클래스_td_align1"><a href="">
					purchase_num</a></td>
					<td align="left"><a href="">
					purchase_info</a></td>
					<td>purchase_price</td>
					<td>purchase_date</td>
				</tr>
			<%}%>
		<% }else if(type.equals("myList")){%>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >주문금액</th>
				<th >날짜</th>
			</tr>
			<% for(OrdersVO vo:list){%>
				<tr class="클래스_tr_top1">
				<% if(purchase_num!=vo.getIdx()){
					purchase_num=vo.getIdx();
					purchase_num_count=1;
					%>
					<td rowspan=
					<%}else{ 
					purchase_num_count++;
					%>
					
					<%} %>
					 ><a href="qOrderView.do?board_num=글번호&page=페이지번호">
					purchase_num</a></td>
					<td align="left"><a href="qOrderView.do?board_num=글번호&page=페이지번호">
					purchase_info</a></td>										
					<td>purchase_price</td>
					<td>purchase_date</td>
				</tr>
			<% }%>
		<% }%>
<tr>
	<td colspan="4">
		<%
			if(/*현재페이지<=1*/ false){
			}else{
				out.print("<a href=qOrderConfirm.do?page=현재페이지-1>");
				out.print("[이전]</a>");
			}
		
			for(int i=/*시작페이지*/0;i<=/*끝페이지*/0;i++){
				if(i==/*현재페이지*/1){
					out.print(" "+i+" ");
				}else{
					out.print(" <a href=qOrderConfirm.do?page="+i+">"+i+"</a> ");
				}
			}
			
			if(/*현재페이지*/0>=/*전체페이지*/1){
			}else{
				out.print("<a href=qlist.do?page=(현재페이지+1)>");
				out.print("[다음]</a>");
			}
		%>
	</td>
</tr>
</table>
</body>
</html>