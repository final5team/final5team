<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="height: 290px;">
	<table class="table table-hover usertable table-striped">
		<thead style="background-color: #72B22B;" class="text-white">
			<tr style="text-align: center;">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${noticeList}">
				<tr style="text-align: center;">
					<td>${notice.nno}</td>
					<td class="tableContent">
						<a href="${pageContext.request.contextPath}/noticedetail?nno=${notice.nno}">
							${notice.noticeTitle}
						</a>
					</td>
					<td>${notice.mid}</td>
					<td><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>				
		</tbody>
	</table>
</div>
<div class="pager default mt-4">
<div class="pagingButtonSet d-flex justify-content-center">
	<a onclick="mainNoticeList(1)" type="button" class="btn btn-muted shadow">처음</a>
	<c:if test="${nPager.groupNo > 1}">
		<a onclick="mainNoticeList(${nPager.startPageNo-1})" class="btn btn-muted shadow">이전</a>

	</c:if>

	<c:forEach var="i" begin="${nPager.startPageNo}" end="${nPager.endPageNo}">
		<c:if test="${nPager.pageNo != i}">
			<a onclick="mainNoticeList(${i})" type="button" class="btn btn-white shadow">${i}</a>
		</c:if>
		<c:if test="${nPager.pageNo == i}">
			<a onclick="mainNoticeList(${i})" type="button" class="btn btn-dark shadow">${i}</a>
		</c:if>
	</c:forEach>

	<c:if test="${nPager.groupNo < nPager.totalGroupNo }">
		<a onclick="mainNoticeList(${nPager.endPageNo+1})" type="button" class="btn btn-muted shadow">다음</a>

	</c:if>
	<a onclick="mainNoticeList(${nPager.totalPageNo})" type="button" class="btn btn-muted shadow">맨끝</a>
	</div>
</div>