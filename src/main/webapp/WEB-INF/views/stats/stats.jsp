<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Percent'],
          ['SRM',     11],
          ['LMS',      2],
          ['SHOP',  2],
          ['UIS', 2],
          ['CMS',    7]
        ]);

        var options = {
          title: '전체 서비스 요청 중 시스템별 비중',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('3dchart'));
        chart.draw(data, options);
      }
      google.charts.setOnLoadCallback(drawdonutChart);
      function drawdonutChart() {
          var data = google.visualization.arrayToDataTable([
            ['Task', 'Rate'],
            ['완료',     11],
            ['',    7]
          ]);

          var options = {
            title: '전체 완료율',
            pieHole: 0.4,

            tooltip: { trigger: 'none' },
            pieSliceTextStyle: {
                color: 'black',
            },
            legend: 'none',
            slices: {
                0: { color: 'green', textStyle: {color: 'orange', fontSize: 14} },
                1: { color: 'transparent' , textStyle: {color: 'transparent'}}
            }
          };

          var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
          chart.draw(data, options);
        }
    </script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['gauge']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['지연률', 80],
        ]);

        var options = {
          width: 500, height: 150,
          redFrom: 80, redTo: 100,
          yellowFrom: 55, yellowTo: 80,
          minorTicks: 5
        };

        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));

        chart.draw(data, options);           
      }
    </script>
    
    <style>
    .nav.nav-tabs-bordered, .nav.tab-content {
	    border-style: solid;
	    border-width: 0 1px 1px 1px;
	    border-color: #85CE36;
	    padding: 10px 20px 0;
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
                <div class="container-fluid">
                	<!-- 첫째 줄 -->
					<div class="row">
						<div  class="col-lg-4">
							 <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">시스템별 요청 비중</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div id="3dchart"></div>
                                </div>
                            </div>
						</div>
						<div  class="col-lg-4">
							 <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">완료율</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
	                                <div class="row">
	                                	<div class="col-md-7"> <div id="donutchart"></div></div>
	                                	<div class="col-md-5">
	                                		<p>Task</p>
		                                	<p>개발: 65%</p>
		                                	<p>테스트: 63%</p>
		                                	<p>고객테: 60%</p>
		                                	<p>배포: 60%</p>
	                                	</div>
	                                </div>
                                </div>
                            </div>
						</div>
						<div  class="col-lg-4">
							 <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">지연율</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                            aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">Dropdown Header:</div>
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body" style="height:240px">
                                	<div class="row">
	                                	<div class="col-md-7"> 
	                                		<div id="chart_div" style="width: 400px; height: 120px;" class="ml-4 mt-3"></div> 
	                                	</div>
	                                	<div class="col-md-5">
	                                		<p>Task</p>
		                                	<p>개발: 65%</p>
		                                	<p>테스트: 63%</p>
		                                	<p>고객테: 60%</p>
		                                	<p>배포: 60%</p>
	                                	</div>
	                                </div>                                  
                                </div>
                            </div>
						</div>
					
					</div>
					<!-- 둘째줄 -->
					<div>
					
					
						<div class="card sameheight-item" style="height: 353px;">
							<div class="card-block">
								<div class="card-title-block">
									<h3 class="title"> basic</h3>
								</div>
								<ul class="nav nav-tabs nav-tabs-bordered">
									<li class="nav-item">
										<a href="#home" class="nav-link active" data-target="#home" data-toggle="tab" aria-controls="home" role="tab">Home</a>
									</li>
									<li class="nav-item">
										<a href="#profile" class="nav-link active" data-target="#profile" data-toggle="tab" aria-controls="profile" role="tab">Profile</a>
									</li>
									<li class="nav-item">
										<a href="#mm" class="nav-link active" data-target="#mm" data-toggle="tab" aria-controls="mm" role="tab">mm</a>
									</li>
								</ul>
								<div class="tab-content tabs-bordered">
									<div class="tab-pane fade in active" id="home">
										<h4>home</h4>
										<p>hhhhhhhhhhhh</p>
									</div>
									<div class="tab-pane fade" id="profile">
										<h4>profile</h4>
										<p>ppppppppppppp</p>
									</div>
									<div class="tab-pane fade" id="mm">
										<h4>mm</h4>
										<p>mmmmmmmmmmmmm</p>
									</div>
								</div>
							</div>
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
