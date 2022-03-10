<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
%>
<%
		String userID =null;
		if(session.getAttribute("userID")!=null){
			userID=(String) session.getAttribute("userID");
		}
	%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<nav class="navbar navbar-expand navbar-dark bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="main.jsp">메인</a>
		<div class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto ">
				<li class="nav-item">
					<a class="nav-link" href="notice.jsp?pageNum=1">공지</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">문의</a>
				</li>
				<li  class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">게시판3</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">ALL</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#">list1</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#">ADD</a></li>
					</ul>
				</li>
			</ul>
			<%if(userID!=null){ %>
			<ul class="navbar-nav ms-auto ">
				<li  class="nav-item">
					<a class="nav-link" href="mypage.jsp"><%=userID %></a>
				</li>
				
				<li class="nav-item">
					<a class="nav-link" href="logoutAction.jsp">로그아웃</a>
				</li>
			</ul>
			<%}else if(userID==null){ %>
			<ul class="navbar-nav ms-auto ">
				<li  class="nav-item">
					<a class="nav-link" href="join.jsp">회원가입</a>
				</li>
				
				<li class="nav-item">
					<a class="nav-link" href="login.jsp">로그인</a>
				</li>
			</ul>
			<%} %>
			
		</div>
	</div>
</nav>