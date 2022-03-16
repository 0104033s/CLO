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
	<title>댓글 수정</title>
	
	</head>
	<body>
	<%
		ReplyDAO replyDAO = new ReplyDAO();
		String update =request.getParameter("update");
		int rNum=Integer.parseInt(request.getParameter("rNum"));
		int bNum=Integer.parseInt(request.getParameter("bNum"));
		String brand=request.getParameter("brand");
		if(update.equals("update")){
			int result = replyDAO.update(rNum, reply.getReply());
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='board.jsp?boardNum="+bNum+"&brand="+brand+"'");
				script.println("</script>");
			}
		}else if(update.equals("delete")){
			int result = replyDAO.delete(rNum);
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='board.jsp?boardNum="+bNum+"&brand="+brand+"'");
				script.println("</script>");
			}
		}
	%>
	</body> 
</html>