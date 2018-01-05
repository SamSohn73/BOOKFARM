<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 사용자가 내용을 고치는 부분 qModify에서 넘겨받은 num 가지고 가기--%> 
	<form action="qUpdate.do" method="post" 
	enctype="multipart/form-data">
	<table>
	<caption>수정하기</caption>
		<tr>
			<td class="td_left">비밀 번호</td>					
			<td class="td_right">
			<input type='text' name='password' size="64" value='#'>						
			</td>
		</tr>
		<tr>
			<td class="td_left">거주국가</td>					
			<td class="td_right">
			<input type='text' name='country_idx' size="64" value='#'
			readonly>						
			</td>
		</tr>
		<tr>
			<td class="td_left">우편 버호</td>					
			<td class="td_right"><!--  -->
				<textarea name='postcode' cols='65' rows='15'><%-- <%=vo.getBoard_content()%> --%></textarea>			
			</td>
		</tr>
		<tr>
			<td class="td_left">주소</td>					
			<td class="td_right">
				<input type="address1" name='board_pass'>
			</td>
		</tr>
		<tr>
			<td class="td_left"><label for="board_file">파일첨부</label></td>					
			<td class="file_td">
			<%-- <%
			String fileName=vo.getBoard_file();
			
			if(fileName!=null){				
			%>
				<%=fileName%>
			<%}else{%><!-- 처음 입력시 파일을 안 넣었다면 수정하는 부분에서만 넣는 것 허용 -->
				<input type="file" name="board_file">
			<%} %> --%>
			</td>	
		</tr>
		<tr class="button_cell">
			<td colspan='2'>			
			<input type='submit' value="수정"> 
			<input type='button' value='뒤로' onClick="javascript:history.go(-1);">				
			</td>
		</tr>
	</table>
	<input type="hidden" name="board_num" value="#">	
	<input type="hidden" name="page" value="<#">	
	</form>	
</body>
</html>