<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="height: 288px;">
	<table class="table  table-striped" id="devList" >
		<thead style="background-color: #3A4651;" class="text-white">
			<tr style="text-align: center;">
				<th>번호</th>
				<th>시스템</th>
				<th>요청유형</th>
				<th>제목</th>
				<th>우선순위</th>
				<th>진행상황</th>
				<th>완료예정일</th>
			</tr>
		</thead>
		<tbody >
			<c:forEach var="dayRequest" items="${listOf7daysLeft}">
				<tr style="text-align: center;">
					<td>${dayRequest.rno}</td>
					<td>${dayRequest.systemName}</td>
					<td>${dayRequest.reqType}</td>
					<td class="tableContent">
						<c:if test="${dayRequest.pmCheck == 1}">
							<strong class="text-danger">N</strong>																
						</c:if>
						<c:if test="${dayRequest.statusName eq '접수중' || dayRequest.statusName eq '접수완료'}">
							<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
						</c:if>
						<c:if test="${dayRequest.statusName eq '개발중' || dayRequest.statusName eq '개발재검토' || dayRequest.statusName eq '개발완료'}">
							<a href="${pageContext.request.contextPath}/developerdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
						</c:if>
						<c:if test="${dayRequest.statusName eq '테스트중' || dayRequest.statusName eq '테스트완료'}">
							<a href="${pageContext.request.contextPath}/testerdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
						</c:if>
						<c:if test="${dayRequest.statusName eq '유저테스트중' || dayRequest.statusName eq '유저테스트완료'}">
							<a href="${pageContext.request.contextPath}/usertestdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
						</c:if>
						<c:if test="${dayRequest.statusName eq '배포중' || dayRequest.statusName eq '배포완료'}">
							<a href="${pageContext.request.contextPath}/distributedetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
						</c:if>
						<c:if test="${dayRequest.statusName eq '완료' || dayRequest.statusName eq '반려'}">
							<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
						</c:if>
					</td>
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
					<td>
						<c:if test="${dayRequest.statusName eq '접수중' || dayRequest.statusName eq '접수완료' }">
							<span class="badge badge-warning">${dayRequest.statusName}</span>
						</c:if>
						<c:if test="${dayRequest.statusName eq '개발재검토' || dayRequest.statusName eq '반려' }">
							<span class="badge badge-danger">${dayRequest.statusName}</span>
						</c:if>
						<c:if test="${dayRequest.statusName eq '개발중' || dayRequest.statusName eq '개발완료' }">
							<span class="badge badge-primary">${dayRequest.statusName}</span>
						</c:if>
						<c:if test="${dayRequest.statusName eq '테스트중' || dayRequest.statusName eq '테스트완료' }">
							<span class="badge badge-success">${dayRequest.statusName}</span>
						</c:if>
						<c:if test="${dayRequest.statusName eq '유저테스트중' || dayRequest.statusName eq '유저테스트완료' }">
							<span class="badge badge-info">${dayRequest.statusName}</span>
						</c:if>
						<c:if test="${dayRequest.statusName eq '배포중' || dayRequest.statusName eq '배포완료' }">
							<span class="badge badge-secondary">${dayRequest.statusName}</span>
						</c:if>
						<c:if test="${dayRequest.statusName eq '완료'}">
							<span class="badge badge-dark">${dayRequest.statusName}</span>
						</c:if>
					</td>
					<td><fmt:formatDate value="${dayRequest.allExpectDate}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
</div>
<div class="pager default mt-4">
	<div class="pagingButtonSet d-flex justify-content-center">
		<a onclick="sevenDaysList(1)" type="button" class="btn btn-muted btn-sm shadow">처음</a>
		<c:if test="${dPager.groupNo > 1}">
			<a onclick="sevenDaysList(${dPager.startPageNo-1})" class="btn btn-muted btn-sm shadow">이전</a>

		</c:if>

		<c:forEach var="i" begin="${dPager.startPageNo}" end="${dPager.endPageNo}">
			<c:if test="${dPager.pageNo != i}">
				<a onclick="sevenDaysList(${i})" type="button" class="btn btn-white btn-sm shadow">${i}</a>
			</c:if>
			<c:if test="${dPager.pageNo == i}">
				<a onclick="sevenDaysList(${i})" type="button" class="btn btn-dark btn-sm shadow">${i}</a>
			</c:if>
		</c:forEach>

		<c:if test="${dPager.groupNo < dPager.totalGroupNo }">
			<a onclick="sevenDaysList(${dPager.endPageNo+1})" type="button" class="btn btn-muted btn-sm shadow">다음</a>

		</c:if>
		<a onclick="sevenDaysList(${dPager.totalPageNo})" type="button" class="btn btn-muted btn-sm shadow">맨끝</a>
	</div>
</div>