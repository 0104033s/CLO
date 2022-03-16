<%@page import="java.io.PrintWriter"%>
<%@page import="reply.ReplyDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="reply" class="reply.Reply" scope="page"/>
<jsp:setProperty name="reply" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>Insert title here</title>
	
	</head>
	<body>
	<%
		int bNum = Integer.parseInt(request.getParameter("bNum"));
		String userID = (String)session.getAttribute("userID");
		String brand=request.getParameter("brand");
		ReplyDAO replyDAO = new ReplyDAO();
		int result = replyDAO.write(bNum, reply.getReply(), userID);
		if(result==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='board.jsp?boardNum="+bNum+"&brand="+brand+"'");
			script.println("</script>");
		}
	%>
	</body> 
</html>