<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.AdminVO"%>
<%@page import="gq.bookfarm.vo.CategoryVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<CategoryVO>	categories	= (Vector<CategoryVO>) request.getAttribute("categories");
	//request.setAttribute("categories", categories);
	String criteria			= request.getParameter("criteria");
	String searchWord		= request.getParameter("searchWord");
	
	if (criteria == null)	criteria	= "";
	if (searchWord == null)	searchWord	= "";
	
	int currentPage	= pageInfo.getPage();
	int startPage	= pageInfo.getStartPage();
	int endPage		= pageInfo.getEndPage();
	int totalRows	= pageInfo.getTotalRows();
	int totalPages	= pageInfo.getTotalPages();
	
	log.debug("adminCustomerList.jsp criteria="		+ criteria);
	log.debug("adminCustomerList.jsp searchWord="	+ searchWord);
	log.debug("adminCustomerList.jsp currentPage="	+ currentPage);
	log.debug("adminCustomerList.jsp startPage="	+ startPage);
	log.debug("adminCustomerList.jsp endPage="		+ endPage);
	log.debug("adminCustomerList.jsp totalRows="	+ totalRows);
	log.debug("adminCustomerList.jsp totalPages="	+ totalPages);
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
<title>카테고리 관리</title>
</head>
<body>
	<table>
		<caption>카테고리 목록</caption>
		<tr>
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
			<td><%=category.getParent_idx()%></td>
			<td><%=category.getIdx()%></td>
			<td><%=category.getCategory_name()%></td>
		</tr>
<%		idNum--;
	} %>
		<tr>
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
					out.print("<a href=../adminCategoryList.do?page=" + (currentPage + 1) + ">");
					out.print(" [next]</a>");
				}
			%>
		</td>
	</tr>
	</table>
	<table>
		<tr>
			<td class="td_align">
				<form action='AdminCategorySearch.do' method='post' name='searchform'>
					<select name='criteria'>
						<option value='idx'				<%if(criteria.equals("idx"))			out.print("selected");%>>인덱스</option>
						<option value='parent_idx'		<%if(criteria.equals("parent_idx"))		out.print("selected");%>>부모인덱스</option>
						<option value='category_name'	<%if(criteria.equals("category_name"))	out.print("selected");%>>카테고리명</option>
					</select>
					<input type='text' name='searchWord' value="<%=searchWord%>">
					<input type='button' value='검색' onclick="search()">						
				</form>
			</td>
			<td align='right'><a href="adminCategoryAddView.do?page=<%=currentPage%>">[카테고리 추가]</a></td>
		</tr>	
	</table>
	<h2><a href="admin/adminLogin.jsp">처음으로</a></h2>
</body>
</html>