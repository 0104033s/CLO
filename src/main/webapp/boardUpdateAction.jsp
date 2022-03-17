<%@page import="board.Board"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>게시판 수정</title>
	</head>
	<body>
	<%
		String brand = request.getParameter("brand");
		int bNum = Integer.parseInt(request.getParameter("bNum"));
		String update=request.getParameter("update");
		if(update.equals("update")){
			int result = new BoardDAO().update(board.getbTitle(),board.getbText(), brand, bNum);
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='board.jsp?boardNum="+bNum+"'");
				script.println("</script>");
			}
		}else if(update.equals("delete")){
			int result = new BoardDAO().delete(bNum);
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("if(!confirm('정말 삭제 하시겠습니까?')){");
				script.println("history.back()");
				script.println("}else{");
				script.println("location.href='boardList.jsp?pageNum=1&brand='}");
				script.println("</script>");
			}
		}
		
	%>
	</body> 
</html>