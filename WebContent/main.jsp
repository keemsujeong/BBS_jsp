<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--스크립트 문장을 실행할수 있도록  --> 
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>JSP게시판 웹사이트</title>
</head>
<body>

 <%
	String userID = null;
 	if(session.getAttribute("userID") != null){
		 userID = (String) session.getAttribute("userID"); //할당된 세션값을 넣어줌
 	}
 %>
<!--하나의 웹사이트의 전반적인 구성을 보여주는 역할  -->
<nav class="navbar navbar-default"> 
	<div class="navbar-header">
	
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded = "false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
			<a class="navbar-brand" href="main.jsp">JSP게시판 웹 사이트</a>
		</div>
		<div class="collpase navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){				
			 %>			 
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<!--현재 가리키고 있는 링크없음 -->
					<a href="#" class="dropdown-toggle" 
						data-toggle="dropdown"  role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<!-- ative 현재 선택된 페이지를 의미하며 한개밖에 쓸수 없ㅇㅁ -->
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
				</li>
			</ul>
		<%
				}else{
		%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<!--현재 가리키고 있는 링크없음 -->
					<a href="#" class="dropdown-toggle" 
						data-toggle="dropdown"  role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
				</li>
			</ul>
			<%		
				}
			%>
		</div>
</nav>
<div class="container">
	<div class="jumbotron">
		<div class="container">
			<h1>웹 사이트 소개</h1>
			<p>이 웹 사이트는 부트스트랩으로 만든 JSP웹 사이트 입니다.</p>
			<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p> 
		</div>
	</div>
</div>

</body>
</html>