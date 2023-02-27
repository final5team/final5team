<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table tasks-block table-striped" >
<thead>
	<tr style="text-align: center;">
		<th>번호</th>
		<th>요청유형</th>
		<th>제목</th>
		<th>우선순위</th>
		<th>요청일</th>
		<th>완료예정일</th>
		<th>담당자</th>
	</tr>
</thead>
<tbody >
	<c:forEach var="requestProcess" items="${requestProcessList}" varStatus="i">
	<tr style="text-align: center;">
		<td>${i.count}</td>
		<td>${requestProcess.reqType}</td>
		<td class="tableContent">${requestProcess.reqTitle}</td>
		<td>
			<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
				<span class="fa fa-star checked" style="color: orange;"></span>
			</c:if>
			<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
				<span class="fa fa-star checked" style="color: orange;"></span>
			</c:if>
			<c:if test="${requestProcess.priority eq '상'}">
				<span class="fa fa-star checked" style="color: orange;"></span>
			</c:if>
		</td>
		<td><fmt:formatDate value="${requestProcess.reqDate}" pattern="yyyy-MM-dd"/></td>
		<td><fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/></td>
		<td>${requestProcess.mname}</td>
	</tr>
	</c:forEach>
	</tbody>
</table>
<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
    <li class="page-item"><a class="page-link" href="list?pageNo=1">처음</a></li>
    <c:if test="${rpPager.groupNo>1}">
    <li class="page-item">
    	<a class="page-link" href="list?pageNo=${rpPager.startPageNo-1}">
    		<i class="fas fa-caret-left"></i>
    	</a>
    </li>
   </c:if>
   <c:forEach var="i" begin="${rpPager.startPageNo}" end="${rpPager.endPageNo}">
   	<c:if test="${rpPager.pageNo != i}">
    	<li class="page-item"><a class="page-link" href="list?pageNo=${i}">${i}</a></li>
   	</c:if>
   	<c:if test="${rpPager.pageNo == i}">
    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" href="list?pageNo=${i}">${i}</a></li>
   	</c:if>
   </c:forEach>
   <c:if test="${rpPager.groupNo<pager.totalGroupNo}">
    <li class="page-item">
    	<a class="page-link" href="#">
    		<i class="fas fa-caret-right"></i>
   	 	</a>
    </li>
   </c:if>
   <li class="page-item"><a class="page-link" href="list?pageNo=${pager.totalPageNo}">맨끝</a></li>
</ul>