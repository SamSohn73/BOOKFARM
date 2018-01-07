<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="xyz.bookfarm.vo.PageVO"%>
<%@page import="xyz.bookfarm.vo.AdminVO"%>
<%@page import="xyz.bookfarm.vo.OrdersVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<OrdersVO>	orders		= (Vector<OrdersVO>) request.getAttribute("orders");
	
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
			<th>아이디</th>
			<th>이름</th>
			<th>우편번호</th>
			<th>주소1</th>
			<th>주소2</th>
			<th>전화번호 1</th>
			<th>전화번호 2</th>
			<th>전화번호 3</th>
			<th>이메일 1</th>
			<th>이메일 2</th>
			<th>성별</th>
			<th>생일</th>
			<th>등급</th>
			<th>마지막 로그인</th>
			<th>로그인 카운트</th>
			<th>계정 생성일</th>
		</tr>
<%	
	int idNum = totalRows - (currentPage-1)*10;
	for(OrdersVO order: orders) {	%>
		<tr>
			<td><%=idNum%></td>
			<td><%=order.getUsername()%></td>
			<td><%=order.getLastname()%><%=customer.getFirstname()%></td>
			<td><%=order.getPostcode()%></td>
			<td><%=order.getAddress1()%></td>
			<td><%=order.getAddress2()%></td>
			<td><%=order.getPhone1()%></td>
			<td><%=order.getPhone2()%></td>
			<td><%=order.getPhone3()%></td>
			<td><%=order.getEmail1()%></td>
			<td><%=order.getEmail2()%></td>
			<td><%=order.getGender()%></td>
			<td><%=order.getBirthday()%></td>
			<td><%=order.getGrade()%></td>
			<td><%=order.getLast_login()%></td>
			<td><%=order.getLogin_cnt()%></td>
			<td><%=order.getAccount_created()%></td>
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
						<option value='customer_username'	<%if(criteria.equals("customer_username"))	out.print("selected");%>>아이디</option>
						<option value='customer_name'		<%if(criteria.equals("customer_name"))		out.print("selected");%>>이름</option>
						<option value='customer_address'	<%if(criteria.equals("customer_address"))	out.print("selected");%>>주소</option>
						<option value='customer_phone'		<%if(criteria.equals("customer_phone"))		out.print("selected");%>>전화번호</option>
						<option value='customer_email'		<%if(criteria.equals("customer_email"))		out.print("selected");%>>이메일</option>
						<option value='customer_birthday'	<%if(criteria.equals("customer_birthday"))	out.print("selected");%>>생일</option>
						<option value='customer_grade'		<%if(criteria.equals("customer_grade"))		out.print("selected");%>>등급</option>
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