<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>
<% 	 		
	ProductVO		product			=		(ProductVO)request.getAttribute("vo");	
	String			current_page 		=		request.getParameter("page");
%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>	
	function modify_list(){
		location.href="adminProductModify.do?idx=<%=product.getIdx()%>&page=<%=current_page%>";
	}
	function delete_list(){
		location.href="adminProductDelete.do?idx=<%=product.getIdx()%>&page=<%=current_page%>";
	}
</script>
</head>
<table>
	<caption>상품 보기</caption>
		<tr>
			<td class="td_left">번 호</td>					
			<td class="td_right">
			<input type='text' name='idx' size="64" readonly value="<%=product.getIdx() %>">								
			</td>
		</tr>
		<tr>
			<td class="td_left">category_idx</td>					
			<td class="td_right">
			<input type='text' name='category_idx' size="64" value="<%=product.getCategory_idx() %>">						
			</td>
		</tr>
		<tr>
			<td class="td_left">product_name</td>					
			<td class="td_right">
			<input type='text' name='product_name' size="64" value="<%=product.getProduct_name() %>">						
			</td>
		</tr>
		<tr>
			<td class="td_left">product_image</td>					
			<td class="file_td">
			<%
			String fileName=product.getProduct_image();
			
			if(fileName!=null){
				fileName=new String(fileName.getBytes(),"UTF-8");
			%>
				<%=fileName%></a>
			<%}else{%><!-- 처음 입력시 파일을 안 넣었다면 수정하는 부분에서만 넣는 것 허용 -->
				<input type="file" name="board_file">
			<%} %>
			</td>				
		</tr>
		<tr>
			<td class="td_left">product_quantity</td>					
			<td class="td_right">
				<input type='text' name='product_name' size="64" value="<%=product.getProduct_quantity() %>">
			</td>
		</tr>
		<tr>
			<td class="td_left">product_price</td>					
			<td class="td_right">
				<input type='text' name='product_price' size="64" value="<%=product.getProduct_price() %>">
			</td>
		</tr>
		<tr>
			<td class="td_left">product_desc</td>					
			<td class="td_right">
				<textarea name='product_desc' cols='65' rows='15' ><%=product.getProduct_desc() %></textarea>
			</td>
		</tr>
		<tr class="button_cell">
			<td colspan='2'>
			<input type='submit' value="수정" onClick="modify_list()"> 
			<input type="button" value="삭제" onClick="delete_list()">
			<input type="button" value="목록" onClick="javascript:history.go(-1);">			
			</td>
		</tr>
	</table>	
</html>