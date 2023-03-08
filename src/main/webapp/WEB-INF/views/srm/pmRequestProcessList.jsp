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
					<th>진행상황</th>
				</tr>
			</thead>
			<tbody >
				<c:forEach var="requestProcess" items="${requestProcessList}" varStatus="i">
				<tr style="text-align: center;">
					<td>${i.count}</td>
					<c:if test="${requestProcess.reqType != null}">
						<td <c:if test="${requestProcess.reqType == '긴급'}"> class="text-danger"</c:if>>
							${requestProcess.reqType}
						</td>
					</c:if>
					<c:if test="${requestProcess.reqType == null}">
						<c:if test="${requestProcess.statusName == '접수중'}">
							<td class="text-info">
								미정
							</td>
						</c:if>
						<c:if test="${requestProcess.statusName == '반려'}">
							<td class="text-warning">
								반려
							</td>
						</c:if>
					</c:if>
					<td class="tableContent">
						<c:if test="${requestProcess.statusName eq '접수중' || requestProcess.statusName eq '접수완료'}">
							<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
						</c:if>
						<c:if test="${requestProcess.statusName eq '개발중' || requestProcess.statusName eq '개발재검토' || requestProcess.statusName eq '개발완료'}">
							<a href="${pageContext.request.contextPath}/developerdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
						</c:if>
						<c:if test="${requestProcess.statusName eq '테스트중' || requestProcess.statusName eq '테스트완료'}">
							<a href="${pageContext.request.contextPath}/testerdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
						</c:if>
						<c:if test="${requestProcess.statusName eq '유저테스트중' || requestProcess.statusName eq '유저테스트완료'}">
							<a href="${pageContext.request.contextPath}/usertestdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
						</c:if>
						<c:if test="${requestProcess.statusName eq '배포중' || requestProcess.statusName eq '배포완료'}">
							<a href="${pageContext.request.contextPath}/distributedetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
						</c:if>
						<c:if test="${requestProcess.statusName eq '완료' || requestProcess.statusName eq '반려'}">
							<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
						</c:if>
					</td>
					<td>
						<c:if test="${requestProcess.priority != null}">
							<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
								<span class="fa fa-star checked" style="color: orange;"></span>
							</c:if>
							<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
								<span class="fa fa-star checked" style="color: orange;"></span>
							</c:if>
							<c:if test="${requestProcess.priority eq '상'}">
								<span class="fa fa-star checked" style="color: orange;"></span>
							</c:if>
						</c:if>
						<c:if test="${requestProcess.priority == null}">
							<span class="text-info">미정</span>
						</c:if>
					</td>
					<td>
						<c:if test="${requestProcess.reqDate != null}">
							<fmt:formatDate value="${requestProcess.reqDate}" pattern="yyyy-MM-dd"/>
						</c:if>
						<c:if test="${requestProcess.reqDate == null}">
							<span class="text-info">미정</span>
						</c:if>
					</td>
					<td>
						<c:if test="${requestProcess.allExpectDate != null}">
							<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
						</c:if>
						<c:if test="${requestProcess.allExpectDate == null}">
							<span class="text-info">미정</span>
						</c:if>
					</td>
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
		<div class="pager default mt-3">
			<div class="pagingButtonSet d-flex justify-content-center">
				<a onclick="pmRequestProcessList(1, '${searchStatus}')" type="button" class="btn btn-muted shadow">처음</a>
				<c:if test="${rpPager.groupNo > 1}">
					<a onclick="pmRequestProcessList(${rpPager.startPageNo-1}, '${searchStatus}')" class="btn btn-muted shadow">이전</a>

				</c:if>

				<c:forEach var="i" begin="${rpPager.startPageNo}" end="${rpPager.endPageNo}">
					<c:if test="${rpPager.pageNo != i}">
						<a onclick="pmRequestProcessList(${i}, '${searchStatus}')" type="button" class="btn btn-white shadow">${i}</a>
					</c:if>
					<c:if test="${rpPager.pageNo == i}">
						<a onclick="pmRequestProcessList(${i}, '${searchStatus}')" type="button" class="btn btn-dark shadow">${i}</a>
					</c:if>
				</c:forEach>

				<c:if test="${rpPager.groupNo < rpPager.totalGroupNo }">
					<a onclick="pmRequestProcessList(${rpPager.endPageNo+1}, '${searchStatus}')" type="button" class="btn btn-muted shadow">다음</a>

				</c:if>
				<a onclick="pmRequestProcessList(${rpPager.totalPageNo}, '${searchStatus}')" type="button" class="btn btn-muted shadow">맨끝</a>
			</div>
		</div>
	</div>	
