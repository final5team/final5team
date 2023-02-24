<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
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
               		<div id="main">
               			<!-- 상단 업무 현황 바 start -->
               			<div class="row">
               				<div class="col-3 mb-4">
	                            <div class="card border-bottom-primary shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
	                                             	 최신요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">1건</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
               			
	               			 <div class="col-3 mb-4">
	                            <div class="card border-bottom-success shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
	                                                	진행 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-spinner"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	               			
	               			<div class="col-3 mb-4">
	                            <div class="card border-bottom-info shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
	                                                	완료 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-file-check"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>

	               			<div class="col-3 mb-4">
	                            <div class="card border-bottom-warning shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
	                                                	반려 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        
               			</div>
               			<!-- 상단 업무 현황 바 end -->
               			
               			<!-- 하단 오늘 마감 and 지연율 start-->
						<div class="row mt-5">
							<!-- 오늘마감start -->
							<div class="col-xl-7">
								<div class="card tasks" style="height: 420.896px;">
									<div class="card-block">
										<div class="tasks-block" style="height: 350px;">
											<div class=" card-title-blcok mb-4">
												<h3 class="title">List to finish [D-7]</h3>
											</div>
											<table class="table tasks-block">
												<thead>
													<tr style="text-align: center;">
														<th></th>
														<th>제목</th>
														<th>요청일</th>
														<th>최종예정일</th>
													</tr>
												</thead>
												<tbody >
													<c:forEach var="aDay" items="${listOf7daysLeft}">
														<tr>
															<td>
																<input class="checkbox" id="customCheckbox" type="checkbox">
																<label for="customCheckbox"></label>
															</td>
															<td class="tableContent pl-0 pb-0 mt-1">
																<c:if test="${member.mtype eq 'pm'}">
																	<a href="${pageContext.request.contextPath}/pm/completedetail?rno=${aDay.rno}">${aDay.reqTitle}</a> 
																</c:if>	
																<c:if test="${member.mtype eq 'developer'}">
																	<a href="${pageContext.request.contextPath}/developerdetail?rno=${aDay.rno}">${aDay.reqTitle}</a> 
																</c:if>	
																<c:if test="${member.mtype eq 'tester'}">
																	<a href="${pageContext.request.contextPath}/testerdetail?rno=${aDay.rno}">${aDay.reqTitle}</a> 
																</c:if>	
																<c:if test="${member.mtype eq 'usertester'}">
																	<a href="${pageContext.request.contextPath}/usertestdetail?rno=${aDay.rno}">${aDay.reqTitle}</a> 
																</c:if>	
																<c:if test="${member.mtype eq 'distributor'}">
																	<a href="${pageContext.request.contextPath}/distributedetail?rno=${aDay.rno}">${aDay.reqTitle}</a> 
																</c:if>	
															</td>
															<td><fmt:formatDate value="${aDay.reqDate}" pattern="yyyy-MM-dd"/></td>
															<td><fmt:formatDate value="${aDay.ddayExpectDate}" pattern="yyyy-MM-dd"/></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- 오늘마감end -->
							<!-- 지연율 start -->
							<div class="col-xl-5">
								<div class="card" style="height: 420.896px; align-items: center;">
								<!-- 파이차트 시작 -->
								<canvas id="myChart" style="width:100%;max-width:600px"></canvas>
								<!-- 파이차트 끝 -->
								</div>
							</div>
							<!-- 지연율 end -->
						</div>
               		
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

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Logout</a>
                </div>
            </div>
        </div>
    </div>



</body>

</html>