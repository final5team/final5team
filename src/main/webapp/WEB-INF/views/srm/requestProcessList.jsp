<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<div style="height: 305px;">
		<table class="table tasks-block table-striped table-hover"  >
			<thead <c:if test="${searchStatus=='대기'}"> style="background-color: #85CE36;" </c:if>
					<c:if test="${searchStatus=='재검토'}"> style="background-color: #FE974B;"</c:if>
					<c:if test="${searchStatus=='진행중'}"> style="background-color: #4BCF99;"</c:if>
					<c:if test="${searchStatus=='완료'}"> style="background-color: #76D4F5;"</c:if>
					style="background-color: #3A4651;"
			class="text-white">
				<tr style="text-align: center;">
					<th>번호</th>
					<th>요청유형</th>
					<th>제목</th>
					<th>중요도</th>
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
					<td class="tableContent">
						<c:if test="${member.mtype == 'developer'}">
							<a href="${pageContext.request.contextPath}/developerdetail?rno=${requestProcess.rno}">
								<c:if test="${requestProcess.devCheck == 1 && requestProcess.developer == member.mid}">
									<strong class="text-danger">New</strong>																
								</c:if>
								${requestProcess.reqTitle}
							</a>
						</c:if>
						<c:if test="${member.mtype == 'tester'}">
							<a href="${pageContext.request.contextPath}/testerdetail?rno=${requestProcess.rno}">
								<c:if test="${requestProcess.tesCheck == 1 && requestProcess.tester == member.mid}">
									<strong class="text-danger">New</strong>																
								</c:if>
								${requestProcess.reqTitle}
							</a>
						</c:if>
						<c:if test="${member.mtype == 'usertester'}">
							<a href="${pageContext.request.contextPath}/usertestdetail?rno=${requestProcess.rno}">
								<c:if test="${requestProcess.uttCheck == 1 && requestProcess.userTester == member.mid}">
									<strong class="text-danger">New</strong>																
								</c:if>
								${requestProcess.reqTitle}
							</a>
						</c:if>
						<c:if test="${member.mtype == 'distributor'}">
							<a href="${pageContext.request.contextPath}/distributedetail?rno=${requestProcess.rno}">
								<c:if test="${requestProcess.disCheck == 1  && requestProcess.distributor == member.mid}">
									<strong class="text-danger">New</strong>																
								</c:if>
								${requestProcess.reqTitle}
							</a>
						</c:if>
					</td>
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
					<td>
						<c:if test="${member.mtype == 'developer'}">
							<c:if test="${requestProcess.devExpectDate != null}"><fmt:formatDate value="${requestProcess.devExpectDate}" pattern="yyyy-MM-dd"/></c:if>
							<c:if test="${requestProcess.devExpectDate == null}">미정</c:if>
						</c:if>
						<c:if test="${member.mtype == 'tester'}">
							<c:if test="${requestProcess.testExpectDate != null}"><fmt:formatDate value="${requestProcess.testExpectDate}" pattern="yyyy-MM-dd"/></c:if>
							<c:if test="${requestProcess.testExpectDate == null}">미정</c:if>
						</c:if>
						<c:if test="${member.mtype == 'usertester'}">
							<c:if test="${requestProcess.userTestExpectDate != null}"><fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/></c:if>
							<c:if test="${requestProcess.userTestExpectDate == null}">미정</c:if>
						</c:if>
						<c:if test="${member.mtype == 'distributor'}">
							<c:if test="${requestProcess.distExpectDate != null}"><fmt:formatDate value="${requestProcess.distExpectDate}" pattern="yyyy-MM-dd"/></c:if>
							<c:if test="${requestProcess.distExpectDate == null}">미정</c:if>
						</c:if>
					</td>
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
						<c:if test="${requestProcess.statusName eq '유저테스트중'}">
							<span class="badge badge-info">품질검사중</span>
						</c:if>
						<c:if test="${requestProcess.statusName eq '유저테스트완료'}">
							<span class="badge badge-info">품질검사완료</span>
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
		<c:if test="${requestProcessList[0].reqTitle == null}">
			<div class="d-flex justify-content-center font-weight-bold">
				내용이 없습니다.
			</div>
		</c:if>
	</div>
	<div>
		<div class="pager default mt-2">
			<div class="pagingButtonSet d-flex justify-content-center">
				<a onclick="requestProcessList(1, '${searchStatus}')" type="button" class="btn btn-muted btn-sm shadow">처음</a>
				<c:if test="${rpPager.groupNo > 1}">
					<a onclick="requestProcessList(${rpPager.startPageNo-1}, '${searchStatus}')" class="btn btn-muted btn-sm shadow">이전</a>

				</c:if>

				<c:forEach var="i" begin="${rpPager.startPageNo}" end="${rpPager.endPageNo}">
					<c:if test="${rpPager.pageNo != i}">
						<a onclick="requestProcessList(${i}, '${searchStatus}')" type="button" class="btn btn-white btn-sm shadow">${i}</a>
					</c:if>
					<c:if test="${rpPager.pageNo == i}">
						<a onclick="requestProcessList(${i}, '${searchStatus}')" type="button" class="btn btn-dark btn-sm shadow">${i}</a>
					</c:if>
				</c:forEach>

				<c:if test="${rpPager.groupNo < rpPager.totalGroupNo }">
					<a onclick="requestProcessList(${rpPager.endPageNo+1}, '${searchStatus}')" type="button" class="btn btn-muted btn-sm shadow">다음</a>

				</c:if>
				<a onclick="requestProcessList(${rpPager.totalPageNo}, '${searchStatus}')" type="button" class="btn btn-muted btn-sm shadow">맨끝</a>
			</div>
		</div>
	</div>	
