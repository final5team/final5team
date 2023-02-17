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
                <div class="container-fluid dashboard-page">
                	<!-- 상단 버튼 3 or 4  시작-->
                	<div class="row mt-5">
                		<!-- 최신 요청 start-->
                		<div class="col-xl-3 stretch-card">
                			<div class="card text-white btn-gradient-danger" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">최신 요청건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5">3 건</h2>
                					<h6 class="">2023년 2월 현황</h6>
                				</div>
                			</div>
                		</div>
                		<!-- 재검토 요청 start-->
                		<div class="col-xl-3 stretch-card">
                			<div class="card text-white bg-gradient-warning" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">재검토 요청
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5">3 건</h2>
                					<h6 class="">2023년 2월 현황</h6>
                				</div>
                			</div>
                		</div>
                		
                		<!-- 진행 요청 start-->
                		<div class="col-xl-3 stretch-card">
                			<div class="card text-white bg-gradient-primary" style="padding: 2.5rem;">
                				<div class="card-body">
           							<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">진행 요청건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5">3 건</h2>
                					<h6 class="">2023년 2월 현황</h6>
                				</div>
                			</div>
                		</div>
                		<!-- 완료 요청 start-->
                		<div class="col-xl-3 stretch-card">
                			<div class="card text-white bg-gradient-secondary" style="padding: 2.5rem;">
                				<div class="card-body">
		           					<img style="position: absolute;top: 0; right: 0; height: 100%;" src="${pageContext.request.contextPath}/resources/img/circle.1541da91.svg">
                					<h4 class="font-weight-normal mb-3">완료 요청건
                						<i class="fas fa-star-of-david float-right"></i>
                					</h4>
                					<h2 class="mb-5">3 건</h2>
                					<h6 class="">2023년 2월 현황</h6>
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
											<h3 class="title">List to finish</h3>
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
												<tr>
													<td>
														<input class="checkbox" id="customCheckbox" type="checkbox">
														<label for="customCheckbox"></label>
													</td>
													<td class="tableContent">
														가족관계증명서ddddddddddddddddddddssssssssssssssssssssssssssssssssssssssssdddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												<tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssdddddddddcccccccccccccccccccdddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												<tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr><tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												<tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												<tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												<tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												<tr>
													<td>
														<input class="checkbox" type="checkbox">
													</td>
													<td class="tableContent">
														가족관계증명서ssssssssssssddddddddddddddddd
													</td>
													<td>2022.12.05</td>
													<td>2023.02.28</td>
												</tr>
												
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
var yValues = [10, 90];
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
