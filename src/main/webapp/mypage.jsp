<%@page import="user.User"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>



<!DOCTYPE html>
<html>
	<head>
		<title>마이페이지</title>
		<style>
			
			.container{
				padding-top:100px;
				padding-bottom:100px;
				height: 100%;
				
			}
			.mypage{
				border-radius: 20px;
				background-color: #000000;
				padding:60px;
			}
			p{
			color:#ffffff;
			margin: 10px;
			padd
			}
			
		</style>
	</head>
	
	<body>
	<%@include file="header.jsp" %>
	<%
		if(session.getAttribute("userID")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='login.jsp'");
		script.println("</script>");
		}
	%>
		<div class="container row m-auto">
			<div class="col-4"></div>
			<div class="mypage col-4 row">
				<ul class="list-group p-0">
				<% 
					
					User user = new UserDAO().mypage(userID);
				%>
					<p>아이디
					<li class="list-group-item"><%=user.getUserID() %></li>
					<p>이름
					<li class="list-group-item"><%=user.getUserName() %></li>
					<p>별명
					<li class="list-group-item"><%=user.getUserNickname() %></li>
					<p>전화번호
					<li class="list-group-item"><%=user.getUserTel() %></li>
					<p>이메일
					<li class="list-group-item"><%=user.getUserEmail() %></li>
					<p>성별
					<li class="list-group-item"><%=user.getUserGender() %></li>
				</ul>
				<a href="#" onclick="pwCheck()" class="btn btn-secondary col-8 offset-2 mt-3">정보 수정</a>
				<a href="#" onclick="pwCheck2()" class="btn btn-secondary col-8 offset-2 mt-3">회원 탈퇴</a>
				
				
			</div>
			<div class="col-4"></div>
		</div>
		<%@include file="footer.jsp" %>
		<script type="text/javascript">
			function pwCheck(){
				var pw = prompt('비밀번호를 입력하세요.');
				var pwcheck = <%=user.getUserPW()%>;
				if(pw==pwcheck)
					location.href='updateMypage.jsp';
				else{
					alert('비밀번호가 틀렸습니다.');
					return false;
				}
			}
			function pwCheck2(){
				var pw = prompt('회원 탈퇴를 원하시면 비밀번호를 입력해주세요.');
				var pwcheck = <%=user.getUserPW()%>;
				if(pw==pwcheck)
					location.href='deleteAction.jsp';
				else{
					alert('비밀번호가 틀렸습니다.');
					return false;
				}
			}
		</script>
	</body> 
</html>