<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="gq.bookfarm.vo.PageVO"%>
<%@page import="gq.bookfarm.vo.BasketVO"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<%@page import="org.apache.log4j.Logger"%>

<%! private final Logger log = Logger.getLogger(this.getClass()); %>

<%
	PageVO				pageInfo	= (PageVO) request.getAttribute("pageInfo");
	Vector<BasketVO>	baskets		= (Vector<BasketVO>) request.getAttribute("baskets");
	Vector<ProductVO>	products	= (Vector<ProductVO>) request.getAttribute("products");
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
		<caption>상품 목록</caption>
		<tr>
			<th>No.</th>
			<th>상품명</th>
			<th>이미지</th>
			<th>수량</th>
			<th>가격</th>
		</tr>
<%	
	int idNum = 1;
	for(BasketVO basket: baskets) {	
		for(ProductVO product: products) {
			if (basket.getProduct_idx() == product.getIdx()) { %>
		<tr>
			<td><%=idNum%></td>
			<td><%=product.getProduct_name()%></td>
			<td><img src="<%=product.getProduct_image()%>"></td>
			<td><%=basket.getQuantity()%></td>
			<td><%=product.getProduct_price()%></td>
		</tr>
<%			total += product.getProduct_price();
			}
		}
		idNum++;
	} %>
	</table>
	합 계 : <%=total%>

	<h3><a href="../index.jsp">처음으로</a></h3>
</body>
</html>