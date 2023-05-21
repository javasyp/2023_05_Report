<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Join" />
<%@ include file="../common/head.jspf"%>

<style>

.join {
	width: 600px;
	height: 600px;
}

.btn-color {
	background: skyblue;
}

.msg {
	margin-top: 5px;
	font-weight: bold;
}

</style>

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<!-- Join 폼 체크 -->
<script>
	let submitJoinFormDone = false;
	let validLoginPw = "";
	let validEmail = "";
	
	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.email.value = form.email.value.trim();
		
		if (form.email.value == 0) {
			alert('이메일을 입력해 주세요.');
			form.email.focus();
			return;
		}
		
		// 이메일 중복일 경우
		if (form.email.value != validEmail) {
			alert('사용할 수 없는 이메일입니다.');
			form.email.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해 주세요.');
			form.loginPw.focus();
			return;
		}
		
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPwConfirm.focus();
			return;
		}
		
		form.name.value = form.name.value.trim();
		
		if (form.name.value == 0) {
			alert('이름을 입력해 주세요.');
			form.name.focus();
			return;
		}
		
		submitJoinFormDone = true;
		
		form.submit();
	}
	
	// 이메일 중복 체크 및 유효성 검사
	function checkEmailDup(el) {
		$('.checkEmailDup-msg').empty();
		const form = $(el).closest('form').get(0);
		
		var email = form.email.value;
		
		if (email.length == 0) {
			validEmail = '';
			return;
		}
		
		// 달라진 게 없을 때 (키보드 이벤트가 일어나도 요청 안함)
		if (validEmail == form.email.value) {
			return;
		}
		
		// 이메일 유효성 검사
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		if(exptext.test(email) == false) {

			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
	
			alert("이메일 형식이 올바르지 않습니다.");
			form.email.focus();
			return;
		}
		
		$.get('../member/getEmailDup', {		// 전송 요청
			isAjax : 'Y',		// ajax 명시
			email : form.email.value
			
		}, function(data) {		// 전송 받음
			
			// 예외 처리
			if (data.success) {
				$('.checkEmailDup-msg').html('<div style="color: blue;">' + data.msg + '</div>');
				validEmail = data.data1;
			} else {
				$('.checkEmailDup-msg').html('<div style="color: red;">' + data.msg + '</div>');
				validEmail = '';
			}
		
		}, 'json');
	}
	
	// lodash debounce
	const checkEmailDupDebounced = _.debounce(checkEmailDup, 1600);
</script>

<form action="../member/doJoin" onsubmit="submitJoinForm(this); return false;" method="POST">
	<div class="Form join" >
		<div>JOIN</div>
			
			<div class="mb-30">
				<div class="txtb" style="margin-bottom: 0;">
					<input type="text" onkeyup="checkEmailDupDebounced(this);"
						placeholder="이메일을 입력하세요" autocomplete="off" name="email" />
				</div>
				<div class="checkEmailDup-msg msg"></div>
			</div>
			
			<div class="mb-30">
				<div class="txtb">
					<input type="text" placeholder="비밀번호를 입력하세요" autocomplete="off" name="loginPw" />
				</div>
			</div>
			
			<div class="mb-30">
				<div class="txtb">
					<input type="text" placeholder="비밀번호 확인을 입력하세요"
						autocomplete="off" name="loginPwConfirm" />
				</div>
			</div>
			
			<div class="mb-30">
				<div class="txtb">
					<input type="text" placeholder="이름을 입력하세요" autocomplete="off" name="name" />
				</div>
			</div>
  
		<input type="submit" class="Btn btn-color" value="회원가입" />
 	</div>
</form>