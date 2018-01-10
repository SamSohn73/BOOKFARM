<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int delGoodsNum = Integer.parseInt(request.getParameter("delgoods"));
	session.removeAttribute("goods"+delGoodsNum);
	response.sendRedirect("result.jsp");
%>