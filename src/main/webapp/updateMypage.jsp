<%@page import="user.UserDAO"%>
<%@page import="user.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>정보 수정</title>
	<style>
		.container{
			padding-top:100px;
			
		}
		.update{
			border-radius:20px;
		 	background-color:#000000;
			padding:80px;
		}
	</style>
	</head>
	<body>
		<%@include file ="header.jsp" %>
		<%User user = new UserDAO().mypage(userID); %>
			<div class="container m-auto row">
				<div class="col-4"></div>
				<div class="update col-4">
					<form action="updateMypageAction.jsp" method="post" onsubmit="return updateCheck()">
						<input class="form-control mb-2" type="text" name="userID" value="<%=user.getUserID()%> " readonly>
						<input class="form-control mb-2" type="text" name="userName" value="<%=user.getUserName() %>" readonly>
						<input class="form-control mb-2" type="text" name="userNickname" id="userNickname" value="<%=user.getUserNickname()%>">
						<input class="form-control mb-2" type="text" name="userTel" value="<%=user.getUserTel()%>" readonly>
						<input class="form-control mb-2" type="email" name="userEmail" id="userEmail" value="<%=user.getUserEmail()%>">
						<input class="form-control mb-5" type="text" name="userGender" value="<%=user.getUserGender()%>" readonly>
						<input class="form-control mb-2" type="submit" value="수정하기">
					</form>
				</div>
				<div class="col-4"></div>
			</div>
		<%@include file = "footer.jsp" %>
		<script>
			function updateCheck(){
				var userNickname = document.getElementById("userNickname");
				var userEmail = document.getElementById("userEmail");
				
				var nickname = /^[A-Za-z0-9가-힣]{2,10}$/;
				var email=/^[a-z0-9]+@([a-z0-9\.]+\.)+[a-z]{2,6}$/;
				
				if(!userNickname.value){
					alert('별명을 입력해주세요');
					userNickname.select();
					userNickname.focus();
					return false;
				}
				if(!nickname.test(userNickname.value)){
					alert('별명은 한글,영어,숫자 2~10글자로 입력해주세요.');
					userNickname.select();
					userNickname.focus();
					return false;
				}
				
				if(!userEmail.value){
					alert('이메일을 입력해주세요.');
					userEmail.select();
					userEmail.focus();
					return false;
				}
				if(!email.test(userEmail.value)){
					alert('이메일 형식이 잘못되었습니다.');
					userEmail.select();
					userEmail.focus();
					return false;
				}
			}
		</script>
	</body> 
</html>