<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CustomerVO	userVO	=	null;
	if(session.getAttribute("loggedInUserVO")!=null)
		userVO			=	(CustomerVO)session.getAttribute("loggedInUserVO");

	String		type			=	"login";
	CustomerVO	vo				=	new CustomerVO();
	if(request.getParameter("type")!=null)
				type			=	request.getParameter("type");
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
<title>로그인</title>

		<link href="../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="../css/shop-homepage.css" rel="stylesheet">
		<link href="../css/login.css" rel="stylesheet">
<script>
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
</script>
</head>
<body onload="pwdCheck.pwd.focus()">
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
<%	if (userVO == null) {	%>
						<li class="nav-item">
							<a class="nav-link" href="#" onclick="document.getElementById('modalLogin').style.display='block'">Login</a>
						</li>
<%	} else {	%>
						<li class="nav-item">
							<a class="nav-link" href="../qCustomerLogout.do">Logout</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="../member/mypage.jsp">Mypage</a>
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
<div class="container my-5">
<form name="pwdCheck" class="col-lg-4" method="post" action="../qCustomerIdPwdCheck.do?type=<%=type %>" target="_top">
	<h3 class="my-3">아이디 비밀번호 입력</h3>
	<table class="table">
		<tr>
			<td>
				<input type="text" size="20" name="username" required="required">
			</td>
			<td rowspan="2">				
				<%if(type.equals("login")){ %>
				<input type="submit" class="btn" value="로그인">
				<%}else if(type.equals("modify")){ %>
				<input type="submit" class="btn input-hansol" value="확인">
				<%} %>
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" size="20" name="password" required="required">
			</td>
		</tr>
		<%if(type.equals("login")){ %>
		<tr>
			<td>
				<a href="../CustomerRegistSetting.do?type=insert" target="_top">
				<input type="button" class="btn" value="회원가입"></a>
				<a href="findChk.jsp" target="_top">
				<input type="button" class="btn" value="아이디/비번 확인"></a>
			</td>			
		</tr>
		<%} %>
	</table>
</form>
</div>

		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>