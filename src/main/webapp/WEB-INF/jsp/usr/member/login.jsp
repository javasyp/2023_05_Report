<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Login" />
<%@ include file="../common/head.jspf"%>

<style>

.login {
	width: 400px;
	height: 500px;
}

.btn-color {
	background: pink;
}

.bottom-text a {
	color: hotpink;
	font-weight: bold;
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
	<div class="Form login" >
		<div>LOGIN</div>
			<div class="txtb">
				<input type="text" placeholder="이메일" autocomplete="off" name="email" />
			</div>
  
			<div class="txtb">
				<input type="password" placeholder="비밀번호" autocomplete="off" name="loginPw" />
			</div>
  
		<input type="submit" class="Btn btn-color" value="로그인" />
 		<div class="bottom-text"> 아이디가 없으신가요? <a href="join"> 회원가입하기</a></div>
 	</div>
</form>

<%@ include file="../common/foot.jspf"%>