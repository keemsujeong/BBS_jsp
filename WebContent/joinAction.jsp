<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="user" class="user.User" scope="page"/> 
<!--  아래의 변수를 모두 입력받아 만들어진 user라는인스턴스가조인함수를 수행하는 매개변수로 들어감 -->
 <jsp:setProperty name="user" property="userID" />  
 <jsp:setProperty name="user" property="userPassword"/>  
 <jsp:setProperty name="user" property="userName"/>
 <jsp:setProperty name="user" property="userGender"/>
 <jsp:setProperty name="user" property="userEmail"/>
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

	if(user.getUserID() == null){
			script.println("<script>");
			script.println("alert('아이디를 입력해주세요.')");
			script.println("history.back()"); //이전페이지로 돌아감
			script.println("</script>");
	}
	else if(user.getUserPassword() == null){
		script.println("<script>");
		script.println("alert('비밀번호를 입력해주세요.')");
		script.println("history.back()"); //이전페이지로 돌아감
		script.println("</script>");
	}
	else if(user.getUserName() == null){
		script.println("<script>");
		script.println("alert('이름을 입력해주세요.')");
		script.println("history.back()"); //이전페이지로 돌아감
		script.println("</script>");
	}
	else if(user.getUserEmail() == null){
		script.println("<script>");
		script.println("alert('이메일을 입력해주세요.')");
		script.println("history.back()"); //이전페이지로 돌아감
		script.println("</script>");
	}
	else if(user.getUserGender() == null){
		script.println("<script>");
		script.println("alert('성별을 입력해주세요.')");
		script.println("history.back()"); //이전페이지로 돌아감
		script.println("</script>");
	}
	else{
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
			
		if(result == -1){ //id는 기본키이기 때문에 중복이 불가능 따라서 데이터베이스 오류가 발생한 경우는 중복된 아이디 입력으로 -1이 리턴됨
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()"); 
			script.println("</script>");
		}
		else{
			session.setAttribute("userID", user.getUserID());
			script.println("<script>");
			script.println("location.href='main.jsp'"); //회원가입성공시 메인페이지로
			script.println("</script>");
		}
	}

	%>
</body>
</html>