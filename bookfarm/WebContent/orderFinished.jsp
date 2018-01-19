<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="gq.bookfarm.vo.OrdersProductVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%
Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
Vector<OrdersProductVO> VopVo		=	(Vector<OrdersProductVO>)request.getAttribute("VopVo");
Vector<ProductVO> VpVo				=	(Vector<ProductVO>)request.getAttribute("VpVo");
	CustomerVO		cVo				=	new CustomerVO();

	int				order_idx		=	(int)request.getAttribute("order_idx");
	String			firstname		=	(String)request.getAttribute("firstname");
	int				total			=	(int)request.getAttribute("total");
	String			add1			=	(String)request.getAttribute("add1");
	String			add2			=	(String)request.getAttribute("add2");
	
	if(session.getAttribute("loggedInUserVO")!=null)
		cVo				=	(CustomerVO)session.getAttribute("loggedInUserVO");


%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		
<title>Insert title here</title>

		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="css/shop-homepage.css" rel="stylesheet">
		<link href="css/login.css" rel="stylesheet">


	<script>
		//Get the modal
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
<%	if (cVo == null) {	%>
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
			<input type="text" class="input-hansol" placeholder="Enter Username" name="username" required>

			<label><b>Password</b></label>
			<input type="password" class="input-hansol" placeholder="Enter Password" name="password" required>

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
				
				
				<div class="my-5">
					<h2 class="my-4">결제가 완료되었습니다</h2>
					<p class="my-4">구매해 주셔서 감사합니다. 아래 내역을 확인해 주세요.</p>
				<form class="my-5">
				<table class="table">
					<tr>
						<th >구매자이름</th>
						<th >송장번호</th>
					</tr>
					<tr>
						<td><%=firstname %></td>
						<td><%=order_idx %></td>
					</tr>
					<tr>
						<td colspan="2">주소</td>
					</tr>
					<tr>
						<td><%=add1 %></td>
						<td><%=add2 %></td>
					</tr>
				</table>
				</form>
				
				
				
				<form class="my-5">
				<table class="table">
					<tr>
						<th>상품명</th>
						<th>갯수</th>
						<th>판매가</th>
						<th>합계가격</th>
					</tr>
					<%int num=0;
					for(OrdersProductVO opVo :VopVo){
						if(opVo.getProducts_idx()==VpVo.get(num).getIdx()){%>
					<tr>
						<td><%=VpVo.get(num).getProduct_name() %></td>
						<td><%=opVo.getProducts_quantity() %></td>
						<td><%=VpVo.get(num).getProduct_price() %></td>
						<td><%=opVo.getFinal_price() %></td>
					</tr>
					<%num++;}
					} %>
					<tr>
						<td colspan="2" align="left">총결제금액</td>
						<td colspan="2" align="right"><%=total %></td>
					</tr>
					<tr>
						<td colspan="4" align="right">
						<a href="index.do"><input type="button" class="btn" value="확인"></a>
						</td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	</div>


		<!-- Footer -->
		<footer class="py-5 bg-dark">
			<div class="container">
				<p class="m-0 text-center text-white">Copyleft &copy; Team Bookfarmer 2018</p>
				<p class="m-0 text-center text-white">DWIT Class3 - Team 책농부</p>
			</div>
		</footer>
	
		<!-- Bootstrap core JavaScript -->
		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>