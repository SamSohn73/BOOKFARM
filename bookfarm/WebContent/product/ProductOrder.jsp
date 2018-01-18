<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gq.bookfarm.vo.CategoryVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.ProductVO" %>
<%@ page import="gq.bookfarm.vo.BasketVO"%>
<%@ page import="java.util.Vector"%>
<%
	CustomerVO		cVo				=	new CustomerVO();
	ProductVO		pVo				=	new ProductVO();
	int				quantity		=	0;
	Vector<BasketVO> VbVo			=	new Vector<BasketVO>();
	Vector<ProductVO> VpVo			=	new Vector<ProductVO>();
	String			type			=	"";

	if(request.getAttribute("pVo")!=null && request.getAttribute("quantity")!=null) {
					pVo				=	(ProductVO)request.getAttribute("pVo");
					quantity		=	(int)request.getAttribute("quantity");
	float			final_price		=	pVo.getProduct_price()*quantity;
	
	BasketVO		bVo				=	new BasketVO();
										bVo.setProduct_idx(pVo.getIdx());
										bVo.setQuantity(quantity);
										bVo.setFinal_price(final_price);
										VbVo.add(bVo);
										VpVo.add(pVo);
	}else{
					VbVo			=	(Vector<BasketVO>)session.getAttribute("baskets");
					VpVo			=	(Vector<ProductVO>)request.getAttribute("VpVo");
	}

	if(session.getAttribute("loggedInUserVO")!=null){
					cVo				=	(CustomerVO)session.getAttribute("loggedInUserVO");
	}else{
										cVo.setUsername("");
										cVo.setFirstname("");
										cVo.setPhone1("");
										cVo.setEmail1("");
										cVo.setAddress1("");
										cVo.setAddress2("");
	}

										request.setAttribute("VpVo", VpVo);
										request.setAttribute("VbVo", VbVo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>

function buy_submit(){
	productForm.action = "./OrderFinish.do";
	productForm.submit();
}
</script>
</head>
<body>



<div class="container">
		<form>
		<h3>구매자 정보</h3>
		<table class="table">
			<tr class="">
				<td class="">이름</td>
				<td class="">
				<input type="text" name="firstname" placeholder="이름"value=<%=cVo.getFirstname()%>>
				</td>
			</tr>
			<tr class="">
				<td class="">휴대폰번호</td>
				<td class="">
				<input type="text" name="phone" placeholder="휴대폰번호"value=<%=cVo.getPhone1() %>>
				</td>
				<td class="">이메일</td>
				<td class="">
				<input type="text" name="email" placeholder="이메일"value=<%=cVo.getEmail1() %>>
				</td>
			</tr>
			<tr class="">
				<td class="">우편번호</td>
				<td class="">
				<input type="text" name="postcode" placeholder="postcode" value=<%=cVo.getPostcode() %>>
				</td>
			</tr>
			<tr class="">
				<td class="" rowspan="2">주소</td>
				<td colspan="3" class="">
				<input type="text" name="add1" placeholder="주소"value=<%=cVo.getAddress1() %>>
				</td>
			</tr>
			<tr class="">
				<td colspan="3" class="">
				<input type="text" name="add2" placeholder="상세 주소"value=<%=cVo.getAddress2() %>>
				</td>
			</tr>
		</table>

	<!-- /.col-lg-3 -->
	<div class="col-lg-9 my-5">
	<h2 class="my-2">장바구니 목록</h2>
		<table class="table">
			<tr>
				<th>삭제</th>
				<th>상품명</th>
				<th>이미지</th>
				<th>수량</th>
				<th>가격</th>
			</tr>
<%int total = 0;
  int num	= 0;
	if (VbVo != null && VpVo != null) {
		for(BasketVO basket: VbVo) {%>
					<tr>
						<td>
							<a href="basketDelete.do?idx=<%=basket.getIdx()%>"><input type='button' class="btn" value="삭제"></a>
						</td>
						<td><a href = "productView.do?idx=<%=basket.getProduct_idx()%>"><%=VpVo.get(num).getProduct_name()%></a></td>
						<td><a href = "productView.do?idx=<%=basket.getProduct_idx()%>"><img class="card-img-top" src="<%=VpVo.get(num).getProduct_image()%> " alt="350x200"></a></td>
						<td><%=basket.getQuantity()%></td>
						<td><%=basket.getFinal_price()%></td>
					</tr>
				<%total += basket.getFinal_price();
				  num++;
		}
	}	%>
	</table>
	<h4>합 계 : <%=total%></h4>
	<input type="hidden" name="total" value="<%=total %>">
	<a href="./index.do"><input type='button' class="btn" value="처음으로"></a>
	<input type='button' class="btn" value="구매하기" onClick="buy_submit()">
	</div>
	</form>
</div>



</body>
</html>