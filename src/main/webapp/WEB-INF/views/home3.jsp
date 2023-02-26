<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    
    <style type="text/css">
     	.border-top-dark {
		  border-top: 0.25rem solid #3A4651 !important;
		}
     	.border-top-danger {
		  border-top: 0.25rem solid #ff4444 !important;
		}
		.tasks-block {
	    overflow-y: scroll;
	    overflow-x: hidden;
	    margin: 0;
	    margin-right: -5px;
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
               		<div id="main" >
               			<!-- 상단 업무 현황 바 start -->
               			<div class="row" style="flex-wrap: nowrap;">
               				<div class="col-3 mb-4">
	                            <div class="card border-left-primary shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
	                                             	 최신요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">1건</div>
	                                        </div>
	                                        <div class="col-auto">
	                                           <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
               			
	               			 <div class="col-3 mb-4">
	                            <div class="card border-left-success shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
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
	                            <div class="card border-left-info shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
	                                                	완료 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>

	               			<div class="col-3 mb-4">
	                            <div class="card border-left-warning shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
	                                                	반려 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        
               			</div>
               			<!-- 상단 업무 현황 바 end -->
               			
               			<!-- 하단 오늘 마감 and 공지사항 start-->
							<!-- 오늘마감start -->
							<div class="col-12 my-4">
								<div class="card tasks border-top-dark shadow" style="height: 420.896px;">
									<div class="card-title-block mt-3 d-flex">
			                			<h5 class="title ml-3 mr-auto">D-7 요청리스트</h5>
			                			
									</div>
									<div class="card-block py-0" style="height: 350px;">
										<!-- 개발리스트start -->
										<table class="table tasks-block table-striped" id="devList" >
											<thead>
												<tr style="text-align: center;">
													<th>번호</th>
													<th>시스템</th>
													<th>요청유형</th>
													<th>제목</th>
													<th>우선순위</th>
													<th>완료예정일</th>
													<th>담당자</th>
													<th>현재단계</th>
												</tr>
											</thead>
											<tbody >
												<tr style="text-align: center;">
													<td>1</td>
													<td>가족관계</td>
													<td>정규</td>
													<td class="tableContent">제dddddddddddddddddddddddd목입니니다.</td>
													<td>
														<span class="fa fa-star checked" style="color: orange;"></span>
													</td>
													<td>2023-02-09</td>
													<td>송영훈</td>
													<td>개발중</td>
												</tr>
											</tbody>
										</table>
										<!-- 개발리스트 end -->
									</div>
								</div>
							</div>
							<!-- 오늘마감end -->
							<!-- 공지사항 start -->
							<div class="col-12">
								<div class="card border-top-danger shadow mb-4" style="height: 420.896px;" >
									<div class="card-title-block mt-3">
			                			<h5 class="title ml-3">공지사항</h5>
			                		</div>
			                		<div class="card-body">
			                			<table class="table tasks-block table-striped">
											<thead>
												<tr style="text-align: center;">
													<th>번호</th>
													<th>제목</th>
													<th>작성자</th>
													<th>작성날짜</th>
												</tr>
											</thead>			                			
			                				<tbody>
			                					<tr style="text-align: center;">
			                						<th>1</th>
			                						<th class="tableContent">제목입니다.</th>
			                						<th>슝영훈</th>
			                						<th>2023-12-03</th>
			                					</tr>
			                					<tr style="text-align: center;">
			                						<th>1</th>
			                						<th class="tableContent">제목입니다.</th>
			                						<th>슝영훈</th>
			                						<th>2023-12-03</th>
			                					</tr>
			                					<tr style="text-align: center;">
			                						<th>1</th>
			                						<th class="tableContent">제목입니다.</th>
			                						<th>슝영훈</th>
			                						<th>2023-12-03</th>
			                					</tr>
			                					<tr style="text-align: center;">
			                						<th>1</th>
			                						<th class="tableContent">제목입니다.</th>
			                						<th>슝영훈</th>
			                						<th>2023-12-03</th>
			                					</tr>
			                					<tr style="text-align: center;">
			                						<th>1</th>
			                						<th class="tableContent">제목입니다.</th>
			                						<th>슝영훈</th>
			                						<th>2023-12-03</th>
			                					</tr>
			                				</tbody>
			                			</table>
			                			<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
										    <li class="page-item">
										    	<a class="page-link" href="#">
										    		<i class="fas fa-caret-left"></i>
										    	</a>
										    </li>
										    <li class="page-item"><a class="page-link" href="#">1</a></li>
										    <li class="page-item"><a class="page-link" href="#">2</a></li>
										    <li class="page-item"><a class="page-link" href="#">3</a></li>
										    <li class="page-item"><a class="page-link" href="#">4</a></li>
										    <li class="page-item"><a class="page-link" href="#">5</a></li>
										    <li class="page-item">
										    	<a class="page-link" href="#">
										    		<i class="fas fa-caret-right"></i>
										   	 	</a>
										    </li>
										</ul>
			                		</div>
								</div>
							</div>
							<!-- 지연율 end -->
               		
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

<script type="text/javascript">
$('#toggleButton').click(function(){
	$('#devList').toggle();
	$('#myDevList').toggle();
	
});

</script>

</body>

</html>