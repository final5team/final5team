<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script>
		$(document).ready(function(){
		  $("#completediv").hide();
		  $("#completebtn").click(function(){
		      $("#completediv").toggle();
		  });		 
		});
		function completeCancel(){
			$("#completediv").hide();
			$("textarea").val("");		
		}
	</script>
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
                <div class="container-fluid">
				
					<div class="row">
						<!-- 게시글 상세보기 start -->
						<div class="col-xl-9 col-lg-8 col-md-8 col-sm-8 mb-4">
							<div class="card">
								<div class="card-header d-flex">
									<div class="mr-auto">배포 완료</div>	
									<c:if test="${reqProcess.reqType eq '정규'}">
										<div class="ml-3">정규<i class="far fa-registered text-secondary"></i></div>
									</c:if>
									<c:if test="${reqProcess.reqType eq '긴급'}">
										<div class="ml-3">긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
									</c:if>									
									<div class="ml-5 mr-4">중요도:
										<c:if test="${reqProcess.priority eq '하' || reqProcess.priority eq '중' ||reqProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
										<c:if test="${reqProcess.priority eq '중' || reqProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
										<c:if test="${reqProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
									</div>										
								</div>
								<div class="card-body">
									<div>배포완료상세보기 ></div>
									<div>
										<h3 class="mr-auto font-weight-bold">${request.reqTitle}</h3>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
											<span class="font-weight-bold ml-2">${request.clientName}</span>
											<span class="ml-3">${request.organ}</span>
										</div>
										<div class="col-sm-6 ml-auto">
											<div class="d-flex">
												<div class="pl-5">시스템:</div>
												<div class="pl-2 flex-grow-1">${request.systemName}</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청일:</div>
												<div class="pl-2 flex-grow-1"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청완료희망일:</div>
												<div class="pl-2 flex-grow-1"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
											</div>
										</div>
									</div>
									<div class="mt-2 ml-5">${request.reqContent}</div>
									<div class="mt-3 ml-5">
										<span>첨부파일: <c:forEach var="file" items="${request.files}">${file.fileName}</c:forEach></span>
										<a href="#" role="button">
											<i class="fas fa-cloud-download-alt"></i>
										</a>
									</div>	
									<div class="d-flex justify-content-end">
										<button class="btn btn-primary btn-lg mt-3 ml-3" type="button" id="completebtn">처리 완료</button>									
									</div>																
								</div>
							</div>
							<div class="card mt-4">
								<div class="card-header">배포 </div>
								<div class="card-body row">
									<div class="col-sm-3" style="text-align: center;">
										<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
										<div class="ml-3">${reqProcess.distributor}</div>
									</div>
									<div class="col-sm-9">
										<div class="ml-3">
											<div class="row">
												<div class="col">
													<label class="control-label mr-2">완료 예정일</label>
													<input value="${reqProcess.distExpectDate}" readonly>													 										
												</div>
												<div class="col">
													<label class="control-label mr-2">실제 완료일</label>
													<input value="${reqProcess.distCompDate}" readonly> 													  												
												</div>												
											</div>											
										</div>
									</div>
								</div>
							</div>							

							<!-- 완료 -->
							<div id="completediv"> 						            
								<form method="post" action="<c:url value='/pm/complete'/>" enctype="multipart/form-data">
									<!-- 요청 접수 card start-->
									<div class="card mt-4 mb-1">
										<div class="card-header">처리 완료</div>
										<div class="card-body">
											<div class="row">
												<div class="col-sm-3" style="text-align:center;">
													<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
													<div class="ml-3">PM</div>
												</div>
												<div class="col-sm-9">	
													<div class="col-sm-12 form-group">
														<label class="control-label">완료 의견</label>
														<textarea rows="2" class="form-control boxed" name="reply"></textarea>
														<input type="hidden" value="${request.rno}" name="rno">
													</div>																								
													
												</div>
											</div>
											<div class="d-flex justify-content-end">
												<button class="btn btn-primary btn-lg mt-3 ml-3" type="submit">최종 완료</button>
												<button class="btn btn-secondary btn-lg mt-3 ml-3" type="button" onclick="completeCancel()">취소</button>									
											</div>
										</div>
									</div>
									<!-- 요청 접수 card end-->								
								</form>
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
									<div></div>
									<div class="mt-4 text-center small"></div>
								</div>
							</div>
						</div>
						<!-- 상태 단계 이력 end -->						
					</div>
					
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
