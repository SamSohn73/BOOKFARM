<%@page import="gq.bookfarm.vo.CategoryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<ProductVO>	products	= (Vector<ProductVO>) request.getAttribute("products");
	Vector<CategoryVO>	categories	= (Vector<CategoryVO>) session.getAttribute("categories");
	
	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage	= pageInfo.getPage();
	int startPage	= pageInfo.getStartPage();
	int endPage		= pageInfo.getEndPage();
	int totalRows	= pageInfo.getTotalRows();
	int totalPages	= pageInfo.getTotalPages();
	
	log.debug("productList.jsp criteria="		+ criteria);
	log.debug("productList.jsp searchWord="		+ searchWord);
	log.debug("productList.jsp currentPage="	+ currentPage);
	log.debug("productList.jsp startPage="		+ startPage);
	log.debug("productList.jsp endPage="		+ endPage);
	log.debug("productList.jsp totalRows="		+ totalRows);
	log.debug("productList.jsp totalPages="		+ totalPages);
%>
<!DOCTYPE>
<html>
<head>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 목록</title>
</head>
<body>
	<table>
		<caption>상품 목록</caption>
		<tr>
			<th>No.</th>
			<th>카테고리</th>
			<th>이미지</th>
			<th>제목</th>
			<th>가격</th>
			<th>재고수량</th>
		</tr>
<%	
	int idNum = totalRows - (currentPage-1)*10;
	for(ProductVO product: products) {	%>
		<tr>
			<td><%=idNum%></td><!--   -->
			<td><%=product.getCategory_idx()%></td>
			<td><a href = "productView.do?idx=<%=product.getIdx()%>&page=<%=currentPage%>&cri=<%=criteria%>&word=<%=searchWord%>"><img src="<%=product.getProduct_image()%>"></a></td>
			<td><a href = "productView.do?idx=<%=product.getIdx()%>&page=<%=currentPage%>&cri=<%=criteria%>&word=<%=searchWord%>"><%=product.getProduct_name()%></a></td>
			<td><%=product.getProduct_price()%></td>
			<td><%=product.getProduct_quantity()%></td>
		</tr>
<%		idNum--;
	} %>
		<tr>
		<td colspan = "17">
			<%//[prev] display
				if (currentPage > 1) {
					out.print("<a href=productList.do?page=" + (currentPage-1) + ">");
					out.print("[prev] </a>");
				}
			%>
			<%//page numbers display
				for (int i = startPage; i <= endPage; i++) {
					if (i == currentPage) {
						out.print("[" +  i + "] ");
					} else {
						out.print("<a href=productList.do?page=" + i +">");
						out.print(i + " </a>");
					}
				}
			%>
			<%//[next] display
				if (currentPage <= endPage && currentPage < totalPages) {
					out.print("<a href=productList.do?page=" + (currentPage + 1) + ">");
					out.print(" [next]</a>");
				}
			%>
		</td>
	</tr>
	</table>

	<table>
		<tr>
			<td class="td_align">
				<form action='productSearch.do' method='post' name='searchform'>
					<select name='criteria'>
						<option value='product_category_idx'	<%if(criteria.equals("category_idx"))	out.print("selected");%>>카테고리</option>
						<option value='product_name'			<%if(criteria.equals("product_name"))	out.print("selected");%>>제목</option>
						<option value='product_price'			<%if(criteria.equals("product_price"))	out.print("selected");%>>가격</option>
						<option value='product_quantity'		<%if(criteria.equals("product_quantity"))out.print("selected");%>>재고수량</option>
						<option value='product_desc'			<%if(criteria.equals("product_desc"))	out.print("selected");%>>내용</option>
					</select>
					<input type='text' name='searchWord' value="<%=searchWord%>">
					<input type='button' value='검색' onclick="search()">
				</form>
			</td>
		</tr>
	</table>
	
	<h3><a href="index.do">처음으로</a></h3> 
</body>
</html>
