<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Check Password" />
<%@ include file="../common/head.jspf"%>

<style>

.check {
	width: 400px;
	height: 500px;
}

.btn-color {
	background: gold;
}

</style>

<form action="../member/doCheckPw" method="POST">
	<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
	<div class="Form check" >
		<div>Check Password</div>
			<div class="txtb">
				<input type="text" name="email" value="${rq.loginedMember.email }" readonly>
			</div>
  
			<div class="txtb">
				<input type="password" placeholder="비밀번호" autocomplete="off" name="loginPw" >
			</div>
  
		<input type="submit" class="Btn btn-color" value="비밀번호 확인">
		<div class="bottom-text">
			<button class="btn-text-link" type="button" onclick="history.back();">뒤로가기</button>
		</div>
 	</div>
</form>

<%@ include file="../common/foot.jspf"%>