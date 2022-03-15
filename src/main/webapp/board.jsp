<%@page import="board.Board"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
	<head>
	<title>게시물</title>
	<style>
		.container{
			padding-top:100px;
		}
		.table{
			width:100%;
			height: 100%;
			
		}
		
	</style>
	</head>
	<body>
		<%@include file="header.jsp" %>
		<%@include file="footer.jsp" %>
		<div class="container m-auto row">
			<div class="col-3"></div>
				<%	int pageNum=1;
					if(request.getParameter("pageNum")!=null)
						pageNum=Integer.parseInt(request.getParameter("pageNum"));
					
					String brand="";
					if(request.getParameter("brand")!=null)
						brand=request.getParameter("brand");
					
					String UserID = (String)session.getAttribute("userID");
					
					int bNum=0;
					if(request.getParameter("boardNum")!=null){
						bNum = Integer.parseInt(request.getParameter("boardNum"));
					}
					Board board = new BoardDAO().read(bNum);
					
					 
				%>
				
			<div class="col-6 border border-2">
				<table class="table">
					<tr>
						<td>브랜드
						<td><a href="boardList.jsp?pageNum=1&brand=<%=board.getBrand()%>"><%=board.getBrand() %></a>
						<td>제목
						<td><%=board.getbTitle() %>
						<td>번호
						<td><%=board.getbNum() %>
					</tr>
					<tr>
						<td>아이디
						<td><%=board.getUserID() %>
						<td>날짜
						<td><%=board.getbDate() %>
						<td>조회수
						<td><%=board.getbCnt() %>
					</tr>
					<%if(board.getbImg()!=null){ %>
					<tr>
						<td colspan="6">
						
							<img src="resource/img/board/<%=board.getbImg() %>">
					</tr>
					<%} %>
					<tr>
						<td colspan="6">
							<%=board.getbText() %>
						</td>
					</tr>
				</table>
				<div  style="text-align:right">
				<%if(userID.equals(board.getUserID())||admin==1){ %>
					<a href="boardUpdate.jsp?bNum=<%=board.getbNum() %>" class="btn btn-dark btn-sm">수정하기</a>
					<a href="boardUpdateAction.jsp?bNum=<%=board.getbNum() %>" class="btn btn-dark btn-sm">삭제하기</a>
					<%} %>
					<a href="boardList.jsp?pageNum=<%=pageNum%>&brand=<%=brand%>" class="btn btn-dark btn-sm">목록으로</a>
				</div>
			</div>
			<div class="col-3"></div>
		</div>
	</body> 
</html>