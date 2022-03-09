<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>회원탈퇴</title>
	
	</head>
	<body>
	<% 
		String userID = (String)session.getAttribute("userID");
		UserDAO userDAO = new UserDAO();
		int result = userDAO.delete(userID);
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("/<script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("if(confirm('정말로 탈퇴하시겠습니까?'))");
			script.println("location.href='index.jsp'");
			script.println("else history.back()");
			script.println("</script>");
			session.invalidate();
		}
	%>
	</body> 
</html>