<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gq.bookfarm.vo.CustomerVO" %>
<%@page import="gq.bookfarm.vo.OrdersVO" %>
<%@page import="gq.bookfarm.vo.OrdersProductVO" %>
<%@page import="gq.bookfarm.vo.PageVO" %>
<%@page import="gq.bookfarm.dao.ProductDAO" %>
<%@page import="java.util.Vector" %>
<%
	
	CustomerVO				vo			=	(CustomerVO)session.getAttribute("loggedInUserVO");
	String					type		=	null;
	int						Page		=	1;
	if(request.getParameter("page")!=null)
							Page		=	Integer.parseInt(request.getParameter("page"));
	if(request.getParameter("type")!=null)
							type		=	request.getParameter("type");
	
	String					cs		=	request.getParameter("cs");
	OrdersVO				oList	=	(OrdersVO)request.getAttribute("oList");
	Vector<OrdersProductVO>	opList	=	(Vector<OrdersProductVO>)request.getAttribute("opList");
	PageVO					info	=	(PageVO)request.getAttribute("info");
	ProductDAO				dao		=	new ProductDAO();
	
	int					total_page	=	info.getTotalPages();
	int					current_page=	info.getPage();
	int					endPage		=	info.getEndPage();
	int					startPage	=	info.getStartPage();
	int					totalRows	=	info.getTotalRows();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역 확인</title>
</head>
<body>
		<table class="클래스_테이블1">
			<caption>주문 정보</caption>
			<tr class="클래스_tr_top1">
				<td class="left">주문하신 분</td>
				<td colspan="3" class="right"><%=vo.getFirstname() %></td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right"><%=vo.getPhone1() %></td>
				<td class="left">이메일</td>
				<td class="right"><%=vo.getEmail1() %></td>
			</tr>
		</table>
		<table class="클래스_테이블1">
			<caption>구매 내역 확인</caption>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >주문금액</th>
				<th >구매날짜</th>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="클래스_td_align1"><%=oList.getIdx() %></td>
				<td align="left"><%=cs %></td>
				<td><%=oList.getFinal_price() %></td>
				<td><%=oList.getDate_purchased() %></td>
			</tr>
</table>
		<table class="클래스_테이블1">
			<tr class="클래스_tr_top1">
				<td class="left">받으실 분</td>
				<td colspan="3" class="right"><%=oList.getDelivery_name() %></td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right"><%=oList.getDelivery_phone1() %></td>
				<td class="left">이메일</td>
				<td class="right"><%=oList.getDelivery_email1() %></td>
			</tr>
			<tr class="클래스_tr_top1" >
				<td class="left">주소</td>
				<td colspan="3" class="right"><%=oList.getDelivery_address1() %> <%=oList.getDelivery_address2() %></td>
			</tr>
			<tr class="클래스_tr_top1">
				<td class="left">결제 금액</td>
				<td colspan="3" class="right"><%=oList.getFinal_price() %></td>
			</tr>
</table>

<table class="클래스_테이블1">
		<caption>구매 내역 확인</caption>
		<%
		int	oclIdx	=	0;
		%>
			<tr class="클래스_tr타이틀1">
				<th >주문번호</th>
				<th >상품정보</th>
				<th	>상품갯수</th>
				<th >주문금액</th>
			</tr>
			<%for(OrdersProductVO opVo:opList){%>
			<tr class="클래스_tr_top1">
					<td class="클래스_td_align1">
					<%if(oclIdx != opVo.getIdx()){ %>
					<%=opVo.getIdx() %>
					<%oclIdx=opVo.getIdx();} %>
					</td>
					<td align="left">
					<a href="상품페이지로 연결" target="_top">
					<%=dao.productGetRow(opVo.getProducts_idx()).getProduct_name() %></a></td>
					<td><%=opVo.getProducts_quantity() %></td>
					<td><%=opVo.getFinal_price() %></td>
				</tr>
			<%}%>
<tr>
	<td colspan="4">
		<%
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
			}%>
	</td>
</tr>
</table>
<table	class="클래스_bottom_table1">
			<tr>
				<td align="right">
				<a href="./member/mypage.jsp">[마이페이지]</a>
				</td>
			</tr>
</table>
</body>
</html>