<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>Insert title here</title>
	
	</head>
	<body>
	<%	
		String tel1 = request.getParameter("userTel1");
		String tel3 = request.getParameter("userTel2");
		String tel2 = request.getParameter("userTel3");
		String userTel = tel1+"-"+tel2+"-"+tel3;
	
		UserDAO userDAO = new UserDAO();
	int result = userDAO.join(user.getUserID(),user.getUserPW(),user.getUserName(),user.getUserNickname()
			,userTel,user.getUserEmail(),user.getUserGender());
	
	if(result== -1 ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 이미 있습니다.')");		
		script.println("history.back()");		
		script.println("</script>");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");		
		script.println("location.href='login.jsp'");		
		script.println("</script>");
	}
	%>
	</body> 
</html>