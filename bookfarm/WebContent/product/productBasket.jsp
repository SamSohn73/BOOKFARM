<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gq.bookfarm.action.*"%>
<%@ page import="gq.bookfarm.control.*"%>
<%@ page import="gq.bookfarm.dao.*"%>
<%@ page import="gq.bookfarm.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" >
<title>basket list</title>
<script language=JavaScript>
	function check(code) {
		document.location.href = "cartcontrol.jsp?action=edit&code=" + code;
	}
	function order() {
		document.location.href = "cartcontrol.jsp?action=order";
	}
</script>
</head>
<body>

</body>
</html>