<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%	
	HttpSession	sess			=	request.getSession();
	String	type				=	request.getParameter("type");
	String	typeView			=	request.getParameter("typeView");//view,insert,modify
	
	CustomerVO	cVo				=	(CustomerVO)sess.getAttribute("loggedInUserVO");
	ReviewVO	reviewVO		=	null;
	
	int			idx				=	0;
	int			currentPage		=	1;	
	int			products_idx	=	0;
	String		name			=	null;
	
	if(typeView.equals("view") || typeView.equals("modify"))
	{
		reviewVO		=	(ReviewVO)request.getAttribute("reviewVO");
		name			=	(String)request.getAttribute("name");
		idx				=	reviewVO.getIdx();
		currentPage		=	Integer.parseInt(request.getParameter("page"));
		products_idx	=	reviewVO.getProducts_idx();
	}
	else if(typeView.equals("insert"))
			products_idx		=	Integer.parseInt(request.getParameter("products_idx"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>
<%	if(typeView.equals("view")) {%>				리뷰 보기
<%	} else if(typeView.equals("modify")) {%>	리뷰 수정
<%	} else {%>									리뷰 등록
<%	}%>
</title>
<script>
	function returnList1(){
		location.href="../qReviewsLists.do?page=<%=currentPage%>&type=<%=type%>&products_idx=<%=products_idx%>";
	}
	function returnList2(){
		location.href="./qReviewsLists.do?page=<%=currentPage%>&type=<%=type%>&products_idx=<%=products_idx%>";
	}
	function modifyList(){
		location.href="./review/IdPwdChk.jsp?idx=<%=idx%>&page=<%=currentPage%>&type=<%=type%>&typeView=modify&products_idx=<%=products_idx%>";
	}
	function deleteRow(){
		location.href="./review/IdPwdChk.jsp?idx=<%=idx%>&page=<%=currentPage%>&type=<%=type%>&typeView=delete&products_idx=<%=products_idx%>";
	}
</script>
</head>
<header>
<iframe src="header.do" height="150" width="800"></iframe>
</header>
<body>
<%if(typeView.equals("insert")){ %>
<form action="../qReviewsInsert.do" method="post">
<%}else if(typeView.equals("modify")){ %>
<form action="qReviewsInsert.do" method="post">
<%}else{ %>
<form action="./qReviewsList.do" method="post">
<%} %>
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
		readonly="readonly"value=<%=name %>
		<%	}else if(typeView.equals("modify")){ %>
		readonly="readonly"value=<%=name %>
		<%	}else{ %>
		readonly="readonly"value=<%=cVo.getUsername() %>
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly" value=<%=reviewVO.getReview_title() %> 
		<%	}else if(typeView.equals("modify")){ %>
		value=<%=reviewVO.getReview_title() %>
		<%	}else{ %>
		placeholder="리뷰 제목"
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly"><%=reviewVO.getReview_text() %> 
		<%	}else if(typeView.equals("modify")){ %>
		><%=reviewVO.getReview_text() %>
		<%	}else{ %>
		placeholder="리뷰 내용"><%}%></textarea></td>
	</tr>
		<%	if(typeView.equals("view")){ %>
	<tr>
		<td colspan="2" class="btn_align">
		<input class="btn" type="button" value="뒤로가기" onclick="javascript:history.back()">
		<%		if(type.equals("list")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
		<%		}else if(type.equals("myList")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
		<%		} %>
		
		<%		if(reviewVO.getCustomers_idx()==(cVo.getIdx())){ %>
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
		<input class="btn" type="button" value="취소" onclick="javascript:history.back()">
		<% 		}else if(typeView.equals("modify")){ %>
		<input class="btn" type="submit" value="수정">
		<%		} %>
		
		<%		if(type.equals("list") && typeView.equals("insert")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList1()">
		<%		}else if(type.equals("list") && typeView.equals("modify")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
		<%		}else if(type.equals("myList")){ %>
		 <input class="btn" type="button" value="목록보기"onclick="returnList2()">
		<%		} %>
		</td>
	</tr>
		<%} %>	
</table>
<input type="hidden" name="page" value="<%=currentPage %>">
<input type="hidden" name="type" value="<%=type %>">
<input type="hidden" name="typeView" value="<%=typeView %>">
<input type="hidden" name="products_idx" value="<%=products_idx %>">
<%	if(typeView.equals("modify")){	%>
<input type="hidden" name="idx" value="<%=idx %>">
<%} %>
</form>
</body>
<footer>
<iframe src="footer.do" height="150" width="800"></iframe>
</footer>
</html>