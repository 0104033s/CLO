<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	<title>게시판 작성</title>
	
	</head>
	<body>
		<%
		String path = "C:/JSP/Gil/CLO/src/main/webapp/resource/img/board";
		try{
			int size=10*1024*1024;
			String file="";
			String originfile="";
			MultipartRequest multi =
					new MultipartRequest(request,path,size,"UTF-8",new DefaultFileRenamePolicy());
			
			Enumeration files = multi.getFileNames();
			String str=(String)files.nextElement();
			file=multi.getFilesystemName(str);
			
			
			String bTitle = multi.getParameter("bTitle");
			String bText = multi.getParameter("bText");
			String brand = multi.getParameter("brand");
			String userID = (String)session.getAttribute("userID");
			originfile=multi.getOriginalFileName(str);
			
			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.write(bTitle, bText, brand, userID, originfile);
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB오류')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");					
				script.println("location.href='board.jsp?boardNum="+(result-1)+"'");
				script.println("</script>");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		%>
	</body> 
</html>