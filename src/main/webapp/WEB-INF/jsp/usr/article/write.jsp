<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Write" />
<%@ include file="../common/head.jspf"%>

<style>

.write {
	width: 800px;
	height: 630px;
	background-color: white;
}

.btn-color {
	background-color: black;
	width: 500px;
	margin: auto;
	margin-top: 30px;
}

</style>

<!-- 작성 폼 체크 -->
<script type="text/javascript">
	let ArticleWrite__submitFormDone = false;
	
	function ArticleWrite__submit(form) {
		if (ArticleWrite__submitFormDone) {
			return;
		}
		
		title = form.title.value.trim();
		
		if (title.length == 0) {
			alert('제목을 입력하세요!');
			form.title.focus();
			return;
		}
		
		body = form.body.value.trim();
		
		if (body.length == 0) {
			alert('내용을 입력하세요!');
			form.body.focus();
			return;
		}
		
		ArticleWrite__submitFormDone = true;
		
		form.submit();
	}
</script>

<form action="doWrite" method="POST" onsubmit="ArticleWrite__submit(this); return false;">
	<div class="Form write">
		<div>Write</div>
			<div class="table-box-type-1">
				<table border="1">
					<colgroup>
						<col width="100" />
						<col width="400" />
					</colgroup>
		
					<tbody>
						<tr>
							<th>작성자</th>
							<td>${rq.loginedMember.name }</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input class="w-full" type="text" autocomplete="off" placeholder="제목을 입력하세요" name="title"/></td>
						</tr>
						<tr>
							<th style="height: 200px;">내용</th>
							<td>
								<textarea style="height: 200px;" class="w-full" autocomplete="off" placeholder="내용을 입력하세요" name="body"></textarea>
							</td>
						</tr>
						
					</tbody>
				</table>
				
				<input type="submit" class="Btn btn-color" value="작성" />
				<div class="bottom-text">
					<button class="btn-text-link" type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</div>
</form>
	
<%@ include file="../common/foot.jspf"%>