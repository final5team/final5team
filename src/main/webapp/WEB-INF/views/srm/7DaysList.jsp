<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table  table-striped" id="devList" >
<thead>
	<tr style="text-align: center;">
		<th>번호</th>
		<th>시스템</th>
		<th>요청유형</th>
		<th>제목</th>
		<th>우선순위</th>
		<th>현재단계</th>
		<th>완료예정일</th>
	</tr>
</thead>
<tbody >
	<c:forEach var="dayRequest" items="${listOf7daysLeft}">
		<tr style="text-align: center;">
			<td>${dayRequest.rno}</td>
			<td>${dayRequest.systemName}</td>
			<td>${dayRequest.reqType}</td>
			<td class="tableContent">${dayRequest.reqTitle}</td>
			<td>
				<c:if test="${dayRequest.priority eq '하' || dayRequest.priority eq '중' ||dayRequest.priority eq '상'}">
					<span class="fa fa-star checked" style="color: orange;"></span>
				</c:if>
				<c:if test="${dayRequest.priority eq '중' || dayRequest.priority eq '상'}">
					<span class="fa fa-star checked" style="color: orange;"></span>
				</c:if>
				<c:if test="${dayRequest.priority eq '상'}">
					<span class="fa fa-star checked" style="color: orange;"></span>
				</c:if>
			</td>
			<td>${dayRequest.statusName}</td>
			<td><fmt:formatDate value="${dayRequest.allExpectDate}" pattern="yyyy-MM-dd"/></td>
		</tr>
	</c:forEach>		
	</tbody>
</table>
<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
    <li class="page-item"><a class="page-link" onclick="7daysList(1)">처음</a></li>
   <c:if test="${dPager.groupNo>1}">
    <li class="page-item">
    	<a class="page-link" onclick="7daysList(${dPager.startPageNo-1})">
    		<i class="fas fa-caret-left"></i>
    	</a>
    </li>
   </c:if>
   <c:forEach var="i" begin="${dPager.startPageNo}" end="${dPager.endPageNo}">
   	<c:if test="${dPager.pageNo != i}">
    	<li class="page-item"><a class="page-link" onclick="7daysList(${i})">${i}</a></li>
   	</c:if>
   	<c:if test="${dPager.pageNo == i}">
    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" onclick="7daysList(${i})">${i}</a></li>
   	</c:if>
   </c:forEach>
   <c:if test="${dPager.groupNo< dPager.totalGroupNo}">
    <li class="page-item">
    	<a class="page-link" onclick="7daysList(${dPager.endPageNo + 1})">
    		<i class="fas fa-caret-right"></i>
   	 	</a>
    </li>
   </c:if>
   <li class="page-item"><a class="page-link" onclick="7daysList(${dPager.totalPageNo})">맨끝</a></li>
</ul>