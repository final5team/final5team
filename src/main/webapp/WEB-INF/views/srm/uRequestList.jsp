<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="height: 280px;">
	<table class="table table-hover usertable table-striped">
		<thead class="text-white" id="table-head-color">
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
				<tr style="text-align: center;">
					<td>${request.rno}</td>
					<td class="tableContent">
						<c:if test="${request.usrCheck == 1}">
							<strong class="text-danger">New</strong>
						</c:if>
						<c:if test="${request.statusNo != 12 &&  request.statusNo != 13}">
							<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
								${request.reqTitle}
							</a>
						</c:if>
						<c:if test="${request.statusNo == 12 || request.statusNo == 13}">
							<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
								${request.reqTitle}
							</a>
						</c:if>
					</td>
					<td>${request.systemName}</td>
					<td><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:if test="${request.statusNo == 12}">
							<span class="badge badge-warning">반려</span>
						</c:if>
						<c:if test="${request.statusNo == 13}">
							<span class="badge badge-success">완료</span>
						</c:if>
						<c:if test="${request.statusNo != 12 && request.statusNo != 13}">
							<span class="badge badge-primary">진행중</span>
						</c:if>
				    </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${userRequestList[0].reqTitle == null}">
		<div class="d-flex justify-content-center">
		내용이 없습니다.
		</div>
	</c:if>
</div>
<c:if test="${userRequestList[0].reqTitle != null}">
<div class="pager default" style="margin-top : 40px">
	<div class="pagingButtonSet d-flex justify-content-center">
		<a onclick="userRequestList('${searchStatus}', 1)" type="button" class="btn btn-muted btn-sm shadow">처음</a>
	<c:if test="${uPager.groupNo > 1}">
		<a onclick="userRequestList('${searchStatus}', ${uPager.startPageNo-1})" class="btn btn-muted btn-sm shadow">이전</a>
	
	</c:if>
	
	<c:forEach var="i" begin="${uPager.startPageNo}" end="${uPager.endPageNo}">
		<c:if test="${uPager.pageNo != i}">
			<a onclick="userRequestList('${searchStatus}', ${i})" type="button" class="btn btn-white btn-sm shadow">${i}</a>
		</c:if>
		<c:if test="${uPager.pageNo == i}">
			<a onclick="userRequestList('${searchStatus}', ${i})" type="button" class="btn btn-info btn-sm shadow">${i}</a>
		</c:if>
	</c:forEach>
	
	<c:if test="${uPager.groupNo < uPager.totalGroupNo }">
		<a onclick="userRequestList('${searchStatus}', ${uPager.endPageNo+1})" type="button" class="btn btn-muted btn-sm shadow">다음</a>
	
	</c:if>
	<a onclick="userRequestList('${searchStatus}', ${uPager.totalPageNo})" type="button" class="btn btn-muted btn-sm shadow">맨끝</a>
	</div>
</div>
</c:if>
