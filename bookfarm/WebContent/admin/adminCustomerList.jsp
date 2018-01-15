<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String tmpValue			= null;
	DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage	= pageInfo.getPage();
	int startPage	= pageInfo.getStartPage();
	int endPage		= pageInfo.getEndPage();
	int totalRows	= pageInfo.getTotalRows();
	int totalPages	= pageInfo.getTotalPages();
	
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
			<th>수정/삭제</th>
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
			<td>
				<a href="adminCustomerModifyView.do?idx=<%=customer.getIdx() %>&page=<%=currentPage %>">
					<input type='button' value="수정">
				</a>
				<a href="adminCustomerDelete.do?idx=<%=customer.getIdx() %>&page=<%=currentPage %>">
					<input type='button' value="삭제">
				</a>
			</td>
			<td><%=idNum%></td>
			<td><%tmpValue = customer.getUsername()		!= null ?	customer.getUsername():"";%><%=tmpValue%></td>
		<!--<td><%=customer.getLastname()%></td>  -->
			<td><%tmpValue = customer.getFirstname()	!= null ?	customer.getFirstname():"";%>	<%=tmpValue%></td>
			<td><%tmpValue = customer.getPostcode()		!= null ?	customer.getPostcode():"";%>	<%=tmpValue%></td>
			<td><%tmpValue = customer.getAddress1()		!= null ?	customer.getAddress1():"";%>	<%=tmpValue%></td>
			<td><%tmpValue = customer.getAddress2()		!= null ?	customer.getAddress2():"";%>	<%=tmpValue%></td>
			<td><%tmpValue = customer.getPhone1()		!= null ?	customer.getPhone1():"";%>		<%=tmpValue%></td>
			<td><%tmpValue = customer.getPhone2()		!= null ?	customer.getPhone2():"";%>		<%=tmpValue%></td>
			<td><%tmpValue = customer.getPhone3()		!= null ?	customer.getPhone3():"";%>		<%=tmpValue%></td>
			<td><%tmpValue = customer.getEmail1()		!= null ?	customer.getEmail1():"";%>		<%=tmpValue%></td>
			<td><%tmpValue = customer.getEmail2()		!= null ?	customer.getEmail2():"";%>		<%=tmpValue%></td>
			<td><%tmpValue = customer.getGender()		!= null ?	customer.getGender() != "m" ? "남성":"여성":"";%><%=tmpValue%></td>
			<td><%tmpValue = customer.getBirthday()		!= null ?	df.format(customer.getBirthday()):"";%><%=tmpValue%></td>
			<td><%=customer.getGrade()%></td>
			<td><%tmpValue = customer.getLast_login()	!= null ?	df.format(customer.getLast_login()):"";%><%=tmpValue%></td>	
			<td><%=customer.getLogin_cnt()%></td>
			<td><%tmpValue = customer.getAccount_created()!= null ?	df.format(customer.getAccount_created()):"";%><%=tmpValue%></td>
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
				<form action='adminCustomerSearch.do' method='post' name='searchform'>
					<select name='criteria'>
						<option value='username'	<%if(criteria.equals("username"))	out.print("selected");%>>아이디</option>
						<option value='firstname'	<%if(criteria.equals("firstname"))	out.print("selected");%>>이름</option>
						<option value='address'		<%if(criteria.equals("address"))	out.print("selected");%>>주소</option>
						<option value='phone'		<%if(criteria.equals("phone"))		out.print("selected");%>>전화번호</option>
						<option value='email'		<%if(criteria.equals("email"))		out.print("selected");%>>이메일</option>
						<option value='gender'		<%if(criteria.equals("gender"))		out.print("selected");%>>성별</option>
						<option value='grade'		<%if(criteria.equals("grade"))		out.print("selected");%>>등급</option>
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