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
	 }
	 
	 .uppermain{
	width: 250px;
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
               		<div id="main" >
               			<!-- 상단 업무 현황 바 start -->
               			<div class="d-flex justify-content-between" style="flex-wrap: nowrap;">
               				<div class="uppermain mb-4 ml-3">
	                            <div class="card border-left-primary shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
	                                             	 처리 대기건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus.requestRecent}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                           <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
               			
	               			 <div class="uppermain mb-4">
	                            <div class="card border-left-success shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-success text-uppercase mb-1">
	                                                	진행 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus.requestInProgress}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-spinner fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	               			
	               			<div class="uppermain mb-4">
	                            <div class="card border-left-info shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-info text-uppercase mb-1">
	                                                	완료 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus.requestDone}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>

	               			<div class="uppermain mb-4">
	                            <div class="card border-left-warning shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-warning text-uppercase mb-1">
	                                                	반려 요청건</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus.requestReject}"/> 건
	                                            </div>
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
								<div class="card tasks-block border-left-dark shadow" style="height: 420.896px;">
									<div class="card-header">
			                			<h5 class="title">D-7 요청리스트</h5>
			                			
									</div>
									<div class="card-block" style="height: 350px;" id ="7daysListContainer">
										<!-- 개발리스트start -->
										<table class="table  table-striped" id="devList" >
											<thead>
												<tr style="text-align: center;">
													<th>번호</th>
													<th>시스템</th>
													<th>요청유형</th>
													<th>제목</th>
													<th>우선순위</th>
													<th>현재단계</th>
													<th>완료예정일</th>
												</tr>
											</thead>
											<tbody >
												<c:forEach var="dayRequest" items="${listOf7daysLeft}">
													<tr style="text-align: center;">
														<td>${dayRequest.rno}</td>
														<td>${dayRequest.systemName}</td>
														<td>${dayRequest.reqType}</td>
														<td class="tableContent">${dayRequest.reqTitle}</td>
														<td>
															<c:if test="${dayRequest.priority eq '하' || dayRequest.priority eq '중' ||dayRequest.priority eq '상'}">
																<span class="fa fa-star checked" style="color: orange;"></span>
															</c:if>
															<c:if test="${dayRequest.priority eq '중' || dayRequest.priority eq '상'}">
																<span class="fa fa-star checked" style="color: orange;"></span>
															</c:if>
															<c:if test="${dayRequest.priority eq '상'}">
																<span class="fa fa-star checked" style="color: orange;"></span>
															</c:if>
														</td>
														<td>${dayRequest.statusName}</td>
														<td><fmt:formatDate value="${dayRequest.allExpectDate}" pattern="yyyy-MM-dd"/></td>
													</tr>
												</c:forEach>		
											</tbody>
										</table>
										<ul class="pagination pagination-sm d-flex justify-content-center mt-4">
										    <li class="page-item"><a class="page-link" onclick="7daysList(1)">처음</a></li>
										    <c:if test="${dPager.groupNo>1}">
											    <li class="page-item">
											    	<a class="page-link" onclick="7daysList(${dPager.startPageNo-1})">
											    		<i class="fas fa-caret-left"></i>
											    	</a>
											    </li>
										    </c:if>
										    <c:forEach var="i" begin="${dPager.startPageNo}" end="${dPager.endPageNo}">
										    	<c:if test="${dPager.pageNo != i}">
											    	<li class="page-item"><a class="page-link" onclick="7daysList(${i})">${i}</a></li>
										    	</c:if>
										    	<c:if test="${dPager.pageNo == i}">
											    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" onclick="7daysList(${i})">${i}</a></li>
										    	</c:if>
										    </c:forEach>
										    <c:if test="${dPager.groupNo< dPager.totalGroupNo}">
											    <li class="page-item">
											    	<a class="page-link" onclick="7daysList(${dPager.endPageNo + 1})">
											    		<i class="fas fa-caret-right"></i>
											   	 	</a>
											    </li>
										    </c:if>
										    <li class="page-item"><a class="page-link" onclick="7daysList(${dPager.totalPageNo})">맨끝</a></li>
										</ul>
										<!-- 개발리스트 end -->
									</div>
								</div>
							</div>
							<!-- 오늘마감end -->
							<!-- 공지사항 start -->
							<div class="col-12 mb-4">
								<div class="card border-left-danger shadow" style="height: 430.896px;">
									<div class="card-header">
										<h3 class="title">공지사항</h3>
									</div>
									<div class="card-body" id="mainNoticeListContainer">
										<table class="table table-hover usertable table-striped">
											<thead>
												<tr style="text-align: center;">
													<th>번호</th>
													<th>제목</th>
													<th>작성자</th>
													<th>작성일</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="notice" items="${noticeList}">
													<tr style="text-align: center;">
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
										    <li class="page-item"><a class="page-link" onclick="mainNoticeList(1)">처음</a></li>
										    <c:if test="${nPager.groupNo>1}">
											    <li class="page-item">
											    	<a class="page-link" onclick="mainNoticeList(${nPager.startPageNo-1})">
											    		<i class="fas fa-caret-left"></i>
											    	</a>
											    </li>
										    </c:if>
										    <c:forEach var="i" begin="${nPager.startPageNo}" end="${nPager.endPageNo}">
										    	<c:if test="${nPager.pageNo != i}">
											    	<li class="page-item"><a class="page-link" onclick="mainNoticeList(${i})">${i}</a></li>
										    	</c:if>
										    	<c:if test="${nPager.pageNo == i}">
											    	<li class="page-item"><a class="page-link" style="background-color: #FF4444; color: white;"onclick="mainNoticeList(${i})">${i}</a></li>
										    	</c:if>
										    </c:forEach>
										    <c:if test="${nPager.groupNo<nPager.totalGroupNo}">
											    <li class="page-item">
											    	<a class="page-link" onclick="mainNoticeList(${nPager.endPageNo + 1})">
											    		<i class="fas fa-caret-right"></i>
											   	 	</a>
											    </li>
										    </c:if>
										    <li class="page-item"><a class="page-link" onclick="mainNoticeList(${nPager.totalPageNo})">맨끝</a></li>
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

	<script>
		function 7daysList(pageNo){
			$.ajax({
				type: "GET", //요청 메소드 방식
				url:"${pageContext.request.contextPath}/7dayslist?dDay7PageNo=" + pageNo,
				dataType:"html", 
				success : function(result){
					$('#7daysListContainer').html(result);
				}
			})
		} 
		
		function mainNoticeList(pageNo){
			$.ajax({
				type: "GET", //요청 메소드 방식
				url:"${pageContext.request.contextPath}/mainnoticelist?noticePageNo=" + pageNo,
				dataType:"html", 
				success : function(result){
					$('#mainNoticeListContainer').html(result);
				}
			})
		} 
	</script>

</body>

</html>