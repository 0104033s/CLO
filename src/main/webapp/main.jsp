<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<title>메인</title>
</head>
<body>
	<%
		if(session.getAttribute("userID")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='login.jsp'");
		script.println("</script>");
		}
	%>
	<%@ include file="header.jsp" %>
	<%@include file="footer.jsp" %>
	

	<div class="container" style="height: 200px;">
	

	</div>
	
</body>
</html>