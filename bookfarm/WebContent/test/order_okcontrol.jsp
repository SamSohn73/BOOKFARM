
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  errorPage="goods_error.jsp" import="jspbook.project.*"%>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="order_ok" class="jspbook.project.Order_ok"/>
<jsp:useBean id="order_ob" class="jspbook.project.Order_okBean"/>
<jsp:setProperty name="order_ok" property="*"/>
<% 
	// ����� ��û�� �����ϱ� ���� �Ķ���͸� ������ ����
	String action = request.getParameter("action");

/*	// ��ǰ ��� ��û�� ���
	if(action.equals("list")) {
		response.sendRedirect("goodslist_admin.jsp");
	}
	// ��ǰ ��� ��û�� ���
	
	if(action.equals("insert")) {		
		if(order_ob.insertDB(order_ok)) {
			response.sendRedirect("menu.jsp");
		}
		else
			throw new Exception("DB �Է¿���");
	}
*/	// ��ǰ ���� ��û�� ���
	if(action.equals("edit")) {	
		Order_ok ok_edit = order_ob.getDB(order_ok.getOrder_id(), order_ok.getCode());
		request.setAttribute("order_ok",ok_edit);
		pageContext.forward("order_edit.jsp");
	}
	// ��ǰ ���� ó���� ���
	else if(action.equals("update")) {
			if(order_ob.updateDB(order_ok)) {
				response.sendRedirect("orderslist_user.jsp");
			}
			else
				throw new Exception("DB ���ſ���");
	}
	// ��ǰ ��ü ��û�� ���
	else if(action.equals("delete")) {
		int order_id = Integer.parseInt(request.getParameter("order_id"));
		if(order_ob.deleteDB(order_id)) {
			response.sendRedirect("orderslist_user.jsp");
		}
		else
			throw new Exception("DB ���� ����");
	}

%>
</body>
</html>