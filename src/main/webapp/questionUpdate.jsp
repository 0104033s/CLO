
<%@page import="question.QuestionDAO"%>
<%@page import="question.Question"%>
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
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		Question question = new QuestionDAO().question(qNum);
	%>
	<div class="container row m-auto">
		<div class="col-3"></div>
		<div class="write col-6 p-auto">
			<form method="post" action="questionUpdateAction.jsp?update=update&qNum=<%=qNum%>" onsubmit="return writeCh()">
				<input class="form-control mb-2" id="title" name="qTitle" type="text" maxlength="30" value="<%=question.getqTitle()%>"/>
				<textarea class="nTitle form-control mb-2" id="text" name="qText" rows="7" ><%=question.getqText()%></textarea>
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