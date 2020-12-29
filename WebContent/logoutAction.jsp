<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
	<%
		session.invalidate(); //현재 페이지에 접속한 회원의 세션을 빼앗기
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>