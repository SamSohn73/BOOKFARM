<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.PageVO"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="gq.bookfarm.vo.CustomerVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	AdminVO adminVO = (AdminVO)session.getAttribute("adminVO");
	CustomerVO 	customerVO		= (CustomerVO)	request.getAttribute("customerVO");
	String		current_page 	=	request.getParameter("page");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM Customer Modification</title>
	
		<!-- Bootstrap core CSS -->
		<!--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="css/shop-homepage.css" rel="stylesheet">
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
		
		
				<div class="col-lg-9">
					<table>
						<form action="adminCustomerModify.do" method="post" >
						<caption>회원 정보 수정</caption>
							<tr>
								<td class="td_left">password</td>					
								<td class="td_right">
								<input type='text' name='password' size="64" readonly value="<%=customerVO.getPassword() %>">								
								</td>
							</tr>
							<tr>
								<td class="td_left">아이디</td>					
								<td class="td_right">
								<input type='text' name='username' size="64" value="<%=customerVO.getUsername() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">이름</td>					
								<td class="td_right">
								<input type='text' name='name' size="64" value="<%=customerVO.getFirstname() %>">	
								</td>
							</tr>		
							<tr>
								<td class="td_left">우편 번호</td>					
								<td class="td_right">
								<input type='text' name='postcode' size="64" value="<%=customerVO.getPostcode() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">주소 1</td>					
								<td class="td_right">
								<input type='text' name='address1' size="64" value="<%=customerVO.getAddress1() %>">	
								</td>
							<tr/>
							<tr>
								<td class="td_left">주소 2</td>					
								<td class="td_right">
								<input type='text' name='address2' size="64" value="<%=customerVO.getAddress2() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">전화 번호 1</td>					
								<td class="td_right">
								<input type='text' name='phone1' size="64" value="<%=customerVO.getPhone1() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">이메일 1</td>					
								<td class="td_right">
								<input type='text' name='email1' size="64" value="<%=customerVO.getEmail1() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">성별</td>					
								<td class="td_right">
								<input type='text' name='gender' size="64" value="<%=customerVO.getGender() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">생일</td>					
								<td class="td_right">
								<input type='text' name='birthday' size="64" value="<%=customerVO.getBirthday() %>">	
								</td>
							</tr>
							<tr>
								<td class="td_left">마지막 로그인</td>					
								<td class="td_right">
								<input type='text' name='last_login' size="64" value="<%=customerVO.getLast_login() %>">	
								</td>
							<tr class="button_cell">
								<td colspan='2'>			
								<input type='submit' value="수정"> 
								<input type='button' value='뒤로' onClick="javascript:history.go(-1);">				
								</td>
							</tr>
						<input type="hidden" name="idx" value=<%=customerVO.getIdx() %>>
						<input type="hidden" name="page" value=<%=current_page %>>	
						</form>	
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
				<p class="m-0 text-center text-white">Copyright &copy; Team Bookfarmer 2018</p>
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
