<%@page import="java.io.PrintWriter"%>
<%@page import="questionR.QuestionRDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="questionR" class="questionR.QuestionR"/>
<jsp:setProperty name="questionR" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>Insert title here</title>
	
	</head>
	<body>
	<%	String update = request.getParameter("update");
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		if(update.equals("update")){	
			QuestionRDAO DAO = new QuestionRDAO();
			int result = DAO.update(questionR.getrReply(), rNum);
			if(result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='question.jsp?qNum="+qNum+"'");
				script.println("</script>");
			}
		}else if(update.equals("delete")){
			QuestionRDAO DAO = new QuestionRDAO();
			int result= DAO.delete(rNum);
			if(result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("if(!confirm('삭제 하시겠습니까?')){");
				script.println("history.back()");
				script.println("}else{");
				script.println("location.href='question.jsp?qNum="+qNum+"'}");
				script.println("</script>");
			
			}
		}
	%>
	</body> 
</html>