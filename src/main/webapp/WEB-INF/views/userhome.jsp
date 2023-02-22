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
    </style>>
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
               		<!-- 상단바 start -->
               		<div class="row mt-5">
               			<div class="col-lg-6">
               				<div class="card" style="height: 275px;">
               					<div class="card-header">내 프로필</div>
               					<div class="card-body"></div>
               				</div>
               			</div>
               			<div class="col-lg-3">
               				<div class="card" style="height: 275px;">
               					<div class="card-header">내가 요청중인 건들</div>
               					<div class="card-body">3건</div>
               				</div>
               			</div>
               			<div class="col-lg-3" >
               				<div class="card" style="height: 275px;">
               					<div class="card-header">진행중인 요청 건들</div>
               					<div class="card-body">0건</div>
               				</div>
               			</div>
               		</div>
               		<!-- 상단바 end -->
               		<!-- 하단바 start -->
               		<div class="mt-5">
               			<div class="container">
               				<div id="demo" class="carousel slide" data-ride="carousel">
							  <ul class="carousel-indicators">
							    <li data-target="#demo" data-slide-to="0" class="active"></li>
							    <li data-target="#demo" data-slide-to="1"></li>
							    <li data-target="#demo" data-slide-to="2"></li>
							  </ul>
							  <div class="carousel-inner">
							    <div class="carousel-item active">
							      <img src="${pageContext.request.contextPath}/resources/img/logoground.png" width="1100" height="500">
							    </div>
							    <div class="carousel-item">
							      <img src="${pageContext.request.contextPath}/resources/img/slamdunk.jpg" width="1100" height="500">
							    </div>
							    <div class="carousel-item">
							      <img src="${pageContext.request.contextPath}/resources/img/notification.jpg" width="1100" height="500">
							    </div>
							  </div>
							  <a class="carousel-control-prev" href="#demo" data-slide="prev">
							    <span class="carousel-control-prev-icon"></span>
							  </a>
							  <a class="carousel-control-next" href="#demo" data-slide="next">
							    <span class="carousel-control-next-icon"></span>
							  </a>
							</div>
               			</div>
               		</div>
               		<!-- 하단바 end -->
               		
               		
               		
               		
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