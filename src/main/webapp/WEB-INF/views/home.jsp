<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
 	   <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/demo/chart-pie-demo.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/demo/chart-bar-demo.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript"></script>
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
                <div class="container-fluid dashboard-page">
                	<!-- 상단 버튼 3 or 4  시작-->
                	<div class="row mt-5">
                		<!-- 최신 요청 start-->
                		<div 
                			<c:if test="${member.mtype == 'pm' || member.mtype == 'developer'}">class="col-xl-3 stretch-card"</c:if>
                			<c:if test="${member.mtype != 'pm' && member.mtype != 'developer'}">class="col-xl-4 stretch-card"</c:if>>
                			<div class="card text-white btn-gradient-danger" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">최신 요청건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5"><c:out value="${workingStatus.requestRecent}"/> 건</h2>
                				</div>
                			</div>
                		</div>
                		<c:if test="${member.mtype == 'developer'}">
                		<!-- 재검토 요청 start-->
                		<div class="col-xl-3 stretch-card">
                			<div class="card text-white bg-gradient-warning" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">재검토 요청
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5"><c:out value="${workingStatus.requestReexam}"/>건</h2>
                				</div>
                			</div>
                		</div>
                		</c:if>
                		<c:if test="${member.mtype == 'pm'}">
                		<!-- 반려건 start-->
                		<div class="col-xl-3 stretch-card">
                			<div class="card text-white bg-gradient-warning" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">반려건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5"><c:out value="${workingStatus.requestReject}"/>건</h2>
                				</div>
                			</div>
                		</div>
                		</c:if>
                		
                		<!-- 진행 요청 start-->
                		<div 
                			<c:if test="${member.mtype == 'pm' || member.mtype == 'developer'}">class="col-xl-3 stretch-card"</c:if>
                			<c:if test="${member.mtype != 'pm' && member.mtype != 'developer'}">class="col-xl-4 stretch-card"</c:if>>
                			<div class="card text-white bg-gradient-primary" style="padding: 2.5rem;">
                				<div class="card-body">
           							<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">진행 요청건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5"><c:out value="${workingStatus.requestInProgress}"/> 건</h2>
                				</div>
                			</div>
                		</div>
                		<!-- 완료 요청 start-->
                		<div 
                			<c:if test="${member.mtype == 'pm' || member.mtype == 'developer'}">class="col-xl-3 stretch-card"</c:if>
                			<c:if test="${member.mtype != 'pm' && member.mtype != 'developer'}">class="col-xl-4 stretch-card"</c:if>>
                			<div class="card text-white bg-gradient-secondary" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">완료 요청건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5"><c:out value="${workingStatus.requestDone}"/> 건</h2>
                				</div>
                			</div>
                		</div>
                	</div>
                	<!-- 상단 버튼 3 or 4  끝 -->
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
																<a href="${pageContext.request.contextPath}/completedetail?rno=${aDay.rno}">${aDay.reqTitle}</a> 
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

					<!-- 하단 오늘 마감 and 지연율 /-->
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
<script>
var xValues = ["지연율", "정상처리율"];
var yValues = [<c:out value="${workCompletionRate.delayRate}"/>, <c:out value="${workCompletionRate.normalRate}"/>];
var barColors = [
  "#70b02b",
  "#9ed85f"
  
];

new Chart("myChart", {
  type: "doughnut",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    title: {
      display: true,
      text: "업무 처리율"
    }
  }
});
</script>

</body>

</html>
