<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs.BbsDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> 
 <jsp:setProperty name="bbs" property="bbsTitle" />  
 <jsp:setProperty name="bbs" property="bbsContent"/>  
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
	<%
	PrintWriter script= response.getWriter();
	String userID = null;
	if(session.getAttribute("userID") != null){ //로그인되어있다면
		userID = (String) session.getAttribute("userID"); //할당된 세션값을 넣어줌
	}
		
	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	//bbs:자바빈의 아이디
	else if(bbs.getBbsContent() == null){
		script.println("<script>");
		script.println("alert('내용을 입력해 주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(bbs.getBbsTitle() == null){
		script.println("<script>");
		script.println("alert('제목을 입력해 주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else{		
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		if(result == -1){
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else{
			script.println("<script>");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>