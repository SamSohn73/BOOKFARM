<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
	ProductVO			productVO		= (ProductVO)session.getAttribute("productVO");
	CustomerVO			userVO			= (CustomerVO)session.getAttribute("loggedInUserVO");

	String				criteria		= request.getParameter("cri");
	String				searchWord		= request.getParameter("word");

	int					current_page	= 1;
	if(request.getParameter("page") != null)	current_page = Integer.parseInt(request.getParameter("page"));
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM Good Detail</title>
	
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
			function list_submit(){
				//location.href="productList.do";
				productForm.action = "productSearch.do?criteria=<%=criteria%>&searchWord=<%=searchWord%>";
				productForm.submit();
			}
			function buy_submit(){
				<%-- productForm.action = "productBuy.do?idx=<%=productVO.getIdx()%>"; --%>
				productForm.action = "productSearch.do?criteria=<%=criteria%>&searchWord=<%=searchWord%>";
				productForm.submit();
			}
			function basket_submit(){
				productForm.action = "basketAdd.do";
				productForm.submit();
			}
			function review_submit(){
				productForm.action = "qReviewsLists.do?type=list&products_idx=<%=productVO.getIdx() %>";
				productForm.submit();
			}
			function main_submit(){
				productForm.action = "index.do";
				productForm.submit();
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
					<form method = "post"  name='productForm'>
						<table>
						<caption>상품 보기</caption>
							<tr>
								<td class="td_left">카테고리</td>
								<td class="td_right">
									<%=categories.get(categories.indexOf(new CategoryVO(productVO.getCategory_idx()))).getCategory_name()%>
								</td>
							</tr>
							<tr>
								<td class="td_left">제 목</td>
								<td class="td_right">
									<%=productVO.getProduct_name()%>
								</td>
							</tr>
							<tr>
								<td class="td_left">이미지</td>
								<td class="td_right">
									<img src="<%=productVO.getProduct_image()%>">
								</td>
							</tr>
							<tr>
								<td class="td_left">상품 소개</td>
								<td class="td_right">
									<textarea name='contents' cols='65' rows='15' readonly><%=productVO.getProduct_desc()%>
								</textarea>
								</td>
							</tr>
							<tr>
								<td class="td_left">가격</td>
								<td class="td_right">
									<%=productVO.getProduct_price()%>
								</td>
							</tr>
							<tr>
								<td class="td_left">수량</td>
								<td class="td_right">
									<select name='quantity'>
										<option value="1" selected >1</option>
										<option value="2" >2</option>
										<option value="3" >3</option>
										<option value="4" >4</option>
										<option value="5" >5</option>
									</select>
								</td>
							</tr>
							
							<tr class="button_cell">
								<td colspan='2'>
								<input type="button" value="즉시구매" onClick="buy_submit()">
								<input type="button" value="장바구니" onClick="basket_submit()">
								<input type="button" value="목록" onClick="list_submit()">
								<input type="hidden" name="page" value=<%=current_page %>>
								<input type="button" value="리뷰보기" onClick="review_submit()">
								<input type="button" value="메인으로" onClick="main_submit()">
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
