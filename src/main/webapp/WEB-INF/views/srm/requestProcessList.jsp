<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<div style="height: 305px;">
		<table class="table tasks-block table-striped table-hover"  >
			<thead style="background-color: #3A4651;" class="text-white">
				<tr style="text-align: center;">
					<th>번호</th>
					<th>요청유형</th>
					<th>제목</th>
					<th>우선순위</th>
					<th>요청일</th>
					<th>완료예정일</th>
					<th>담당자</th>
					<th>진행상황</th>
				</tr>
			</thead>
			<tbody >
				<c:forEach var="requestProcess" items="${requestProcessList}" varStatus="i">
				<tr style="text-align: center;">
					<td>${i.count}</td>
					<td <c:if test="${requestProcess.reqType == '긴급'}"> class="text-danger"</c:if>>
					${requestProcess.reqType}
					</td>
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
					<td>
						<c:if test="${requestProcess.statusName eq '접수중' || requestProcess.statusName eq '접수완료' }">
							<span class="badge badge-warning">${requestProcess.statusName}</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '개발재검토' || requestProcess.statusName eq '반려' }">
							<span class="badge badge-danger">${requestProcess.statusName}</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '개발중' || requestProcess.statusName eq '개발완료' }">
							<span class="badge badge-primary">${requestProcess.statusName}</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '테스트중' || requestProcess.statusName eq '테스트완료' }">
							<span class="badge badge-success">${requestProcess.statusName}</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '유저테스트중' || requestProcess.statusName eq '유저테스트완료' }">
							<span class="badge badge-info">${requestProcess.statusName}</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '배포중' || requestProcess.statusName eq '배포완료' }">
							<span class="badge badge-secondary">${requestProcess.statusName}</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '완료'}">
							<span class="badge badge-dark">${requestProcess.statusName}</span>
						</c:if>
					
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
		    <li class="page-item"><a class="page-link" onclick="requestProcessList(1)">처음</a></li>
		    <c:if test="${rpPager.groupNo>1}">
			    <li class="page-item">
			    	<a class="page-link" onclick="requestProcessList(${rpPager.startPageNo-1})">
			    		<i class="fas fa-caret-left"></i>
			    	</a>
			    </li>
		    </c:if>
		    <c:forEach var="i" begin="${rpPager.startPageNo}" end="${rpPager.endPageNo}">
		    	<c:if test="${rpPager.pageNo != i}">
			    	<li class="page-item"><a class="page-link" onclick="requestProcessList(${i})">${i}</a></li>
		    	</c:if>
		    	<c:if test="${rpPager.pageNo == i}">
			    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" onclick="requestProcessList(${i})">${i}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${rpPager.groupNo<rpPager.totalGroupNo}">
			    <li class="page-item">
			    	<a class="page-link" onclick="requestProcessList(${rpPager.endPageNo + 1})">
			    		<i class="fas fa-caret-right"></i>
			   	 	</a>
			    </li>
		    </c:if>
		    <li class="page-item"><a class="page-link" onclick="requestProcessList(${rpPager.totalPageNo})">맨끝</a></li>
		</ul>
	</div>	
