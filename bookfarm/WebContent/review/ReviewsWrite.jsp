<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//뷰, 삽입/수정 공용페이지
	//입력,출력 변수들
	String	type				= "insert";	//view,insert,modify
	String	current_page		= "";
	String	review_writer		= "1";
	String	review_subject		= "1";
	String	review_content		= "1";
	String	review_pass			= "1";
	String	review_file			= "1";

	//CSS
	/*
	left
	right
	file_t
	btn
	*/


	//qna_board_list.jsp에서 보던 페이지 가져오기
	current_page = request.getParameter("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function curr_list(){
		location.href="../qlist.do?page=<%=current_page%>";
	}
</script>
</head>
<body>
<form action="../qWrite.do" method="post" enctype="multipart/form-data">
<table>
	<%	if(type.equals("view")){ %>
		<caption>리뷰 보기</caption>
	<%	}else if(type.equals("modify")){ %>
		<caption>리뷰 수정</caption>
	<%	}else{ %>
		<caption>리뷰 등록</caption>
	<%	} %>	
	<tr>
		<td class="left">글쓴이</td>
		<td class="right"><input type="text" name="review_writer" size="15" required="required"
		<%	if(type.equals("view")){ %>
		readonly="readonly"value=<%=review_writer %>
		<%	}else if(type.equals("modify")){ %>
		value=<%=review_writer %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_subject" size="40" required="required"
		<%	if(type.equals("view")){ %>
		readonly="readonly" value=<%=review_subject %> 
		<%	}else if(type.equals("modify")){ %>
		value=<%=review_subject %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_content" rows="15" cols="50" required="required"
		<%	if(type.equals("view")){ %>
		readonly="readonly"><%=review_writer %> 
		<%	}else if(type.equals("modify")){ %>
		><%=review_writer %>
		<%	}else{ %>
		>
		<%	} %>
		</textarea></td>
	</tr>
	<%	if(type.equals("view")){ %>
			
	<%	}else{ %>
			<tr>
				<td class="left">비밀번호</td>
				<td class="right"><input type="password" name="review_pass" required="required"		
				value=<%=review_pass %>></td>
			</tr>
	<%	} %>
	<%	if(type.equals("view")){ %>
			
	<%	}else if(type.equals("modify")){ %>
			<tr>
				<td class="left">파일첨부</td>
				<td class="right"><input class="file_t" type="file" name="review_file" id="review_file"></td>
			</tr>
	<%	}else{ %>
			<tr>
				<td class="left">파일첨부</td>
				<td class="right"><input class="file_t" type="file" name="review_file" id="review_file"></td>
			</tr>
	<%	} %>		
			
	<%	if(type.equals("view")){ %>
			<tr>
				<td colspan="2" class="btn_align">
				<input class="btn" type="button" value="뒤로가기" onclick="javascript:history.back()">
				<input class="btn" type="button" value="목록보기" onclick="curr_list()">
				</td>
			</tr>
	<%}else{ %>
			<tr>
				<td colspan="2" class="btn_align">
				<input class="btn" type="submit" value="등록">
				<input class="btn" type="button" value="취소" onclick="javascript:history.back()">
				<input class="btn" type="button" value="목록보기" onclick="curr_list()">
				</td>
			</tr>
	<%} %>	
</table>
</form>
</body>
</html>