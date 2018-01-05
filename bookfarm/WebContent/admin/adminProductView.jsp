<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"	import = "adminVO.ProductVO"%>
<% 	 		
	ProductVO vo=(ProductVO)request.getAttribute("vo");	
	String current_page = (String)request.getAttribute("page");
%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>	
	function list_submit(){
		location.href="qList.do?page=<%=current_page%>";
	}
	function modify_list(){
		location.href="qModify.do?idx=<%=vo.getIdx()%>&page=<%=current_page%>";
	}
	function delete_list(){
		location.href="idx=<%=vo.getIdx()%>&page=<%=current_page%>";
	}
</script>
</head>
<table>
	<caption>상품 보기</caption>
		<tr>
			<td class="td_left">번 호</td>					
			<td class="td_right">
			<input type='text' name='idx' size="64" readonly value="#">								
			</td>
		</tr>
		<tr>
			<td class="td_left">category_idx</td>					
			<td class="td_right">
			<input type='text' name='category_idx' size="64" value="#"
			readonly>						
			</td>
		</tr>
		<tr>
			<td class="td_left">product_name</td>					
			<td class="td_right">
			<input type='text' name='product_name' size="64" value="#"
			readonly>						
			</td>
		</tr>
		<tr>
			<td class="td_left">products_image</td>					
			<td class="file_td">
			<%-- <%
			String fileName=vo.getBoard_file();
			
			if(fileName!=null){
				fileName=new String(fileName.getBytes(),"UTF-8");
			%>
				<a href = "board/file_down.jsp?file_name=<%=fileName %>">
				<%=fileName%></a>
			<%}%> --%><!-- 처음 입력시 파일을 안 넣었다면 수정하는 부분에서만 넣는 것 허용 -->
			</td>			
		</tr>
		<tr>
			<td class="td_left">product_quantity</td>					
			<td class="td_right">
				<textarea name='product_quantity' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">products_price</td>					
			<td class="td_right">
				<textarea name='products_price' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">product_desc</td>					
			<td class="td_right">
				<textarea name='product_desc' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr class="button_cell">
			<td colspan='2'>
			<input type='button' value="수정" onClick="modify_list()"> 
			<input type="button" value="삭제" onClick="delete_list()">
			<input type="button" value="목록" onClick="list_submit()">			
			</td>
		</tr>
	</table>	
</html>