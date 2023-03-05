<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <style>
    #requestInfo {
   	 	background-image: url('${pageContext.request.contextPath}/resources/img/completed.png'); 
		background-repeat: no-repeat;
		background-position: 700px 420px;
		background-size: 200px;		
    }
    </style>
</head>

<body id="page-top">
	
    <!-- Page Wrapper -->
    <div id="wrapper">
		
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
                <!-- End of Topbar -->

                <!-- 여기에 내용 담기 start -->
                <div class="container">
                	<div id="main"> <!-- main start -->
                		<div class="title-block">
                	 		<h3 class="title">최종 승인 상세 보기</h3>
                	 	</div>
                	 	<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
						<!-- 게시글 상세보기 start -->
						<section><!-- 요청정보 DIV START -->
							<div class="card border-top-dark mt-3" id= "<c:if test='${request.statusNo==13}'>requestInfo</c:if>" >
								<div class="card-block">
									<div class="card-title-block">
	                	 				<h3 class="title">
		                	 				요청 상세 보기<i class="ml-1 fas fa-book-open"></i>
	                	 				</h3>
	                	 			</div>
	                	 			<div class="card-body"><!-- card-body start -->
										<div class="row">
											<div class="col-3 label">요청자</div>
											<div class="col-2">${request.clientName}</div>
											<div class="col-3 label">요청 번호</div>
											<div class="col-2">No.${request.rno}</div>
										</div>
										<hr/>
										
										<div class="row">
											<div class="col-3 label">요청일</div>
											<div class="col-2"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
											<div class="col-3 label">완료 희망일</div>
											<div class="col-2"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">시스템 </div>
											<div class="col-2">${request.systemName}</div>
											<div class="col-3 label">소속 기관</div>
											<div class="col-2">${request.organ}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">요청 유형</div>
											<div class="col-2">
												<c:if test="${requestProcess.reqType eq '정규'}">
													<div>정규<i class="far fa-registered text-secondary"></i></div>
												</c:if>
												<c:if test="${requestProcess.reqType eq '긴급'}">
													<div>긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
												</c:if>
											</div>
											<div class="col-3 label">중요도</div>
											<div class="col-2">
												<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
													<span class="fa fa-star checked" style="color: orange;"></span>
												</c:if>
												<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
													<span class="fa fa-star checked" style="color: orange;"></span>
												</c:if>
												<c:if test="${requestProcess.priority eq '상'}">
													<span class="fa fa-star checked" style="color: orange;"></span>
												</c:if>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">제목</div>
											<div class="col-8">${request.reqTitle}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">내용</div>
											<div class="col-7 border" style="min-height:100px;">${request.reqContent}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">첨부파일</div>
											<div class="col-7">
												<c:forEach var="statusHistoryFile" items="${request.files}">
													<div>
														<span>${statusHistoryFile.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</div>
										<c:if test="${request.statusNo==11 && member.mtype =='pm'}">
											<div class="d-flex justify-content-end">
												<button class="btn btn-primary btn-lg mt-3 ml-3" type="button" data-toggle="modal" data-target="#completeModal">처리 완료</button>									
											</div>	
										</c:if>
									</div> <!-- card-body/ -->	
								</div> <!-- card-block /-->	
							</div>
						</section><!-- 요청정보 DIV END -->
						<!-- 단계별 처리 내역 start -->
				   	 	<c:if test="${member.mtype !='user'}">
							<div class="card border-top-primary mt-3 mb-3" id="requestEndInfo">
								<div class="card-block">
									<div class="card-title-block">
		               	 				<h3 class="title">
		                	 				단계별 처리 일정 <i class="fas fa-history"></i>
		               	 				</h3>
		               	 			</div>
									<table class="table table-hover" style="text-align: center;">
									   <thead style="background-color: #72B22B;" class="text-white">
									      <tr>
									     	 <th>단계</th>
									         <th>담당자</th>
									         <th>완료 예정일</th>
									         <th>완료일</th>
									      </tr>
									   </thead>
									   <tbody>
											     <tr>
											        <td>개발</td>
											        <td>${requestProcess.developer}</td>
											        <td><fmt:formatDate value="${requestProcess.devExpectDate}" pattern="yyyy-MM-dd"/></td>
											        <td><fmt:formatDate value="${requestProcess.devCompDate}" pattern="yyyy-MM-dd"/></td>
											     </tr>
											     <tr>
											        <td>테스트</td>
											        <td>${requestProcess.tester}</td>
											        <td><fmt:formatDate value="${requestProcess.testExpectDate}" pattern="yyyy-MM-dd"/></td>
											        <td><fmt:formatDate value="${requestProcess.testCompDate}" pattern="yyyy-MM-dd"/></td>
											     </tr>
											     <c:if test="${requestProcess.reqType eq '정규'}">
												     <tr>
												        <td>유저 테스트</td>
												        <td>${requestProcess.userTester}</td>
												        <td><fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/></td>
												        <td><fmt:formatDate value="${requestProcess.userTestCompDate}" pattern="yyyy-MM-dd"/></td>
												     </tr>
											     </c:if>
											     <tr>
											        <td>배포</td>
											        <td>${requestProcess.distributor}</td>
											        <td><fmt:formatDate value="${requestProcess.distExpectDate}" pattern="yyyy-MM-dd"/></td>
											        <td><fmt:formatDate value="${requestProcess.distCompDate}" pattern="yyyy-MM-dd"/></td>
											     </tr>
									     <tr>
									        <td>최종 승인</td>
									        <td>${requestProcess.pm}</td>
									        <td><fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/></td>
									        <td><fmt:formatDate value="${requestProcess.allCompDate}" pattern="yyyy-MM-dd"/></td>
									     </tr>
									  </tbody>
								   </table>
							   </div>
							</div>
				     	</c:if>
						<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
						<!-- 단계별 처리 내역 end -->
						
						<!-- 처리 완료 모달창 start -->
						 <div class="modal fade" id="completeModal" role="dialog" aria-labelledby="developDueDate" aria-hidden="true" >
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">											
										<h5 class="modal-title" id="developDueDate">처리 완료</h5>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>
									<div class="modal-body text-center">	
										<p>해당 서비스 요청을 최종 완료 처리하시겠습니까?</p>									
										<label class="mt-1" style="color: #343a40;" for="expectDate">최종 완료 일자</label>											
										<input value="<fmt:formatDate value='<%=new java.util.Date()%>' pattern='yyyy-MM-dd'/>" name="allCompDate" readonly>
																					
									</div>
									<div class="modal-footer">	
										<form method="get" action="<c:url value='/pm/complete'/>">
											<input type="hidden" name="rno" value="${request.rno}"/>	
											<button class="btn btn-primary" type="submit">확인</button>									
											<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>	
										</form>					                    
									</div>
								</div>
							</div>
						</div>
						<!-- 처리 완료 모달창 end -->	
						<!-- 게시글 상세보기 end -->
					</div><!-- main end -->					
                </div>
                <!-- 여기에 내용 담기 end -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>


</body>

</html>
