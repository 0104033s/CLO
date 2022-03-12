<%@page import="java.io.PrintWriter"%>
<%@page import="noticeR.NoticeRDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="noticeR" class="noticeR.NoticeR"/>
<jsp:setProperty name="noticeR" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>Insert title here</title>
	
	</head>
	<body>
	<%
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		String userID = (String)session.getAttribute("userID");
		
		NoticeRDAO DAO = new NoticeRDAO();
		int result = DAO.write(nNum,noticeR.getrReply(), userID);
		if(result == -1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("location.href='notice.jsp?nNum="+nNum+"'");
			script.println("</script>");
		}
	%>
	</body> 
</html>