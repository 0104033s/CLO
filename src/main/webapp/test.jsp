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
		<%@include file="header.jsp" %>
		<form action="test2.jsp" method="post">
			<input type="text" name="test1">
			<input type="submit" value=submit>
		</form>
		<%@include file="footer.jsp" %>
	</body> 
</html>