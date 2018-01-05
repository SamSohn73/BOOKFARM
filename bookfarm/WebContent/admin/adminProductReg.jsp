<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%-- <%
	//qna_board_list.jsp에서 보던 페이지 가져오기
	String current_page = request.getParameter("page");
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script>
	<%-- function curr_list(){
		location.href="../qList.do?page=<%=current_page%>";
	} --%>
</script>
</head>
<body>
	<form action="../qRegist.do" method="post" 
		enctype="multipart/form-data">	
		<table>
			<caption>상품 등록</caption>
			<tr>
				<td class="td_left"><label for="categories">카테고리</label></td>					
				<td class="td_right">
					<input type="text" name="categories" size="50" maxlength='100' required="required">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="products_quantity">수 량</label></td>					
				<td class="td_right">
					<input type="text" name="products_quantity">
				</td>
			</tr>			
			<tr>
				<td class="td_left"><label for="products_model">모델</label></td>					
				<td class="td_right">
					<input type="text" name="products_model" size="10" maxlength='10' required="required">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="products_image">이미지</label></td>	
				<td class="td_right">
					<input type="file" name="products_image">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="products_price">가격</label></td>					
				<td class="td_right">
					<input type="text" name="products_price">
				</td>
			</tr>
			<tr>
				<td class="td_left"><label for="getProduct_desc">설명</label></td>					
				<td class="td_right">
					<textarea name='getProduct_desc' cols='60' rows='15' required="required"></textarea>
				</td>
			</tr>
			<tr class="commandCell">
				<td colspan='2'><!-- <input type='button' value="등록" onClick="check(this.form)"> -->
				<input type='submit' value="등록">
				<input type='button' value="취소"  onclick="javascript:history.back();"> 
				<input type="button" value="상품보기" >
				</td>
			</tr>
		</table>		
	</form>
</body>
</html>




