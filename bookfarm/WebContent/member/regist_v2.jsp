<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@page import="java.sql.Date" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	String		type			=	"modify";	//view, insert, modify	
	CustomerVO	vo				=	new CustomerVO();
	int			nowYear			=	Calendar.getInstance().get(Calendar.YEAR);
	int			year			=	(int)request.getAttribute("year");
	int			month			=	(int)request.getAttribute("month");
	int			day				=	(int)request.getAttribute("day");
	int			dayLimit		=	(int)request.getAttribute("dayLimit");
	
	
	if(request.getParameter("type")!=null)
				type			=	(String)request.getParameter("type");
	else
				type			=	"modify";
	
	if(request.getAttribute("vo")!=null)
				vo				=	(CustomerVO)request.getAttribute("vo");
	
	CustomerVO	userVO			=	null;
	if(session.getAttribute("loggedInUserVO")!=null)
				userVO			=	(CustomerVO)session.getAttribute("loggedInUserVO");
	
	
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
<title>회원가입</title>
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="css/shop-homepage.css" rel="stylesheet">
		<link href="css/login.css" rel="stylesheet">

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
		}else if(form.firstname.value.length==0){
			alert('이름을 확인해 주세요');
			form.firstname.focus();
			return;
		}else if(form.postcode.value.length==0){
			alert('우편번호를 확인해 주세요');
			form.postcode.focus();
			return;
		}else if(form.address1.value.length==0){
			alert('주소를 확인해 주세요');
			form.address1.focus();
			return;
		}else if(form.address2.value.length==0){
			alert('주소를 확인해 주세요');
			form.address2.focus();
			return;
		}else if(form.phone1.value.length==0){
			alert('연락처를 확인해 주세요');
			form.phone1.focus();
			return;
		}else if(form.day.value.length==0){
			alert('생년월일을 확인해 주세요');
			form.day.focus();
			return;
		}else if(form.email1.value.length==0){
			alert('이메일을 확인해 주세요');
			form.email1.focus();
			return;
		}else if(form.user_gender.value.length==0){
			alert('성별을 확인해 주세요');
			form.user_gender.focus();
			return;
		}else{
			form.submit();
		}
	}
	function selFuc(obj)
	{
		obj.form.action="./CustomerRegistSetting.do?type=<%=type %>";
		obj.form.submit();
	}
	
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
<div class="container my-5">
	<div class="row">
		<div class="col-lg-9 col-md-9 mb-9">

	<%	if(type.equals("view")){ %>
<form action="./qCustomerRegist.do?type=<%=type %>" method="post">
		<h2 class="my-4">회원 정보 보기</h2>
	<%	}else if(type.equals("modify")){ %>
<form action="./qCustomerRegist.do?type=<%=type %>" method="post">
		<h2 class="my-4">회원 정보 수정</h2>
	<%	}else{ %>
<form action="./qCustomerRegist.do?type=<%=type %>" method="post">
		<h2 class="my-4">회원가입</h2>
	<%}%>
<table class="table">
	<tr>
		<td class="table-secondary"><label>아이디</label></td>
		<td><input type="text" name="username" placeholder="아이디"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getUsername() %>
		<%	}else if(type.equals("modify")){ %>
		readonly="readonly"value=<%=vo.getUsername() %>
		<%	}else{ 
			if(vo.getUsername()!=null){%>
		value=<%=vo.getUsername() %>
		<%	}%><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary"><label>비밀번호</label></td>
		<td><input type="password" name="password" placeholder="비밀번호"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getPassword() %>
		<%	}else{
			if(vo.getPassword()!=null){%>
		value=<%=vo.getPassword() %>
		<%	}%><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary"><label>이름</label></td>
		<td><input type="text" name="firstname" placeholder="이름"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getFirstname() %>
		<%	}else{
			if(vo.getFirstname()!=null){%>
		value=<%=vo.getFirstname() %>
		<%	}%><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary" rowspan="2"><label>주소</label></td>
		<td>
		<input type="text" name="postcode" placeholder="postcode"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getPostcode() %>
		<%	}else{
			if(vo.getPostcode()!=null){%>
		value=<%=vo.getPostcode() %>
		<%	}%><%}%>
		>
		<a href="#" onclick="window.open('xxx.html','width=500px, height=500px')">
		<input type="button" class="zip_btn" value="우편번호찾기"></a>
		</td>
	</tr>
	<tr>
		<td><input type="text" name="address1" placeholder="주소"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getAddress1() %>
		<%	}else{
			if(vo.getAddress1()!=null){%>
		value=<%=vo.getAddress1() %>
		<%	} %><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary"><label>상세주소</label></td>
		<td><input type="text" name="address2" placeholder="상세주소"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getAddress2() %>
		<%	}else{
			if(vo.getAddress2()!=null){%>
		value=<%=vo.getAddress2() %>
		<%	} %><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary"><label>연락처1</label></td>
		<td><input type="text" name="phone1" placeholder="연락처1"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getPhone1() %>
		<%	}else{
			if(vo.getPhone1()!=null){%>
		value=<%=vo.getPhone1() %>
		<%	} %><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary"><label>생년월일</label>
		<td class="">
					<select class="btn" onchange="selFuc(this)" name="year">
							<option value="0">년도</option>
						<% for(int i=nowYear;i>=(nowYear-100);i--){ %>
							<option value="<%=i%>"
							<%if(year==i){%> selected<%}%>>
							<%= i%> 년</option>
							<%} %>
						</select>
						<%if(year!=0){ %>
						 - <select class="btn" onchange="selFuc(this)" name="month">
							<option value="0">월</option>
						<% for(int j=1;j<=12;j++){ %>
							<option value="<%=j%>"
							<%if(month==j){%> selected<%}%>>
							<%= j%> 월</option>
							<%} %>
						</select>
						<%} 
						  if(month!=0){%>
						 - <select class="btn" onchange="selFuc(this)" name="day">
							<option value="0">일</option>
						<% for(int k=1;k<=dayLimit;k++){ %>
							<option value="<%=k%>"
							<%if(day==k){%> selected<%}%>>
							<%= k%> 일</option>
							<%} %>
						</select>
						<%} %>
		</td>
	</tr>
	<tr>
		<td class="table-secondary"><label>이메일</label></td>
		<td><input type="email" name="email1" placeholder="이메일"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=vo.getEmail1() %>
		<%	}else{
			if(vo.getEmail1()!=null){%>
		value=<%=vo.getEmail1() %>
		<%	}%><%}%>
		></td>
	</tr>
	<tr>
		<td class="table-secondary"><label>성별</label></td>
		<td>
		<%	
			if(type.equals("view")){
				String user_gender	=	vo.getGender();
				if(user_gender.equals("m")){%>
					<input type="radio" name="user_gender" value="m"checked="checked" >남
					<input type="radio" name="user_gender" value="f"disabled="disabled">여
		<%		}else{%>
					<input type="radio" name="user_gender" value="m"disabled="disabled">남
					<input type="radio" name="user_gender" value="f"checked="checked">여
		<%		}
			}else if(vo.getGender()!=null){ 
				String user_gender	=	vo.getGender();
				if(user_gender.equals("m")){%>
					<input type="radio" name="user_gender" value="m"checked="checked">남
					<input type="radio" name="user_gender" value="f">여
		<%		}else{%>
					<input type="radio" name="user_gender" value="m">남
					<input type="radio" name="user_gender" value="f"checked="checked">여
		<%		}
			}else{ %>
			<input type="radio" name="user_gender" value="m">남
			<input type="radio" name="user_gender" value="f">여
		<%	} %>
			
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" class="">
			<input type="button" class="btn" value="확인" onclick="register_check(this.form)">
			<%if(type.equals("modify") || type.equals("view")){ %>
			<a href="./member/mypage.jsp"><input type="button" class="btn" value="취소"></a>
			<%}else if(type.equals("insert")){ %>
			<a href="index.do"><input type="button" class="btn" value="취소"></a>
			<%} %>
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