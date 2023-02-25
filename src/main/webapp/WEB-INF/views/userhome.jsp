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
		a{
		 	text-decoration: none;
		 	color: #858796;	
		}
		a:hover{
		 	text-decoration: none;
		 	color: #3a4651;	
		}
		td , th{
		text-align: center;
		}
	.topnav {
	  overflow: hidden;
	  background-color: #fff;
	  width: 950px;
	  margin: 0 auto;
	  border-bottom: 2px solid #76D4F5;
	}
	
	.topnav a {
	  float: left;
	  color: #76D4F5;
	  text-align: center;
	  padding: 10px 16px;
	  text-decoration: none;
	  font-size: 17px;
	}
	
	.topnav a:hover {
	  background-color: #ddd;
	  color: black;
	}
	
	.topnav a.active {
	  background-color: #76D4F5;
	  color: white;
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
                						<div class="d-flex justify-content-center">
                							<img width="90" height="90" class="rounded-circle" src="${pageContext.request.contextPath}/customer/mypage/${member.mid}">
                							<div class="mt-4">
                								<div class="title">${member.mname} 님 환영합니다.</div>
                							</div>
                						</div>
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
		                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><c:out value="${userRequestStatusCount.requestInProgress}"></c:out> 건</div>
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
		                                             	 완료 요청건</div>
		                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><c:out value="${userRequestStatusCount.requestDone}"></c:out> 건</div>
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
							<div class="col-12" >
								<div class="card border-left-info" style="height: 430.896px;">
									<div class="card-header mb-2">
										<h3 class="title">나의 요청 상황</h3>
									</div>
									<div class="topnav">
										  <a class="active" href="#">전체</a>
										  <a href="#">진행중</a>
										  <a href="#">완료</a>
									</div>
									<div class="card-body py-0 ">
										<table class="table table-hover usertable table-striped">
											<thead>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>시스템</th>
													<th>요청일자</th>
													<th>진행상황</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>1</td>
													<td class="tableContent"><a href="#">asdfasd내용내용fasdf</a></td>
													<td>가족관계시스템</td>
													<td>2023-09-09</td>
													<td><span class="btn btn-sm btn-primary">진행중</span></td>
												</tr>
												<tr>
													<td>2</td>
													<td class="tableContent">asdfasd내용내용fasdf</td>
													<td>주민등본시스템</td>
													<td>2023-09-09</td>
													<td><span class="btn btn-sm btn-danger">반려</span></td>
												</tr>
												<tr>
													<td>3</td>
													<td class="tableContent">asdasdfasdfasdddddddddddddddfasdffasd내용내용fasdf</td>
													<td>주민등본시스템</td>
													<td>2023-09-09</td>
													<td><span class="btn btn-sm btn-info">완료</span></td>
												</tr>
											</tbody>
										</table>
										<nav aria-label="Page navigation">
											  <ul class="pagination justify-content-center pagination-sm">
											    <li class="page-item disabled">
											      <a class="page-link">Previous</a>
											    </li>
											    <li class="page-item"><a class="page-link" href="#">1</a></li>
											    <li class="page-item"><a class="page-link" href="#">2</a></li>
											    <li class="page-item"><a class="page-link" href="#">3</a></li>
											    <li class="page-item">
											      <a class="page-link" href="#">Next</a>
											    </li>
											  </ul>
											</nav>
									</div>
								</div>
							</div>	               			
							<div class="col-12 my-4">
								<div class="card border-left-danger" style="height: 430.896px;">
									<div class="card-header">
										<h3 class="title">공지사항</h3>
									</div>
									<div class="card-body">
										<table class="table table-hover usertable table-striped">
											<thead>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>작성자</th>
													<th>작성일</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th>1</th>
													<td class="tableContent"><a href="#">asdfasd내용내용fasdf</a></td>
													<td>송영훈</td>
													<td>2023-09-09</td>
												</tr>
												<tr>
													<th>2</th>
													<td class="tableContent">asdfasd내용내용fasdf</td>
													<td>강지성</td>
													<td>2023-09-09</td>
												</tr>
												<tr>
													<th>3</th>
													<td class="tableContent">asdfasd내용내용fasdf</td>
													<td>강지성</td>
													<td>2023-09-09</td>
												</tr>
												<tr>
													<th>4</th>
													<td class="tableContent">asdfasd내용내용fasdf</td>
													<td>강지성</td>
													<td>2023-09-09</td>
												</tr>
												<tr>
													<th>5</th>
													<td class="tableContent">asdfasd내용내용fasdf</td>
													<td>강지성</td>
													<td>2023-09-09</td>
												</tr>
											</tbody>
										</table>
											<nav aria-label="Page navigation">
											  <ul class="pagination justify-content-center pagination-sm">
											    <li class="page-item disabled">
											      <a class="page-link">Previous</a>
											    </li>
											    <li class="page-item"><a class="page-link" href="#">1</a></li>
											    <li class="page-item"><a class="page-link" href="#">2</a></li>
											    <li class="page-item"><a class="page-link" href="#">3</a></li>
											    <li class="page-item">
											      <a class="page-link" href="#">Next</a>
											    </li>
											  </ul>
											</nav>
									</div>
								
								</div>
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