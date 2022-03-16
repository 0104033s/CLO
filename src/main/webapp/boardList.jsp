<%@page import="reply.ReplyDAO"%>
<%@page import="brand.Brand"%>
<%@page import="brand.BrandDAO"%>
<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>게시판</title>
	<style>
		.container{
			padding-top:100px;
		}
		.board{
			
		}
		.table{
			text-align: center;
			padding-top: 10px;
		}
	</style>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	</head>
	<body>
	<%@include file = "header.jsp" %>
	<%@include file = "footer.jsp" %>
	
	<div class="container row m-auto">
		<div class="col-2" style="text-align:center">
		<%
			int pageNum =Integer.parseInt(request.getParameter("pageNum"));
			String brand =(String)request.getParameter("brand");
			String array = request.getParameter("array");
			if(request.getParameter("array")!=null){
				array = request.getParameter("array");
			}
			ArrayList<Brand> brandList =new BrandDAO().brandList("");
			if(brand==""){
		%><h2>ALL</h2><%}else{ %>
			<h2><%=brand %></h2>
			<%} %>
			<ul class="text-align-center list-group list-group-flush pt-">
				<li class="list-group-item"><a href="boardList.jsp?pageNum=1&brand=">ALL</a>
				<%for(int i=0;i<brandList.size();i++){ %>
				<li class="list-group-item"><a href="boardList.jsp?pageNum=1&brand=<%=brandList.get(i).getbName() %>"><%=brandList.get(i).getbName() %></a>
				<%} %>
			</ul>
		</div>
		<div class="board col-8">
			<table class="table">
				<thead>
					<tr>
						<th>번호
						<th>브랜드
						<th>제목
						<th>아이디
						<th>날짜
						<th>조회
					</th>
				</thead>
				<colgroup>
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:40%">
						<col style="width:10%">
						<col style="width:20%">
						<col style="width:10%">
					</colgroup>
				<%
					ArrayList<Board> list = new BoardDAO().boardList(brand, pageNum);
					ReplyDAO replyDAO = new ReplyDAO();
				%>
				
				<tbody>
				<%
					if(list.isEmpty()){
						%>
					<tr>
						<td colspan="6">게시물이 없습니다.
					</tr>	
						<%
					}
					for(int i=0; i<list.size();i++){
						int reply = replyDAO.count(list.get(i).getbNum());
						%>
						
					<tr>
						<td><%=list.get(i).getbNum() %></td>
						<td><%=list.get(i).getBrand() %>
						<td><a onclick="return readCk()"href="board.jsp?boardNum=<%=list.get(i).getbNum() %>&pageNum=<%=pageNum%>&brand=<%=brand%>"><%=list.get(i).getbTitle() %>
						<%if(list.get(i).getbImg()!=null){%>
							<span class="material-icons" style="font-size:13px">photo_camera</span>
						<%}%></a>
						<%if(reply!=0){ %><span class="badge badge-sm bg-dark rounded-pill" ><%=reply %></span><%} %>
						<td><%=list.get(i).getUserID() %>
						<td><%=list.get(i).getbDate() %>
						<td><%=list.get(i).getbCnt() %>
					</tr>
					<%} %>
				
				</tbody>
			</table>
			<div class="write" style="text-align: right;">
				<a href="boardWrite.jsp" onclick="return writeCk()" class="btn btn-dark ">글쓰기</a>
			</div>
		<%	BoardDAO pageDAO = new BoardDAO();
	  		int pageCnt =pageDAO.pageNum(brand); 

	  	%>
			<nav>
			  <ul class="pagination pagination-sm justify-content-center">
			  <%if(pageNum!=1){ %>
			    <li class="page-item ">
			      <a class="page-link" href="boardList.jsp?pageNum=<%=pageNum-1%>&brand=<%=brand%>">이전</a>
			    </li>
			    <%}
			  	if(pageCnt>1){
			    for(int i=0;i<pageCnt;i++){ %>
			    <li class="page-item"><a class="page-link" href="boardList.jsp?pageNum=<%=i+1 %>&brand=<%=brand%>"><%=i+1 %></a></li>
			   <%}
			    }%>
			   
			   <%if(pageCnt!=pageNum){ %>
			    <li class="page-item">
			      <a class="page-link" href="boardList.jsp?pageNum=<%=pageNum+1%>&brand=<%=brand%>">다음</a>
			    </li>
			    <%} %>
			  </ul>
			</nav>
		</div>
		<div class="col-2"></div>
	</div>
	<script type="text/javascript">
	function writeCk(){
		if(<%=userID%>==null){
			alert('비회원은 글을 작성할 수 없습니다.');
			return false;
		}
	}
		function readCk(){
			if(<%=userID%>==null){
				alert('로그인을 해주세요.');
				return false;
			}
		}
		function array(){
			var selected = document.getElementById("array");
			var optionVal = selected.options[selected.selectedIndex].value;
		}
	</script>
	</body> 
</html>