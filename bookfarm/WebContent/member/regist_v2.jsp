<%@page import="gq.bookfarm.vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	String		type			=	"modify";	//view, insert, modify	
	CustomerVO	cVo				=	new CustomerVO();
	
	
	if(request.getParameter("type")!=null)
				type			=	(String)request.getParameter("type");
	
	if(type.equals("modify") || type.equals("view"))
				cVo				=	(CustomerVO)session.getAttribute("loggedInUserVO");
	
	int year=0;
	int month=0;
	int day=0;
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
			form.submit();
		}
	}
	function selFuc(obj)
	{
		<%type="dateInsert";%>
		obj.form.submit();
	}
	function selFuc_modi(obj)
	{
		<%type="dateModi";%>
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
	<%	}else if(type.equals("insert")){ %>
<form action="../qCustomerRegist.do?type=<%=type %>" method="post">
<table>
		<caption>회원가입</caption>
	<%	}else if(type.equals("dateInsert")){ %>
<form action="../CustomerRegistSetting.do?type=<%=type %>" method="post">
<table>
		<caption>회원가입</caption>	
	<%	}else if(type.equals("dateModi")){ %>
<form action="../CustomerRegistSetting.do?type=<%=type %>" method="post">
<table>
		<caption>회원가입</caption>	
	<%	} %>
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
						<% for(CategoryVO cat_Vo1 :catVo1){ %>
							<option value="<%=cat_Vo1.getIdx()%>"
							<%if(year==cat_Vo1.getIdx()){%> selected<%}%>>
							<%= cat_Vo1.getCategory_name()%></option>
							<%} %>
						</select>
						<%if(year!=0){ %>
						<select class="btn" onchange="selFuc(this)" name="month">
							<option value="0">월</option>
						<% for(CategoryVO cat_Vo2 :catVo2){ %>
							<option value="<%=cat_Vo2.getIdx()%>"
							<%if(month==cat_Vo2.getIdx()){%> selected<%}%>>
							<%= cat_Vo2.getCategory_name()%></option>
							<%} %>
						</select>
						<%} 
						  if(month!=0){%>
						<select class="btn" onchange="selFuc(this)" name="day">
							<option value="0">일</option>
						<% for(ProductVO pVo :VpVo){ %>
							<option value="<%=pVo.getIdx()%>"
							<%if(day==pVo.getIdx()){%> selected<%}%>>
							<%= pVo.getProduct_name()%></option>
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
			<%if(!type.equals("insert")){ %>
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