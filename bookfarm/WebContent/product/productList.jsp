<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.PageVO"%>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo		= (PageVO) request.getAttribute("pageInfo");
	Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
	Vector<ProductVO>	products		= (Vector<ProductVO>) request.getAttribute("products");
	CustomerVO			userVO			= (CustomerVO)session.getAttribute("loggedInUserVO");

	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage	= pageInfo.getPage();
	int startPage	= pageInfo.getStartPage();
	int endPage		= pageInfo.getEndPage();
	int totalRows	= pageInfo.getTotalRows();
	int totalPages	= pageInfo.getTotalPages();
	
	log.debug("productList.jsp criteria="		+ criteria);
	log.debug("productList.jsp searchWord="		+ searchWord);
	log.debug("productList.jsp currentPage="	+ currentPage);
	log.debug("productList.jsp startPage="		+ startPage);
	log.debug("productList.jsp endPage="		+ endPage);
	log.debug("productList.jsp totalRows="		+ totalRows);
	log.debug("productList.jsp totalPages="		+ totalPages);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM Goods List</title>
	
		<!-- Bootstrap core CSS -->
		<!--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="css/shop-homepage.css" rel="stylesheet">
		<link href="css/login.css" rel="stylesheet">
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
			function search(){
				if(searchform.searchWord.value==""){
					alert('검색어를 넣으세요');
					searchform.searchWord.focus();
					return;
				}
				searchform.submit();
			}
			$('body').on('mouseenter mouseleave','.dropdown',function(e){
				  var _d=$(e.target).closest('.dropdown');_d.addClass('show');
				  setTimeout(function(){
				    _d[_d.is(':hover')?'addClass':'removeClass']('show');
				  },300);
				});
		</script>
	</head>
	
	<body>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="index.do">Bookfarm - Online Bookstore</a>
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
							<a class="nav-link" href="./contact.jsp">Contact</a>
						</li>
<%	if (userVO == null) {	%>
						<li class="nav-item">
							<a class="nav-link" href="#" onclick="document.getElementById('modalLogin').style.display='block'">Login</a>
						</li>
<%	} else {	%>
						<li class="nav-item">
							<a class="nav-link" href="qCustomerLogout.do">Logout</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="./member/mypage.jsp">Mypage</a>
						</li>
<%	}	%>
						<li class="nav-item">
							<a class="nav-link" href="basketList.do">Shopping Cart</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="./admin/adminLogin.jsp"> </a>
						</li>
					</ul>
				</div>
			</div>
		</nav>
<!-- The Modal -->
<div id="modalLogin" class="modal">
	<span onclick="document.getElementById('modalLogin').style.display='none'" class="close" title="Close Modal">&times;</span>

	<!-- Modal Content -->
	<form class="modal-content animate" name="pwdCheck" method="post" action="qCustomerIdPwdCheck.do?type=login" target="_top">

		<div class="container">
			<label><b>Username</b></label>
			<input type="text" placeholder="Enter Username" name="username" required>

			<label><b>Password</b></label>
			<input type="password" placeholder="Enter Password" name="password" required>

			<button type="submit">Login</button>
			<!--<label>
				<input type="checkbox" checked="checked"> Remember me
			</label>-->
		</div>

		<div class="container" style="background-color:#f1f1f1">
			<button type="button" class="btn" onclick="location.href='CustomerRegistSetting.do?type=insert' ">회원 가입</button>
			<button type="button" class="btn" onclick="location.href='member/findChk.jsp' ">로그인 정보확인</button>
			<button type="button" class="cancelbtn" onclick="document.getElementById('modalLogin').style.display='none'">취소</button>
		</div>
	</form>
</div>	
		<!-- Page Content -->
		<div class="container">
	
			<div class="row">
	
				<div class="col-lg-3">
		
					<h1 class="my-4">책팜</h1>
<%	for(CategoryVO category: categories) {	
		if (category.getParent_idx() == 0) { %>
					<div class="dropdown">
						<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" onclick="location.href='productSearch.do?criteria=category_idx&searchWord=<%=category.getIdx()%>' ">
							<%=category.getCategory_name()%> <b class="caret"></b>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
<%		}
		int catIdx = category.getIdx();
		for(CategoryVO subCategory: categories) {
			if (catIdx == subCategory.getParent_idx()) { %>
							<a class="dropdown-item" href="productSearch.do?criteria=category_idx&searchWord=<%=subCategory.getIdx()%>"><%=subCategory.getCategory_name()%></a>
<%			}
		}
		if (category.getParent_idx() == 0) { %>
						</div>
					</div>
<%		}
	}%>
				</div>
				<!-- /.col-lg-3 -->
		
				<div class="col-lg-9">
					<div class="row">
<%	for(ProductVO product: products) {	%>
						<div class="col-lg-4 col-md-6 mb-4">
							<div class="card h-100">
								<a href="productView.do?idx=<%=product.getIdx()%>">
									<img class="card-img-top" src="<%=product.getProduct_image()%>" alt="700x400"></a>
								<div class="card-body">
									<h4 class="card-title">
										<a href="productView.do?idx=<%=product.getIdx()%>"><%=product.getProduct_name()%></a>
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
									out.print("<a href=productList.do?page=" + (currentPage-1) + ">");
									out.print("[prev] </a>");
								}
							%>
							<%//page numbers display
								for (int i = startPage; i <= endPage; i++) {
									if (i == currentPage) {
										out.print("[" +  i + "] ");
									} else {
										out.print("<a href=productList.do?page=" + i +">");
										out.print(i + " </a>");
									}
								}
							%>
							<%//[next] display
								if (currentPage <= endPage && currentPage < totalPages) {
									out.print("<a href=productList.do?page=" + (currentPage + 1) + ">");
									out.print(" [next]</a>");
								}
							%>
						</td>
					</tr>
					</table>
				
					<table>
						<tr>
							<td class="td_align">
								<form action='productSearch.do' method='post' name='searchform'>
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
<<<<<<< HEAD
				
				
				
	<table>
		<caption>상품 목록</caption>
		<tr>
			<th>No.</th>
			<th>카테고리</th>
			<th>이미지</th>
			<th>제목</th>
			<th>가격</th>
			<th>재고수량</th>
		</tr>
<%	
	 idNum = totalRows - (currentPage-1)*10;
	for(ProductVO product: products) {	%>
		<tr>
			<td><%=idNum%></td>
			<td><%=product.getCategory_idx()%></td>
			<td><a href = "productView.do?idx=<%=product.getIdx()%>&page=<%=currentPage%>&cri=<%=criteria%>&word=<%=searchWord%>"><img src="<%=product.getProduct_image()%>"></a></td>
			<td><a href = "productView.do?idx=<%=product.getIdx()%>&page=<%=currentPage%>&cri=<%=criteria%>&word=<%=searchWord%>"><%=product.getProduct_name()%></a></td>
			<td><%=product.getProduct_price()%></td>
			<td><%=product.getProduct_quantity()%></td>
		</tr>
<%		idNum--;
	} %>
		<tr>
		<td colspan = "17">
			<%//[prev] display
				if (currentPage > 1) {
					out.print("<a href=productList.do?page=" + (currentPage-1) + ">");
					out.print("[prev] </a>");
				}
			%>
			<%//page numbers display
				for (int i = startPage; i <= endPage; i++) {
					if (i == currentPage) {
						out.print("[" +  i + "] ");
					} else {
						out.print("<a href=productList.do?page=" + i + ">");
						out.print(i + " </a>");
					}
				}
			%>
			<%//[next] display
				if (currentPage <= endPage && currentPage < totalPages) {
					out.print("<a href=productList.do?page=" + (currentPage + 1) + ">");
					out.print(" [next]</a>");
				}
			%>
		</td>
	</tr>
	</table>

	<table>
		<tr>
			<td class="td_align">
				<form action='productSearch.do' method='post' name='searchform'>
					<select name='criteria'>
						<option value='product_category_idx'	<%if(criteria.equals("category_idx"))	out.print("selected");%>>카테고리</option>
						<option value='product_name'			<%if(criteria.equals("product_name"))	out.print("selected");%>>제목</option>
						<option value='product_price'			<%if(criteria.equals("product_price"))	out.print("selected");%>>가격</option>
						<option value='product_quantity'		<%if(criteria.equals("product_quantity"))out.print("selected");%>>재고수량</option>
						<option value='product_desc'			<%if(criteria.equals("product_desc"))	out.print("selected");%>>내용</option>
					</select>
					<input type='text' name='searchWord' value="<%=searchWord%>">
					<input type='button' value='검색' onclick="search()">
				</form>
			</td>
		</tr>
	</table>
=======
>>>>>>> branch 'master' of https://github.com/SamSohn73/BOOKFARM.git
	
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
		
		<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script> -->
	</body>
</html>
