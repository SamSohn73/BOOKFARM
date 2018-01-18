<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.dao.ReviewDAO" %>
<%@ page import="gq.bookfarm.dao.CustomerDAO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
		Vector<ReviewVO> list	=	(Vector<ReviewVO>)request.getAttribute("list");
		Vector<String>nameList	=	(Vector<String>)request.getAttribute("nameList");
		int		totalPages		= 1;
		int		currentPage		= 1;
		int		startPage		= 1;
		int		endPage			= 1;
		int		totalRows		= 1;		
		
		if(request.getAttribute("info")!=null){
		PageVO	info			=	(PageVO)request.getAttribute("info");
				totalPages		=	info.getTotalPages();
				currentPage		=	info.getPage();
				startPage		=	info.getStartPage();
				endPage			=	info.getEndPage();
				totalRows		=	info.getTotalRows();
		}
									
		String	searchCondition	=	(String)request.getAttribute("searchCondition");
		String	searchWord		=	(String)request.getAttribute("searchWord");
		
		int		customers_idx	=	0;
		CustomerVO	userVO		=	null;
		
		if(session.getAttribute("loggedInUserVO")!=null){
				userVO			=	(CustomerVO)session.getAttribute("loggedInUserVO");
				customers_idx	=	userVO.getIdx();
		}
		
		String	type			=	(String)request.getParameter("type");
		int		products_idx	=	0;
		if(request.getParameter("products_idx")!=null)
				products_idx	=	Integer.parseInt((String)request.getParameter("products_idx"));
		
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
<title>리뷰창</title>
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="css/shop-homepage.css" rel="stylesheet">
		<link href="css/login.css" rel="stylesheet">
	<script>
		function search()
		{
			if(searchform.searchWord.value=="")
			{
				alert('검색어를 넣으세요');
				searchform.searchWord.focus();
				return;
			}
				searchform.submit();
		}
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
				<h2>
						<%if(type.equals("list")){%>
								리뷰 게시판
						<%}else{%>
								내 리뷰 목록
						<%}%>
						</h2>
					<table class="table">
						<tr class="">
							<th >날짜</th>
							<th >제목</th>
							<th >작성자</th>
							<th >조회수</th>
						</tr>
						<%int nCount=0;
						if(type.equals("myPage"))
						{
							for(ReviewVO vo:list)
							{
							%>
							<tr class="클래스_tr_top1">
								<td><%=vo.getDate_added()%></td>
								<td align="left"><a target="_top" href="qReviewsHitUpdate.do?idx=<%=vo.getIdx()%>
								&page=1&type=myList&typeView=view">
								<%=vo.getReview_title()%></a></td>
								<td><%=nameList.get(nCount)%></td>
								<td><%=vo.getReviews_read()%></td>
							</tr>
							<%nCount++;
							}
						}
						else if(type.equals("myList"))
						{
							for(ReviewVO vo:list)
							{
							%>
							<tr class="클래스_tr_top1">
								<td><%=vo.getDate_added()%></td>
								<td align="left"><a href="qReviewsHitUpdate.do?idx=<%=vo.getIdx()%>
								&page=<%=currentPage%>&type=<%=type%>&typeView=view">
								<%=vo.getReview_title()%></a></td>
								<td><%=nameList.get(nCount)%></td>
								<td><%=vo.getReviews_read()%></td>
							</tr>
							<%nCount++;
							}
						}
						else
						{
							for(ReviewVO vo:list)
							{
							%>
							<tr class="클래스_tr_top1">
								<td><%=vo.getDate_added()%></td>
								<td align="left"><a href="qReviewsHitUpdate.do?idx=<%=vo.getIdx()%>
								&page=<%=currentPage%>&type=<%=type%>&typeView=view">
								<%=vo.getReview_title()%></a></td>
								<td><%=nameList.get(nCount)%></td>
								<td><%=vo.getReviews_read()%></td>
							</tr>
							<%nCount++;
							}
						}
						%>
			<tr>
				<td colspan="5" class="hr" align="center">
					<%
					if(type.equals("list"))
					{
						if(searchWord == null)
						{
							if(currentPage<=1)
							{
									out.print("");
							}
							else
							{
									out.print("<a href=./qReviewsLists.do?page="+(currentPage-1)+
											"&products_idx="+products_idx+
											"&type="+type+
											">");
									out.print(" [이전] </a>");
							}
							for(int i=startPage;i<=endPage;i++)
							{
								if(i==currentPage)
								{
									out.print(" ["+i+"] ");
								}
								else
								{					
									out.print("<a href=./qReviewsLists.do?page="+i+
											"&products_idx="+products_idx+
											"&type="+type+
											"> ");
									out.print(i+" </a>");
								}
							}
							if(currentPage>=totalPages)
							{
									out.print("");
							}
							else
							{
									out.print("<a href=./qReviewsLists.do?page="+(currentPage+1)+
											"&products_idx="+products_idx+
											"&type="+type+
											">");
									out.print(" [다음] </a>");
							}
						}
						else
						{
							if(currentPage<=1)
							{
								out.print("");
							}
							else
							{
								out.print("<a href=./qReviewsSearch.do?page="+(currentPage-1)+
										"&searchCondition="+searchCondition+
										"&searchWord="+searchWord+
										"&products_idx="+products_idx+
										"&type="+type+
										">");
								out.print(" [이전] </a>");
							}
							for(int i=startPage;i<=endPage;i++)
							{
								if(i==currentPage)
								{
									out.print(" ["+i+"] ");
								}
								else
								{					
									out.print("<a href=./qReviewsSearch.do?page="+i+
											"&searchCondition="+searchCondition+
											"&searchWord="+searchWord+
											"&products_idx="+products_idx+
											"&type="+type+
											"> ");
									out.print(i+" </a>");
								}
							}
							if(currentPage>=totalPages)
							{
									out.print("");
							}
							else
							{
									out.print("<a href=./qReviewsSearch.do?page="+(currentPage+1)+
											"&searchCondition="+searchCondition+
											"&searchWord="+searchWord+
											"&products_idx="+products_idx+
											"&type="+type+
											">");
									out.print(" [다음] </a>");
							}
						}
					}
					else if(type.equals("myList"))
					{
						if(searchWord == null)
						{
							if(currentPage<=1)
							{
									out.print("");
							}
							else
							{
									out.print("<a href=./qReviewsLists.do?page="+(currentPage-1)+
											"&products_idx="+products_idx+
											"&customers_idx="+customers_idx+
											"&type="+type+
											">");
									out.print(" [이전] </a>");
							}
							for(int i=startPage;i<=endPage;i++)
							{
								if(i==currentPage)
								{
									out.print(" ["+i+"] ");
								}
								else
								{					
									out.print("<a href=./qReviewsLists.do?page="+i+
											"&products_idx="+products_idx+
											"&customers_idx="+customers_idx+
											"&type="+type+
											"> ");
									out.print(i+" </a>");
								}
							}
							if(currentPage>=totalPages)
							{
									out.print("");
							}
							else
							{
									out.print("<a href=./qReviewsLists.do?page="+(currentPage+1)+
											"&products_idx="+products_idx+
											"&customers_idx="+customers_idx+
											"&type="+type+
											">");
									out.print(" [다음] </a>");
							}
						}
						else
						{
							if(currentPage<=1)
							{
								out.print("");
							}
							else
							{
								out.print("<a href=./qReviewsSearch.do?page="+(currentPage-1)+
										"&searchCondition="+searchCondition+
										"&searchWord="+searchWord+
										"&products_idx="+products_idx+
										"&customers_idx="+customers_idx+
										"&type="+type+
										">");
								out.print(" [이전] </a>");
							}
							for(int i=startPage;i<=endPage;i++)
							{
								if(i==currentPage)
								{
									out.print(" ["+i+"] ");
								}
								else
								{					
									out.print("<a href=./qReviewsSearch.do?page="+i+
											"&searchCondition="+searchCondition+
											"&searchWord="+searchWord+
											"&products_idx="+products_idx+
											"&customers_idx="+customers_idx+
											"&type="+type+
											"> ");
									out.print(i+" </a>");
								}
							}
							if(currentPage>=totalPages)
							{
									out.print("");
							}
							else
							{
									out.print("<a href=./qReviewsSearch.do?page="+(currentPage+1)+
											"&searchCondition="+searchCondition+
											"&searchWord="+searchWord+
											"&products_idx="+products_idx+
											"&customers_idx="+customers_idx+
											"&type="+type+
											">");
									out.print(" [다음] </a>");
							}
						}
					}
					else
					{
						%>
						<a href="qReviewsLists.do?customers_idx=<%=customers_idx %>&type=myList" target="_top">
						<input type="button" class="btn" value="더보기"></a>
						<%
					}
					
					%>
				</td>
			</tr>
			</table>
			<%
			if(!type.equals("myPage"))
			{
			%>
			<table	class="table">
						<tr>
							<td colspan="5" class="" align="center">
								<form action="qReviewsSearch.do?products_idx=<%=products_idx %>&type=<%=type%>"
								method="post" name="searchform">
									<select class="btn" name="searchCondition">
										<option value="customers_idx"
										<%if(searchCondition!=null && searchCondition.equals("customers_idx")){%>
										selected<%}%>>작성자</option>
										<option value="review_title"
										<%if(searchCondition!=null && searchCondition.equals("review_title")){%>
										selected<%}%>>제목</option>
										<option value="review_text"
										<%if(searchCondition!=null && searchCondition.equals("review_text")){%>
										selected<%}%>>글내용</option>
									</select>
									<input type="text" class="" size="15" name="searchWord" required="required"/>
									<input type="button" class="btn" value="검색" onclick="search()">
								</form>
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td colspan="4">
							</td>
							<%
							if(type.equals("list") )
							{%>
							<td align="right">
								<%if(session.getAttribute("loggedInUserVO")!=null){
							%>
							<a href="./review/ReviewsWrite.jsp?page=<%=currentPage%>
							&products_idx=<%=products_idx %>
							&type=<%=type%>
							&typeView=insert">
							 <input type="button" class="btn" value="글쓰기"> </a>
							<%} %>
							<a href="index.do"> 
							<input type="button" class="btn" value="메인으로"> </a>
							</td>
							<%
							}
							else if(type.equals("myList"))
							{
							%>
							<td align="right">
							<a href="./member/mypage.jsp">
							<input type="button" class="btn" value="마이페이지"></a>
							</td>
							<%} %>
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