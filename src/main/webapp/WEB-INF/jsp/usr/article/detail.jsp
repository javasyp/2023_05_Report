<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Detail" />
<%@ include file="../common/head.jspf"%>

<style>

.detail {
	width: 800px;
	height: 600px;
	background-color: white;
}

</style>
<!-- 댓글 폼 체크 -->
<script type="text/javascript">
	let ReplyWrite__submitFormDone = false;
	
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}
		
		reply = form.body.value.trim();
		
		if (reply == 0) {
			alert('댓글 내용을 입력하세요!');
			form.body.focus();
			return;
		}
		
		ReplyWrite__submitFormDone = true;
		
		form.submit();
	}
</script>

<div class="Form detail">
	<div>Detail</div>
		<div class="table-box-type-1">
			<table border="1">
				<colgroup>
					<col width="100" />
					<col width="400" />
				</colgroup>
	
				<tbody>
					<tr>
						<th>번호</th>
						<td><div class="badge">${article.id }</div></td>
					</tr>
					<tr>
						<th>작성일자</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.extra_writer }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${article.body }</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 댓글 -->
		<div class="table-box-type-1 mt-5">
			<c:if test="${rq.logined }">
				<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submitForm(this); return false;">
					<input type="hidden" name="relId" value="${article.id }" />
					<table>
						<colgroup>
							<col width="400" />
							<col width="100" />
						</colgroup>

						<tbody>
							<tr>
								<td>
									<textarea class="w-full" name="body" placeholder="댓글을 입력하세요" /></textarea>
								</td>
								<td>
									<button type="submit" style="font-weight: bold;">COMMENT</button>
								</td>
							</tr>
						</tbody>

					</table>
				</form>
			</c:if>
			<c:if test="${rq.notLogined }">
				<div style="font-size: 20px;">
					&gt&gt <a class="btn-text-link" href="${rq.loginUri }">로그인 후 댓글 작성하기</a> &lt&lt
				</div>
			</c:if>
		</div>
		
		<div class="mt-5 mb-5">
			COMMENT (${repliesCount })
			<table class="table-box-type-1">
				<colgroup>
					<col width="70" />
					<col width="150" />
					<col width="100" />
					<col width="180" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>작성일</th>
						<th>작성자</th>
						<th>내용</th>
					</tr>
				</thead>
	
				<tbody>
					<c:forEach var="reply" items="${replies }">
						<tr>
							<td>${reply.id}</td>
							<td>${reply.regDate.substring(2,16)} </td>
							<td>${reply.extra_writer}</td>
							<td>${reply.body}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty replies}">
						<tr>
							<td colspan="4">댓글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<div class="bottom-text">
			<button class="btn-text-link" type="button" onclick="history.back();">뒤로가기</button>
		</div>
</div>
	
<%@ include file="../common/foot.jspf"%>