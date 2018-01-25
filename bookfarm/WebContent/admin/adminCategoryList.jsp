<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gq.bookfarm.vo.AdminVO"%>
<%@ page import="gq.bookfarm.vo.PageVO"%>
<%@ page import="gq.bookfarm.vo.CategoryVO"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	AdminVO				adminVO				= (AdminVO)session.getAttribute("adminVO"); 
	PageVO				pageInfo			= (PageVO) request.getAttribute("pageInfo");
	Vector<CategoryVO>	sessionCategories	= (Vector<CategoryVO>) session.getAttribute("categories");
	Vector<CategoryVO>	categories			= (Vector<CategoryVO>) request.getAttribute("categories");
	
	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage	= pageInfo.getPage();
	int startPage	= pageInfo.getStartPage();
	int endPage		= pageInfo.getEndPage();
	int totalRows	= pageInfo.getTotalRows();
	int totalPages	= pageInfo.getTotalPages();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
	
		<title>BOOKFARM Category List</title>
	
		<!-- Bootstrap core CSS -->
		<!--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
		<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	
		<!-- Custom styles for this template -->
		<link href="css/shop-homepage.css" rel="stylesheet">

		<script type="text/javascript">
			function search(){
				if(searchform.searchWord.value==""){
					alert('검색어를 넣으세요');
					searchform.searchWord.focus();
					return;
				}
				searchform.submit();
			}
		</script>
	</head>
	
	<body>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="index.do">Bookfarm - Admin Page</a>
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
							<a class="nav-link" href="adminCustomerList.do">고객관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminProductList.do">상품관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminOrdersList.do">주문관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminCategoryList.do">카테고리관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminReviewsList.do">리뷰관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="adminLogout.do">로그아웃</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- Page Content -->
		<div class="container">
	
			<div class="row">
	
				<div class="col-lg-3">
		
					<h1 class="my-4">책팜</h1>

				</div>
				<!-- /.col-lg-3 -->
		
		
				<div class="col-lg-9">
					<h2 class="my-4">카테고리 목록</h2>
					<table class="table">						
						<tr class="text-justify, table-secondary">
							<th>수정/삭제</th>
							<th>No.</th>
							<th>상위 카테고리</th>
							<th>카테고리 번호</th>
							<th>카테고리 이름</th>
						</tr>
				<%	
					int idNum = totalRows - (currentPage-1)*10;
					for(CategoryVO category: categories) {	%>
						<tr>
							<td>
								<a href="adminCategoryModifyView.do?idx=<%=category.getIdx()%>&page=<%=currentPage%>">
									<input type='button' value="수정">
								</a>
								<a href="adminCategoryDelete.do?idx=<%=category.getIdx()%>&page=<%=currentPage%>">
									<input type='button' value="삭제">
								</a>
							</td>
							<td><%=idNum%></td>
				<%		if (category.getParent_idx() == 0) { %>
							<td>최상위</td>
				<%		} else { %>
							<td><%=sessionCategories.get(sessionCategories.indexOf(new CategoryVO(category.getParent_idx()))).getCategory_name()%></td>
				<%		} %>
							<td><%=category.getIdx()%></td>
							<td><%=category.getCategory_name()%></td>
						</tr>
				<%		idNum--;
					} %>
						<tr align="center">
						<td colspan = "17">
							<%//[prev] display
								if (currentPage > 1) {
									out.print("<a href=adminCategoryList.do?page=" + (currentPage-1) + ">");
									out.print("[prev] </a>");
								}
							%>
							<%//page numbers display
								for (int i = startPage; i <= endPage; i++) {
									if (i == currentPage) {
										out.print("[" +  i + "] ");
									} else {
										out.print("<a href=adminCategoryList.do?page=" + i +">");
										out.print(i + " </a>");
									}
								}
							%>
							<%//[next] display
								if (currentPage <= endPage && currentPage < totalPages) {
									out.print("<a href=adminCategoryList.do?page=" + (currentPage + 1) + ">");
									out.print(" [next]</a>");
								}
							%>
						</td>
					</tr>
					</table>
					<table class="table">
						<tr align="right">
							<td align='right'><a href="adminCategoryAddView.do?page=<%=currentPage%>">
							<input type='button' class="btn" value='카테고리 추가'></a></td>
						</tr>
						<tr align="center">
							<td class="td_align" align="center">
								<form action='adminCategorySearch.do' method='post' name='searchform'>
									<select name='criteria'>
										<option value='idx'				<%if(criteria.equals("idx"))			out.print("selected");%>>인덱스</option>
										<option value='parent_idx'		<%if(criteria.equals("parent_idx"))		out.print("selected");%>>부모인덱스</option>
										<option value='category_name'	<%if(criteria.equals("category_name"))	out.print("selected");%>>카테고리명</option>
									</select>
									<input type='text' name='searchWord' value="<%=searchWord%>">
									<input type='button' class="btn" value='검색' onclick="search()">						
								</form>
							</td>							
						</tr>	
					</table>
				</div>
				<!-- /.col-lg-9 -->
		
			</div>
			<!-- /.row -->
	
		</div>
		<!-- /.container -->
	
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
	</body>
</html>
