<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.BasketVO"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	Vector<BasketVO>	baskets		= (Vector<BasketVO>) session.getAttribute("baskets");
	Vector<ProductVO>	products	= (Vector<ProductVO>) session.getAttribute("products");
	float				total		= 0;
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 목록</title>
</head>
<body>
	<table>
		<caption>장바구니 목록</caption>
		<tr>
			<th>삭제</th>
			<th>No.</th>
			<th>상품명</th>
			<th>이미지</th>
			<th>수량</th>
			<th>가격</th>
		</tr>
<%
	int idNum = 1;
	if (baskets != null && products != null) {
		for(BasketVO basket: baskets) {	
			for(ProductVO product: products) {
				if (basket.getProduct_idx() == product.getIdx()) { %>
		<tr>
			<td>
				<a href="basketDelete.do?idx=<%=basket.getIdx()%>"><input type='button' value="삭제"></a>
			</td>
			<td><%=idNum%></td>
			<td><a href = "productView.do?idx=<%=product.getIdx()%>"><%=product.getProduct_name()%></a></td>
			<td><a href = "productView.do?idx=<%=product.getIdx()%>"><img src="<%=product.getProduct_image()%>"></a></td>
			<td><%=basket.getQuantity()%></td>
			<td><%=basket.getFinal_price()%></td>
		</tr>
<%					total += basket.getFinal_price();
					break;
				}
			}
			idNum++;
		}
	}	%>
	</table>
	합 계 : <%=total%>

	<h3><a href="./index.do">처음으로</a></h3>
</body>
</html>