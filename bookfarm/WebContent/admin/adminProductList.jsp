<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.PageVO"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="gq.bookfarm.vo.CategoryVO"%>
<%@ page import="gq.bookfarm.vo.ProductVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	AdminVO				adminVO		= (AdminVO)session.getAttribute("adminVO");
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<ProductVO>	products	= (Vector<ProductVO>) request.getAttribute("products");
	Vector<CategoryVO>	categories	= (Vector<CategoryVO>) session.getAttribute("categories");
	
	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
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
	
		<title>BOOKFARM Product List</title>
	
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
		
		
				<div class="col-lg-9">
					<div class="row">
<%	for(ProductVO product: products) {	%>
						<div class="col-lg-4 col-md-6 mb-4">
							<div class="card h-100">
								<a href="adminProductView.do?idx=<%=product.getIdx()%>">
									<img class="card-img-top" src="<%=product.getProduct_image()%>" alt="700x400"></a>
								<div class="card-body">
									<h4 class="card-title">
										<a href="adminProductView.do?idx=<%=product.getIdx()%>"><%=product.getProduct_name()%></a>
									</h4>
									<h5><%=product.getProduct_price()%></h5>
									<p class="card-text"><%=product.getProduct_desc().substring(0, 40)%> ...</p>
								</div>
								<div class="card-footer">
									<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
								</div>
							</div>
						</div>
<%	}	%>
					</div>
					<!-- /.row -->	
	
					<table>
						<tr>
						<td colspan = "17">
							<%//[prev] display
								if (currentPage > 1) {
									out.print("<a href=adminProductList.do?page=" + (currentPage-1) + ">");
									out.print("[prev] </a>");
								}
							%>
							<%//page numbers display
								for (int i = startPage; i <= endPage; i++) {
									if (i == currentPage) {
										out.print("[" +  i + "] ");
									} else {
										out.print("<a href=adminProductList.do?page=" + i +">");
										out.print(i + " </a>");
									}
								}
							%>
							<%//[next] display
								if (currentPage <= endPage && currentPage < totalPages) {
									out.print("<a href=adminProductList.do?page=" + (currentPage + 1) + ">");
									out.print(" [next]</a>");
								}
							%>
						</td>
					</tr>
					</table>
				
					<table>
						<tr>
							<td class="td_align">
								<form action='adminProductSearch.do' method='post' name='searchform'>
									<select name='criteria'>
										<option value='product_category_idx'	<%if(criteria.equals("category_idx"))	out.print("selected");%>>카테고리</option>
										<option value='product_name'			<%if(criteria.equals("product_name"))	out.print("selected");%>>제목</option>
										<option value='product_price'			<%if(criteria.equals("product_price"))	out.print("selected");%>>가격</option>
										<option value='product_quantity'		<%if(criteria.equals("product_quantity"))out.print("selected");%>>재고수량</option>
										<option value='product_desc'			<%if(criteria.equals("product_desc"))	out.print("selected");%>>내용</option>
									</select>
<%	if (criteria.equals("category_idx")) {%>
									<input type='text' name='searchWord' value="<%=categories.get(categories.indexOf(new CategoryVO(Integer.parseInt(searchWord)))).getCategory_name()%>">
<%	} else { %>
									<input type='text' name='searchWord' value="<%=searchWord%>">
<%	}	%>
									<input type='button' value='검색' onclick="search()">
								</form>
							</td>
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
