<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%	
Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
	HttpSession	sess			=	request.getSession();
	String	type				=	request.getParameter("type");
	String	typeView			=	request.getParameter("typeView");//view,insert,modify
	
	CustomerVO	cVo				=	(CustomerVO)sess.getAttribute("loggedInUserVO");
	ReviewVO	reviewVO		=	null;
	
	int			idx				=	0;
	int			currentPage		=	1;	
	int			products_idx	=	0;
	String		name			=	null;
	
	if(typeView.equals("view") || typeView.equals("modify"))
	{
		reviewVO		=	(ReviewVO)request.getAttribute("reviewVO");
		name			=	(String)request.getAttribute("name");
		idx				=	reviewVO.getIdx();
		currentPage		=	Integer.parseInt(request.getParameter("page"));
		products_idx	=	reviewVO.getProducts_idx();
	}
	else if(typeView.equals("insert")){
			products_idx		=	Integer.parseInt(request.getParameter("products_idx"));
	}

%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">

<%	if(typeView.equals("insert")) {%>
		<link href="../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="../css/shop-homepage.css" rel="stylesheet">
		<link href="../css/login.css" rel="stylesheet">
<%	} else {%>
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="css/shop-homepage.css" rel="stylesheet">
		<link href="css/login.css" rel="stylesheet">
<%	}%>

<title>
<%	if(typeView.equals("view")) {%>				리뷰 보기
<%	} else if(typeView.equals("modify")) {%>	리뷰 수정
<%	} else {%>									리뷰 등록
<%	}%>
</title>
<script>
	function returnList1(){
		location.href="../qReviewsLists.do?page=<%=currentPage%>&type=<%=type%>&products_idx=<%=products_idx%>";
	}
	function returnList2(){
		location.href="./qReviewsLists.do?page=<%=currentPage%>&type=<%=type%>&products_idx=<%=products_idx%>";
	}
	function modifyList(){
		location.href="./review/IdPwdChk.jsp?idx=<%=idx%>&page=<%=currentPage%>&type=<%=type%>&typeView=modify&products_idx=<%=products_idx%>";
	}
	function deleteRow(){
		location.href="./review/IdPwdChk.jsp?idx=<%=idx%>&page=<%=currentPage%>&type=<%=type%>&typeView=delete&products_idx=<%=products_idx%>";
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
		<div class="my-5">
			<%if(typeView.equals("insert")){ %>
			<form action="../qReviewsInsert.do" method="post">
			<%}else if(typeView.equals("modify")){ %>
			<form action="qReviewsInsert.do" method="post">
			<%}else{ %>
			<form action="./qReviewsList.do" method="post">
			<%} %>
				<%	if(typeView.equals("view")){ %>
					<h2>리뷰 보기</h2>
				<%	}else if(typeView.equals("modify")){ %>
					<h2>리뷰 수정</h2>
				<%	}else{ %>
					<h2>리뷰 등록</h2>
				<%	} %>
			<table class="table">
				<tr>
					<td class="">글쓴이</td>
					<td class=""><input type="text" name="review_writer" size="15" required="required"
					<%	if(typeView.equals("view")){ %>
					readonly="readonly"value=<%=name %>
					<%	}else if(typeView.equals("modify")){ %>
					readonly="readonly"value=<%=name %>
					<%	}else{ %>
					readonly="readonly"value=<%=cVo.getUsername() %>
					<%	} %>
					></td>
				</tr>
				<tr>
					<td class="">제목</td>
					<td class=""><input type="text" name="review_title" size="40" required="required"
					<%	if(typeView.equals("view")){ %>
					readonly="readonly" value=<%=reviewVO.getReview_title() %> 
					<%	}else if(typeView.equals("modify")){ %>
					value=<%=reviewVO.getReview_title() %>
					<%	}else{ %>
					placeholder="리뷰 제목"
					<%	} %>
					></td>
				</tr>
				<tr>
					<td class="">내용</td>
					<td class=""><textarea name="review_text" rows="15" cols="50" required="required"
					<%	if(typeView.equals("view")){ %>
					readonly="readonly"><%=reviewVO.getReview_text() %> 
		<%	}else if(typeView.equals("modify")){ %>
		><%=reviewVO.getReview_text() %>
		<%	}else{ %>
		placeholder="리뷰 내용"><%}%></textarea></td>
				</tr>
					<%	if(typeView.equals("view")){ %>
				<tr>
					<td colspan="2" class="" align="center">
					<input class="btn" type="button" value="뒤로가기" onclick="javascript:history.back()">
					<%		if(type.equals("list")){ %>
					 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
					<%		}else if(type.equals("myList")){ %>
					 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
					<%		} %>
					
					<%		if(sess.getAttribute("loggedInUserVO")!=null && (reviewVO.getCustomers_idx()==(cVo.getIdx()))){ %>
					 <input class="btn" type="button" value="수정하기"onclick="modifyList()">
					 <input class="btn" type="button" value="삭제하기"onclick="deleteRow()">
					<%		} %>
					</td>
				</tr>
					<%}else{ %>
				<tr>
					<td colspan="2" class="" align="center">
					<%		if(typeView.equals("insert")){ %>
					<input class="btn" type="submit" value="등록">
					<input class="btn" type="button" value="취소" onclick="javascript:history.back()">
					<% 		}else if(typeView.equals("modify")){ %>
					<input class="btn" type="submit" value="수정">
					<%		} %>
					
					<%		if(type.equals("list") && typeView.equals("insert")){ %>
					 <input class="btn" type="button" value="목록보기"onclick="returnList1()">
					<%		}else if(type.equals("list") && typeView.equals("modify")){ %>
					 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
					<%		}else if(type.equals("myList")){ %>
					 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
					<%		} %>
					</td>
				</tr>
					<%} %>	
			</table>
			<input type="hidden" name="page" value="<%=currentPage %>">
			<input type="hidden" name="type" value="<%=type %>">
			<input type="hidden" name="typeView" value="<%=typeView %>">
			<input type="hidden" name="products_idx" value="<%=products_idx %>">
			<%	if(typeView.equals("modify")){	%>
			<input type="hidden" name="idx" value="<%=idx %>">
			<%} %>
			<%if(typeView.equals("insert")){ %>
			</form>
			<%}else if(typeView.equals("modify")){ %>
			</form>
			<%}else{ %>
			</form>
			<%} %>
			</div>
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