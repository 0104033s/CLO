<%@page import="reply.ReplyDAO"%>
<%@page import="reply.Reply"%>
<%@page import="board.Board"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
	<head>
	<%
	int bNum=0;
	if(request.getParameter("boardNum")!=null){
		bNum = Integer.parseInt(request.getParameter("boardNum"));
	}
	Board board = new BoardDAO().read(bNum); %>
	<title><%=board.getBrand() %>-<%=board.getbNum() %></title>
	<style>
		.container{
			padding-top:100px;
		}
		.reply{
			padding-top:50px;
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
					
					
					
					
					 
				%>
				
			<div class="col-6 ">
				<table class="table m-2 border border-2">
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
		<div class="container row m-auto" style="padding-bottom:150px;">
			<div class="col-2"></div>
			<div class="col-8 m-auto">
				<div class="mb-5" id="replyList" style="display:block;">
					<ul class="reple row border m-auto mb-2" style="text-align:center; list-style-type: none;">
						<li class="col-2">ID. </li>
						<li class="col-3">date.</li>
						<li class="col-5">내용</li>
					</ul>
					<%
						ReplyDAO replyDAO = new ReplyDAO();
						ArrayList<Reply> list = replyDAO.reply(bNum);
					
						if(list.isEmpty()){%>
						<ul class="m-auto mb-2" style="text-align:center; list-style-type:none;">
							<li>댓글이 없습니다.
						</ul>
						
						<%
						}for(int i=0; i<list.size();i++){
						
					%>
					<ul class="row m-auto mb-2 " id="reply<%=list.get(i).getrNum() %>"style="text-align:center; list-style-type: none; overflow:none; word-wrap:break-word; border-bottom-color: #0f0f0f; ">
						<li class="col-2"><%=list.get(i).getUserID() %></li>
						<li class="col-3"><%=list.get(i).getrDate() %></li>
						<li class="col-5"><%=list.get(i).getReply() %></li>
						<li class="col-2" >
						<%if(userID.equals(list.get(i).getUserID())){ %>
							<a class="btn btn-dark btn-sm" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">수정</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="javascript:;" onclick="return updateRe(<%=list.get(i).getrNum() %>)">수정하기</a></li>
								<li><a class="dropdown-item" href="replyUpdateAction.jsp?update=delete&rNum=<%=list.get(i).getrNum() %>&bNum=<%=bNum%>">삭제하기</a></li>
							</ul>
								<%} %>
					</ul>
				<!-- 댓글 수정 -->
					<div class="replyUpdate" id="replyUpdate<%=list.get(i).getrNum() %>" style="display:none;">
						<form action="replyUpdateAction.jsp?rNum=<%=list.get(i).getrNum() %>&bNum=<%=bNum%>&update=update&brand=<%=brand %>" method="post" onsubmit="return updateCk(<%=list.get(i).getrNum() %>)">
						<div class="input-group mb-2">
							<textarea id="update<%=list.get(i).getrNum() %>" name="reply" class="form-control"><%=list.get(i).getReply() %></textarea>
							<button class="btn btn-dark" type="submit" >수정하기</button>
						</div>
						</form>
					</div>
					<%} %>
				</div>
				<!-- 댓글 작성 -->
					<div >
					<form action="replyWriteAction.jsp?bNum=<%=bNum%>&brand=<%=brand %>" method="post" onsubmit="return rpCk()">
						<div class="input-group mb-2 col-8">
							<span class="input-group-text"><%=userID %></span>
							<textarea id="reply" name="reply" class="form-control"></textarea>
							<button class="btn btn-dark" type="submit" >댓글쓰기</button>
						</div>
					</form>
					</div>
			</div>
			<div class="col-2"></div>
		</div>
		<script>
		
		function rpCk(){//댓글작성
			var reply = document.getElementById("reply");
			
			if(!reply.value){
				alert('댓글을 입력 해주세요.');
				reply.select();
				reply.focus();
				return false;
			}
		}
		function updateRe(rNum){//댓글 수정 창 열기
			var reply = document.getElementById("replyUpdate"+rNum);
			var reply2 =document.getElementById("replyUpdate"+!rNum);
			var update = document.getElementById("update"+rNum);
			reply.style.display="block";
			update.focus();
			document.getElementById("reply"+rNum).style.display="none";
		}
		function updateCk(rNum){//댓글수정
			var reply = document.getElementById("update"+rNum);
			if(!reply.value){
				alert('댓글을 입력해주세요.');
				reply.select();
				reply.focus();
				return false;
			}
		}
	</script>
	</body> 
</html>