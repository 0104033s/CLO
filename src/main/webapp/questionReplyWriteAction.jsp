<%@page import="questionR.QuestionRDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="noticeR" class="noticeR.NoticeR"/>
<jsp:setProperty name="noticeR" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>Insert title here</title>
	
	</head>
	<body>
	<%
		int qNum = Integer.parseInt(request.getParameter("qNum"));
		String userID = (String)session.getAttribute("userID");
		
		QuestionRDAO DAO = new QuestionRDAO();
		int result = DAO.write(qNum,noticeR.getrReply(), userID);
		if(result == -1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("location.href='question.jsp?qNum="+qNum+"'");
			script.println("</script>");
		}
	%>
	</body> 
</html>