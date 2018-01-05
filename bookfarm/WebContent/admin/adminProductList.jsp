<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table class="top_table">
	<caption>상품 목록</caption>
	<tr class="tr_title">
		<th>번호</th>
		<th>카테고리</th>
		<th>수량</th>
		<th>이미지</th>
		<th>가격</th>
	</tr>	
<%
	//검색에서 넘어온 경우
	/* String criteria = (String)request.getAttribute("criteria");
	String searchword = (String)request.getAttribute("searchword");
	
	
	
	Vector<BoardVO> list=(Vector<BoardVO>)request.getAttribute("list");
	페이지 나누기를 위한 정보
	PageVO info = (PageVO)request.getAttribute("info");
	int total_page = info.getTotalPage();
	int current_page = info.getPage();
	int endPage = info.getEndPage();
	int startPage = info.getStartPage();
	int totalRows = info.getTotalRows();
	
	//글 번호 다시 매기기
	int id_num = totalRows-(current_page-1)*10;
	
	
	for(BoardVO i:list){ */
%>
	<tr class="tr_top">
		<%-- <td class="td_align"><%=i.getBoard_num() %></td>--%>
		<td class = "td_align"><%-- <%=id_num %> --%></td>				
		<td>
			<%
				/* if(i.getBoard_re_lev() != 0){
					for(int j = 0; j <= i.getBoard_re_lev()*1;j++){
						out.print("&nbsp;");
					}
				} */
			%>
			<%--제목에 현재 board_num이 몇 번인지 링크 걸기 --%>					
			<%-- <a href="qHitUpdate.do?board_num=<%=i.getBoard_num()%>&page=<%=current_page%>">
			<%=i.getBoard_subject()%></a>			
		</td>
		<td class="td_align"><%=i.getBoard_name() %></td>
		<td class="td_align"><%=i.getBoard_date() %></td>
		<td class="td_align"><%=i.getBoard_readcount() %></td>
	</tr> --%>
<%/* }
	id_num--; */
	%>	
	<tr>
		<td colspan = "5">
			<%
			/* if(searchword == null){
				
				//[이전] 나오게 하기
				if(current_page <= 1){
					out.print("[이전]");
				}else{
					out.print("<a href = qList.do?page="+(current_page-1)+">");
					out.print("[이전]</a>");
				}
				
				for(int i = startPage; i <= endPage; i++){
					if(i == current_page){
						out.print("["+i+"]");
					}else{
						out.print("<a href = qList.do?page="+i+">");
						out.print(i+"</a>");
					}
				}
				
				//[이후] 나오게 하기
				if(current_page <= total_page){
					out.print("[다음]");
				}else{
					out.print("<a href = qList.do?page="+(current_page+1)+">");
					out.print("[다음]</a>");
				}
			}else{
				//[이전] 나오게 하기
				if(current_page <= 1){
					out.print("[이전]");
				}else{
					out.print("<a href = qSearch.do?page="+(current_page-1)+"&criteria="+criteria+"&searchword="+searchword+">");
					out.print("[이전]</a>");
				}
				
				for(int i = startPage; i <= endPage; i++){
					if(i == current_page){
						out.print("["+i+"]");
					}else{
						out.print("<a href = qSearch.do?page="+i+"&criteria="+criteria+"&searchword="+searchword+">");
						out.print(i+"</a>");
					}
				}
				
				//[이후] 나오게 하기
				if(current_page <= total_page){
					out.print("[다음]");
				}else{
					out.print("<a href = qSearch.do?page="+(current_page+1)+"&criteria="+criteria+"&searchword="+searchword+">");
					out.print("[다음]</a>");
				}
			} */
			%>
	</tr>
</table>
<table class="bottom_table">
	<tr>
		<td class="td_align">
			<form action='#' method='post' name='searchform'>
				<select name='criteria'>
					<option value='category_idx'>카테고리</option>
					<option value='product_name'>상품명</option>
				</select>
				<input type='text' name='searchword'>
				<input type='button' value='검색' onclick="search()">		
				<input type='hidden' name="page" value="#">				
			</form>
		</td>
		<td align='right'><a href="#">[상품 등록]</a></td>
	</tr>
</table>
</body>
</html>