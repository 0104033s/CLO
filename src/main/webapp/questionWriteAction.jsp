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
	<title>Insert title here</title>
	
	</head>
	<body>
	<%
		String userID = (String)session.getAttribute("userID");
		QuestionDAO questionDAO = new QuestionDAO();
		int result = questionDAO.write(question.getqTitle(),question.getqText(),userID);
		if(result==-1){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("location.href='questionList.jsp?pageNum=1'");
			script.println("</script>");
		}
	%>
	</body> 
</html>