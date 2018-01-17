<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@page import="java.sql.Date" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	String		type			=	"modify";	//view, insert, modify	
	CustomerVO	cVo				=	new CustomerVO();
	int			nowYear			=	Calendar.getInstance().get(Calendar.YEAR);
	int			year			=	0;
	int			month			=	0;
	int			day				=	0;
	int			dayLimit		=	0;
	
	
	if(request.getParameter("type")!=null)
				type			=	(String)request.getParameter("type");
	
	if(session.getAttribute("loggedInUserVO")!=null && (type.equals("modify") || type.equals("view"))){
				cVo				=	(CustomerVO)session.getAttribute("loggedInUserVO");
	
	SimpleDateFormat format		=	new SimpleDateFormat("yyyy-MM-dd");
	Date		date			=	cVo.getBirthday();
	
	SimpleDateFormat	dy		=	new SimpleDateFormat("yyyy");
				year			=	Integer.parseInt(dy.format(date));
				
	SimpleDateFormat	dm		=	new SimpleDateFormat("MM");
				month			=	Integer.parseInt(dm.format(date));
				
	SimpleDateFormat	dd		=	new SimpleDateFormat("dd");
				day				=	Integer.parseInt(dd.format(date));
	}
	else if(request.getAttribute("workingUserVO")!=null){
				cVo				=	(CustomerVO)request.getAttribute("workingUserVO");
				year			=	(int)request.getAttribute("year");
				month			=	(int)request.getAttribute("month");
				day				=	(int)request.getAttribute("day");
	}
	
	
	if((month==1) || (month==3) || (month==5) || (month==7) || (month==8) || (month==10) || (month==12)){
				dayLimit		=	31;
	}else if((month==4) || (month==6) || (month==9) || (month==11)){
				dayLimit		=	30;
	}else if(month==2){
		if((year%4==0) && (year%100!=0) || (year%400==0))
				dayLimit		=	29;
		else
				dayLimit		=	28;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script>
	function register_check(form){
		
		if(form.username.value.length==0){
			alert('아이디를 확인해 주세요');
			form.username.focus();
			return;
		}else if(form.password.value.length==0){
			alert('비밀번호를 확인해 주세요');
			form.password.focus();
			return;
		}else if(form.firstname.value.length==0){
			alert('이름을 확인해 주세요');
			form.firstname.focus();
			return;
		}else if(form.postcode.value.length==0){
			alert('우편번호를 확인해 주세요');
			form.postcode.focus();
			return;
		}else if(form.address1.value.length==0){
			alert('주소를 확인해 주세요');
			form.address1.focus();
			return;
		}else if(form.address2.value.length==0){
			alert('주소를 확인해 주세요');
			form.address2.focus();
			return;
		}else if(form.phone1.value.length==0){
			alert('연락처를 확인해 주세요');
			form.phone1.focus();
			return;
		}else if(form.birthday.value.length==0){
			alert('생년월일을 확인해 주세요');
			form.birthday.focus();
			return;
		}else if(form.email1.value.length==0){
			alert('이메일을 확인해 주세요');
			form.email1.focus();
			return;
		}else if(form.user_gender.value.length==0){
			alert('성별을 확인해 주세요');
			form.user_gender.focus();
			return;
		}else{
			<%type="insert";%>
			form.submit();
		}
	}
	function selFuc(obj)
	{
		<%
		if(type.equals("insert"))
			type="dateInsert";
		else if(type.equals("modify"))
			type="dateModi";
		%>
		obj.form.action="../CustomerRegistSetting.do?type=<%=type %>";
		obj.form.submit();
	}
</script>
</head>
<%if(type.equals("view") || type.equals("modify")){ %>
<header>
<iframe src="../header.do" height="150" width="800"></iframe>
</header>
<%} %>
<body>
	<%	if(type.equals("view")){ %>
<form action="./qCustomerRegist.do?type=<%=type %>" method="post">
<table>
		<caption>회원 정보 보기</caption>
	<%	}else if(type.equals("modify")){ %>
<form action="../qCustomerRegist.do?type=<%=type %>" method="post">
<table>
		<caption>회원 정보 수정</caption>
	<%	}else{ %>
<form action="../qCustomerRegist.do?type=<%=type %>" method="post">
<table>
		<caption>회원가입</caption>
	<%}%>
	<tr>
		<td><label>아이디</label></td>
		<td><input type="text" name="username" placeholder="아이디"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getUsername() %>
		<%	}else if(type.equals("modify")){ %>
		readonly="readonly"value=<%=cVo.getUsername() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>비밀번호</label></td>
		<td><input type="password" name="password" placeholder="비밀번호"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getPassword() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getPassword() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>이름</label></td>
		<td><input type="text" name="firstname" placeholder="이름"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getFirstname() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getFirstname() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td rowspan="2"><label>주소</label></td>
		<td>
		<input type="text" name="postcode" placeholder="postcode"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getPostcode() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getPostcode() %>
		<%	}else{ %>
		
		<%	} %>
		>
		<a href="#" onclick="window.open('xxx.html','width=500px, height=500px')">
		<input type="button" class="zip_btn" value="우편번호찾기"></a>
		</td>
	</tr>
	<tr>
		<td><input type="text" name="address1" placeholder="주소"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getAddress1() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getAddress1() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>상세주소</label></td>
		<td><input type="text" name="address2" placeholder="상세주소"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getAddress2() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getAddress2() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>연락처1</label></td>
		<td><input type="text" name="phone1" placeholder="연락처1"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getPhone1() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getPhone1() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>생년월일</label>
		<%-- <td><input type="text" name="birthday" placeholder="yyyy-mm-dd"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getBirthday() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getBirthday() %>
		<%	}else{ %>
		
		<%	} %>
		></td> --%>
		<td class="클래스_btn_align1">
					<select class="btn" onchange="selFuc(this)" name="year">
							<option value="0">년도</option>
						<% for(int i=nowYear;i>=(nowYear-100);i--){ %>
							<option value="<%=i%>"
							<%if(year==i){%> selected<%}%>>
							<%= i%> 년</option>
							<%} %>
						</select>
						<%if(year!=0){ %>
						 - <select class="btn" onchange="selFuc(this)" name="month">
							<option value="0">월</option>
						<% for(int j=1;j<=12;j++){ %>
							<option value="<%=j%>"
							<%if(month==j){%> selected<%}%>>
							<%= j%> 월</option>
							<%} %>
						</select>
						<%} 
						  if(month!=0){%>
						 - <select class="btn" onchange="selFuc(this)" name="day">
							<option value="0">일</option>
						<% for(int k=1;k<=dayLimit;k++){ %>
							<option value="<%=k%>"
							<%if(day==k){%> selected<%}%>>
							<%= k%> 일</option>
							<%} %>
						</select>
						<%} %>
		</td>
	</tr>
	<tr>
		<td><label>이메일</label></td>
		<td><input type="email" name="email1" placeholder="이메일"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=cVo.getEmail1() %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=cVo.getEmail1() %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>성별</label></td>
		<td>
		<%	
			if(type.equals("view")){
				String user_gender	=	cVo.getGender();
				if(user_gender.equals("m")){%>
					<input type="radio" name="user_gender" value="m"checked="checked" >남
					<input type="radio" name="user_gender" value="f"disabled="disabled">여
		<%		}else{%>
					<input type="radio" name="user_gender" value="m"disabled="disabled">남
					<input type="radio" name="user_gender" value="f"checked="checked">여
		<%		}
			}else if(type.equals("modify")){ 
				String user_gender	=	cVo.getGender();
				if(user_gender.equals("m")){%>
					<input type="radio" name="user_gender" value="m"checked="checked">남
					<input type="radio" name="user_gender" value="f">여
		<%		}else{%>
					<input type="radio" name="user_gender" value="m">남
					<input type="radio" name="user_gender" value="f"checked="checked">여
		<%		}	
			}else{ %>
			<input type="radio" name="user_gender" value="m">남
			<input type="radio" name="user_gender" value="f">여
		<%	} %>
			
		</td>
	</tr>
	<tr>
		<td colspan="2" class="btn_align">
			<input type="button" value="확인" onclick="register_check(this.form)">
			<%if(type.equals("modify") || type.equals("view")){ %>
			<a href="../member/mypage.jsp"><input type="button" value="취소"></a>
			<%}else{ %>
			<a href="../hansol_main_example.jsp"><input type="button" value="취소"></a>
			<%} %>
		</td>
	</tr>
</table>
</form>
</body>
<%if(type.equals("view") || type.equals("modify")){ %>
<footer>
<iframe src="../footer.do" height="150" width="800"></iframe>
</footer>
<%} %>
</html>