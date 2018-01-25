<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.dao.ReviewDAO" %>
<%@ page import="gq.bookfarm.dao.CustomerDAO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="gq.bookfarm.vo.AdminVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%	
	int			current_page	=	Integer.parseInt(request.getParameter("page"));
	int			parent_idx		=	Integer.parseInt(request.getParameter("parent_idx"));
	int			category_idx	=	Integer.parseInt(request.getParameter("category_idx"));
	int			products_idx	=	Integer.parseInt(request.getParameter("products_idx"));
	Vector<CategoryVO> catVo1=	(Vector<CategoryVO>)request.getAttribute("catVo1");
	Vector<CategoryVO> catVo2=	(Vector<CategoryVO>)request.getAttribute("catVo2");
	Vector<ProductVO> VpVo	=	(Vector<ProductVO>)request.getAttribute("VpVo");

	HttpSession	sess			=	request.getSession();
	AdminVO		adminVO			=	(AdminVO) session.getAttribute("adminVO");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="Online Bookstore Bookfarm">
		<meta name="author" content="BookFarmer">
		<link rel="shortcut icon" href="../favicon.ico">
		
<title>리뷰 등록</title>
<script>
	function returnList(){
		location.href="./adminReviewsList.do";
	}
	function selFuc(obj)
	{
		obj.form.submit();
	}
</script>
</head>
<body>
		<form action="./adminReviewsWrite.do?page=<%=current_page %>" method="post" name=catForm>
						<select class="btn" onchange="selFuc(this)" name="parent_idx">
							<option value="0">전체</option>
						<% for(CategoryVO cat_Vo1 :catVo1){ %>
							<option value="<%=cat_Vo1.getIdx()%>"
							<%if(parent_idx==cat_Vo1.getIdx()){%> selected<%}%>>
							<%= cat_Vo1.getCategory_name()%></option>
							<%} %>
						</select>
						<%if(parent_idx!=0){ %>
						<select class="btn" onchange="selFuc(this)" name="category_idx">
							<option value="0">전체</option>
						<% for(CategoryVO cat_Vo2 :catVo2){ %>
							<option value="<%=cat_Vo2.getIdx()%>"
							<%if(category_idx==cat_Vo2.getIdx()){%> selected<%}%>>
							<%= cat_Vo2.getCategory_name()%></option>
							<%} %>
						</select>
						<%} 
						  if(category_idx!=0){%>
						<select class="btn" onchange="selFuc(this)" name="products_idx">
							<option value="0">전체</option>
						<% for(ProductVO pVo :VpVo){ %>
							<option value="<%=pVo.getIdx()%>"
							<%if(products_idx==pVo.getIdx()){%> selected<%}%>>
							<%= pVo.getProduct_name()%></option>
							<%} %>
						</select>
						<%} %>
		</form>
<form action="./adminReviewsInsert.do" method="post">
<table>
		<caption>리뷰 등록</caption>
	<tr>
		
	</tr>
	<tr>
		<td class="left">글쓴이</td>
		<td class="right"><input type="text" name="review_writer" size="15" required="required"
		readonly="readonly"value=<%=adminVO.getUser_name() %>></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		placeholder="리뷰 제목"></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		placeholder="리뷰 내용"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="btn_align">
		<input class="btn" type="submit" value="등록">
		<input class="btn" type="button" value="취소" onclick="javascript:history.back()">
		<input class="btn" type="button" value="목록보기"onclick="returnList()">
		</td>
	</tr>
</table>
<input type="hidden" name="page" value="<%=current_page %>">
<input type="hidden" name="parent_idx" value="<%=parent_idx %>">
<input type="hidden" name="category_idx" value="<%=category_idx %>">
<input type="hidden" name="products_idx" value="<%=products_idx %>">
</form>
</body>
</html>