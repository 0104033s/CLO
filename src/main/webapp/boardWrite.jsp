<%@page import="brand.Brand"%>
<%@page import="java.util.ArrayList"%>
<%@page import="brand.BrandDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>게시판 작성</title>
	<style>
		.container{
			padding-top:100px;
		}
		.board{
			background-color: #000000;
			border-radius: 20px;
			padding:10px;
		}
	</style>
	</head>
	<body>
	<%@include file="header.jsp" %>
	<%@include file="footer.jsp" %>
	<%
		
		ArrayList<Brand> list = new BrandDAO().brandList("");
	
	%>
	<div class="container m-auto row">
		<div class="col-3"></div>
		<div class="board col-6">
			<form method="post" enctype="multipart/form-data" action="boardWriteAction.jsp" onsubmit="return writeCk()">
				<input class="form-control mb-2" type="text" id="bTitle" name="bTitle" maxlength="25" placeholder="제목"/>
				<textarea rows="10" class="form-control mb-2" id="bText" name="bText" style="resize:none" placeholder="내용"></textarea>
				<select class="form-select mb-2" id="brand" name="brand">
					<option value="no">brand
					<%for(int i=0;i<list.size();i++){ %>
					<option value="<%=list.get(i).getbName()%>"><%=list.get(i).getbName()%></option>
					<%} %>
				</select>
				<input class="form-control mb-4" type="file" id="bImg" name="bImg" />
				<input class="form-control mb-2" type="submit" value="글쓰기"/>
				<input class="form-control" type="reset" value="다시쓰기"/>
			</form>
		</div>
		<div class="col-3"></div>
	</div>
	<script>
		function writeCk(){
			var title = document.getElementById("bTitle");
			var text = document.getElementById("bText");
			var brand = document.getElementById("brand");
			if(!title.value){
				alert('제목을 입력해주세요.');
				title.select();
				title.focus();
				return false;
			}
			if(title.value.length<2){
				alert('제목은 2자이상 작성해주세요.');
				title.select();
				title.focus();
				return false;
			}
			if(!text.value){
				alert('내용을 작성해주세요.');
				text.select();
				text.focus();
				return false;
			}
			if(brand.value=="no"){
				alert('브랜드를 설정해주세요.');
				brand.focus();
				return false;
			}
		}
	</script>
	</body> 
</html>