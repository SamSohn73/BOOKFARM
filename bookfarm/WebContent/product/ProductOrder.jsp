<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.BasketVO"%>
<%@ page import="java.util.Vector"%>
<%
Vector<CategoryVO>	categories	= (Vector<CategoryVO>) session.getAttribute("categories");
	CustomerVO		cVo				=	new CustomerVO();
	ProductVO		pVo				=	new ProductVO();
	int				quantity		=	0;
	Vector<BasketVO> VbVo			=	new Vector<BasketVO>();
	Vector<ProductVO> VpVo			=	new Vector<ProductVO>();
	String			bchk			=	"p";

	if(request.getAttribute("pVo")!=null && request.getAttribute("quantity")!=null) {
					pVo				=	(ProductVO)request.getAttribute("pVo");
					quantity		=	(int)request.getAttribute("quantity");
	float			final_price		=	pVo.getProduct_price()*quantity;
	
	BasketVO		bVo				=	new BasketVO();
										bVo.setProduct_idx(pVo.getIdx());
										bVo.setQuantity(quantity);
										bVo.setFinal_price(final_price);
										VbVo.add(bVo);
										VpVo.add(pVo);
	}else{
					VbVo			=	(Vector<BasketVO>)session.getAttribute("baskets");
					VpVo			=	(Vector<ProductVO>)request.getAttribute("VpVo");
					bchk			=	"b";
	}

	if(session.getAttribute("loggedInUserVO")!=null){
					cVo				=	(CustomerVO)session.getAttribute("loggedInUserVO");
	}else{
										cVo.setUsername("");
										cVo.setFirstname("");
										cVo.setPhone1("");
										cVo.setEmail1("");
										cVo.setPostcode("");
										cVo.setAddress1("");
										cVo.setAddress2("");
	}

										session.setAttribute("VpVo", VpVo);
										session.setAttribute("VbVo", VbVo);
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
		function buy_submit(){
			form1.submit();
		}
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
<%	if (session.getAttribute("loggedInUserVO")==null) {	%>
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
				<div class="col-lg-9 my-5">
					<form name="form1" method="post" action="./OrderFinish.do" target="_top">
					<h3>구매자 정보</h3>
					<table class="table">
						<tr class="">
							<td class="">이름</td>
							<td class="">
							<input type="text" name="firstname" placeholder="이름"value=<%=cVo.getFirstname()%>>
							</td>
						</tr>
						<tr class="">
							<td class="">휴대폰번호</td>
							<td class="">
							<input type="text" name="phone" placeholder="휴대폰번호"value=<%=cVo.getPhone1() %>>
							</td>
							<td class="">이메일</td>
							<td class="">
							<input type="text" name="email" placeholder="이메일"value=<%=cVo.getEmail1() %>>
							</td>
						</tr>
						<tr class="">
							<td class="">우편번호</td>
							<td class="">
							<input type="text" name="postcode" placeholder="postcode" value=<%=cVo.getPostcode() %>>
							</td>
						</tr>
						<tr class="">
							<td class="" rowspan="2">주소</td>
							<td colspan="3" class="">
							<input type="text" name="add1" placeholder="주소"value=<%=cVo.getAddress1() %>>
							</td>
						</tr>
						<tr class="">
							<td colspan="3" class="">
							<input type="text" name="add2" placeholder="상세 주소"value=<%=cVo.getAddress2() %>>
							</td>
						</tr>
					</table>
			
				<!-- /.col-lg-3 -->
				<div class="col-lg-9 my-5">
				<h2 class="my-2">장바구니 목록</h2>
					<table class="table">
						<tr>
							<th>삭제</th>
							<th>상품명</th>
							<th>이미지</th>
							<th>수량</th>
							<th>가격</th>
						</tr>
			<%int total = 0;
			  int num	= 0;
				if (VbVo != null && VpVo != null) {
					for(BasketVO basket: VbVo) {%>
								<tr>
									<td>
										<a href="basketDelete.do?idx=<%=basket.getIdx()%>"><input type='button' class="btn" value="삭제"></a>
									</td>
									<td><a href = "productView.do?idx=<%=basket.getProduct_idx()%>"><%=VpVo.get(num).getProduct_name()%></a></td>
									<td><a href = "productView.do?idx=<%=basket.getProduct_idx()%>"><img class="card-img-top" src="<%=VpVo.get(num).getProduct_image()%> " alt="350x200"></a></td>
									<td><%=basket.getQuantity()%></td>
									<td><%=basket.getFinal_price()%></td>
								</tr>
							<%total += basket.getFinal_price();
							  num++;
					}
				}%>
				</table>
				<h4>합 계 : <%=total%></h4>
				<%=VbVo.get(0).getProduct_idx() %>
				<input type="hidden" name="total" value="<%=total %>">
				<input type="hidden" name="bchk" value="<%=bchk %>">
				<a href="./index.do"><input type='button' class="btn" value="처음으로"></a>
				<input type='button' class="btn" value="구매하기" onClick="buy_submit()">
				</div>
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