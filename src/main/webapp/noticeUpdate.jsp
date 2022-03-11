<%@page import="notice.Notice"%>
<%@page import="notice.NoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>공지 수정</title>
	
	<style>
		
		.container{
			padding-top:100px;
		}
		.write{
			border-radius:20px;
			background-color: #000000;
			padding:60px;
		}
	</style>
	
	</head>
	<body>
	<%@include file = "header.jsp" %>
	<%
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		Notice notice = new NoticeDAO().notice(nNum);
		
	%>
	<div class="container row m-auto">
		<div class="col-3"></div>
		<div class="write col-6 p-auto">
			<form method="post" action="noticeUpdateAction.jsp?update=update&nNum=<%=nNum%>" onsubmit="return writeCh()">
				<input class="form-control mb-2" id="title" name="nTitle" type="text" maxlength="30" value="<%=notice.getnTitle()%>"/>
				<textarea class="nTitle form-control mb-2" id="text" name="nText" rows="7" ><%=notice.getnText()%></textarea>
				<input class="form-control mb-2" type="file"/>
				<input class="form-control mb-2" type="submit" value="수정하기"/>
				<input class="form-control mb-2" type="reset" value="원래대로"/>
				<input class="form-control mb-2" type="button" onclick="back()"value="뒤로가기"/>
			</form>
		</div>
		<div class="col-3"></div>
	</div>
	<script type="text/javascript">
		function writeCh(){
			var title = document.getElementById("title");
			var text = document.getElementById("text");
			
			if(title.value.length<2){
				alert('제목을 2글자 이상 입력 해주세요.');
				title.focus();
				title.select();
				return false;
			}
			if(!text.value){
				alert('내용을 입력 해주세요.');
				text.focus();
				text.select();
				return false;
			}
		}
		function back(){
			history.back();
		}
	</script>
	<%@include file = "footer.jsp" %>
	</body> 
</html>