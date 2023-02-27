<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-hover usertable table-striped">
<thead>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>시스템</th>
		<th>요청일자</th>
		<th>진행상황</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="request" items="${userRequestList}">
		<tr>
			<td>${request.rno}</td>
			<td class="tableContent">
				<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
					${request.reqTitle}
				</a>
			</td>
			<td>${request.systemName}</td>
			<td><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></td>
			<td><span class="btn btn-sm btn-primary">
				<c:if test="${request.statusNo == 12}">
					반려
				</c:if>
				<c:if test="${request.statusNo == 13}">
					완료
				</c:if>
				<c:if test="${request.statusNo != 12 && request.statusNo != 13}">
					진행중
				</c:if>
			</span></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
    <li class="page-item"><a class="page-link" onclick="userRequestList('${searchStatus}', 1)">처음</a></li>
   <c:if test="${uPager.groupNo>1}">
    <li class="page-item">
    	<a class="page-link" onclick="userRequestList('${searchStatus}', ${uPager.startPageNo-1})">
    		<i class="fas fa-caret-left"></i>
    	</a>
    </li>
   </c:if>
   <c:forEach var="i" begin="${uPager.startPageNo}" end="${uPager.endPageNo}">
   	<c:if test="${uPager.pageNo != i}">
    	<li class="page-item"><a class="page-link" onclick="userRequestList('${searchStatus}', ${i})">${i}</a></li>
   	</c:if>
   	<c:if test="${uPager.pageNo == i}">
    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" onclick="userRequestList('${searchStatus}', ${i})">${i}</a></li>
   	</c:if>
   </c:forEach>
   <c:if test="${uPager.groupNo<pager.totalGroupNo}">
    <li class="page-item">
    	<a class="page-link" onclick="userRequestList('${searchStatus}', ${uPager.endPageNo + 1})">
    		<i class="fas fa-caret-right"></i>
   	 	</a>
    </li>
   </c:if>
   <li class="page-item"><a class="page-link"onclick="userRequestList('${searchStatus}', ${uPager.totalPageNo})">맨끝</a></li>
</ul>