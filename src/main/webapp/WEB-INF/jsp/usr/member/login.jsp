<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN" />
<%@ include file="../common/head.jspf"%>

<style>

.Login_Form {
	width: 400px;
	background-color: #f1f1f1;
	height: 500px;
	padding: 80px 40px;
	border-radius: 10px;
	text-align: center;
}

.Login_Form > div:first-child {
	text-align: center;
	margin-bottom: 50px;
	font-size: 30px;
	font-weight: bold;
}

.txtb {
	border-bottom: 2px solid #adadad;
	position : relative;
	margin : 30px 0;
}

.txtb input {
	font-size: 15px;
	color: #333333;
	width: 100%;
	border: none;
	padding: 0 10px;
	height: 40px;
	outline: none;
}

.loginBtn {
	display: block; 
	width:100%;
	height: 50px; 
	border: none; 
	background: pink;
	border-radius: 10px;
	background-size: 200%;
	border-color: white;
	color: #ffffff;
	outline: none;
	cursor: pointer;
	transition:.5s;
}

.bottom-text {
	margin-top: 30px;
	text-align: center;
}

.bottom-text a {
	color: hotpink;
}

</style>

<script>
	function submitLoginForm(form) {
		
		form.loginId.value = form.loginId.value.trim();
		
		if (form.loginId.value == 0) {
			alert('아이디를 입력해 주세요.');
			form.loginId.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해 주세요.');
			form.loginPw.focus();
			return;
		}
		
		form.submit();
	}
</script>

<form action="../member/doLogin" onsubmit="submitLoginForm(this); return false;" method="POST">
	<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
	<div class="Login_Form" >
		<div>LOGIN</div>
			<div class="txtb">
				<input type="text" placeholder="아이디를 입력해 주세요." autocomplete="off" name="loginId" >
			</div>
  
			<div class="txtb">
				<input type="password" placeholder="비밀번호를 입력해 주세요." autocomplete="off" name="loginPw" >
			</div>
  
		<input type="submit" class="loginBtn" value="로그인">
 		<div class="bottom-text"> 아이디가 없으신가요? <a href="join"> 회원가입하기</a></div>
 	</div>
</form>