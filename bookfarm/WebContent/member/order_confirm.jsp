<%@page import="org.apache.catalina.filters.CsrfPreventionFilter"%>
<%@ page import="xyz.bookfarm.vo.OrdersVO" %>
<%@ page import="xyz.bookfarm.dao.OrdersProductDAO" %>
<%@ page import="xyz.bookfarm.vo.OrdersProductVO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Date" %>
<%@ page import="xyz.bookfarm.vo.PageVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		Vector<OrdersVO> list		=	(Vector<OrdersVO>)request.getAttribute("list");
		String	type				= "myList";	//myPage, myList
		if(request.getParameter("type")!=null)
				type				=	request.getParameter("type");
		
		String	searchCondition		=	(String)request.getAttribute("searchCondition");
		String	searchWord			=	(String)request.getAttribute("searchWord");
		
		Vector<String>	cs			=	null;
		PageVO			info		=	null;
		
		int				total_page	=	0;
		int				current_page=	0;
		int				endPage		=	0;
		int				startPage	=	0;
		int				totalRows	=	0;
		if(type.equals("myPage"))
		{
						cs			=	(Vector<String>)request.getAttribute("cs");
		}
		else if(type.equals("myList"))
		{
						info		=	(PageVO)request.getAttribute("info");
			
						total_page	=	info.getTotalPages();
						current_page=	info.getPage();
						endPage		=	info.getEndPage();
						startPage	=	info.getStartPage();
						totalRows	=	info.getTotalRows();
		}
		
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
			<%for(OrdersVO vo:list){
				int	csCount	=	0;
			%>
				<tr class="클래스_tr_top1">
					<td class="클래스_td_align1">
					<a href="qOrderView.do?idx=<%=vo.getIdx() %>&page=<%=current_page %>" target="_top">
					<%=vo.getIdx() %></a></td>
					<td align="left">
					<a href="qOrderView.do?idx=<%=vo.getIdx() %>&page=<%=current_page %>" target="_top">
					<%=cs.get(0) %></a></td>
					<%csCount++; %>
					<td><%=vo.getFinal_price() %></td>
					<td><%=vo.getDate_purchased() %></td>
				</tr>
			<%}%>
		<% }else if(type.equals("myList")){%>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >주문금액</th>
				<th >날짜</th>
			</tr>
			<%for(OrdersVO vo:list){%>
			<tr class="클래스_tr_top1">
					<td class="클래스_td_align1">
					<a href="qOrderView.do?idx=<%=vo.getIdx() %>&page=<%=current_page %>" target="_top">
					<%= %></a></td>
					<td align="left">
					<a href="qOrderView.do?idx=<%=vo.getIdx() %>&page=<%=current_page %>" target="_top">
					<%= %></a></td>
					<td><%= %></td>
					<td><%= %></td>
				</tr>
			<%}%>
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