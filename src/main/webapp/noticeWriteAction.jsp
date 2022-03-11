<%@page import="java.io.PrintWriter"%>
<%@page import="notice.NoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="notice" class="notice.Notice" scope="page"/>
<jsp:setProperty name="notice" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>공지 등록</title>
	
	</head>
	<body>
	<%
		String userID = (String)session.getAttribute("userID");
		
		NoticeDAO noticeDAO = new NoticeDAO();
		int result = noticeDAO.write(notice.getnTitle(),userID,notice.getnText());
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("history.back()");
			script.println("</script>");		
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='noticeList.jsp?pageNum=1'");
			script.println("</script>");
		}
	%>
	
	</body> 
</html>