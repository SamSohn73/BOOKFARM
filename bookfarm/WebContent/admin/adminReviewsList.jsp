<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		//CustomerVO	userVO		=	(CustomerVO)session.getAttribute("adminVO");
		Vector<ReviewVO> list	=	(Vector<ReviewVO>)request.getAttribute("list");
		PageVO	info			=	(PageVO)request.getAttribute("info");
		Vector<CategoryVO> catVo1=	(Vector<CategoryVO>)request.getAttribute("catVo1");
		Vector<CategoryVO> catVo2=	(Vector<CategoryVO>)request.getAttribute("catVo2");
		Vector<ProductVO> VpVo	=	(Vector<ProductVO>)request.getAttribute("VpVo");
		Vector<String>nameList	=	(Vector<String>)request.getAttribute("nameList");
		int		totalPages		=	info.getTotalPages();
		int		currentPage		=	info.getPage();
		int		startPage		=	info.getStartPage();
		int		endPage			=	info.getEndPage();
		int		totalRows		=	info.getTotalRows();
		
		
		/* CustomerDAO cDao		=	new CustomerDAO(); */
		String	searchCondition	=	(String)request.getAttribute("searchCondition");
		String	searchWord		=	(String)request.getAttribute("searchWord");
		
		
		int		products_idx	=	0;
		int		category_idx	=	0;
		int		parent_idx		=	0;
			if(request.getParameter("products_idx")!=null)	
				products_idx	=	Integer.parseInt((String)request.getParameter("products_idx"));
			if(request.getParameter("category_idx")!=null)	
				category_idx	=	Integer.parseInt((String)request.getParameter("category_idx"));
			if(request.getParameter("parent_idx")!=null)	
				parent_idx		=	Integer.parseInt((String)request.getParameter("parent_idx"));
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
		function selFuc1(obj)
		{
			obj.form.submit();
		}
		function selFuc2(obj)
		{
			obj.form.submit();
		}
		function selFuc3(obj)
		{
			obj.form.submit();
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
		<div class="col-lg-9" align="center">
		<h2 class="my-4">리뷰게시판	</h2>		
		<table	class="table">
			<tr>
				<td class="bg-light">
					<form action="adminReviewsList.do" method="post" name=catForm>
						<select class="btn" onchange="selFuc1(this)" name="parent_idx">
							<option value="0">전체</option>
						<% for(CategoryVO cat_Vo1 :catVo1){ %>
							<option value="<%=cat_Vo1.getIdx()%>"
							<%if(parent_idx==cat_Vo1.getIdx()){%> selected<%}%>>
							<%= cat_Vo1.getCategory_name()%></option>
							<%} %>
						</select>
						<%if(parent_idx!=0){ %>
						<select class="btn" onchange="selFuc2(this)" name="category_idx">
							<option value="0">전체</option>
						<% for(CategoryVO cat_Vo2 :catVo2){ %>
							<option value="<%=cat_Vo2.getIdx()%>"
							<%if(category_idx==cat_Vo2.getIdx()){%> selected<%}%>>
							<%= cat_Vo2.getCategory_name()%></option>
							<%} %>
						</select>
						<%}
						  if(category_idx!=0 && parent_idx!=0){%>
						<select class="btn" onchange="selFuc3(this)" name="products_idx">
							<option value="0">전체</option>
						<% for(ProductVO pVo :VpVo){ %>
							<option value="<%=pVo.getIdx()%>"
							<%if(products_idx==pVo.getIdx()){%> selected<%}%>>
							<%= pVo.getProduct_name()%></option>
							<%} %>
						</select>
						<%} %>
					</form>
				</td>
				</tr>
				<tr align="center">
				<td class="bg-light">
					<form action="adminReviewsSearch.do?page=<%=currentPage%>&products_idx=<%=products_idx %>
					&parent_idx=<%=parent_idx %>&category_idx=<%=category_idx %>"
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
						<input type="text" class="btn" size="10" name="searchWord" required="required"
						<%if(searchWord!=null){%> value="<%=searchWord%>"<%}%>/>
						<input type="button" class="btn" value="검색" onclick="search()">
					</form>
				</td>
			</tr>
		</table>	
		<table class="table">
			<tr class="table-secondary">
				<th >날짜</th>
				<th >제목</th>
				<th >작성자</th>
				<th >조회수</th>
			</tr>
			<%int nCount=0;
			for(ReviewVO vo:list)
				{%>
				<tr class="bg-light">
					<td><%=vo.getDate_added()%></td>
					<td align="left"><a href="adminReviewsView.do?idx=<%=vo.getIdx()%>
					&page=<%=currentPage%>&p=<%=products_idx%>&par=<%=parent_idx%>
					&cat=<%=category_idx%>&con=<%=searchCondition%>&word=<%=searchWord%>">
					<%=vo.getReview_title()%></a></td>
					<td><%=nameList.get(nCount)%></td>
					<td><%=vo.getReviews_read()%></td>
				</tr>
				<%nCount++;}%>
				<tr>
				<td colspan="4" align="center">
				<%	if(searchWord == null)
					{
						if(currentPage<=1)
						{
								out.print("");
						}
						else
						{
								out.print("<a href=./adminReviewsList.do?page="+(currentPage-1)+
										"&products_idx="+products_idx
										+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
								out.print("[이전]</a>");
						}
						for(int i=startPage;i<=endPage;i++)
						{
							if(i==currentPage)
							{
								out.print("["+i+"]");
							}
							else
							{					
								out.print("<a href=./adminReviewsList.do?page="+i+
										"&products_idx="+products_idx
										+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
								out.print(i+"</a>");
							}
						}
						if(currentPage>=totalPages)
						{
								out.print("");
						}
						else
						{
								out.print("<a href=./adminReviewsList.do?page="+(currentPage+1)+
										"&products_idx="+products_idx
										+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
								out.print("[다음]</a>");
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
							out.print("<a href=./adminReviewsSearch.do?page="+(currentPage-1)+
									"&searchCondition="+searchCondition+
									"&searchWord="+searchWord+
									"&products_idx="+products_idx
									+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
							out.print("[이전]</a>");
						}
						for(int i=startPage;i<=endPage;i++)
						{
							if(i==currentPage)
							{
								out.print("["+i+"]");
							}
							else
							{					
								out.print("<a href=./adminReviewsSearch.do?page="+i+
										"&searchCondition="+searchCondition+
										"&searchWord="+searchWord+
										"&products_idx="+products_idx
										+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
								out.print(i+"</a>");
							}
						}
						if(currentPage>=totalPages)
						{
								out.print("");
						}
						else
						{
								out.print("<a href=./adminReviewsSearch.do?page="+(currentPage+1)+
										"&searchCondition="+searchCondition+
										"&searchWord="+searchWord+
										"&products_idx="+products_idx
										+"&parent_idx="+parent_idx+"&category_idx="+category_idx+">");
								out.print("[다음]</a>");
						}
					}%>
				</td>
			</tr>
			<tr align="right">
				<td align="right" colspan="4">
				<a href="adminReviewsWrite.do?page=<%=currentPage%>
				&products_idx=<%=products_idx %>&parent_idx=<%=parent_idx %>
				&category_idx=<%=category_idx %>">
				<input type='button' class="btn" value='글쓰기'></a>
				<a href="./admin/adminLogin.jsp">
				<input type='button' class="btn" value='메인으로'></a>
				</td>
			</tr>
		</table>
		<br>
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
		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>