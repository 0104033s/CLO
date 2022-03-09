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
		session.invalidate();
	%>
	<script >
		location.href="index.jsp";
	</script>
	</body> 
</html>