<%@page import="org.apache.catalina.filters.CsrfPreventionFilter"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Date" %>
<%@ page import="gq.bookfarm.vo.OrdersVO" %>
<%@ page import="gq.bookfarm.dao.OrdersProductDAO" %>
<%@ page import="gq.bookfarm.dao.ProductDAO" %>
<%@ page import="gq.bookfarm.vo.OrdersProductVO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		Vector<OrdersVO> list		=	new Vector<OrdersVO>();
		OrdersVO		oList		=	new OrdersVO();
		Vector<OrdersProductVO> opList=	new Vector<OrdersProductVO>();
		ProductDAO		dao			=	new ProductDAO();
		
		String	type				= "myList";	//myPage, myList, singleList
		if(request.getParameter("type")!=null)
				type				=	request.getParameter("type");
		
	/*	String	searchCondition		=	(String)request.getAttribute("searchCondition");
		String	searchWord			=	(String)request.getAttribute("searchWord");	*/
		
		Vector<String>	cs			=	null;
		PageVO			info		=	null;
		
		int				total_page	=	0;
		int				current_page=	1;
		int				endPage		=	0;
		int				startPage	=	0;
		int				totalRows	=	0;
		if(type.equals("myPage"))
		{
						list		=	(Vector<OrdersVO>)request.getAttribute("list");
						cs			=	(Vector<String>)request.getAttribute("cs");
		}
		else if(type.equals("myList"))
		{
						list		=	(Vector<OrdersVO>)request.getAttribute("list");
						cs			=	(Vector<String>)request.getAttribute("cs");
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
					<a href="qOrderView.do?type=singleList&idx=<%=vo.getIdx() %>&page=<%=current_page %>&cs=<%=cs.get(csCount) %>" target="_top">
					<%=vo.getIdx() %></a></td>
					<td align="left">
					<a href="qOrderView.do?type=singleList&idx=<%=vo.getIdx() %>&page=<%=current_page %>&cs=<%=cs.get(csCount) %>" target="_top">
					<%=cs.get(csCount) %></a></td>
					<%csCount++; %>
					<td><%=vo.getFinal_price() %></td>
					<td><%=vo.getDate_purchased() %></td>
				</tr>
			<%}%>
<tr>
	<td colspan="4" align="center">
		<%if(type.equals("myList"))
		{
			if(current_page<=1){
			}else{
				out.print("<a href=./qOrdersConfirm.do?type="+type+"&page="+(current_page-1)+">");
				out.print("[이전]</a>");
			}
		
			for(int i=startPage;i<=endPage;i++){
				if(i==current_page){
					out.print(" "+i+" ");
				}else{
					out.print(" <a href=qOrdersConfirm.do?type="+type+"&page="+i+">"+i+"</a> ");
				}
			}
			
			if(current_page>=total_page){
			}else{
				out.print("<a href=qOrdersConfirm.do?type="+type+"&page="+(current_page+1)+">");
				out.print("[다음]</a>");
			}
		}
		else if(type.equals("myPage"))
		{
			%>
			<a href="./qOrdersConfirm.do?type=myList&page=1" target="_top">[더보기]</a>
			<%
		}
		%>
	</td>
</tr>
</table>
<%
if(type.equals("myList"))
{
%>
<table	class="클래스_bottom_table1">
			<tr>
				<td align="right">
				<a href="./member/mypage.jsp">[마이페이지]</a>
				</td>
			</tr>
</table>
<%
}
%>
</body>
</html>