<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.sql.*"%>
<%@ page import="gq.bookfarm.vo.ReviewVO" %>
<%@ page import="gq.bookfarm.vo.CustomerVO" %>
<%@ page import="gq.bookfarm.dao.ReviewDAO" %>
<%@ page import="gq.bookfarm.dao.CustomerDAO" %>
<%@ page import="gq.bookfarm.vo.PageVO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%	
	HttpSession	sess			=	request.getSession();
	String	type				=	request.getParameter("type");
	String	typeView			=	request.getParameter("typeView");//view,insert,modify
	
	CustomerVO	cVo				=	(CustomerVO)sess.getAttribute("loggedInUserVO");
	ReviewVO	vo				=	null;
	CustomerDAO	cDao			=	null;
	int			idx				=	0;
	int			currentPage		=	1;	
	int			products_idx	=	0;
	
	if(typeView.equals("view") || typeView.equals("modify"))
	{
				vo				=	(ReviewVO)request.getAttribute("vo");
				cDao			=	new CustomerDAO();
				idx				=	vo.getIdx();
				//idx				=	(int)request.getAttribute("idx");
				currentPage		=	Integer.parseInt(request.getParameter("page"));
				products_idx	=	vo.getProducts_idx();
	}
	else if(typeView.equals("insert"))
			products_idx		=	Integer.parseInt(request.getParameter("products_idx"));

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
		readonly="readonly"value=<%=cDao.getName(vo.getCustomers_idx()) %>
		<%	}else if(typeView.equals("modify")){ %>
		readonly="readonly"value=<%=cDao.getName(vo.getCustomers_idx()) %>
		<%	}else{ %>
		readonly="readonly"value=<%=cVo.getUsername() %>
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">제목</td>
		<td class="right"><input type="text" name="review_title" size="40" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly" value=<%=vo.getReview_title() %> 
		<%	}else if(typeView.equals("modify")){ %>
		value=<%=vo.getReview_title() %>
		<%	}else{ %>
		placeholder="리뷰 제목"
		<%	} %>
		></td>
	</tr>
	<tr>
		<td class="left">내용</td>
		<td class="right"><textarea name="review_text" rows="15" cols="50" required="required"
		<%	if(typeView.equals("view")){ %>
		readonly="readonly"><%=vo.getReview_text() %> 
		<%	}else if(typeView.equals("modify")){ %>
		><%=vo.getReview_text() %>
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
		
		<%		if(vo.getCustomers_idx()==(cVo.getIdx())){ %>
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
</html>