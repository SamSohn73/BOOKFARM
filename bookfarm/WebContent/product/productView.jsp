<%@page import="gq.bookfarm.vo.CategoryVO"%>
<%@page import="java.util.Vector"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<% 	 		
	int				current_page		= 1;
		if(request.getParameter("page")!=null)
					current_page		= Integer.parseInt(request.getParameter("page"));
		else
					current_page		= 1;
	ProductVO			productVO		= (ProductVO)request.getAttribute("productVO");
	Vector<CategoryVO>	categories		= (Vector<CategoryVO>) session.getAttribute("categories");
	String criteria			= request.getParameter("cri");
	String searchWord		= request.getParameter("word");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 보기</title>
<script>	
	function list_submit(){
		//location.href="productList.do";
		productForm.action = "productSearch.do?criteria=<%=criteria%>&searchWord=<%=searchWord%>";
		productForm.submit();
	}
	function buy_submit(){
		<%-- productForm.action = "productBuy.do?idx=<%=productVO.getIdx()%>"; --%>
		productForm.action = "productSearch.do?criteria=<%=criteria%>&searchWord=<%=searchWord%>";
		productForm.submit();
	}
	function basket_submit(){
		productForm.action = "basketAdd.do";
		productForm.submit();
	}
	function review_submit(){
		productForm.action = "qReviewsLists.do?type=list&products_idx=<%=productVO.getIdx() %>";
		productForm.submit();
	}
	function main_submit(){
		productForm.action = "index.do";
		productForm.submit();
	}
</script>
</head>
<body>
	<form method = "post"  name='productForm'>
		<table>
		<caption>상품 보기</caption>
			<tr>
				<td class="td_left">카테고리</td>
				<td class="td_right">
					<%=productVO.getCategory_idx()%>
				</td>
			</tr>
			<tr>
				<td class="td_left">제 목</td>
				<td class="td_right">
					<%=productVO.getProduct_name()%>
				</td>
			</tr>
			<tr>
				<td class="td_left">이미지</td>
				<td class="td_right">
					<img src="<%=productVO.getProduct_image()%>">
				</td>
			</tr>
			<tr>
				<td class="td_left">상품 소개</td>
				<td class="td_right">
					<textarea name='contents' cols='65' rows='15' readonly><%=productVO.getProduct_desc()%>
				</textarea>
				</td>
			</tr>
			<tr>
				<td class="td_left">가격</td>
				<td class="td_right">
					<%=productVO.getProduct_price()%>
				</td>
			</tr>
			<tr>
				<td class="td_left">수량</td>
				<td class="td_right">
					<select name='quantity'>
						<option value="1" selected >1</option>
						<option value="2" >2</option>
						<option value="3" >3</option>
						<option value="4" >4</option>
						<option value="5" >5</option>
					</select>
				</td>
			</tr>
			
			<tr class="button_cell">
				<td colspan='2'>
				<input type="button" value="즉시구매" onClick="buy_submit()">
				<input type="button" value="장바구니" onClick="basket_submit()">
				<input type="button" value="목록" onClick="list_submit()">
				<input type="hidden" name="page" value=<%=current_page %>>
				<input type="button" value="리뷰보기" onClick="review_submit()">
				<input type="button" value="메인으로" onClick="main_submit()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>


