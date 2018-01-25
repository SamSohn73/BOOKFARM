<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<% AdminVO adminVO = (AdminVO)session.getAttribute("adminVO"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
		<title>BOOKFARM online bookstore</title>
	
		
		<link href="../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="../css/shop-homepage.css" rel="stylesheet">

		<script>
			// Get the modal
			var modal = document.getElementById('modalLogin');
			
			// When the user clicks anywhere outside of the modal, close it
			window.onclick = function(event) {
				if (event.target == modal) {
					modal.style.display = "none";
				}
			}
			
			function register_check(form){
				if(form.username.value.length==0){
					alert('아이디를 확인해 주세요');
					form.username.focus();
					return;
				}else if(form.password.value.length==0){
					alert('비밀번호를 확인해 주세요');
					form.password.focus();
					return;
				}else{
					form.submit();
				}
			}

			function check(form){
				if(form.user_name.value.length==0){
					alert('아이디를 확인해 주세요');
					form.user_name.focus();
					return;
				}else if(form.user_pass.value.length==0){
					alert('비밀번호를 확인해 주세요');
					form.user_pass.focus();
					return;
				}else{
					form.submit();
				}
			}
		</script>
	</head>
	
	<body>

	
	
<%if(adminVO == null) {%>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="../index.do">Bookfarm - Admin Page</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
		</nav>

		<form method="post" action="../adminLogin.do">
		<div class="container"  align="center">
			<div class="col-lg-3 my-4">
			<table class="table">
				<tr>
					<td><input type="text" name="user_name" placeholder="아이디" required></td>
		
					<td><input type="password" name="user_pass" placeholder="비밀번호" required></td>
				</tr>
				<tr>
					<td rowspan="2">
						<button type="button" class="btn" onclick="check(this.form);">로그인</button>
					</td>
				</tr>
			</table>
			</div>
		</div>	
		</form>
<%}else{%>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="../index.do">Bookfarm - Admin Page</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item active">
							<a class="nav-link" href="../index.do">Home
								<span class="sr-only">(current)</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../adminCustomerList.do">고객관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../adminProductList.do">상품관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../adminOrdersList.do">주문관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../adminCategoryList.do">카테고리관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../adminReviewsList.do">리뷰관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../adminLogout.do">로그아웃</a>
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
		
				</div>
				<!-- /.col-lg-9 -->
		
			</div>
			<!-- /.row -->
	
		</div>
		<!-- /.container -->
	

<%}%>
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
