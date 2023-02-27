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
                <div class="container">
                	<div id="main">
	                	<!-- 상단부분start -->
	                		<div class="row">
	                			<div class="col-5 ml-3">
	                				<div class="card card-success shadow pd-2" style="height:140px;">
	                					<div class="card-header" ></div>
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
										  <a class="active" onclick="userRequestList('전체')">전체</a>
										  <a onclick="userRequestList('진행중')">진행중</a>
										  <a onclick="userRequestList('완료')">완료</a>
										  <a onclick="userRequestList('반려')">반려</a>
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
												<c:forEach var="request" items="${userRequestList}">
													<tr>
														<td>${request.rno}</td>
														<td class="tableContent">
															<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
																${request.reqTitle}
															</a>
														</td>
														<td>${request.systemName}</td>
														<td><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></td>
														<td><span class="btn btn-sm btn-primary">
															<c:if test="${request.statusNo == 12}">
																반려
															</c:if>
															<c:if test="${request.statusNo == 13}">
																완료
															</c:if>
															<c:if test="${request.statusNo != 12 && request.statusNo != 13}">
																진행중
															</c:if>
														</span></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<ul class="pagination pagination-sm d-flex justify-content-center mt-1">
										    <li class="page-item"><a class="page-link" href="list?pageNo=1">처음</a></li>
										    <c:if test="${uPager.groupNo>1}">
											    <li class="page-item">
											    	<a class="page-link" href="list?pageNo=${uPager.startPageNo-1}">
											    		<i class="fas fa-caret-left"></i>
											    	</a>
											    </li>
										    </c:if>
										    <c:forEach var="i" begin="${uPager.startPageNo}" end="${uPager.endPageNo}">
										    	<c:if test="${uPager.pageNo != i}">
											    	<li class="page-item"><a class="page-link" href="list?pageNo=${i}">${i}</a></li>
										    	</c:if>
										    	<c:if test="${uPager.pageNo == i}">
											    	<li class="page-item"><a class="page-link" style="background-color: #76D4F5; color: white;" href="list?pageNo=${i}">${i}</a></li>
										    	</c:if>
										    </c:forEach>
										    <c:if test="${uPager.groupNo<pager.totalGroupNo}">
											    <li class="page-item">
											    	<a class="page-link" href="#">
											    		<i class="fas fa-caret-right"></i>
											   	 	</a>
											    </li>
										    </c:if>
										    <li class="page-item"><a class="page-link" href="list?pageNo=${uPager.totalPageNo}">맨끝</a></li>
										</ul>
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
												<c:forEach var="notice" items="${noticeList}">
													<tr>
														<th>${notice.nno}</th>
														<td class="tableContent">
															<a href="${pageContext.request.contextPath}/noticedetail?nno=${notice.nno}">
																${notice.noticeTitle}
															</a>
														</td>
														<td>${notice.mid}</td>
														<td><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></td>
													</tr>
												</c:forEach>				
											</tbody>
										</table>
										<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
										    <li class="page-item"><a class="page-link" href="list?pageNo=1">처음</a></li>
										    <c:if test="${nPager.groupNo>1}">
											    <li class="page-item">
											    	<a class="page-link" href="list?pageNo=${nPager.startPageNo-1}">
											    		<i class="fas fa-caret-left"></i>
											    	</a>
											    </li>
										    </c:if>
										    <c:forEach var="i" begin="${nPager.startPageNo}" end="${nPager.endPageNo}">
										    	<c:if test="${nPager.pageNo != i}">
											    	<li class="page-item"><a class="page-link" href="list?pageNo=${i}">${i}</a></li>
										    	</c:if>
										    	<c:if test="${nPager.pageNo == i}">
											    	<li class="page-item"><a class="page-link" style="background-color: #FF4444; color: white;" href="list?pageNo=${i}">${i}</a></li>
										    	</c:if>
										    </c:forEach>
										    <c:if test="${nPager.groupNo<pager.totalGroupNo}">
											    <li class="page-item">
											    	<a class="page-link" href="#">
											    		<i class="fas fa-caret-right"></i>
											   	 	</a>
											    </li>
										    </c:if>
										    <li class="page-item"><a class="page-link" href="list?pageNo=${nPager.totalPageNo}">맨끝</a></li>
										</ul>
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