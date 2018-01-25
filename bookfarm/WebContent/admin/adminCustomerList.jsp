<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="gq.bookfarm.vo.PageVO"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="gq.bookfarm.vo.CustomerVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	AdminVO adminVO = (AdminVO)session.getAttribute("adminVO");
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
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM Customer List</title>
	
		<!-- Bootstrap core CSS -->
		<!--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="css/shop-homepage.css" rel="stylesheet">

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
	</head>
	
	<body>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="index.do">Bookfarm - Admin Page</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item active">
							<a class="nav-link" href="index.do">Home
								<span class="sr-only">(current)</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminCustomerList.do">고객관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminProductList.do">상품관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminOrdersList.do">주문관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminCategoryList.do">카테고리관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminReviewsList.do">리뷰관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminLogout.do">로그아웃</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- Page Content -->
		<div class="container">
	
			<div class="row">
	
				<div class="col-lg-3">		
					<h1 class="my-4">책팜</h1>
				</div>
				<!-- /.col-lg-3 -->
		
		
				<div class="col-lg-9" align="center">
					<h2 class="my-4" align="left">회원 목록</h2>
					<table class="table">						
						<tr class="text-justify">
							<th>수정/삭제</th>
							<th>No.</th>
							<th>아이디</th>
							<th>이름</th>
							<th>우편번호</th>
							<th>주소1</th>
							<th>주소2</th>
							<th>전화번호 1</th>
						</tr>
						<tr class="text-justify">
							<th colspan="2"></th>
							<th>이메일 1</th>
							<th>성별</th>
							<th>생일</th>
							<th>마지막<br> 로그인</th>
							<th>로그인<br> 카운트</th>
							<th>계정 생성일</th>
						</tr>
						<tr><th colspan="9"></th></tr>
<%	
	int idNum = totalRows - (currentPage-1)*10;
	int count = 1;
	for(CustomerVO customer: customers) {
			if(count%2 != 0){%>
						<tr class="table-secondary">
						<%}else{ %>
						<tr class="bg-light">
						<%} %>
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
							<td><%tmpValue = customer.getFirstname()	!= null ?	customer.getFirstname():"";%>	<%=tmpValue%></td>
							<td><%tmpValue = customer.getPostcode()		!= null ?	customer.getPostcode():"";%>	<%=tmpValue%></td>
							<td><%tmpValue = customer.getAddress1()		!= null ?	customer.getAddress1():"";%>	<%=tmpValue%></td>
							<td><%tmpValue = customer.getAddress2()		!= null ?	customer.getAddress2():"";%>	<%=tmpValue%></td>
							<td><%tmpValue = customer.getPhone1()		!= null ?	customer.getPhone1():"";%>		<%=tmpValue%></td>
						</tr>
			<%if(count%2 != 0){%>
						<tr class="table-secondary">
						<%}else{ %>
						<tr class="bg-light">
						<%} %>
							<td colspan="2"></td>
							<td><%tmpValue = customer.getEmail1()		!= null ?	customer.getEmail1():"";%>		<%=tmpValue%></td>
							<td><%tmpValue = customer.getGender()		!= null ?	customer.getGender() != "m" ? "남성":"여성":"";%><%=tmpValue%></td>
							<td><%tmpValue = customer.getBirthday()		!= null ?	df.format(customer.getBirthday()):"";%><%=tmpValue%></td>
							<td><%tmpValue = customer.getLast_login()	!= null ?	df.format(customer.getLast_login()):"";%><%=tmpValue%></td>	
							<td><%=customer.getLogin_cnt()%></td>
							<td><%tmpValue = customer.getAccount_created()!= null ?	df.format(customer.getAccount_created()):"";%><%=tmpValue%></td>
						</tr>
<%		idNum--; count++;	
	} %>
						<tr align="center">
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
					
					<table class="table">
						<tr align="center">
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
									<input type='button' class="btn" value='검색' onclick="search()">
								</form>
							</td>
							<!--  <td align='right'><a href="admin/admin_add.jsp?page=<%=currentPage%>">[사용자 추가]</a></td>  -->
						</tr>
					</table>
				</div>
				<!-- /.col-lg-9 -->
		
			</div>
			<!-- /.row -->
	
		</div>
		<!-- /.container -->
	
		<!-- Footer -->
		<footer class="py-5 bg-dark">
			<div class="container">
				<p class="m-0 text-center text-white">Copyleft &copy; Team Bookfarmer 2018</p>
				<p class="m-0 text-center text-white">DWIT Class3 - Team 책농부</p>
			</div>
			<!-- /.container -->
		</footer>	
	
		<!-- Bootstrap core JavaScript -->
		<!--<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>-->
		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
	</body>
</html>
