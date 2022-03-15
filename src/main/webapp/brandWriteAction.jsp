<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="brand.BrandDAO"%>
<%@page import="brand.Brand"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="brand" class="brand.Brand" scope="page"/>
<jsp:setProperty name="brand" property="*"/>
<!DOCTYPE html>
<html>
	<head>
	<title>브랜드 등록</title>
	<%
		BrandDAO brandDAO = new BrandDAO();
		String path = "C:/JSP/Gil/CLO/src/main/webapp/resource/img/brand";
		try{
		int size=1024*1024*10; //10MB
		String file = ""; //파일명 중복
		String originfile ="";	//실제 파일명
		MultipartRequest multi = new MultipartRequest(request,path,size,"UTF-8",new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String str=(String)files.nextElement();
		file = multi.getFilesystemName(str);
		originfile = multi.getOriginalFileName(str);
		String bName = multi.getParameter("bName");
		String bInfo = multi.getParameter("bInfo");
		String bUrl = multi.getParameter("bUrl");
		int result =brandDAO.write(bName,bInfo,bUrl,file,originfile);
		
		if(result ==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp?bWord='");
			script.println("</script>");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}

	%>
	</head>
	<body>
	
	</body> 
</html>