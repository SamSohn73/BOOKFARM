<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gq.bookfarm.vo.CustomerVO" %>
<%@page import="gq.bookfarm.vo.OrdersVO" %>
<%@page import="gq.bookfarm.vo.OrdersProductVO" %>
<%@page import="gq.bookfarm.vo.PageVO" %>
<%@page import="gq.bookfarm.vo.CategoryVO" %>
<%@page import="gq.bookfarm.dao.ProductDAO" %>
<%@page import="java.util.Vector" %>
<%
	Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
	CustomerVO				vo			=	(CustomerVO)session.getAttribute("loggedInUserVO");
	String					type		=	null;
	int						Page		=	1;
	if(request.getParameter("page")!=null)
							Page		=	Integer.parseInt(request.getParameter("page"));
	if(request.getParameter("type")!=null)
							type		=	request.getParameter("type");
	
	String					cs		=	request.getParameter("cs");
	OrdersVO				oList	=	(OrdersVO)request.getAttribute("oList");
	Vector<OrdersProductVO>	opList	=	(Vector<OrdersProductVO>)request.getAttribute("opList");
	Vector<String>			nameList=	(Vector<String>)request.getAttribute("nameList");
	PageVO					info	=	(PageVO)request.getAttribute("info");
	
	int					total_page	=	info.getTotalPages();
	int					current_page=	info.getPage();
	int					endPage		=	info.getEndPage();
	int					startPage	=	info.getStartPage();
	int					totalRows	=	info.getTotalRows();

%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
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
<%	if (vo == null) {	%>
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
				
				
				
				
				
				
						<h2>주문 정보</h2>
						<table class="table">
							<tr class="">
								<td class="left">주문하신 분</td>
								<td colspan="3" class="right"><%=vo.getFirstname() %></td>
							</tr>
							<tr class="">
								<td class="left">휴대폰번호</td>
								<td class="right"><%=vo.getPhone1() %></td>
								<td class="left">이메일</td>
								<td class="right"><%=vo.getEmail1() %></td>
							</tr>
						</table>
						<table class="table">
							<caption>구매 내역 확인</caption>
							<tr class="">
								<th >주문번호</th>
								<th >상품정보</th>
								<th >주문금액</th>
								<th >구매날짜</th>
							</tr>
							<tr class="">
								<td class=""><%=oList.getIdx() %></td>
								<td align="left"><%=cs %></td>
								<td><%=oList.getFinal_price() %></td>
								<td><%=oList.getDate_purchased() %></td>
							</tr>
				</table>
						<table class="table">
							<tr class="">
								<td class="left">받으실 분</td>
								<td colspan="3" class="right"><%=oList.getDelivery_name() %></td>
							</tr>
							<tr class="">
								<td class="left">휴대폰번호</td>
								<td class="right"><%=oList.getDelivery_phone1() %></td>
								<td class="left">이메일</td>
								<td class="right"><%=oList.getDelivery_email1() %></td>
							</tr>
							<tr class="" >
								<td class="left">주소</td>
								<td colspan="3" class="right"><%=oList.getDelivery_address1() %> <%=oList.getDelivery_address2() %></td>
							</tr>
							<tr class="">
								<td class="left">결제 금액</td>
								<td colspan="3" class="right"><%=oList.getFinal_price() %></td>
							</tr>
				</table>
				
				<table class="table">
						<caption>구매 내역 확인</caption>
						<%
						int	oclIdx	=	0;
						%>
							<tr class="">
								<th >주문번호</th>
								<th >상품정보</th>
								<th	>상품갯수</th>
								<th >주문금액</th>
							</tr>
							<%for(OrdersProductVO opVo:opList){int nCount=0;%>
							<tr class="">
									<td class="">
									<%if(oclIdx != opVo.getIdx()){ %>
									<%=opVo.getIdx() %>
									<%oclIdx=opVo.getIdx();} %>
									</td>
									<td align="left">
									<a href="productView.do?idx=<%=opVo.getProducts_idx() %>&page=1" target="_top">
									<%=nameList.get(nCount) %></a></td>
									<td><%=opVo.getProducts_quantity() %></td>
									<td><%=opVo.getFinal_price() %></td>
								</tr>
							<%nCount++;}%>
				<tr>
					<td colspan="4">
						<%
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
							}%>
					</td>
				</tr>
				</table>
				<table	class="table">
							<tr>
								<td align="right">
								<a href="./member/mypage.jsp">
								<input type="button" class="btn" value="마이페이지"></a>
								</td>
							</tr>
				</table>



				</div>
			</div>
		</div>
	</div>
	
		<!-- Footer -->
		<footer class="py-5 bg-dark">
			<div class="container">
				<p class="m-0 text-center text-white">Copyright &copy; Team Bookfarmer 2018</p>
				<p class="m-0 text-center text-white">DWIT Class3 - Team 책농부</p>
			</div>
			<!-- /.container -->
		</footer>
		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>