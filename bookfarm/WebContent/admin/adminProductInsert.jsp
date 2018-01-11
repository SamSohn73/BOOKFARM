<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	String current_page 			=	request.getParameter("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

</head>
<body>
	<form action="../adminProductInsert.do" method="post" enctype="multipart/form-data">	
		<table>
			<caption>상품 등록</caption>
			<tr>
				<td class="td_left"><label for="category_idx">카테고리</label></td>					
				<td class="td_right">
					<input type="text" name="category_idx" size="50" maxlength='100' required="required">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="products_quantity">수 량</label></td>					
				<td class="td_right">
					<input type="text" name="product_quantity">
				</td>
			</tr>			
			<tr>
				<td class="td_left"><label for="product_name">책 이름</label></td>					
				<td class="td_right">
					<input type="text" name="product_name" size="10" maxlength='10' required="required">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="product_image">이미지</label></td>	
				<td class="td_right">
					<input type="file" name="product_image" id="product_image">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="product_price">가격</label></td>					
				<td class="td_right">
					<input type="text" name="product_price">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="product_desc">설명</label></td>					
				<td class="td_right">
					<textarea name='product_desc' cols='60' rows='15' required="required"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan='2'>
				<input type='submit' value="등록">
				<input type='button' value="취소"  onclick="javascript:history.back();">
				<input type="hidden" name="page" value=<%=current_page %>>
				</td>
			</tr>
		</table>		
	</form>
</body>
</html>




