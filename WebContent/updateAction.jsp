<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs.BbsDAO" %>
  <%@ page import="bbs.Bbs" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
<!-- 회원가입을 처리해주는 페이지(결과,UI) -->
	<%
	PrintWriter script= response.getWriter();
	String userID = null;
	if(session.getAttribute("userID") != null){ //로그인되어있다면
		userID = (String) session.getAttribute("userID"); //할당된 세션값을 넣어줌
	}
	
 	
 	int bbsID= 0;
 	
 	if(request.getParameter("bbsID") != null){
 		bbsID= Integer.parseInt(request.getParameter("bbsID"));
 	}
 	

	BbsDAO bbsDAO = new BbsDAO();
	int result = bbsDAO.update(bbsID,request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
	if(result == -1){
		script.println("<script>");
		script.println("alert('글수정에 실패했습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	else{
		script.println("<script>");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}

	%>
</body>
</html>