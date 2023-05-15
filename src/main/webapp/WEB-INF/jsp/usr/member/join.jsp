<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>

<style>

.Join_Form {
	width: 600px;
	background-color: #f1f1f1;
	height: 700px;
	padding: 80px 40px;
	border-radius: 10px;
	text-align: center;
}

.Join_Form > div:first-child {
	text-align: center;
	margin-bottom: 50px;
	font-size: 30px;
	font-weight: bold;
}

.txtb {
	border-bottom: 2px solid #adadad;
	position: relative;
	/* margin-bottom: 30px; */
}

.mb-30 {
	margin-bottom: 30px;
}

.txtb input {
	font-size: 15px;
	color: #333;
	width: 100%;
	border: none;
	padding: 0 10px;
	height: 40px;
	outline: none;
}

.joinBtn {
	display: block; 
	width: 100%;
	height: 50px; 
	border: none; 
	background: skyblue;
	border-radius: 10px;
	background-size: 200%;
	border-color: white;
	color: #ffffff;
	outline: none;
	cursor: pointer;
	transition:.5s;
}

</style>

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<!-- Join 폼 체크 -->
<script>
	let submitJoinFormDone = false;
	let validLoginId = "";
	let validLoginPw = "";
	let validName = "";
	let validEmail = "";
	
	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다.');
			return;
		}
		
		form.loginId.value = form.loginId.value.trim();
		
		if (form.loginId.value == 0) {
			alert('아이디를 입력해 주세요.');
			form.loginId.focus();
			return;
		}
		
		// 아이디 중복일 경우
		if (form.loginId.value != validLoginId) {
			alert('사용할 수 없는 아이디입니다.');
			form.loginId.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해 주세요.');
			form.loginPw.focus();
			return;
		}
		
		form.name.value = form.name.value.trim();
		
		if (form.name.value == 0) {
			alert('이름을 입력해 주세요.');
			form.name.focus();
			return;
		}
		
		form.nickname.value = form.nickname.value.trim();
		
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해 주세요.');
			form.nickname.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해 주세요.');
			form.cellphoneNum.focus();
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
		
		submitJoinFormDone = true;
		
		form.submit();
	}
	
	// 아이디 중복 체크
	function checkLoginIdDup(el) {
		$('.checkLoginIdDup-msg').empty();
		const form = $(el).closest('form').get(0);
		
		if (form.loginId.value.length == 0) {
			validLoginId = '';
			return;
		}
		
		// 달라진 게 없을 때 (키보드 이벤트가 일어나도 요청 안함)
		if (validLoginId == form.loginId.value) {
			return;
		}
		
		$.get('../member/getLoginIdDup', {		// 전송 요청
			isAjax : 'Y',		// ajax 명시
			loginId : form.loginId.value
			
		}, function(data) {		// 전송 받음
			
			$('.checkmsg').html('<div>' + data.msg + '</div>');
			// 예외 처리
			if (data.success) {
				validLoginId = data.data1;
			} else {
				validLoginId = '';
			}
		
		}, 'json');
	}
	
	// 비밀번호 유효성 검사
	function checkPswd(el) {
		const form = $(el).closest('form').get(0);
		
		var loginPw = form.loginPw.value;
		
		if (loginPw.length == 0) {
			validLoginPw = '';
			return;
		}
		
		// 달라진 게 없을 때 (키보드 이벤트가 일어나도 요청 안함)
		if (validLoginPw == loginPw) {
			return;
		}
		
		var pswd = $(".password").val();
		var num = pswd.search(/[0-9]/g);
		var eng = pswd.search(/[a-z]/ig);

		if (pswd.length < 8 || pswd.length > 20){
			alert("8자리 ~ 20자리 이내로 입력해 주세요.");
			return false;
			
		} else if (pswd.search(/\s/) != -1){
			alert("비밀번호는 공백 없이 입력해 주세요.");
			return false;
			
		} else if (num < 0 || eng < 0){
			alert("영문 및 숫자를 혼합하여 입력해 주세요.");
			return false;
			
		} else {
			console.log("비밀번호 통과"); 
			return true;
		}
	}
	
	// 이름 유효성 검사
	function checkName(el) {
		const form = $(el).closest('form').get(0);
		
		var name = form.name.value;
		
		if (name.length == 0) {
			validName = '';
			return;
		}
		
		// 달라진 게 없을 때 (키보드 이벤트가 일어나도 요청 안함)
		if (validName == name) {
			return;
		}
		
		var num = /[0-9]/;	// 숫자 
		var eng = /[a-zA-Z]/;	// 문자 
		var spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
		var kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크

		if ( !(num.test(name)) && !(eng.test(name)) && !(spc.test(name)) && (kor.test(name)) ){
			console.log("이름 통과");
			return true;
		} else {
			alert("한글만 입력 가능합니다.");
			return false;
		}
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
			
			$('.checkEmailDup-msg').html('<div>' + data.msg + '</div>');
			$('.Join_Form').css('height','750px');
			// 예외 처리
			if (data.success) {
				validEmail = data.data1;
			} else {
				validEmail = '';
			}
		
		}, 'json');
	}
	
	// lodash debounce
	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 600);
	const checkPswdDebounced = _.debounce(checkPswd, 1000);
	const checkNameDebounced = _.debounce(checkName, 600);
	const checkEmailDupDebounced = _.debounce(checkEmailDup, 1600);
</script>


<form action="../member/doJoin" onsubmit="submitJoinForm(this); return false;" method="POST">
	<div class="Join_Form" >
		<div>JOIN</div>
			<div class="mb-30">
				<div class="txtb">
					<input type="text" onkeyup="checkLoginIdDupDebounced(this);"
						placeholder="아이디를 입력해 주세요." autocomplete="off" name="loginId" >
				</div>
				<div class="checkmsg"></div>
			</div>
			
			<div class="mb-30">
				<div class="txtb">
					<input type="text" onkeyup="checkPswdDebounced(this);" class="password"
						placeholder="비밀번호를 입력해 주세요." autocomplete="off" name="loginPw" >
				</div>
			</div>
			
			<div class="mb-30">
				<div class="txtb">
					<input type="text"  onkeyup="checkNameDebounced(this);" class="name"
						placeholder="이름을 입력해 주세요." autocomplete="off" name="name" >
				</div>
			</div>
			
			<div class="mb-30">
				<div class="txtb">
					<input type="text" placeholder="닉네임을 입력해 주세요." autocomplete="off" name="nickname" >
				</div>
			</div>
				
			<div class="mb-30">
				<div class="txtb">
					<input type="text" placeholder="전화번호를 입력해 주세요." autocomplete="off" name="cellphoneNum" >
				</div>
			</div>
				
			<div class="mb-30">
				<div class="txtb">
					<input type="text" onkeyup="checkEmailDupDebounced(this);"
						placeholder="이메일을 입력해 주세요." autocomplete="off" name="email" >
				</div>
				<div class="checkEmailDup-msg"></div>
			</div>
  
		<input type="submit" class="joinBtn" value="회원가입">
 	</div>
</form>