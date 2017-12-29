<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		//입력 필요한 변수들
									//Servlet에서 담아놓은 정보 가져오기
		//vo						//VO새로 만들고 거기에 옮기기
									//다른 추가정보도 받음
		
		String	type			= "list";	//list아니면 myPage
		String	review_num		= "";
		String	review_re_lev	= "";
		String	review_subject	= "";
		String	review_writer	= "";
		String	review_count	= "";
		int		review_board_num= 0;
		int		total_page		= 0;
		int		current_page	= 0;
		int		start_page		= 0;
		int		end_page		= 0;
		int		total_Rows		= 0;
		
		//출력하는 변수들
		String	searchCondition	= "";
		String	searchword		= "";
				review_writer	= "";
				review_subject	= "";
		String	review_content	= "";
		
		//불러올 CSS
		/*
		클래스_테이블1
		클래스_tr타이틀1
		클래스_tr_top1
		클래스_td_align1
		클래스_bottom_table1
		클래스_td_align1
		클래스_btn_align1
		클래스_btn1
		*/
		
		int		id_num			= total_Rows-(current_page-1)*10;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰창</title>
	<script>
		function search(){
			if(searchform.searchword.value==""){
				alert('검색어를 넣으세요');
				searchform.searchword.focus();
				return;
			}
			searchform.submit();
		}
	</script>
</head>
<body>
		<table class="클래스_테이블1">
			<caption>
			<%	if(type.equals("list")){ %>
				리뷰 게시판
			<%	}else{ %>
				내 리뷰 목록
			<%	}%>
			</caption>
			<tr class="클래스_tr타이틀1">
				<th >번호</th>
				<th >제목</th>
				<th >작성자</th>
				<th >날짜</th>
				<th >조회수</th>
			</tr>
<%		for(/*VO가져온것 돌리기*/int i=0;i<=0;i++){	%>
			<tr class="클래스_tr_top1">
				<td class="클래스_td_align1">글번호</td>
				<td align="left"><a href="qHitUpdate.do?board_num=글번호&page=페이지번호">					
				글제목</a></td>										
				<td>작성자</td>
				<td>날짜</td>
				<td>조회수</td>
			</tr>
<%
	//글번호 감소(글번호는 보드 넘버와 다르게 그냥 표시되는 글의 번호)
}%>
<tr>
	<td colspan="5">
		<%
			if(/*현재페이지<=1*/ false){
				out.print("");
			}else{
				out.print("<a href=qlist.do?page=현재페이지-1>");
				out.print("[이전]</a>");
			}
		
			for(int i=/*시작페이지*/0;i<=/*끝페이지*/0;i++){
				if(i==/*현재페이지*/1){
					out.print(" "+i+" ");
				}else{
					out.print(" <a href=qlist.do?page="+i+">"+i+"</a> ");
				}
			}
			
			if(/*현재페이지*/0>=/*전체페이지*/1){
				out.print("");
			}else{
				out.print("<a href=qlist.do?page=(현재페이지+1)>");
				out.print("[다음]</a>");
			}
		%>
	</td>
</tr>
</table>
<%	if(type.equals("list")){ %>
<table	class="클래스_bottom_table1">
			<tr>
				<td colspan="5" class="클래스_td_align1">
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td colspan="5" class="클래스_btn_align1">
					<form action="qSearch.do" method="post" name="searchform">
						<select class="btn" name="searchCondition">
							<option value="board_writer">작성자</option>
							<option value="board_subject">제목</option>
							<option value="board_content">글내용</option>
						</select>
						<input type="text" class="클래스_btn1" size="10" name="searchword" required="required"/>
						<input type="button" class="클래스_btn1" value="검색" onclick="search()">
					</form>
				</td>
				<td align="right">
				<a href="board/qna_board_write.jsp?page=현재페이지">[글쓰기]</a>
				</td>
			</tr>
</table>
<%	} %>
</body>
</html>