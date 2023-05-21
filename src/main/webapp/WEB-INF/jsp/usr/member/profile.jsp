<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Profile" />
<%@ include file="../common/head.jspf"%>
<%@ page import="report.syp.demo.util.Ut"%>

<style>

.myPage {
	width: 500px;
	height: 750px;
}

.btn-color {
	background: gold;
}

.left {
	text-align: left;
	margin-bottom: 5px;
}

</style>

<form action="../member/checkPw?replaceUri=${Ut.getEncodedUri('../member/modify') }" method="POST">
	<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
	<div class="Form myPage mb-30" >
		<div>My Profile</div>
		
			<div class="txtb">
				<div class="left">가입일</div>
				<input type="text" value="${rq.loginedMember.regDate }" readonly>
			</div>
  
			<div class="txtb">
				<div class="left">수정일</div>
				<input type="text" value="${rq.loginedMember.updateDate }" readonly>
			</div>
			
			<div class="txtb">
				<div class="left">이메일</div>
				<input type="text" value="${rq.loginedMember.email }" readonly>
			</div>
			
			<div class="txtb">
				<div class="left">이름</div>
				<input type="text" value="${rq.loginedMember.name }" readonly>
			</div>
  		
		<input type="submit" class="Btn btn-color" value="프로필 수정하기" />
		
		<div class="bottom-text">
			<button class="btn-text-link" type="button" onclick="history.back();">뒤로가기</button>
		</div>
 	</div>
</form>

<%@ include file="../common/foot.jspf"%>