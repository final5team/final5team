<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<table>
<c:if test="${requestList.size() > 0}">
	<tr>
		<th class="ex ">No.</th>
		<th class="ex ">시스템</th>
		<th class="ex ">요청 유형</th>
		<th class="ex ">요청 제목</th>
		<th class="ex ">요청 일자</th>
		<th class="ex">단계</th>
	</tr>

	<c:forEach var="request" items="${requestList}">
		<tr>
			<td class="rno" style="max-width: 40px;  min-width : 40px; white-space: nowrap; overflow: hidden;">${request.rno}</td>
			<td class="client" style="max-width: 95px;  min-width : 95px; white-space: nowrap; overflow: hidden;">${request.systemName}</td>
			<c:if test="${request.statusNo == 1}">
				<td class="sysType">
					<span class="badge badge-warning">대기</span>
				</td>
			</c:if>
			<c:if test="${request.statusNo == 12}">
				<td class="sysType">
					<span class="badge badge-warning">반려</span>
				</td>
			</c:if>
			<c:if test="${request.statusNo != 1 && request.statusNo != 12}">
				<c:if test="${request.reqType eq '정규'}">
					<td class="sysType">
						<span class="badge badge-primary">${request.reqType}</span>
					</td>
				</c:if>
				<c:if test="${request.reqType eq '긴급'}">
					<td class="sysType">
						<span class="badge badge-danger">${request.reqType}</span>
					</td>
				</c:if>

			</c:if>
			<td class="reqTitle" style="max-width: 190px; min-width : 190px; white-space: nowrap; overflow: hidden;">
				<c:if test="${request.usrCheck == 1}">
					<strong class="text-danger">New</strong>
				</c:if>	
				${request.reqTitle}
			</td>
			<td class="reqDate" style="max-width: 87px; min-width : 87px; white-space: nowrap; overflow: hidden;">
				<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd" />
			</td>
			<td class="step_td">
				<c:if test="${sessionScope.member.mtype != 'user'}">
					<%@ include file="/WEB-INF/views/srm/restatus/stepintable_my.jsp"%>
				</c:if>
				<c:if test="${sessionScope.member.mtype == 'user'}">
					<%@ include file="/WEB-INF/views/srm/restatus/stepintable_user.jsp"%>				
				</c:if>
			</td>
		</tr>
	</c:forEach>
</c:if>
	<c:if test="${requestList.size() == 0}">
		<div id="noResult"> 해당되는 내용이 없습니다. </div>
	</c:if>
	
</table>
<c:if test="${pager.totalRows > 6}">
<div class="pager">
	<div class="pagingButtonSet d-flex justify-content-center">
		<a onclick="pageChange(1)" type="button" class="btn btn-muted shadow">처음</a>
		<c:if test="${pager.groupNo > 1}">
			<a onclick="pageChange(${pager.startPageNo-1})" class="btn btn-muted shadow">이전</a>
								 
		</c:if>

		<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
			<c:if test="${pager.pageNo != i}">
				<a onclick="pageChange(${i})" type="button" class="btn btn-white shadow">${i}</a>
			</c:if>
			<c:if test="${pager.pageNo == i}">
				<a onclick="pageChange(${i})" type="button" class="btn btn-dark shadow">${i}</a>
			</c:if>
		</c:forEach>

		<c:if test="${pager.groupNo < pager.totalGroupNo }">
			<a onclick="pageChange(${pager.endPageNo+1})" type="button" class="btn btn-muted shadow">다음</a>

		</c:if>
		<a onclick="pageChange(${pager.totalPageNo})" type="button" class="btn btn-muted shadow">맨끝</a>
	</div>
</div>
</c:if>
<c:if test="${pager.totalRows == 0}">
	<div class="pager default">
	</div>
</c:if>
