<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.Enumeration"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language="javascript">
function ch(){		
	if(resultf.chall.checked==false){
		resultf.cbox.checked=false;
		for(i=0;i<resultf.cbox.length;i++){	
			resultf.cbox[i].checked=false;
		}
	}else{ 
		resultf.cbox.checked=true;
		for(i=0;i<resultf.cbox.length;i++){
			resultf.cbox[i].checked=true;
		}
	}

}
function delgoods(num){
	del.delnum.value=num;
	del.submit();
}

function mod(str){
	resultf.contype.value=str;
	resultf.submit();
}

</script>
</head>
<body>
<form name=del action="controller.jsp" method=post>
	<input type=hidden name=delnum>
</form>

<form name=resultf action="controller.jsp" method=post>
<input type=hidden name=contype>

<table bordercolor=black border=1 cellspacing=1>
<caption>�������</caption>
	<tr align=center>
		<td>��ü����<br><input type=checkbox name=chall onclick="ch()"></td>
		<td>ǰ��</td>
		<td>����</td>
		<td>����</td>
		<td>����</td>
	</tr>
<%
int sum=0;
Enumeration e = session.getAttributeNames();
int totalAmount=0;
while(e.hasMoreElements()){
	String name = e.nextElement().toString();
	shopping.Goods goods = (shopping.Goods)session.getAttribute(name);
%>
	<tr align=center>
		<td><input type=checkbox name=cbox value=<%=goods.getGnum()%>></td>
		<td>
			<input type=hidden name=goods_<%=goods.getGnum()%> value=<%=goods.getGoods()%>>
			<input type=hidden name=price_<%=goods.getGnum()%> value=<%=goods.getPrice()%>>
			<input type=hidden name=gnums value=<%=goods.getGnum()%>>
			<%=goods.getGoods()%>
		</td>
		<td><%=goods.getPrice()%></td>
		<td>
		<select name=amount_<%=goods.getGnum()%>>
			<%for(int i = 0 ; i < 100; i++){%>
			<option value=<%=i%> <%if(i==goods.getAmount())%>selected<%;%>><%=i%></option>
			<%} %>
		</td>
		<td><input type=button value=���� onclick=delgoods(<%=goods.getGnum()%>)></td>
	</tr>	
	<%
	totalAmount++;
	sum+=goods.getPrice()*goods.getAmount();
	%>
<%}
if(totalAmount==0){%>
	<tr align=center>
		<td colspan=5>��ٱ��� ǰ���� �����ϴ�!</td>
	</tr>
<%}%>
	<tr align=center>
		<td>���հ�</td><td colspan=4><%=sum%></td>
	</tr>
</table>
<input type=button value=�������� onclick=mod('����')>
<a href=jangbaguni.jsp>���� ������</a>

</form>
</body>
</html> 