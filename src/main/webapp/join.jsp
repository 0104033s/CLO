<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
	<title>회원가입</title>
	<style>
		.container{
			padding-top:100px;
			
		}
		.join{
			border-radius:20px;
		 	background-color:#000000;
			padding:80px;
		}
	</style>
	</head>
	<body>
		<%@include file="header.jsp" %>
		
		<div class="container row m-auto">
			<div class="col-4"></div>
			<div class="join col-4">
				<form action="joinAction.jsp" method="post" onsubmit="return joinCheck()">
					<input class="form-control mb-2" type="text" id="userID" name="userID" placeholder="아이디" maxlength="20">
					<input class="form-control mb-2" type="password" id="userPW" name="userPW" placeholder="비밀번호" maxlength="20">
					<input class="form-control mb-2" type="password" id="userPW2" name="userPW2" placeholder="비밀번호확인" maxlength="20">
					<input class="form-control mb-2" type="text" id="userName" name="userName" placeholder="이름" maxlength="20">
					<input class="form-control mb-2" type="text" id="userNickname" name="userNickname" placeholder="별명" maxlength="20">
					<div class="input-group row m-auto mb-2">
						<select id="userTel1" name="userTel1" class="form-select m-auto">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="070">070</option>
						</select>
						 - <input class="form-control m-auto" type="text" id="userTel2" name="userTel2" placeholder="0000" maxlength="4">
						 - <input class="form-control m-auto" type="text" id="userTel3" name="userTel3" placeholder="0000" maxlength="4">
					</div>
					
					<input type="hidden" name="userTel" value="">
					<input class="form-control mb-2" type="email" id="userEmail" name="userEmail" placeholder="이메일" maxlength="50">
					<select id="userGender" name="userGender" class="form-select mb-auto" >
							<option value="GENDER">성별</option>
							<option value="MAN">남자</option>
							<option value="WOMAN">여자</option>
						</select>
					<div class="input-group row m-auto mb-4">
						
					</div>
					<input class="form-control mb-2" type="submit" value="가입하기">
					<input class="form-control" type="reset" value="다시쓰기">
				</form>
			</div>
			<div class="col-4"></div>
		</div>
		<%@include file="footer.jsp" %>
		<script type="text/javascript">
			function joinCheck(){
				
				var userID = document.getElementById("userID");
				var userPW = document.getElementById("userPW");
				var userPW2 = document.getElementById("userPW2");
				var userName = document.getElementById("userName");
				var userNickname = document.getElementById("userNickname");
				var userTel1 =document.getElementById("userTel1");
				var userTel2 =document.getElementById("userTel2");
				var userTel3 =document.getElementById("userTel3");
				var userTel = userTel1.value+userTel2.value+userTel3.value;
				var userEmail = document.getElementById("userEmail");
				var userGender = document.getElementById("userGender");

				var id = /^[A-Za-z0-9]{4,12}$/; //영어,숫자 4~12글자
				var pw = /^[A-Za-z0-9]{4,20}$/;
				var name = /^[가-힣]{2,4}$/;	//한글만, 2~4글자
				var nickname = /^[A-Za-z0-9가-힣]{2,10}$/;		//별명 한글,영어,숫자 2~10글자
				var tel =/^[0-9]{4}$/;	//전화번호 숫자만 4글자
				var email=/^[a-z0-9]+@([a-z0-9\.]+\.)+[a-z]{2,6}$/;
				
				if(!userID.value){
					alert('아이디를 입력해주세요.');
					userID.select();
					userID.focus();
					return false;
				}
				if(!id.test(userID.value)){
					alert('아이디는 영어,숫자 4~12글자로 입력해주세요.');
					userID.focus();
					userID.select();
					return false;
				}
				if(!userPW.value){
					alert('비밀번호를 입력해주세요.');
					userPW.select();
					userPW.focus();
					return false;
				}
				if(!pw.test(userPW.value)){
					alert('비밀번호는 영어,숫자 4~20글자로 입력해주세요.');
					userPW.select();
					userPW.focus();
					return false;
				}
				if(userPW.value!=userPW2.value){
					alert('비밀번호를 확인해주세요.');
					userPW2.select();
					userPW2.focus();
					return false;
				}
				if(!userName.value){
					alert('이름을 입력해주세요.');
					userName.select();
					userName.focus();
					return false;
				}
				if(!name.test(userName.value)){
					alert('이름은 한글 2~4글자로 입력해주세요.');
					userName.select();
					userName.focus();
					return false;
				}
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
				if(!userTel2.value||!userTel3.value){
					alert('전화번호를 입력해주세요.');
					userTel2.select();
					userTel2.focus();
					return false;
				}
				if(!tel.test(userTel2.value)){
					alert('전화번호는 숫자만 4글자 입력해주세요.');
					userTel2.select();
					userTel2.focus();
					return false;
				}
				if(!tel.test(userTel3.value)){
					alert('전화번호는 숫자만 4글자 입력해주세요.');
					userTel3.select();
					userTel3.focus();
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
				if(userGender.value == "GENDER"){
					alert('성별을 선택해주세요');
					userGender.select();
					return false;
				}
				
			}
		</script>
	</body> 
</html>