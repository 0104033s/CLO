<%@page import="question.QuestionDAO"%>
<%@page import="question.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>문의</title>
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
							
							if(request.getParameter("pageNum")!= null){
								pageNum = Integer.parseInt(request.getParameter("pageNum"));
							}
							QuestionDAO questionDAO = new QuestionDAO();
							if(admin==0){
							ArrayList<Question> list = new QuestionDAO().questionList(userID,pageNum);
							if(list.isEmpty()){%>
							<tr style="text-align:center;">
								<td colspan="5" >문의 글이 없습니다.</td>
							</tr>
							<%
							}
							for(int i=0; i<list.size(); i++){
						%>
							<tr>
								<td><%=list.get(i).getqNum() %>
								<td><a href="question.jsp?qNum=<%=list.get(i).getqNum()%>"><%=list.get(i).getqTitle() %></a>
								<td id="userID"><%=list.get(i).getUserID()%>
								<td><%=list.get(i).getqDate() %>
								<td><%=list.get(i).getqCount() %>
							</tr>
							<%} %>
							<%}else if(admin==1){
							ArrayList<Question> list = new QuestionDAO().adminList(pageNum);
							if(list.isEmpty()){%>
							<tr style="text-align:center;">
								<td colspan="5" >문의 글이 없습니다.</td>
							</tr>
							<%
							}
								for(int i=0; i<list.size(); i++){
								%>
								<tr>
									<td><%=list.get(i).getqNum() %>
									<td><a href="question.jsp?qNum=<%=list.get(i).getqNum()%>"><%=list.get(i).getqTitle() %></a>
									<td id="userID"><%=list.get(i).getUserID()%>
									<td><%=list.get(i).getqDate() %>
									<td><%=list.get(i).getqCount() %>
								</tr>
								<%}}else{ %>
								<tr style="text-align:center;">
								<td colspan="5" >로그인을 해주세요. <a href="login.jsp">로그인</a></td>
							</tr>
								<%} %>
						</tbody>
					</table>
					<%if(admin==1){ %>
					<div class="col-12 ">
						<nav>
						  <ul class="pagination pagination-sm justify-content-center">
						  <%if(pageNum!=1){ %>
						 	<li class="page-item"><a class="page-link" href="questionList.jsp?pageNum=<%=pageNum-1%>">이전</a></li>
						 	<%} 
						  QuestionDAO pageDAO = new QuestionDAO();
						  int pageCnt =pageDAO.adminPage();
						  	if(pageCnt!=1){
						 	for(int i=0; i<pageCnt;i++){
						 	%>
						    <li class="page-item "><a class="page-link" href="questionList.jsp?pageNum=<%=i+1%>"><%=i+1%></a></li>
						   
						    <%} 
						  	}
						    if(pageNum!=pageCnt){
						    %>
						 	<li class="page-item"><a class="page-link" href="questionList.jsp?pageNum=<%=pageNum+1%>">다음</a></li>
						  	<%} %>
						  </ul>
						</nav>
					</div>
					<%}else if(admin==0){%>
					<div class="col-12 ">
						<nav>
						  <ul class="pagination pagination-sm justify-content-center">
						  <%if(pageNum!=1){ %>
						 	<li class="page-item"><a class="page-link" href="questionList.jsp?pageNum=<%=pageNum-1%>">이전</a></li>
						 	<%} 
						  QuestionDAO pageDAO = new QuestionDAO();
						  int pageCnt =pageDAO.page(userID);
						  	if(pageCnt!=1){
						 	for(int i=0; i<pageCnt;i++){
						 	%>
						    <li class="page-item "><a class="page-link" href="questionList.jsp?pageNum=<%=i+1%>"><%=i+1%></a></li>
						   
						    <%} 
						  	}
						    if(pageNum!=pageCnt){
						    %>
						 	<li class="page-item"><a class="page-link" href="quesiontList.jsp?pageNum=<%=pageNum+1%>">다음</a></li>
						  	<%} %>
						  </ul>
						</nav>
					</div>
					<%} %>
					
					
					<div class="col-12" style="text-align:right">
					<a href="questionWrite.jsp" onclick="return writeCk()" class="btn btn-dark">글쓰기</a>
					</div>
					
				</div>
				<div class="col-2"></div>
			</div>
		<%@include file="footer.jsp" %>
		<script type="text/javascript">
		function writeCk(){
			if(<%=userID%>==null){
				alert('비회원은 글을 작성할 수 없습니다.');
				return false;
			}
		}
		</script>
	
	</body> 
</html>