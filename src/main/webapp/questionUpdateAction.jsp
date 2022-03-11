<%@page import="java.io.PrintWriter"%>
<%@page import="question.QuestionDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="question" class="question.Question" scope="page"/>
<jsp:setProperty name="question" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>문의글 수정</title>
	
	</head>
	<body>
	<%
	
	int qNum = Integer.parseInt(request.getParameter("qNum"));
	String update = request.getParameter("update");
	
	if(update.equals("delete")){
	QuestionDAO questionDAO = new QuestionDAO();
	int result = questionDAO.delete(qNum);
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB오류.')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("if(!confirm('정말 삭제하시겠습니까?')){");
		script.println("history.back()}else{");
		script.println("location.href='questionList.jsp?pageNum=1'}");
		script.println("</script>");
		}
	}else if(update.equals("update")){
		QuestionDAO questionDAO = new QuestionDAO();
		int result = questionDAO.update(question.getqTitle(),question.getqText(),qNum);
		if(result ==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정완료.')");
			script.println("location.href='questionList.jsp?pageNum=1'");
			script.println("</script>");
			}
	}
	
	%>
	</body> 
</html>