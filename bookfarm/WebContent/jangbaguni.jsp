<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<jsp:useBean id="db" class="shopping.Database"/>
<%Vector<Vector<Object>> vv = db.getDB();%>
</head>
<body>
<form action=controller.jsp method=post name=jang>
<input type=hidden name=jangs value="ok">
<table bordercolor=black border=1 cellspacing=1>
	<tr align=center>
		<!-- <td>üũ</td> -->
		<td>����</td> 
		<td>ǰ��</td>
		<td>����</td>
		<td>����</td>
	</tr>
	<%
	//Vector<String> vnums = new Vector<String>();
	for(int i = 0 ; i < vv.size();i++){  %>
		<%Vector<Object> v = vv.get(i); %>		
		<input type=hidden name=gnum_<%=v.get(0)%> value=<%=v.get(0)%>>
	<tr align=center>		
		<!-- <td><input type=checkbox name=checkOn value=<%=v.get(0)%>></td>-->
		<td><img src="C:\eclipse\workspace\session\WebContent\notebook.jpg" width=60 height=60></td>
		<td><input type=hidden name=goods_<%=v.get(0)%> value=<%=v.get(1)%>><%=v.get(1)%></td>
		<td><input type=hidden name=price_<%=v.get(0)%> value=<%=v.get(2)%>><%=v.get(2)%></td>
		<td>
			<select name=amount_<%=v.get(0)%>>
				<option value="0" selected>0</option>
				<%for(int j=1;j<11;j++){ %>
				<option value="<%=j%>"><%=j%></option>	
				<%}%>
			</select>
		</td>
	</tr>
	<%
	}
	%>
	<tr align=center>	
		<td colspan=5><input type=reset value="����"><input type=submit value="��ٱ��ϴ��"></td>
	</tr>
</table>
</form>
</body>
</html>