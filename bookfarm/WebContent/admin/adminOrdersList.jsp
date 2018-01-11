<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.AdminVO"%>
<%@page import="gq.bookfarm.vo.OrdersVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<OrdersVO>	orders		= (Vector<OrdersVO>) request.getAttribute("orders");
	log.debug("adminOrdersList.jsp orders.size()="		+ orders.size());
	
	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage			= pageInfo.getPage();
	int startPage			= pageInfo.getStartPage();
	int endPage				= pageInfo.getEndPage();
	int totalRows			= pageInfo.getTotalRows();
	int totalPages			= pageInfo.getTotalPages();
	
	log.debug("adminOrdersList.jsp criteria="		+ criteria);
	log.debug("adminOrdersList.jsp searchWord="		+ searchWord);
	log.debug("adminOrdersList.jsp currentPage="	+ currentPage);
	log.debug("adminOrdersList.jsp startPage="		+ startPage);
	log.debug("adminOrdersList.jsp endPage="		+ endPage);
	log.debug("adminOrdersList.jsp totalRows="		+ totalRows);
	log.debug("adminOrdersList.jsp totalPages="		+ totalPages);
%>
<!DOCTYPE>
<html>
<head>
	<script type="text/javascript">
		function search(){
			if(searchform.searchWord.value==""){
				alert('검색어를 넣으세요');
				searchform.searchWord.focus();
				return;
			}
			searchform.submit();
		}
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문 관리</title>
</head>
<body>
	<table>
		<caption>주문 목록</caption>
		<tr>
			<th>No.</th>
			<th>주문자</th>
			<th>수신인</th>
			<th>우편번호</th>
			<th>주소1</th>
			<th>주소2</th>
			<th>전화번호 1</th>
			<th>전화번호 2</th>
			<th>전화번호 3</th>
			<th>이메일 1</th>
			<th>이메일 2</th>
			<th>결재자</th>
			<th>수신인</th>
			<th>우편번호</th>
			<th>주소1</th>
			<th>주소2</th>
			<th>전화번호 1</th>
			<th>전화번호 2</th>
			<th>전화번호 3</th>
			<th>이메일 1</th>
			<th>이메일 2</th>
			<th>결재방법</th>
			<th>결재가격</th>
			<th>최종수정일</th>
			<th>구매일</th>
			<th>주문상태</th>
			<th>주문환료일</th>
		</tr>
<%
	int idNum = totalRows - (currentPage-1)*10;
	for(OrdersVO order: orders) {	%>
		<tr>
			<td>
				<a href="adminOrdersProductList.do?idx=<%=order.getIdx()%>&page=<%=currentPage%>">
					<%=idNum%>
				</a>
			</td>
			<td>
				<a href="adminCustomerModifyView.do?idx=<%=order.getCustomers_idx()%>&page=<%=currentPage%>">
					<%=order.getCustomers_idx()%>
				</a>
			</td>
			<td><%=order.getDelivery_name()%></td>
			<td><%=order.getDelivery_postcode()%></td>
			<td><%=order.getDelivery_address1()%></td>
			<td><%=order.getDelivery_address2()%></td>
			<td><%=order.getDelivery_phone1()%></td>
			<td><%=order.getDelivery_phone2()%></td>
			<td><%=order.getDelivery_phone3()%></td>
			<td><%=order.getDelivery_email1()%></td>
			<td><%=order.getDelivery_email2()%></td>
			<td><%=order.getBilling_name()%></td>
			<td><%=order.getBilling_postcode()%></td>
			<td><%=order.getBilling_address1()%></td>
			<td><%=order.getBilling_address2()%></td>
			<td><%=order.getBilling_phone1()%></td>
			<td><%=order.getBilling_phone2()%></td>
			<td><%=order.getBilling_phone3()%></td>
			<td><%=order.getBilling_email1()%></td>
			<td><%=order.getBilling_email2()%></td>
			<td><%=order.getPayment_method()%></td>
			<td><%=order.getFinal_price()%></td>
			<td><%=order.getLast_modified()%></td>
			<td><%=order.getDate_purchased()%></td>
			<td><%=order.getOrders_status()%></td>
			<td><%=order.getOrders_date_finished()%></td>
		</tr>
<%		idNum--;
	} %>
		<tr>
		<td colspan = "17">
			<%//[prev] display
				if (currentPage > 1) {
					out.print("<a href=adminOrdersList.do?page=" + (currentPage-1) + ">");
					out.print("[prev] </a>");
				}
			%>
			<%//page numbers display
				for (int i = startPage; i <= endPage; i++) {
					if (i == currentPage) {
						out.print("[" +  i + "] ");
					} else {
						out.print("<a href=adminOrdersList.do?page=" + i +">");
						out.print(i + " </a>");
					}
				}
			%>
			<%//[next] display
				if (currentPage <= endPage && currentPage < totalPages) {
					out.print("<a href=adminOrdersList.do?page=" + (currentPage + 1) + ">");
					out.print(" [next]</a>");
				}
			%>
		</td>
	</tr>
	</table>
	
	<table>
		<tr>
			<td class="td_align">
				<form action='AdminOrdersearch.do' method='post' name='searchform'>
					<select name='criteria'>
						<option value='orders_name'				<%if(criteria.equals("orders_name"))			out.print("selected");%>>이름</option>
						<option value='orders_address'			<%if(criteria.equals("orders_address"))			out.print("selected");%>>주소</option>
						<option value='orders_phone'			<%if(criteria.equals("orders_phone"))			out.print("selected");%>>전화번호</option>
						<option value='orders_email'			<%if(criteria.equals("orders_email"))			out.print("selected");%>>이메일</option>
						<option value='orders_payment_method'	<%if(criteria.equals("orders_payment_method"))	out.print("selected");%>>결제방법</option>
					</select>
					<input type='text' name='searchWord' value="<%=searchWord%>">
					<input type='button' value='검색' onclick="search()">						
				</form>
			</td>
			<!--  <td align='right'><a href="admin/admin_add.jsp?page=<%=currentPage%>">[사용자 추가]</a></td>  -->
		</tr>
	</table>
	<h2><a href="admin/adminLogin.jsp">처음으로</a></h2>
</body>
</html>