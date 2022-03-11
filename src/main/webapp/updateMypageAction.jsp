<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>정보수정</title>
	
	</head>
	<body>
	<%
		String userID = (String)session.getAttribute("userID");
		UserDAO userDAO = new UserDAO();
		int result = userDAO.update(userID, user.getUserNickname(),user.getUserEmail());
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류.')");
			script.println("history.back()");
			script.println("/<script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");		
			script.println("location.href='mypage.jsp'");		
			script.println("</script>");
		}
	%>
	</body> 
</html>