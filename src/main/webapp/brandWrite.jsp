<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>브랜드 등록</title>
	<style>
		.container{
			padding-top:100px;
			
		}
		.write{
			background-color: #000000;
			border-radius: 20px;
			padding:30px;
		}
	</style>
	</head>
	<body>
		<%@include file="header.jsp" %>
		<%@include file="footer.jsp" %>
		<div class="container row m-auto">
			<div class="col-3"></div>
			<div class="write col-6">
				<form action="brandWriteAction.jsp" method="post" onsubmit="writeCk()" enctype="multipart/form-data">
					<input class="form-control mb-2" type="text" id="bName" name="bName" maxlength="20" placeholder="이름"/>
					<textarea class="bName form-control mb-2" id="bInfo" name="bInfo" rows="7" placeholder="정보작성.."></textarea>
					<input class="form-control mb-2" type="text" id="bUrl" name="bUrl" maxlength="40" placeholder="사이트 주소"/>
					<input class="form-control mb-2" type="file" id="bImg" name="bImg"/>
					<input class="form-control mb-2" type="submit" value="등록하기"/>
					<input class="form-control" type="reset" value="다시쓰기"/>
				</form>
			</div>
			<div class="col-3"></div>
		</div>
	</body> 
</html>