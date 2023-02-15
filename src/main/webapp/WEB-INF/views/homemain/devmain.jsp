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
                	<div class="row">
                		<!-- 최신 요청 start-->
                		<div class="col-md-3">
                			<div class="card">
                				<div class="card-body">
                					<h4>최신 요청건</h4>
                					<i></i>
                				</div>
                			</div>
                		</div>
                		<!-- 재검토 요청 start-->
                		<div class="col-md-3">
                			<div class="card">
                				<div class="card-body">재검토 요청건</div>
                			</div>
                		</div>
                		<!-- 진행 요청 start-->
                		<div class="col-md-3">
                			<div class="card">
                				<div class="card-body">진행 요청건</div>
                			</div>
                		</div>
                		<!-- 완료 요청 start-->
                		<div class="col-md-3">
                			<div class="card">
                				<div class="card-body">완료 요청건</div>
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



</body>

</html>
