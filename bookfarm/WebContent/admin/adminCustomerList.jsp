<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.AdminVO"%>
<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<CustomerVO>	customers	= (Vector<CustomerVO>) request.getAttribute("customers");
	
	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage			= pageInfo.getPage();
	int startPage			= pageInfo.getStartPage();
	int endPage				= pageInfo.getEndPage();
	int totalRows			= pageInfo.getTotalRows();
	int totalPages			= pageInfo.getTotalPages();
	
	log.debug("adminCustomerList.jsp criteria="		+ criteria);
	log.debug("adminCustomerList.jsp searchWord="	+ searchWord);
	log.debug("adminCustomerList.jsp currentPage="	+ currentPage);
	log.debug("adminCustomerList.jsp startPage="	+ startPage);
	log.debug("adminCustomerList.jsp endPage="		+ endPage);
	log.debug("adminCustomerList.jsp totalRows="	+ totalRows);
	log.debug("adminCustomerList.jsp totalPages="	+ totalPages);
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
<title>고객 관리</title>
</head>
<body>
	<table>
		<caption>회원 목록</caption>
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
	for(CustomerVO customer: customers) {	%>
		<tr>
			<td><%=idNum%></td>
			<td><%=customer.getUsername()%></td>
			<td><%=customer.getLastname()%><%=customer.getFirstname()%></td>
			<td><%=customer.getPostcode()%></td>
			<td><%=customer.getAddress1()%></td>
			<td><%=customer.getAddress2()%></td>
			<td><%=customer.getPhone1()%></td>
			<td><%=customer.getPhone2()%></td>
			<td><%=customer.getPhone3()%></td>
			<td><%=customer.getEmail1()%></td>
			<td><%=customer.getEmail2()%></td>
			<td><%=customer.getGender()%></td>
			<td><%=customer.getBirthday()%></td>
			<td><%=customer.getGrade()%></td>
			<td><%=customer.getLast_login()%></td>
			<td><%=customer.getLogin_cnt()%></td>
			<td><%=customer.getAccount_created()%></td>
		</tr>
<%		idNum--;
	} %>
		<tr>
		<td colspan = "17">
			<%//[prev] display
				if (currentPage > 1) {
					out.print("<a href=adminCustomerList.do?page=" + (currentPage-1) + ">");
					out.print("[prev] </a>");
				}
			%>
			<%//page numbers display
				for (int i = startPage; i <= endPage; i++) {
					if (i == currentPage) {
						out.print("[" +  i + "] ");
					} else {
						out.print("<a href=adminCustomerList.do?page=" + i +">");
						out.print(i + " </a>");
					}
				}
			%>
			<%//[next] display
				if (currentPage <= endPage && currentPage < totalPages) {
					out.print("<a href=adminCustomerList.do?page=" + (currentPage + 1) + ">");
					out.print(" [next]</a>");
				}
			%>
		</td>
	</tr>
	</table>
	
	<table>
		<tr>
			<td class="td_align">
				<form action='AdminCustomerSearch.do' method='post' name='searchform'>
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