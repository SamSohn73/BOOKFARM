<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<table>
	<caption>회원 정보 보기</caption>
		<tr>
			<td class="td_left">회원 번호</td>					
			<td class="td_right">
			<input type='text' name='idx' size="64" readonly value="#">								
			</td>
		</tr>
		<tr>
			<td class="td_left">회원 이름</td>					
			<td class="td_right">
			<input type='text' name='username' size="64" value="#"
			readonly>						
			</td>
		</tr>
		<tr>
			<td class="td_left">성 별</td>					
			<td class="td_right">
				<textarea name='gender' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">국 가</td>					
			<td class="td_right">
				<textarea name='country_idx' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">우편 번호</td>					
			<td class="td_right">
				<textarea name='postcode' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">주 소</td>					
			<td class="td_right">
				<textarea name='address1' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">전화 번호</td>					
			<td class="td_right">
				<textarea name='phone1' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">e_mail</td>					
			<td class="td_right">
				<textarea name='email1' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">회원 등급</td>					
			<td class="td_right">
				<textarea name='grade' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">last_login</td>					
			<td class="td_right">
				<textarea name='last_login' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="td_left">login_cnt</td>					
			<td class="td_right">
				<textarea name='login_cnt' cols='65' rows='15' readonly>
				</textarea>
			</td>
		</tr>
		
		<tr class="button_cell">
			<td colspan='2'>
			<input type='button' value="답변" onClick="reply_list()">
			<input type='button' value="수정" onClick="modify_list()"> 
			<input type="button" value="삭제" onClick="delete_list()">
			<input type="button" value="목록" onClick="list_submit()">			
			</td>
		</tr>
	</table>	
</html>