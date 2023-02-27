<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="height: 290px;">
	<table class="table table-hover usertable table-striped">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${noticeList}">
				<tr>
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
<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
    <li class="page-item"><a class="page-link" onclick="mainNoticeList(1)">처음</a></li>
    <c:if test="${nPager.groupNo>1}">
	    <li class="page-item">
	    	<a class="page-link" onclick="mainNoticeList(${nPager.startPageNo-1})">
	    		<i class="fas fa-caret-left"></i>
	    	</a>
	    </li>
    </c:if>
    <c:forEach var="i" begin="${nPager.startPageNo}" end="${nPager.endPageNo}">
    	<c:if test="${nPager.pageNo != i}">
	    	<li class="page-item"><a class="page-link" onclick="mainNoticeList(${i})">${i}</a></li>
    	</c:if>
    	<c:if test="${nPager.pageNo == i}">
	    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" onclick="mainNoticeList(${i})">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${nPager.groupNo<nPager.totalGroupNo}">
	    <li class="page-item">
	    	<a class="page-link" onclick="mainNoticeList(${nPager.endPageNo + 1})">
	    		<i class="fas fa-caret-right"></i>
	   	 	</a>
	    </li>
    </c:if>
    <li class="page-item"><a class="page-link" onclick="mainNoticeList(${nPager.totalPageNo})">맨끝</a></li>
</ul>