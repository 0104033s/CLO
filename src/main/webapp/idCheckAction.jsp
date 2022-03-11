<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>Insert title here</title>
	
	</head>
	<body>
		<%
			String userID = request.getParameter("userID");
			System.out.println(userID);
			UserDAO userDAO = new UserDAO();
			int result = userDAO.idCk(userID);
			if(result == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('사용할 수 없는 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('사용 가능한 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
	</body> 
</html>