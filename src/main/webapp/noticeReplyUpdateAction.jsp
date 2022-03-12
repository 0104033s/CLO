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
	<%	String update = request.getParameter("update");
		int nNum = Integer.parseInt(request.getParameter("nNum"));
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		if(update.equals("update")){	
			NoticeRDAO DAO = new NoticeRDAO();
			int result = DAO.update(noticeR.getrReply(), rNum);
			if(result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='notice.jsp?nNum="+nNum+"'");
				script.println("</script>");
			}
		}else if(update.equals("delete")){
			NoticeRDAO DAO = new NoticeRDAO();
			int result= DAO.delete(rNum);
			if(result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("if(!confirm('삭제 하시겠습니까?')){");
				script.println("history.back()");
				script.println("}else{");
				script.println("location.href='notice.jsp?nNum="+nNum+"'}");
				script.println("</script>");
			
			}
		}
	%>
	</body> 
</html>