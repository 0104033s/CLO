<%@page import="user.User"%>
<%@page import="notice.Notice"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="user.UserDAO"%>
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
		}
		
	</style>
	</head>
	<body>
	<%@include file="header.jsp" %>
	<%
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		Notice notice= new NoticeDAO().notice(nNum);	
		UserDAO userDAO = new UserDAO();
		int admin = userDAO.admin(userID);
	%>
	<!-- 게시물 -->
	<div class="container row m-auto">
			<div class="col-2"></div>
			<div class="notice col-8 m-auto">
				<table class="table">
					<tr>
						<td colspan="2" class="title">제목
						<td colspan="2"><%=notice.getnTitle() %>
						<td class="title">번호
						<td><%=notice.getnNum() %>
					</tr>
					<tr>
						<td class="title">아이디
						<td><%=notice.getUserID() %>
						<td class="title">날짜
						<td><%=notice.getnDate() %>
						<td class="title">조회수
						<td><%=notice.getnCount() %>
					</tr>
					<tr>
						<td colspan="12" class="title">글내용
					</tr>
					<tr>
						<td colspan="12" style="height: 100%"><%=notice.getnText() %>
					</tr>
				</table>
				<div style="padding-top:20px; text-align:right;">
					<%if(userID.equals(notice.getUserID()) ||admin == 1){ %>
					<a href="noticeUpdate.jsp?nNum=<%=notice.getnNum() %>" class="btn btn-dark">수정</a>
					<a href="noticeUpdateAction.jsp?update=delete&nNum=<%=notice.getnNum() %>" class="btn btn-dark">삭제</a>
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