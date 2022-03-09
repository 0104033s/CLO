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
	<%String test1 = request.getParameter("test1");%>
	test1 : <%=test1%>
	<%@include file="footer.jsp" %>
	</body> 
</html>