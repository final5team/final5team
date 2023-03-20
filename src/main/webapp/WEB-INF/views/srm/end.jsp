<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <style>
    
    #completeInfo {
   	 	background-image: url('${pageContext.request.contextPath}/resources/img/completed.png'); 
		background-repeat: no-repeat;
		background-position: 700px 420px;
		background-size: 200px;		
    }
    #rejectInfo {
   	 	background-image: url('${pageContext.request.contextPath}/resources/img/rejectedStamp.jpg'); 
		background-repeat: no-repeat;
		background-position: 700px 350px;
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
                	 	<!-- 여기에 단계 상태 이력 넣기 -->
                	 	<div> 
	                	 <%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	
                	 	<!-- 여기에 단계 상태 이력 넣기 /-->
						
						<!-- 접수 완료 start -->
				   	 	<c:if test="${request.statusNo != 12}">
							<div class="card border-top-primary mt-3 mb-3" id="completeInfo">
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
										        <td>${mnameList.developer}</td>
										        <td><fmt:formatDate value="${requestProcess.devExpectDate}" pattern="yyyy-MM-dd"/></td>
										        <td><fmt:formatDate value="${requestProcess.devCompDate}" pattern="yyyy-MM-dd"/></td>
										    </tr>
										    <tr>
										        <td>테스트</td>
										        <td>${mnameList.tester}</td>
										        <td><fmt:formatDate value="${requestProcess.testExpectDate}" pattern="yyyy-MM-dd"/></td>
										        <td><fmt:formatDate value="${requestProcess.testCompDate}" pattern="yyyy-MM-dd"/></td>
										    </tr>
										    <c:if test="${requestProcess.reqType eq '정규'}">
											     <tr>
											        <td>유저 테스트</td>
											        <td>${mnameList.userTester}</td>
											        <td><fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/></td>
											        <td><fmt:formatDate value="${requestProcess.userTestCompDate}" pattern="yyyy-MM-dd"/></td>
											     </tr>
										    </c:if>
										    <tr>
										        <td>배포</td>
										        <td>${mnameList.distributor}</td>
										        <td><fmt:formatDate value="${requestProcess.distExpectDate}" pattern="yyyy-MM-dd"/></td>
										        <td><fmt:formatDate value="${requestProcess.distCompDate}" pattern="yyyy-MM-dd"/></td>
										    </tr>
										    <tr>
										        <td>최종 승인</td>
										        <td>${mnameList.pm}</td>
										        <td><fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/></td>
										        <td><fmt:formatDate value="${requestProcess.allCompDate}" pattern="yyyy-MM-dd"/></td>
										    </tr>
										</tbody>
								   </table>
							   </div>
							   <c:if test="${request.statusNo==11 && member.mtype =='pm'}">
							 	  	<div class="d-flex justify-content-end ">
										<button class="btn btn-primary btn-md my-2 mx-3" type="button" data-toggle="modal" data-target="#completeModal">최종 완료</button>									
									</div>
								</c:if>
							</div>
				     	</c:if>
						
						<!-- 접수 완료 end -->
						<!-- 접수 반려 start -->
						<c:if test="${request.statusNo == 12}">
							<div class="card border-top-danger mt-3 mb-1">
								<h3 class="title m-3">						
									반려 처리 내역 <i class="ml-1 fas fa-external-link-alt"></i>
								</h3>
								<div class="card-body">									
									<div class="form-group row">
										<label class="label col-3">반려 사유</label>
										<div class="form-control boxed col-8" name="reply" style="min-height: 100px;">${rejectHistory.reply}</div>
									</div>											
									<div class="mt-3 row">
										<c:if test="${request.files != null}">
											<div class="col-3 label">첨부 파일</div>
											<div class="col">
												<c:forEach var="file" items="${rejectHistory.fileList}">
													<div>
														<span>${file.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${file.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</c:if>
									</div>																														
								</div>										
							</div>
						</c:if>
						<c:if test="${member.mtype == 'user'}">
							<button class="btn btn-dark btn-sm ml-5 mt-2" onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'">목록</button>
						</c:if>
						<c:if test="${member.mtype != 'user'}">
							<button class="btn btn-dark btn-sm ml-5 mt-2" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
						</c:if>
						<!-- 접수결과 반려 end -->
						<!-- 처리 완료 모달창 start -->
						 <div class="modal fade" id="completeModal" role="dialog" aria-labelledby="dueDate" aria-hidden="true" >
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">											
										<h5 class="modal-title" id="dueDate">최종 완료</h5>
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
