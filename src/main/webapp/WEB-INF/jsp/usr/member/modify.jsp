<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Modify My Profile" />
<%@ include file="../common/head.jspf"%>

<style>

.modify {
	width: 500px;
	height: 950px;
}

.btn-color {
	background: gold;
}

.left {
	text-align: left;
	margin-bottom: 5px;
}

</style>

<!-- 수정 폼 체크 -->
<script type="text/javascript">
	let MemberModify__submitFormDone = false;
	
	function MemberModify__submitForm(form) {
		if (MemberModify__submitFormDone) {
			return;
		}
		
		memberLoginPw = form.loginPw.value.trim();
		
		if (memberLoginPw.length > 0) {
			memberLoginPwConfirm = form.loginPwConfirm.value.trim();
			
			if (memberLoginPwConfirm.length == 0) {
				alert('비밀번호 확인을 입력하세요!');
				form.loginPwConfirm.focus();
				return;
			}
			
			if (memberLoginPw != memberLoginPwConfirm) {
				alert('비밀번호가 일치하지 않습니다.');
				form.loginPw.focus();
				return;
			}
		}
		
		memberName = form.name.value.trim();
		
		if (memberName.length == 0) {
			alert('이름을 입력하세요!');
			form.name.focus();
			return;
		}
		
		MemberModify__submitFormDone = true;
		
		form.submit();
	}
</script>

<form action="../member/doModify" method="POST" onsubmit="MemberModify__submitForm(this); return false;">
	<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
	<div class="Form modify mb-30" >
		<div>Modify My Profile</div>
		
			<div class="txtb">
				<div class="left">가입일</div>
				<input type="text" value="${rq.loginedMember.regDate }" readonly>
			</div>
  
			<div class="txtb">
				<div class="left">수정일</div>
				<input type="text" value="${rq.loginedMember.updateDate }" readonly />
			</div>
			
			<div class="txtb">
				<div class="left">이메일</div>
				<input type="text" value="${rq.loginedMember.email }" readonly />
			</div>
			
			<div class="txtb">
				<div class="left">새 비밀번호</div>
				<input type="text" name="loginPw" placeholder="새 비밀번호를 입력하세요" />
			</div>
			
			<div class="txtb">
				<div class="left">새 비밀번호 확인</div>
				<input type="text" name="loginPwConfirm" placeholder="새 비밀번호 확인을 입력하세요" />
			</div>
			
			<div class="txtb">
				<div class="left">이름</div>
				<input type="text" name="name" placeholder="이름을 입력하세요"
					value="${rq.loginedMember.name }" />
			</div>
  		
		<input type="submit" class="Btn btn-color" value="프로필 수정" />
		
		<div class="bottom-text">
			<button class="btn-text-link" type="button" onclick="history.back();">뒤로가기</button>
		</div>
 	</div>
</form>

<%@ include file="../common/foot.jspf"%>