<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>로그인</title>
	
	<style>
		body{
			overflow:hidden;
		}
		.container{
		padding-top:200px;
		}
		.login{
		border-radius:20px;
		background-color:#000000;
		padding:60px;
		}
	</style>
	
	</head>
	<body>
		<%@include file="header.jsp" %>
		<div class="container row m-auto">
			<div class="col-4"></div>
			<div class="login col-4 p-auto">
				<form action="loginAction.jsp" method="post" onsubmit="return loginCheck()">
					<input type="text" id="userID" name="userID" class="form-control mb-2" maxlength="20" placeholder="아이디 4~12자"/>
					<input type="password" id="userPW" name="userPW" class="form-control mb-5" maxlength="20" placeholder="비밀번호"/>
					<input type="submit" class="form-control mb-2 mt-2 btn btn-secondary" value="로그인"/>
					<input type="button" class="form-control btn btn-secondary" onclick="join()" value="회원가입"/>
				</form>
			</div>
			<div class="col-4"></div>
			
		</div>
		<%@include file="footer.jsp" %>
		<script type="text/javascript">
			function loginCheck(){
				var userID = document.getElementById("userID");
				var userPW = document.getElementById("userPW");
				if(!userID.value){
					alert('아이디를 입력해주세요.');
					userID.select();
					userID.focus();
					return false;
				}
				if(userID.value.length>12 ||userID.value.length<4){
					alert('아이디를 4~12자로 입력해주세요.');
					userID.select();
					userID.focus();
					return false;
				}
				if(!userPW.value){
					alert('비밀번호를 입력해주세요.')
					userPW.select();
					userPW.focus();
					return false;
				}
			}
			function join(){
				location.href="join.jsp";
			}
		</script>
	</body> 
</html>