<%@page import="gq.bookfarm.dao.OrdersDAO" %>
<%@page import="gq.bookfarm.dao.OrdersProductDAO" %>
<%@page import="gq.bookfarm.dao.ProductDAO" %>
<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@page import="gq.bookfarm.vo.OrdersVO"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<%@page import="gq.bookfarm.vo.OrdersProductVO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	CustomerVO		cVo			=	(CustomerVO) session.getAttribute("loggedInUserVO");
	int				customer_idx=	cVo.getIdx();
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
<title>마이 페이지</title>

		<link href="../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="../css/shop-homepage.css" rel="stylesheet">
		<link href="../css/login.css" rel="stylesheet">
		
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
				<a class="navbar-brand" href="../index.do">Bookfarm - Online Bookstore</a>
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
							<a class="nav-link" href="../about.jsp">About</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../contact.jsp">Contact</a>
						</li>
<%	if (cVo == null) {	%>
						<li class="nav-item">
							<a class="nav-link" href="#" onclick="document.getElementById('modalLogin').style.display='block'">Login</a>
						</li>
<%	} else {	%>
						<li class="nav-item">
							<a class="nav-link" href="../qCustomerLogout.do">Logout</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="mypage.jsp">Mypage</a>
						</li>
<%	}	%>
						<li class="nav-item">
							<a class="nav-link" href="../basketList.do">Shopping Cart</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../admin/adminLogin.jsp"> </a>
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


<div class="container">
		<h1 class="my-5"><%=cVo.getFirstname() %> 님의 마이페이지 입니다</h1>
		<h3>회원 정보</h3>
		<table class="table">
			<tr class="">
				<td class="left">아이디</td>
				<td class="right"><%=cVo.getUsername() %></td>
				<td class="left">이름</td>
				<td class="right"><%=cVo.getFirstname() %></td>
			</tr>
			<tr class="">
				<td class="left">휴대폰번호</td>
				<td class="right"><%=cVo.getPhone1() %></td>
				<td class="left">이메일</td>
				<td class="right"><%=cVo.getEmail1() %></td>
			</tr>
			<tr class="">
				<td class="left" rowspan="2">주소</td>
				<td colspan="3" class="right"><%=cVo.getAddress1() %></td>
			</tr>
			<tr class="">
				<td colspan="3" class="right"><%=cVo.getAddress2() %></td>
			</tr>
			<tr>
				<td colspan="4" align="right"><a href="./login.jsp?type=modify">
				<input class="btn" type="button" value="내정보 수정"></a></td>
			</tr>
		</table>

		<iframe src="../qOrdersConfirm.do?type=myPage"
				height="480" width="1000"></iframe>
		
		<iframe src="../qReviewsLists.do?type=myPage"
				height="480" width="1000"></iframe>
		<br>
		<a href="../qCustomerLogout.do"><input class="btn" type="button" value="logout"></a>
		<a href="../index.do"><input class="btn" type="button" value="메인으로"></a>
</div>
		
		
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