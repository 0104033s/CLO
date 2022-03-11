<%@page import="notice.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>공지</title>
	<style>
		.container{
			padding-top:200px;
			
		}
		.notice{
			background-color: #0000000;
		}
		.table{
			width:600px;
		}
		th{
		font-size: 15px;
		}
	</style>
	</head>
	<body>
		<%@include file="header.jsp" %>
			<div class="container row m-auto">
				<div class="col-2"></div>
				<div class="notice col-8">
					<table class="table">
						<colgroup>
							<col width="10%">
							<col width="40%">
							<col width="20%">
							<col width="20%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr style="text-align:center;">
								<th>번호
								<th>제목
								<th>작성자
								<th>날짜
								<th>조회
							</tr>
						</thead>
						<tbody>
						<%	int pageNum = 1;
							
							if(pageNum == 1){
								pageNum = Integer.parseInt(request.getParameter("pageNum"));
							}
						NoticeDAO noticeDAO = new NoticeDAO();
							ArrayList<Notice> list = noticeDAO.noticeList(pageNum);
							for(int i=0; i<list.size(); i++){
						%>
							<tr>
								<td><%=list.get(i).getnNum() %>
								<td><a href="notice.jsp?nNum=<%=list.get(i).getnNum()%>"><%=list.get(i).getnTitle() %></a>
								<td><%=list.get(i).getUserID()%>
								<td><%=list.get(i).getnDate() %>
								<td><%=list.get(i).getnCount() %>
							</tr>
							<%} %>
						</tbody>
					</table>
					<div class="col-12 " >
						<nav>
						  <ul class="pagination pagination-sm justify-content-center">
						  <%if(pageNum!=1){ %>
						 	<li class="page-item"><a class="page-link" href="noticeList.jsp?pageNum=<%=pageNum-1%>">이전</a></li>
						 	<%} 
						  NoticeDAO pageDAO = new NoticeDAO();
						  int pageCnt =pageDAO.page();
						  	if(pageCnt!=1){
						 	for(int i=0; i<pageCnt;i++){
						 	%>
						    <li class="page-item "><a class="page-link" href="noticeList.jsp?pageNum=<%=i+1%>"><%=i+1%></a></li>
						   
						    <%} 
						  	}
						    if(pageNum!=pageCnt){
						    %>
						 	<li class="page-item"><a class="page-link" href="noticeList.jsp?pageNum=<%=pageNum+1%>">다음</a></li>
						  	<%} %>
						  </ul>
						</nav>
					</div>
					<%UserDAO userDAO = new UserDAO();
						int result=userDAO.admin(userID);
						
						if(result == 1){
					%>
					<div class="col-12" style="text-align:right">
					<a href="noticeWrite.jsp" class="btn btn-dark">글쓰기</a>
					</div>
					<%} %>
				</div>
				<div class="col-2"></div>
			</div>
		<%@include file="footer.jsp" %>
	</body> 
</html>