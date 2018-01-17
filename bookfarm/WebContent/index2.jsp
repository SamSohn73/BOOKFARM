<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
	Vector<ProductVO>	best6Products	= (Vector<ProductVO>) session.getAttribute("best6Products");
	CustomerVO			userVO			= (CustomerVO)session.getAttribute("loggedInUserVO");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM online bookstore</title>
	
		<!-- Bootstrap core CSS -->
		<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="css/shop-homepage.css" rel="stylesheet">
		<link href="css/login.css" rel="stylesheet">
	</head>
	
	<body>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="#">Bookfarm - Online Bookstore</a>
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
							<a class="nav-link" href="./about.jsp">About</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="./services.jsp">Services</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="./contact.jsp">Contact</a>
						</li>
<%	if (userVO == null) {	%>
						<li class="nav-item">
							<a class="nav-link" href="./member/login.jsp">Login</a>
						</li>
<%	} else {	%>
						<li class="nav-item">
							<a class="nav-link" href="logout.do">Logout</a>
						</li>
<%	}	%>
						<li class="nav-item">
							<a class="nav-link" href="basketList.do">Shopping 	Cart</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="./admin/adminLogin.jsp"> </a>
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
					<div class="list-group">
<%	for(CategoryVO category: categories) {	
		if (category.getParent_idx() == 0) { %>
						<a href="productSearch.do?criteria=category_idx&searchWord=<%=category.getIdx()%>" class="list-group-item"><%=category.getCategory_name()%></a>
<%		}
	}	%>
				<!--	<a href="#" class="list-group-item">Category 2</a>
						<a href="#" class="list-group-item">Category 3</a>	-->
					</div>
				</div>
				<!-- /.col-lg-3 -->
		
				<div class="col-lg-9">
					<div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner" role="listbox">
							<div class="carousel-item active">
								<img class="d-block img-fluid" src="image/firstSlide.jpg" alt="First slide 900x350">
							</div>
							<div class="carousel-item">
								<img class="d-block img-fluid" src="image/secondSlide.jpg" alt="Second slide 900x350">
							</div>
							<div class="carousel-item">
								<img class="d-block img-fluid" src="image/thirdSlide.jpg" alt="Third slide 900x350">
							</div>	
					<!--	<div class="carousel-item">
								<img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Third slide">
							</div>	-->
						</div>
						<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
		
					<div class="row">
		
<%	for(ProductVO product: best6Products) {	%>
						<div class="col-lg-4 col-md-6 mb-4">
							<div class="card h-100">
								<a href="productView.do?idx=<%=product.getIdx()%>">
									<img class="card-img-top" src="<%=product.getProduct_image()%>" alt="700x400"></a>
								<div class="card-body">
									<h4 class="card-title">
										<a href="productView.do?idx=<%=product.getIdx()%>"><%=product.getProduct_name()%></a>
									</h4>
									<h5><%=product.getProduct_price()%></h5>
									<p class="card-text"><%=product.getProduct_desc()%></p>
								</div>
								<div class="card-footer">
									<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
								</div>
							</div>
						</div>
<%	}	%>
					</div>
					<!-- /.row -->
		
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
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	</body>
</html>
