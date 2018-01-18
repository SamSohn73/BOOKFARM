<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.CategoryVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	AdminVO				adminVO		= (AdminVO)session.getAttribute("adminVO");
	String				currentPage	= request.getParameter("page");
	CategoryVO			category	= (CategoryVO) request.getAttribute("category");
	Vector<CategoryVO>	categories	= (Vector<CategoryVO>) session.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM Category Modification</title>
	
		<!-- Bootstrap core CSS -->
		<!--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="css/shop-homepage.css" rel="stylesheet">

		<script>
			function register_check(form){
				if (form.category_name.value.length==0) {
					alert('카테고리명을 입력해주세요.');
					form.id.focus();
					return;
				} else {
					form.submit();
				}
			}
			
			function adminCategoryList() {
				location.href="./adminCategoryList.do?page=<%=currentPage%>";
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
		
		
				<div class="col-lg-9">
					<form action="./adminCategoryModify.do?page=<%=currentPage%>&idx=<%=category.getIdx()%>" method="post">
						<table>
							<caption>카테고리 수정</caption>	
							<tr>
								<td><label>상위 카테고리</label>
								<td>
									<select name='partent_idx'>
<%					for(CategoryVO cat: categories) {	%>
										<option value="<%=cat.getParent_idx()%>" <%if(cat.getParent_idx() == category.getParent_idx())	out.print("selected");%>><%=cat.getCategory_name()%></option>
										
<%					} %>
									</select>
								</td>
							</tr>
							<tr>
								<td><label>카테고리 이름</label>
								<td><input type="text" name="category_name" value="<%=category.getCategory_name()%>"></td>
							</tr>
							<tr>
								<td colspan="2" class="btn_align">
									<input type="button" name="add"		value="수정"			onclick="register_check(this.form)">
									<input type="button" name="cancel"	value="취소"			onclick="javascript:history.back()">
									<input type="button" name="list"	value="카테고리 목록"	onclick="adminCategoryList()">
								</td>
							</tr>
						</table>
					</form>
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
