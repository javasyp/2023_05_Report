<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Board List" />
<%@ include file="../common/head.jspf"%>

<style>

.list {
	width: 800px;
	height: 600px;
	background-color: white;
}

/* 페이징 */
.page_wrap {
	text-align:center;
	font-size:0;
	margin-top: 30px;
 }

.page_nation {
	display:inline-block;
}

.page_nation .none {
	display:none;
}

.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:#999999;
	text-decoration:none;
}

.page_nation a.active {
	background-color:#42454c;
	color:#fff;
	border:1px solid #42454c;
}

</style>

<div class="Form list" >
	<div>Board List (${articlesCount })</div>
		
		<table class="table table-zebra w-full">
			<colgroup>
				<col width="70" />
				<col width="140" />
				<col width="140" />
				<col width="140" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>작성일자</th>
					<th>제목</th>
					<th>작성자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="article" items="${articles }">
					<tr>
						<td>${article.id }</td>
						<td>${article.regDate.substring(0,10) }</td>
						<td>
							<a class="btn-text-link" href="detail?id=${article.id }">${article.title }</a>
						</td>
						<td>${article.extra_writer }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty articles}">
		           <tr>
						<td colspan="4">게시물이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	
		<!-- 페이징 -->
		<!-- 페이지네이션 블록 크기 -->
		<c:set var="blockSize" value="5" />
		
		<!-- 현재 블록의 시작 페이지 번호 -->
		<c:set var="startBlockPage" value="${(page - 1) - ((page - 1) % blockSize) + 1}" />
		
		<!-- 현재 블록의 끝 페이지 번호 -->
		<c:set var="endBlockPage" value="${startBlockPage + blockSize - 1}" />
		<!-- 마지막 블록 페이지가 전체 페이지 개수보다 클 경우 -->
		<c:if test="${endBlockPage > pagesCount}">
		  <c:set var="endBlockPage" value="${pagesCount}" />
		</c:if>
		
		<div class="page_wrap">
			<div class="page_nation">
				<!-- 이전 블록 버튼 -->
				<c:if test="${page > blockSize}">
					<a href="?page=${startBlockPage - blockSize}">&lt</a>
				</c:if>
				 
				<!-- 페이지 그룹 -->
				<c:forEach var="pageNumber" begin="${startBlockPage}" end="${endBlockPage}">
				  <c:if test="${pageNumber <= pagesCount}">
				    <c:choose>
				      <c:when test="${pageNumber == page}">
				        <a class="active" href="?page=${pageNumber}">${pageNumber}</a>
				      </c:when>
				      <c:otherwise>
				        <a href="?page=${pageNumber}">${pageNumber}</a>
				      </c:otherwise>
				    </c:choose>
				  </c:if>
				</c:forEach>
					
				<!-- 다음 블록 버튼 -->
				<c:if test="${endBlockPage < pagesCount}">
			        <a href="?page=${endBlockPage + 1}">&gt</a>
			    </c:if>
			</div>
		</div>
</div>

<%@ include file="../common/foot.jspf"%>