<%@page import="java.util.ArrayList"%>
<%@page import="noticeR.NoticeR"%>
<%@page import="noticeR.NoticeRDAO"%>
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

			font-size: 15px;
			height: 500px;

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
		
	%>
	<!-- 게시물 -->
	<div class="container row m-auto">
			<div class="col-2"></div>
			<div class="notice col-8 m-auto">
				<table class="table border border-2">
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
						<td colspan="12" style="height: 100%; overflow:hidden; word-break:break-all;"><%=notice.getnText() %>
					</tr>
				</table>
				<div style="padding-top:20px; text-align:right;">
					<%if(userID.equals(notice.getUserID()) ||admin == 1){ %>
					<a href="noticeUpdate.jsp?nNum=<%=notice.getnNum() %>" class="btn btn-dark">수정</a>
					<a href="noticeUpdateAction.jsp?update=delete&nNum=<%=notice.getnNum() %>" class="btn btn-dark">삭제</a>
					<%} %>
					<a href="noticeList.jsp?pageNum=1"  class="btn btn-dark">목록</a>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		
		<!-- 댓글 -->
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
						NoticeRDAO rDAO = new NoticeRDAO();
						ArrayList<NoticeR> list = rDAO.list(nNum);
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
						<li class="col-5"><%=list.get(i).getrReply() %></li>
						<li class="col-2" >
						<%if(userID.equals(list.get(i).getUserID())){ %>
							<a class="btn btn-dark btn-sm" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">수정</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="javascript:;" onclick="return updateRe(<%=list.get(i).getrNum() %>)">수정하기</a></li>
								<li><a class="dropdown-item" href="noticeReplyUpdateAction.jsp?update=delete&rNum=<%=list.get(i).getrNum() %>&nNum=<%=nNum%>">삭제하기</a></li>
							</ul>
								<%} %>
					</ul>
				<!-- 댓글 수정 -->
					<div class="replyUpdate" id="replyUpdate<%=list.get(i).getrNum() %>" style="display:none;">
						<form action="noticeReplyUpdateAction.jsp?rNum=<%=list.get(i).getrNum() %>&nNum=<%=nNum%>&update=update" method="post" onsubmit="return updateCk(<%=list.get(i).getrNum() %>)">
						<div class="input-group mb-2">
							<textarea id="update<%=list.get(i).getrNum() %>" name="rReply" class="form-control"><%=list.get(i).getrReply() %></textarea>
							<button class="btn btn-dark" type="submit" >수정하기</button>
						</div>
						</form>
					</div>
					<%} %>
				</div>
				<!-- 댓글 작성 -->
					<div >
					<form action="noticeReplyWriteAction.jsp?nNum=<%=nNum%>" method="post" onsubmit="return rpCk()">
						<div class="input-group mb-2 col-8">
							<span class="input-group-text"><%=userID %></span>
							<textarea id="reply" name="rReply" class="form-control"></textarea>
							<button class="btn btn-dark" type="submit" >댓글쓰기</button>
						</div>
					</form>
					</div>
			</div>
			
			<div class="col-2"></div>
		</div>
	<%@include file="footer.jsp" %>
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