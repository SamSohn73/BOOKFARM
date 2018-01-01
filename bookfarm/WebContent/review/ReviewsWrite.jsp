<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="xyz.bookfarm.vo.ReviewsVO" %>
<%@ page import="xyz.bookfarm.dao.ReviewsDAO" %>
<%@ page	import="xyz.bookfarm.vo.PageVO" %>
<%	
	//뷰, 삽입/수정 공용페이지
	//입력,출력 변수들
	String	type				=	"";	//This is index which indicate where connection from...
	if(request.getParameter("type")!=null)
			type				=	request.getParameter("type");
	else if(request.getAttribute("type")!=null)
			type				=	(String)request.getAttribute("type");
	
	String	typeView			=	"";	//view,insert,modify	
	if(request.getParameter("typeView")!=null)
			typeView			=	request.getParameter("typeView");
	else if(request.getAttribute("typeView")!=null)
			typeView			=	(String)request.getAttribute("typeView");
	
	int		idx					=	Integer.parseInt((String)request.getAttribute("idx"));
	int		products_idx		=	0;
	int		customers_idx		=	0;	
	int		currentPage			=	1;
	String	reviewUsername		=	"";
	String	username			=	"";
			/*username			=	(String)request.getAttribute("username");*/
	String	review_title		=	null;
	String	review_text			=	null;
	
	if(typeView.equals("insert"))
	{
			products_idx		=	Integer.parseInt(request.getParameter("products_idx"));
			currentPage			=	Integer.parseInt(request.getParameter("page"));
	}
	else if(typeView.equals("view"))
	{
			currentPage			=	Integer.parseInt((String)request.getAttribute("page"));
			products_idx		=	Integer.parseInt((String)request.getAttribute("products_idx"));
			customers_idx		=	Integer.parseInt((String)request.getAttribute("customers_idx"));
	
	ReviewsVO vo				=	(ReviewsVO)request.getAttribute("vo");
			/*reviewUsername	=	cDao.getUsername(vo.getCustomers_idx());*/
			review_title		=	vo.getReview_title();
			review_text			=	vo.getReview_text();	
	}
	else if(typeView.equals("modify"))
	{
			currentPage			=	Integer.parseInt((String)request.getAttribute("page"));
			products_idx		=	Integer.parseInt((String)request.getAttribute("products_idx"));
			customers_idx		=	Integer.parseInt((String)request.getAttribute("customers_idx"));
			
	ReviewsVO vo				=	(ReviewsVO)request.getAttribute("vo");
			review_title		=	vo.getReview_title();
			review_text			=	vo.getReview_text();
									request.setAttribute("type", type);
	}

	/*CSS	
	left
	right
	file_t
	btn
	*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function returnList(){
		location.href="../qReviewsList.do?page=<%=currentPage%>&products_idx=<%=products_idx%>&type=<%=type%>";
	}
	function returnMyList(){
		location.href="../qReviewsList.do?page=<%=currentPage%>&customers_idx=<%=customers_idx%>&type=<%=type%>";
	}
	function modifyList(){		
		<% request.setAttribute("typeView", "modify"); %>		
		location.href="./review/IdPwdChk.jsp?idx=<%=idx%>&page=<%=currentPage%>&customers_idx=<%=customers_idx%>&products_idx=<%=products_idx%>&type=<%=type%>";
	}	
	function modify(){
		location.href="../qReviewsModify.do?idx=<%=idx%>&page=<%=currentPage%>&customers_idx=<%=customers_idx%>&products_idx=<%=products_idx%>&type=<%=type%>";
	}
	function deleteRow(){
		<% request.setAttribute("typeView", "delete"); %>
		location.href="./review/IdPwdChk.jsp?idx=<%=idx%>&page=<%=currentPage%>&customers_idx=<%=customers_idx%>&products_idx=<%=products_idx%>&type=<%=type%>";
	}
</script>
</head>
<body>
<form action="../qReviewsInsert.do" method="post">
<table>
	<%	if(typeView.equals("view")){ %>
		<caption>리뷰 보기</caption>
	<%	}else if(typeView.equals("modify")){ %>
		<caption>리뷰 수정</caption>
	<%	}else{ %>
		<caption>리뷰 등록</caption>
	<%	} %>	
	<tr>
		<td class="left">글쓴이</td>
		<td class="right"><input type="text" name="review_writer" size="15" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly"value=<%=reviewUsername %>
		<%	}else if(typeView.equals("modify")){ %>
		readonly="readonly"value=<%=reviewUsername %>
		<%	}else{ %>
		readonly="readonly"value=<%=username %>
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly" value=<%=review_title %> 
		<%	}else if(typeView.equals("modify")){ %>
		value=<%=review_title %>
		<%	}else{ %>
		
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly"><%=review_text %> 
		<%	}else if(typeView.equals("modify")){ %>
		><%=review_text %>
		<%	}else{ %>
		>
		<%	} %>
		</textarea></td>
	</tr>
		<%	if(typeView.equals("view")){ %>
	<tr>
		<td colspan="2" class="btn_align">
		<input class="btn" type="button" value="뒤로가기" onclick="javascript:history.back()">
		
		<%		if(type.equals("list")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList()">
		<% 		}else if(type.equals("myList")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnMyList()">
		<%		} %>
		
		<%		if(username.equals(reviewUsername)){ %>
		 <input class="btn" type="button" value="수정하기"onclick="modifyList()">
		 <input class="btn" type="button" value="삭제하기"onclick="deleteRow()">
		<%		} %>
		</td>
	</tr>
		<%}else{ %>
	<tr>
		<td colspan="2" class="btn_align">
		<%		if(typeView.equals("insert")){ %>
		<input class="btn" type="submit" value="등록">
		<% 		}else if(typeView.equals("modify")){ %>
		<input class="btn" type="button" value="수정"onclick="modify()">
		<%		} %>
		
		<input class="btn" type="button" value="취소" onclick="javascript:history.back()">
		
		<%		if(type.equals("list")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList()">
		<% 		}else if(type.equals("myList")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnMyList()">
		<%		} %>
		</td>
	</tr>
		<%} %>	
</table>
<input type="hidden" name="page" value="<%=currentPage %>">
<input type="hidden" name="customers_idx" value="<%=customers_idx %>">
<input type="hidden" name="products_idx" value="<%=products_idx %>">
<input type="hidden" name="type" value="<%=type %>">
<input type="hidden" name="typeView" value="<%=typeView %>">
</form>
</body>
</html>