<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.util.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, jspbook.project.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ֹ� Ȯ��</title>
</head>
<body>
	<jsp:useBean id="login" class="jspbook.project.LoginBean"
		scope="session" />
	<jsp:useBean id="cb" class="jspbook.project.CartBean" scope="session" />
	<center>
		<h2>���� �ֹ� ����Ʈ</h2>
		<hr>
		<%=session.getAttribute("userid")%>���� �ֹ� ����Ʈ <br> <br> [<a
			href="main.jsp">���� ȭ������</a>]
		<h2>�ֹ� ��ǰ ���</h2>
		<form name=form1 method=post action=order_user.jsp>
			<table cellpadding=5 cellspacing=0 border="1">
				<tr bgcolor="#99CCFF">
					<td>�ֹ� ��ȣ</td>
					<td>�ڵ�</td>
					<td>����</td>
				</tr>
				<%
					Order_userBean order_ub = new Order_userBean();
					ArrayList<Order_user> uDatas = order_ub.getDBList((String) session.getAttribute("userid"));

					Order_okBean order_ob = new Order_okBean();

					for (Order_user order_user : uDatas) {

						if (order_user.getUserid().equals(session.getAttribute("userid"))) {
							ArrayList<Order_ok> oDatas = order_ob.getDBList(order_user.getOrder_id());
							for (Order_ok order_ok : oDatas) {
				%>
				<tr>
					<td><%=order_ok.getOrder_id()%></td>
					<td><%=order_ok.getCode()%></td>
					<td><%=order_ok.getAmount()%></td>
				</tr>
				<%
					}
						}
					}
				%>
			</table>
		</form>
		<br>

		<form method="post" action="order_okcontrol.jsp">
			<input type=hidden name="action" value="delete"> �ֹ� ��ȣ : <input
				type="text" name="order_id"> <input type="submit"
				value="�ֹ� ���">
		</form>
		<a href="main.jsp">���� �޴� ����</a>
		<P>
		</TABLE>
	</center>
</body>
</html>