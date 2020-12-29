<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="user" class="user.User" scope="page"/> 
 <jsp:setProperty name="user" property="userID" />  
  <jsp:setProperty name="user" property="userPassword"/>  
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
		
		
		if(userID != null){
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){
			session.setAttribute("userID", user.getUserID());
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()"); //이전페이지로 돌아감
				script.println("</script>");
		}
		else if(result == -1){
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()"); //이전페이지로 돌아감
			script.println("</script>");
		}
		else if(result == -2){
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다')");
				script.println("history.back()"); //이전페이지로 돌아감
				script.println("</script>");
		}
	%>
</body>
</html>