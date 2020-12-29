<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
<style type="text/css">
	a,a :hover{
		color:#000000;  /* 글자색 검정 */
		text-decoration:none; /* 밑줄 없앰 */	
	}
</style>
</head>
<body>
 <%
	String userID = null;
 	if(session.getAttribute("userID") != null){
		 userID = (String) session.getAttribute("userID"); //할당된 세션값을 넣어줌
 	}
 	
 	int pageNum = 1; //기본페이지
 	if(request.getParameter("pageNum") != null){
 		pageNum = Integer.parseInt(request.getParameter("pageNum"));
 	}
 %>
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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){				
			 %>			 
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
						data-toggle="dropdown"  role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
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
	<div class="row">
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
			<thead>
				<tr>
					<th style="background-color:#eeeeee; text-align:center;">번호</th>
					<th style="background-color:#eeeeee; text-align:center;">제목</th>
					<th style="background-color:#eeeeee; text-align:center;">작성자</th>
					<th style="background-color:#eeeeee; text-align:center;">작성일</th>
				</tr>
			</thead>
			<tbody>
	 			<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNum);
					for(int i = 0; i < list.size(); i++){
				%>
				<tr>
					<td><%= list.get(i).getBbsID() %></td>
					<td> <a href ="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"> <%= list.get(i).getBbsTitle() %> </a></td>
					<td> <%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
				</tr>
			<%
				}
			
			%> 
			</tbody>
		</table>
		<%
			if(pageNum != 1){	//페이지가 2개 이상이기 때문에 이전페이지 생성
		%>
			<a href="bbs.jsp?pageNum=<%=pageNum - 1 %>" class="btn btn-success btn-arraw-left ">이전</a>		
		<%
			}if(bbsDAO.nextPage(pageNum + 1)){ //다음페이지가 존재한다면 다음페이지로 넘어감
		%>
			<a href="bbs.jsp?pageNum=<%= pageNum + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
		<%
			}
		%>
		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
	</div>
</div>
</body>
</html>