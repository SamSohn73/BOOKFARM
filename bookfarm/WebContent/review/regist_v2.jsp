<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력 변수
	String	type				= "view";	//view, insert, modify
	String	user_id					= "1";
	String	user_passwd				= "1";
	String	user_name				= "1";
	String	user_zip1				= "1";
	String	user_zip2				= "1";
	String	user_addr1				= "1";
	String	user_addr2				= "1";
	String	user_tel1				= "1";
	String	user_tel2				= "1";
	String	user_age				= "1";
	String	user_email				= "1";
	String	user_gender				= "male";

	//출력 변수
	/* 		id					= "";
			passwd				= "";
			name				= "";
			zip1				= "";
			zip2				= "";
			addr1				= "";
			addr2				= "";
			tel1				= "";
			tel2				= "";
			age					= "";
			email				= "";
			gender				= "";
			 */
	//CSS
	/*
	left
	right
	btn_align
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script>
	function zip_chk(){
		location.href="../qZip.do";
	}
	
	function register_check(form){
		
		if(form.user_id.value.length==0){
			alert('아이디를 확인해 주세요');
			form.user_id.focus();
			return;
		}else if(form.user_passwd.value.length==0){
			alert('비밀번호를 확인해 주세요');
			form.user_passwd.focus();
			return;
		}else if(form.user_name.value.length==0){
			alert('이름을 확인해 주세요');
			form.user_name.focus();
			return;
		}else if(form.user_zip1.value.length==0){
			alert('주소를 확인해 주세요');
			form.user_zip1.focus();
			return;
		}else if(form.user_zip2.value.length==0){
			alert('주소를 확인해 주세요');
			form.user_zip2.focus();
			return;
		}else if(form.addr1.value.length==0){
			alert('주소를 확인해 주세요');
			form.addr1.focus();
			return;
		}else if(form.user_addr2.value.length==0){
			alert('주소를 확인해 주세요');
			form.user_addr2.focus();
			return;
		}else if(form.user_tel1.value.length==0){
			alert('연락처를 확인해 주세요');
			form.user_tel1.focus();
			return;
		}else if(form.user_tel2.value.length==0){
			alert('연락처를 확인해 주세요');
			form.user_tel2.focus();
			return;
		}else if(form.user_age.value.length==0){
			alert('나이를 확인해 주세요');
			form.user_age.focus();
			return;
		}else if(form.user_email.value.length==0){
			alert('이메일을 확인해 주세요');
			form.user_email.focus();
			return;
		}else if(form.user_gender.value.length==0){
			alert('성별을 확인해 주세요');
			form.user_gender.focus();
			return;
		}else{
			form.submit();
		}
	}
</script>
</head>
<body>
<form action="regist.do" method="post">
<table>
	<%	if(type.equals("view")){ %>
		<caption>회원 정보 보기</caption>
	<%	}else if(type.equals("modify")){ %>
		<caption>회원 정보 수정</caption>
	<%	}else{ %>
		<caption>회원가입</caption>
	<%	} %>	
	<tr>
		<td><label>아이디</label>
		<td><input type="text" name="user_id" placeholder="ID"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_id %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_id %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>비밀번호</label>
		<td><input type="password" name="user_passwd" placeholder="비밀번호"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_passwd %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_passwd %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>이름</label>
		<td><input type="text" name="user_name" placeholder="이름"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_name %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_name %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td rowspan="2"><label>우편번호</label>
		<td>
		<input type="text" name="user_zip1"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_zip1 %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_zip1 %>
		<%	}else{ %>
		
		<%	} %>
		>-<input type="text" name="user_zip2"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_zip2 %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_zip2 %>
		<%	}else{ %>
		
		<%	} %>
		>
		<input type="button" class="zip_btn" value="우편번호찾기" onclick="zip_chk()">
		</td>
	</tr>
	<tr>
		<td><input type="text" name="user_addr1"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_addr1 %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_addr1 %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>상세주소</label>
		<td><input type="text" name="user_addr2" placeholder="상세주소"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_addr2 %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_addr2 %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>연락처1</label>
		<td><input type="text" name="user_tel1" placeholder="연락처1"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_tel1 %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_tel1 %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>연락처2</label>
		<td><input type="text" name="user_tel2" placeholder="연락처2"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_tel2 %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_tel2 %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>나이</label>
		<td><input type="text" name="user_age" placeholder="나이"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_age %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_age %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>이메일</label>
		<td><input type="email" name="user_email" placeholder="이메일"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=user_email %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=user_email %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td><label>성별</label>
		<td>
		<%	if(type.equals("view")){
				if(user_gender.equals("male")){%>
					<input type="radio" name="user_gender" value="남"checked="checked" >남
					<input type="radio" name="user_gender" value="여"disabled="disabled">여
		<%		}else{%>
					<input type="radio" name="user_gender" value="남"disabled="disabled">남
					<input type="radio" name="user_gender" value="여"checked="checked">여
		<%		}
			}else if(type.equals("modify")){ 
				if(user_gender.equals("male")){%>
					<input type="radio" name="user_gender" value="남"checked="checked">남
					<input type="radio" name="user_gender" value="여">여
		<%		}else{%>
					<input type="radio" name="user_gender" value="남">남
					<input type="radio" name="user_gender" value="여"checked="checked">여
		<%		}	
			}else{ %>
			<input type="radio" name="user_gender" value="남">남
			<input type="radio" name="user_gender" value="여">여
		<%	} %>
			
		</td>
	</tr>
	<tr>
		<td colspan="2" class="btn_align">
			<input type="button" value="확인" onclick="register_check(this.form)">
			<input type="reset" value="취소">
		</td>
	</tr>
</table>
</form>
</body>
</html>