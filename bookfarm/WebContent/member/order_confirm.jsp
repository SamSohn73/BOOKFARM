<%@page import="org.apache.catalina.filters.CsrfPreventionFilter"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Date" %>
<%@ page import="gq.bookfarm.vo.OrdersVO" %>
<%@ page import="gq.bookfarm.vo.OrdersProductVO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
		Vector<OrdersVO> list		=	new Vector<OrdersVO>();
		OrdersVO		oList		=	new OrdersVO();
		Vector<OrdersProductVO> opList=	new Vector<OrdersProductVO>();
		
		String	type				= "myList";	//myPage, myList, singleList
		if(request.getParameter("type")!=null)
				type				=	request.getParameter("type");

		Vector<String>	cs			=	null;
		PageVO			info		=	null;
		
		int				total_page	=	0;
		int				current_page=	1;
		int				endPage		=	0;
		int				startPage	=	0;
		int				totalRows	=	0;
		if(type.equals("myPage"))
		{
						list		=	(Vector<OrdersVO>)request.getAttribute("list");
						cs			=	(Vector<String>)request.getAttribute("cs");
		}
		else if(type.equals("myList"))
		{
						list		=	(Vector<OrdersVO>)request.getAttribute("list");
						cs			=	(Vector<String>)request.getAttribute("cs");
						info		=	(PageVO)request.getAttribute("info");
						
						total_page	=	info.getTotalPages();
						current_page=	info.getPage();
						endPage		=	info.getEndPage();
						startPage	=	info.getStartPage();
						totalRows	=	info.getTotalRows();
		}
		
		CustomerVO		userVO		=	null;
		if(session.getAttribute("loggedInUserVO")!=null)
						userVO		=	(CustomerVO)session.getAttribute("loggedInUserVO");
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
<title>구매 내역 확인</title>
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
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
	<%	if(type.equals("myPage")) {%>
	
	<%}else{%>
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
	<%}%>
	</script>
</head>
<body>
<%	if(type.equals("myPage")) {%>
	<div>
		<div>
			<div class="col-lg-12">
				<div class="">	
<%}else{%>
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
				<div class="my-5">
<%} %>





<h2>구매 내역 확인</h2>
	<table class="table">
			<tr class="">
				<th >주문번호</th>
				<th >상품정보</th>
				<th >주문금액</th>
				<th >날짜</th>
			</tr>
			<%int	csCount	=	0;
			for(OrdersVO vo:list){
			%>
				<tr class="클래스_tr_top1">
					<td class="클래스_td_align1">
					<a href="qOrderView.do?type=singleList&idx=<%=vo.getIdx() %>&page=<%=current_page %>&cs=<%=cs.get(csCount) %>" target="_top">
					<%=vo.getIdx() %></a></td>
					<td align="left">
					<a href="qOrderView.do?type=singleList&idx=<%=vo.getIdx() %>&page=<%=current_page %>&cs=<%=cs.get(csCount) %>" target="_top">
					<%=cs.get(csCount) %></a></td>
					<%csCount++; %>
					<td><%=vo.getFinal_price() %></td>
					<td><%=vo.getDate_purchased() %></td>
				</tr>
			<%}%>
				<tr>
					<td colspan="4" align="center">
						<%if(type.equals("myList"))
						{
							if(current_page<=1){
							}else{
								out.print("<a href=./qOrdersConfirm.do?type="+type+"&page="+(current_page-1)+">");
								out.print(" [이전] </a>");
							}
						
							for(int i=startPage;i<=endPage;i++){
								if(i==current_page){
									out.print(" "+i+" ");
								}else{
									out.print(" <a href=qOrdersConfirm.do?type="+type+"&page="+i+"> "+i+" </a> ");
								}
							}
							
							if(current_page>=total_page){
							}else{
								out.print("<a href=qOrdersConfirm.do?type="+type+"&page="+(current_page+1)+">");
								out.print(" [다음] </a>");
							}
						}
						else if(type.equals("myPage"))
						{
							%>
							<a href="./qOrdersConfirm.do?type=myList&page=1" target="_top">
							<input type="button" class="btn" value="더보기"></a>
							<%
						}
						%>
					</td>
				</tr>
				</table>
				<%
				if(type.equals("myList"))
				{
				%>
				<table	class="table">
							<tr>
								<td align="right">
								<a href="./member/mypage.jsp">
								<input type="button" class="btn" value="마이페이지"></a>
								</td>
							</tr>
				</table>
				<%
				}
				%>
				</div>
			</div>
		</div>
	</div>
	
	<%	if(type.equals("myPage")) {%>
	<%}else{ %>
		<!-- Footer -->
		<footer class="py-5 bg-dark">
			<div class="container">
				<p class="m-0 text-center text-white">Copyleft &copy; Team Bookfarmer 2018</p>
				<p class="m-0 text-center text-white">DWIT Class3 - Team 책농부</p>
			</div>
			<!-- /.container -->
		</footer>
	<%} %>	
		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>