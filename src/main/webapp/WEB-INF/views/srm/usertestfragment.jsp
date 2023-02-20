<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Topbar -->
               <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
               <!-- End of Topbar -->

               <!-- 여기에 내용 담기 start -->
               <div class="container-fluid">
			
				<div class="row">
					<!-- 게시글 상세보기 start -->
					<div class="col-xl-9 col-lg-8 col-md-8 col-sm-8">
						<div class="card">
							<div class="card-header d-flex">						
								<h6 class="mr-auto text-primary font-weight-bold">유저테스트 상세보기 ></h6>
								<div class="ml-3">정규<i class="far fa-registered text-secondary"></i></div>
								<div class="ml-3">긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
								<div class="ml-5 mr-4">중요도: 
									<span class="fa fa-star checked" style="color: orange;"></span>
									<span class="fa fa-star checked" style="color: orange;"></span>
									<span class="fa fa-star checked" style="color: orange;"></span>
								</div>					
							</div>
							<div class="card-body">
								<div>
									<h3 class="mr-auto font-weight-bold">${request.reqTitle}</h3>
								</div>
								<div class="row">
									<div class="col-sm-6">
										<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
										<span class="font-weight-bold ml-2">${member.mname}</span>
										<span class="ml-3">${member.organ}</span>
										<span class="ml-3">${member.position}</span>
									</div>
									<div class="col-sm-6 ml-auto">
										<div class="d-flex">
											<div class="pl-5">시스템:</div>
											<div class="pl-2 flex-grow-1">${request.systemName}</div>
										</div>
										<div class="d-flex">
											<div class="pl-5">요청일:</div>
											<div class="pl-2 flex-grow-1">
												<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/>
											</div>
										</div>
										<div class="d-flex">
											<div class="pl-5">요청 완료 예정일:</div>
											<div class="pl-2 flex-grow-1" id="allExpectDate">
												${requestProcess.allExpectDateStr}
											</div>
										</div>
										<c:if test="${request.statusNo == 8}">
											<div class="d-flex">
												<div class="pl-5">유저테스트 완료 예정일 :</div>
												<div class="pl-2 flex-grow-1">
													<fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
										</c:if>
									</div>
								</div>
								<div class="mt-2">${request.reqTitle}</div>
								<div class="mt-2">${request.reqContent}</div>
								<div class="mt-3">
									<!-- 요청 첨부 파일 리스트 -->
									<span>파일이름</span>
									<a href="#" role="button">
										<i class="fas fa-cloud-download-alt"></i>
									</a>
								</div>
							</div>
						</div>
						
						<div>
							<!-- 유저테스트 요청 상태(7) -->
							<c:if test="${request.statusNo == 7}">
								<div class="d-flex justify-content-end">
									 <button class="btn btn-primary btn-lg mt-3" onclick="getDatemodal()" type="button">유저테스트 시작</button>
								</div>
							</c:if>
							<!-- 유저테스트 중 상태(8) -->
							<c:if test="${request.statusNo == 8}">
								<div class="d-flex justify-content-end">
									<form action="${pageContext.request.contextPath}/endwork" method="post" class="mt-3">
										<input type="hidden" name="rno" value="${request.rno}"/>
										<input type="hidden" name="nextStatus" value="9"/>
										<button class="btn btn-info btn-lg mt-3">유저테스트 완료</button>
									</form>
								</div>
							</c:if>
						</div>
						
						<div class="card mt-3">
							<div class="card-header">
								개발 내용
							</div>
							<c:forEach var="statusHistory" varStatus="index" items="${devToTesterHistories}">
								<div class="card-body row  border-success ml-4 mr-4 mt-3 mb-3">
									<div class="col-sm-2 d-flex align-items-center" style="text-align: center;">
										<div>
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hoon.png" width="60%">
											<div class="ml-3">김레지나</div>
										
										</div>
									</div>
									<div class="col-sm-10">
										<div class="d-flex justify-content-end mr-5">
											<div>${index.count}차 개발</div>
											<div class="ml-auto"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
										</div>
										<div>
											개발내용: ${statusHistory.reply}
										</div>
										<span>첨부파일: 파일이름</span>
										<a href="#" role="button">
											<i class="fas fa-cloud-download-alt"></i>
										</a>
									</div>
								</div>
							</c:forEach>
						</div>
						
					</div>
					<!-- 게시글 상세보기 end -->
					<!-- 상태 단계 이력 start -->						
					<div class="col-xl-3 col-lg-4 col-md-4 col-sm-4">
						<div class="card">
							<div class="card-header">
								<h6 class="m-0 font-weight-bold text-primary">단계 상태</h6>
							</div>
							<div class="card-body">
								<!-- request.statusName(현재 상태)에 따라 다른 단계 화면 표시-->
								<%@ include file="/WEB-INF/views/srm/nowstatusvertical.jsp" %>
							</div>
						</div>
					</div>
					<!-- 상태 단계 이력 end -->						
				</div>
				
               </div>