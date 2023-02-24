<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style type="text/css">
     .carousel-inner img {
	   	 width: 100%;
	    height: 100%;
	  }
	  .carousel-item {
	  	height: 550px;
	  }
	 .card.card-primary > .card-header {
      background-color: #85CE36;
      border-color: #85CE36; 
      }
      .card.card-warning > .card-header {
	    background-color: #fe974b;
		}
		.card.card-success > .card-header {
		    background-color: #4bcf99;
		}
		.card.card-danger > .card-header {
		    background-color: #FF4444;
		}
		.card.card-info > .card-header {
		    background-color: #76D4F5;
		}
		.usertable{
		 border-top: 2px solid RGB(244 244 244);
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
                	<div id="main">
	                	<!-- 상단부분start -->
	                		<div class="row">
	                			<div class="col-6">
	                				<div class="card card-success shadow pd-2" style="height:140px;">
	                					<div class="card-header"></div>
	                					<div class="card-body"></div>
	                				</div>
	                			</div>
	                			
	                			<div class="col-3 mb-4">
		                            <div class="card card-primary shadow pd-2" style="height:140px;">
		                            	<div class="card-header"></div>
		                                <div class="card-body">
		                                    <div class="row no-gutters align-items-center">
		                                        <div class="col mr-2">
		                                            <div class="text-lg font-weight-bold text-success text-uppercase mb-1">
		                                                	진행 요청건</div>
		                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
		                                        </div>
		                                        <div class="col-auto">
		                                            <i class="fas fa-spinner fa-2x text-gray-300"></i>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
	                        
	                			<div class="col-3 mb-4">
		                            <div class="card card-warning shadow pd-2" style="height:140px;">
		                                <div class="card-header"></div>
		                                <div class="card-body">
		                                    <div class="row no-gutters align-items-center">
		                                        <div class="col mr-2">
		                                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
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
	                		</div>
	                	<!-- 상단부분end -->
	               		<!-- 하단부분 start -->
	               			<div class="row mb-3">
	               				<div class="col-6">
	               					<div class="card card-info">
	               						<div class="card-header"></div>
	               						<div class="title ml-3 mt-3">
	               							<h5>나의 요청 상황</h5>
	               						</div>
	               						<div class="card-body">
											<table class="table table-hover table-striped usertable">
												
												<thead>
											      <tr>
											        <th>번호</th>
											        <th>제목</th>
											        <th>요청일자</th>
											        <th>진행상태</th>
											      </tr>
											    </thead>
											    <tbody>
											      <tr>
											        <td>1</td>
											        <td>john@example.com 인데요</td>
											        <td>2021-09-09</td>
											        <td><span class="btn btn-sm btn-primary">진행중</span></td>
											      </tr>
											    </tbody>
												
											</table>	               						
	               						</div>
	               					</div>
	               				</div>
	               				<div class="col-6"></div>
	               			</div>
	               		<!-- 하단부분 end -->
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