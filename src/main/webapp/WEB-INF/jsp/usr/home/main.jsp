<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<div style="display:inline; text-align:center;">
	<div>
		<c:if test="${rq.isLogined() }">
			${rq.loginedMember.name } 님
		</c:if>
		환영합니다!
	</div>
</div>