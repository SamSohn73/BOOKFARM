<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.CategoryVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	String				current_page	= request.getParameter("page");
	AdminVO				adminVO			= (AdminVO)session.getAttribute("adminVO");
	Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
		<title>BOOKFARM Product Insert</title>
	
		<!-- Bootstrap core CSS -->
		<!--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
		<link href="../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="../css/shop-homepage.css" rel="stylesheet">

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
					<form action="../adminProductInsert.do" method="post" enctype="multipart/form-data">
						<table>
							<caption>상품 등록</caption>
							<tr>
								<td class="td_left"><label for="category_idx">카테고리</label></td>
								<td class="td_right">
									<select name='category_idx'>
<%	for(CategoryVO category: categories) {	%>
										<option value="<%=category.getIdx()%>"><%=category.getCategory_name()%></option>
<%	} %>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td_left"><label for="products_quantity">수 량</label></td>					
								<td class="td_right">
									<input type="text" name="product_quantity">
								</td>
							</tr>			
							<tr>
								<td class="td_left"><label for="product_name">책 이름</label></td>					
								<td class="td_right">
									<input type="text" name="product_name" size="10" maxlength='10' required="required">
								</td>
							</tr>
							<tr>
								<td class="td_left"><label for="product_image">이미지</label></td>	
								<td class="td_right">
									<input type="file" name="product_image" id="product_image">
								</td>
							</tr>
							<tr>
								<td class="td_left"><label for="product_price">가격</label></td>					
								<td class="td_right">
									<input type="text" name="product_price">
								</td>
							</tr>
							<tr>
								<td class="td_left"><label for="product_desc">설명</label></td>					
								<td class="td_right">
									<textarea name='product_desc' cols='60' rows='15' required="required"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan='2'>
								<input type='submit' value="등록">
								<input type='button' value="취소"  onclick="javascript:history.back();">
								<input type="hidden" name="page" value=<%=current_page %>>
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
		<script src="../vendor/jquery/jquery.js"></script>
		<script src="../vendor/bootstrap/js/bootstrap.bundle.js"></script>
	</body>
</html>
