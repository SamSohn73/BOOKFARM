
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.util.*,jspbook.project.*"
	errorPage="cart_error.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ֹ� ����</title>
</head>
<body>
	<center>
		<h2>�ֹ� ����</h2>
		<hr>
		[<a href="goodslist_user.jsp">��ǰ �������</a>]

	
		<h4>���� ���</h4>
		<form>
			<table cellpadding=5 cellspacing=0 border="1">
				<tr bgcolor="#99CCFF">
					<td>��ǰ�ڵ�</td>
					<td>��ǰ��</td>
					<td>�ܰ�</td>
					<td>����</td>
					<td>�Ѿ�</td>
				</tr>
				
				<%
					// ArrayList ��ü�� ���� DB���� ������ ����� �����.
					ArrayList order_list = (ArrayList)session.getAttribute("order_list");
					int i = 0; 
					while(i < order_list.size()-1){
				%>
						<tr>
							<td><%=order_list.get(i++)%></td>
							<td><%=order_list.get(i++)%></a></td>
							<td><%=order_list.get(i++)%></td>
							<td><%=order_list.get(i++)%></td>
							<td><%=order_list.get(i++)%></td>
						</tr>
						
				<%
					}
					String strSum = (String)order_list.get(order_list.size()-1);
					int intSum = Integer.parseInt(strSum);
				%><tr>
					<td bgcolor="#99CCFF" colspan=4 align=center>�Ѿ�</td>
					<td><%=intSum%></td>
				</tr>
				</table>
			</form>
					
		
		<br><br>
		<h4>������ ����</h4>
	
		<%
			Order_user order_user = new Order_user();

			MemberBean mb = new MemberBean();
			Member member = mb.getMember((String) session.getAttribute("userid"));

			order_user.setUserid(member.getUserid());
			order_user.setName(member.getName());
			order_user.setAddress(member.getAddress());
			order_user.setPhone(member.getPhone());
			//order_user.setTotal_price(intSum);
			
			
		%>
		
          
		<form name=form1 method=post action=order_usercontrol.jsp>
			<input type=hidden name="action" value="insert"> 
			<input type=hidden name="total_price" value="<%=order_user.getTotal_price() %>">
		
			<table cellpadding=5 cellspacing=0 border="1">
				<tr>
					<td bgcolor="#99CCFF">ID</td>
					<td><input type=text name="userid"	value="<%=order_user.getUserid()%>"></td>
				</tr>
				<tr>
					<td bgcolor="#99CCFF">Name</td>
					<td><input type=text name="name"	value="<%=order_user.getName()%>"></td>
				</tr>
				<tr>
					<td bgcolor="#99CCFF">Address</td>
					<td><input type=text name="address"	value="<%=order_user.getAddress()%>"></td>
				</tr>
				<tr>
					<td bgcolor="#99CCFF">Phone</td>
					<td><input type=text name="phone"	value="<%=order_user.getPhone()%>"></td>
				</tr>
				<tr>
					<td colspan=5 align=center><input type=submit value="����">
					</td>
				</tr>
			</table>
		</form>


		<br>
	</center>
</body>
</html>