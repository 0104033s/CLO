<%@page import="board.Board"%>
<%@page import="brand.Brand"%>
<%@page import="java.util.ArrayList"%>
<%@page import="brand.BrandDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>게시글 수정</title>
	<style>
		.container{
			padding-top:100px;
		}
		.update{
			background-color: #000000;
			border-radius: 20px;
			padding:10px;
		}
	</style>
	</head>
	<body>
	<%@ include file="header.jsp" %>
	<%@ include file="footer.jsp" %>
		<%
			int bNum = Integer.parseInt(request.getParameter("bNum"));
			ArrayList<Brand> brandList = new BrandDAO().brandList("");
			String brand = request.getParameter("brand");
			Board board = new BoardDAO().read(bNum);
		%>
		<div class="container m-auto row">
			<div class="col-3"></div>
			<div class="update col-6">
				<form method="post" action="boardUpdateAction.jsp?bNum=<%=bNum %>&update=update" onsubmit="return writeCk()">
				<input class="form-control mb-2" type="text" id="bTitle" name="bTitle" maxlength="25" placeholder="제목" value="<%=board.getbTitle()%>"/>
				<textarea rows="10" class="form-control mb-2" id="bText" name="bText" style="resize:none" placeholder="내용"><%=board.getbText() %></textarea>
				<select class="form-select mb-2" id="brand" name="brand">
					<option value="<%=brand%>"><%=brand %>
					<%for(int i=0;i<brandList.size();i++){ %>
					<option value="<%=brandList.get(i).getbName()%>"><%=brandList.get(i).getbName()%></option>
					<%}%>
				</select>
				<input type="hidden" id="bImg" name="bImg" value="" />
				<input class="form-control mb-2" type="submit" value="수정하기"/>
				<input class="form-control" type="reset" value="다시쓰기"/>
			</form>
			</div>
			<div class="col-3"></div>
		</div>
	</body> 
</html>