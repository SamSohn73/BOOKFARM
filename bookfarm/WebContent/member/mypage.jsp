<%@page import="gq.bookfarm.dao.OrdersDAO" %>
<%@page import="gq.bookfarm.dao.OrdersProductDAO" %>
<%@page import="gq.bookfarm.dao.ProductDAO" %>
<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@page import="gq.bookfarm.vo.OrdersVO"%>
<%@page import="gq.bookfarm.vo.ProductVO"%>
<%@page import="gq.bookfarm.vo.OrdersProductVO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	CustomerVO		cVo			=	(CustomerVO) session.getAttribute("LoginedUserVO");
	int				customer_idx=	cVo.getIdx();
	
	
	/* OrdersDAO		dao			=	new OrdersDAO();
	Vector<OrdersVO> list		=	dao.ordersList(1, 5);
	OrdersProductDAO opDao		=	new OrdersProductDAO();
	ProductDAO		pDao		=	new ProductDAO();
	ProductVO		pVo			=	new ProductVO(); */

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1><%=cVo.getFirstname() %> 님의 마이페이지 입니다</h1>
		<table class="myPage_table1">
			<caption>회원 정보</caption>
			<tr class="myPage_tr_top1">
				<td class="left">아이디</td>
				<td class="right"><%=cVo.getUsername() %></td>
				<td class="left">이름</td>
				<td class="right"><%=cVo.getFirstname() %></td>
			</tr>
			<tr class="myPage_tr_top1">
				<td class="left">휴대폰번호</td>
				<td class="right"><%=cVo.getPhone1() %></td>
				<td class="left">이메일</td>
				<td class="right"><%=cVo.getEmail1() %></td>
			</tr>
			<tr class="myPage_tr_top1">
				<td class="left" rowspan="2">주소</td>
				<td colspan="3" class="right"><%=cVo.getAddress1() %></td>
			</tr>
			<tr class="myPage_tr_top1">
				<td colspan="3" class="right"><%=cVo.getAddress2() %></td>
			</tr>
			<tr>
				<td align="right"><a href="./login.jsp?type=modify">
				내정보 수정</a></td>
			</tr>
		</table>

		<iframe src="../qOrdersConfirmAction.do?type=myPage"
				height="450" width="800"></iframe>
		
		<iframe src="../qReviewsLists.do?type=myPage"
				height="450" width="800"></iframe>
		
		<a href="../qCustomerLogout.do">logout</a>
		<a href="hansol_main_example.jsp">메인으로</a>
</body>
</html>