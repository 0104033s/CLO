<%@page import="user.UserDAO"%>
<%@page import="question.Question"%>
<%@page import="question.QuestionDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
%>

<!DOCTYPE html>
<html>
	<head>
	<title>게시물 제목</title>
	<style>
		.container{
			padding-top:100px;
		}
		.notice{
			border-radius: 20px;
			border-color:#000000;
			font-size: 15px;
			height: 500px;
			background-color: #000000;
			padding:20px;
		}
		.table{
			background-color: #ffffff;
			height: 100%;
		}
		.title{
			padding:3px;
			font-size: 12px;
		}
	</style>
	</head>
	<body>
	<%@include file="header.jsp" %>
	
	<!-- 게시물 -->
	<%
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		Question question = new QuestionDAO().question(qNum);
		UserDAO userDAO = new UserDAO();
		int admin = userDAO.admin(userID);
	%>
	<div class="container row m-auto">
			<div class="col-2"></div>
			<div class="notice col-8 m-auto">
				<table class="table">
					<tr>
						<td colspan="2" class="title">제목
						<td colspan="2"><%=question.getqTitle() %>
						<td class="title">번호
						<td><%=question.getqNum() %>
					</tr>
					<tr>
						<td class="title">아이디
						<td><%=question.getUserID() %>
						<td class="title">날짜
						<td><%=question.getqDate() %>
						<td class="title">조회수
						<td><%=question.getqCount() %>
					</tr>
					<tr>
						<td colspan="12" class="title">글내용
					</tr>
					<tr>
						<td colspan="12" style="height: 100%"><%=question.getqText() %>
					</tr>
				</table>
				
				<div style="padding-top:20px; text-align:right;">
					<%if(userID.equals( question.getUserID())||admin == 1){ %>
					<a href="questionUpdate.jsp?qNum=<%=question.getqNum() %>" class="btn btn-dark">수정</a>
					<a href="questionUpdateAction.jsp?update=delete&qNum=<%=question.getqNum() %>" class="btn btn-dark">삭제</a>
					<%} %>
					<a href="#" onclick="back()" class="btn btn-dark">목록</a>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		
		<!-- 댓글 -->
		<div class="container row m-auto" style="padding-bottom:150px;">
			<div class="col-2"></div>
			<div class="notice col-8 m-auto">
				<table class="table">
						<tr>
							<td colspan="1" class="title">아이디
							<td colspan="1">
							<td colspan="1" class="title">날짜
							<td colspan="1">
							<td colspan="2" class="title">추천
						</tr>
					</table>
			</div>
			<div class="col-2"></div>
		</div>
	<%@include file="footer.jsp" %>
	<script>
		function back(){
			history.back();
		}
	</script>
	</body> 
</html>