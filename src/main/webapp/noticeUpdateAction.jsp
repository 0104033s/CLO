<%@page import="java.io.PrintWriter"%>
<%@page import="notice.NoticeDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="notice" class="notice.Notice" scope="page"/>
<jsp:setProperty name= "notice" property = "*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>공지 수정</title>
	
	</head>
	<body>
	<%
	String update = request.getParameter("update");
	int nNum = Integer.parseInt(request.getParameter("nNum"));
	if(update.equals("update")){
		NoticeDAO noticeDAO = new NoticeDAO();
		int result = noticeDAO.update(notice.getnTitle(),notice.getnText(),nNum);
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정완료.')");
			script.println("location.href='noticeList.jsp?pageNum=1'");
			script.println("</script>");
		}
	}else if(update.equals("delete")){
		NoticeDAO noticeDAO = new NoticeDAO();
		int result = noticeDAO.delete(nNum);
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("if(!confirm('정말 삭제하시겠습니까?')){");
			script.println("history.back()");
			script.println("}else{");
			script.println("location.href='noticeList.jsp?pageNum=1'}");
			script.println("</script>");
		}
	}
	%>
	
	</body> 
</html>