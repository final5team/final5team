<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    
    <style type="text/css">
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
               				<a class="uppermain mb-4 ml-3" href="#" onclick="pmRequestProcessList(1, '접수대기')">
	                            <div class="card border-left-primary shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
	                                             	 접수 대기
	                                            </div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus['1']}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                           <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </a>
	                        
	                        <a class="uppermain mb-4" href="#" onclick="pmRequestProcessList(1, '승인대기')">
	                            <div class="card border-left-primary shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
	                                             	 승인 대기
	                                            </div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus['11']}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                           <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </a>
	                        
               			
	               			 <a class="uppermain mb-4" href="#" onclick="pmRequestProcessList(1, '진행중')">
	                            <div class="card border-left-success shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-success text-uppercase mb-1">
	                                                	진행 중</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:set var="operating" 
	                                             	 value="${workingStatus['2'] 
	                                             	 + workingStatus['3'] 
	                                             	 + workingStatus['4'] 
	                                             	 + workingStatus['5'] 
	                                             	 + workingStatus['6'] 
	                                             	 + workingStatus['7'] 
	                                             	 + workingStatus['8'] 
	                                             	 + workingStatus['9'] 
	                                             	 + workingStatus['10']}"/>
	                                            	<c:out value="${operating}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-spinner fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </a>
	               			
	               			<a class="uppermain mb-4" href="#" onclick="pmRequestProcessList(1, '완료및반려')">
	                            <div class="card border-left-info shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-info text-uppercase mb-1">
	                                                	완료 및 반려</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:set var="done" 
	                                             	 value="${workingStatus['12'] + workingStatus['13']}"/> 
	                                            	<c:out value="${done}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </a>         
               			</div>
               			<!-- 상단 업무 현황 바 end -->
               			
               			<!-- 하단 오늘 마감 and 공지사항 start-->
							<!-- 오늘마감start -->
							<!-- pm 업무 리스트 start -->
							<div class="col-12 my-4">
								<div class="card tasks border-left-dark shadow" style="height: 420.896px;">
									<div class="card-header d-flex">
			                			<h5 class="title ml-3 mr-auto" id="devTitle">
			                				<span id="title">PM 업무 리스트</span>		
			                			</h5>
									</div>
									<div class="card-block pt-2" style="height: 350px;" id="requestProcessListContainer">
										<!-- 리스트 start -->
										<div style="height: 305px;">
											<table class="table tasks-block table-striped table-hover"  >
												<thead style="background-color: #3A4651;" class="text-white">
													<tr style="text-align: center;">
														<th>요청번호</th>
														<th>시스템</th>
														<th>요청유형</th>
														<th>제목</th>
														<th>우선순위</th>
														<th>요청일</th>
														<th>완료예정일</th>
														<th>진행상황</th>
													</tr>
												</thead>
												<tbody >
													<c:forEach var="requestProcess" items="${requestProcessList}" varStatus="i">
													<tr style="text-align: center;">
														<td>${requestProcess.rno}</td>
														<td>${requestProcess.systemName}</td>
														<c:if test="${requestProcess.reqType != null}">
															<td <c:if test="${requestProcess.reqType == '긴급'}"> class="text-danger"</c:if>>
																${requestProcess.reqType}
															</td>
														</c:if>
														<c:if test="${requestProcess.reqType == null}">
															<c:if test="${requestProcess.statusName == '접수중'}">
																<td class="text-primary">
																	미정
																</td>
															</c:if>
															<c:if test="${requestProcess.statusName == '반려'}">
																<td class="text-warning">
																	반려
																</td>
															</c:if>
														</c:if>
														<td class="tableContent">
															<c:if test="${requestProcess.pmCheck == 1}">
																<strong class="text-danger">N</strong>																
															</c:if>
															<c:if test="${requestProcess.statusName eq '접수중' || requestProcess.statusName eq '접수완료'}">
																<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
															</c:if>
															<c:if test="${requestProcess.statusName eq '개발중' || requestProcess.statusName eq '개발재검토' || requestProcess.statusName eq '개발완료'}">
																<a href="${pageContext.request.contextPath}/developerdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
															</c:if>
															<c:if test="${requestProcess.statusName eq '테스트중' || requestProcess.statusName eq '테스트완료'}">
																<a href="${pageContext.request.contextPath}/testerdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
															</c:if>
															<c:if test="${requestProcess.statusName eq '유저테스트중' || requestProcess.statusName eq '유저테스트완료'}">
																<a href="${pageContext.request.contextPath}/usertestdetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
															</c:if>
															<c:if test="${requestProcess.statusName eq '배포중'}">
																<a href="${pageContext.request.contextPath}/distributedetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
															</c:if>
															<c:if test="${requestProcess.statusName eq '배포완료' || requestProcess.statusName eq '완료' || requestProcess.statusName eq '반려'}">
																<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${requestProcess.rno}">${requestProcess.reqTitle}</a>
															</c:if>
														</td>
														<td>
															<c:if test="${requestProcess.priority != null}">
																<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
																	<span class="fa fa-star checked" style="color: orange;"></span>
																</c:if>
																<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
																	<span class="fa fa-star checked" style="color: orange;"></span>
																</c:if>
																<c:if test="${requestProcess.priority eq '상'}">
																	<span class="fa fa-star checked" style="color: orange;"></span>
																</c:if>
															</c:if>
															<c:if test="${requestProcess.priority == null}">
																<span class="text-info">미정</span>
															</c:if>
														</td>
														<td>
															<c:if test="${requestProcess.reqDate != null}">
																<fmt:formatDate value="${requestProcess.reqDate}" pattern="yyyy-MM-dd"/>
															</c:if>
															<c:if test="${requestProcess.reqDate == null}">
																<span class="text-info">미정</span>
															</c:if>
															
														</td>
														<td>
															<c:if test="${requestProcess.allExpectDate != null}">
																<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
															</c:if>
															<c:if test="${requestProcess.allExpectDate == null}">
																<span class="text-info">미정</span>
															</c:if>
														</td>
														<td>
															<c:if test="${requestProcess.statusName eq '접수중' || requestProcess.statusName eq '접수완료' }">
																<span class="badge badge-warning">${requestProcess.statusName}</span>
															</c:if>
															<c:if test="${requestProcess.statusName eq '개발재검토' || requestProcess.statusName eq '반려' }">
																<span class="badge badge-danger">${requestProcess.statusName}</span>
															</c:if>
															<c:if test="${requestProcess.statusName eq '개발중' || requestProcess.statusName eq '개발완료' }">
																<span class="badge badge-primary">${requestProcess.statusName}</span>
															</c:if>
															<c:if test="${requestProcess.statusName eq '테스트중' || requestProcess.statusName eq '테스트완료' }">
																<span class="badge badge-success">${requestProcess.statusName}</span>
															</c:if>
															<c:if test="${requestProcess.statusName eq '유저테스트중' || requestProcess.statusName eq '유저테스트완료' }">
																<span class="badge badge-info">${requestProcess.statusName}</span>
															</c:if>
															<c:if test="${requestProcess.statusName eq '배포중' || requestProcess.statusName eq '배포완료' }">
																<span class="badge badge-secondary">${requestProcess.statusName}</span>
															</c:if>
															<c:if test="${requestProcess.statusName eq '완료'}">
																<span class="badge badge-dark">${requestProcess.statusName}</span>
															</c:if>
														
														</td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										<div>
											<div class="pager default mt-3">
												<div class="pagingButtonSet d-flex justify-content-center">
													<a onclick="pmRequestProcessList(1, '${searchStatus}')" type="button" class="btn btn-muted shadow">처음</a>
													<c:if test="${rpPager.groupNo > 1}">
														<a onclick="pmRequestProcessList(${rpPager.startPageNo-1}, '${searchStatus}')" class="btn btn-muted shadow">이전</a>
					
													</c:if>
					
													<c:forEach var="i" begin="${rpPager.startPageNo}" end="${rpPager.endPageNo}">
														<c:if test="${rpPager.pageNo != i}">
															<a onclick="pmRequestProcessList(${i}, '${searchStatus}')" type="button" class="btn btn-white shadow">${i}</a>
														</c:if>
														<c:if test="${rpPager.pageNo == i}">
															<a onclick="pmRequestProcessList(${i}, '${searchStatus}')" type="button" class="btn btn-dark shadow">${i}</a>
														</c:if>
													</c:forEach>
					
													<c:if test="${rpPager.groupNo < rpPager.totalGroupNo }">
														<a onclick="pmRequestProcessList(${rpPager.endPageNo+1}, '${searchStatus}')" type="button" class="btn btn-muted shadow">다음</a>
					
													</c:if>
													<a onclick="pmRequestProcessList(${rpPager.totalPageNo}, '${searchStatus}')" type="button" class="btn btn-muted shadow">맨끝</a>
												</div>
											</div>
										</div>	

										<!--리스트 end -->
									</div>
								</div>
							</div>
							<!-- pm 업무 리스트 end -->
							<!-- dday7 업무 리스트 start -->
							<div class="col-12 my-4">
								<div class="card border-left-dark shadow" style="height: 420.896px;">
									<div class="card-header">
			                			<h5 class="title">D-7 요청리스트</h5>
									</div>
									<div class="card-block" style="height: 350px;" id ="sevenDaysListListContainer">
										<!-- 개발리스트start -->
										<div style="height: 288px;">
											<table class="table  table-striped" id="devList" >
												<thead style="background-color: #3A4651;" class="text-white">
													<tr style="text-align: center;">
														<th>번호</th>
														<th>시스템</th>
														<th>요청유형</th>
														<th>제목</th>
														<th>우선순위</th>
														<th>진행상황</th>
														<th>완료예정일</th>
													</tr>
												</thead>
												<tbody >
													<c:forEach var="dayRequest" items="${listOf7daysLeft}">
														<tr style="text-align: center;">
															<td>${dayRequest.rno}</td>
															<td>${dayRequest.systemName}</td>
															<td>${dayRequest.reqType}</td>
															<td class="tableContent">
																<c:if test="${dayRequest.statusName eq '접수중' || dayRequest.statusName eq '접수완료'}">
																	<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
																</c:if>
																<c:if test="${dayRequest.statusName eq '개발중' || dayRequest.statusName eq '개발재검토' || dayRequest.statusName eq '개발완료'}">
																	<a href="${pageContext.request.contextPath}/developerdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
																</c:if>
																<c:if test="${dayRequest.statusName eq '테스트중' || dayRequest.statusName eq '테스트완료'}">
																	<a href="${pageContext.request.contextPath}/testerdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
																</c:if>
																<c:if test="${dayRequest.statusName eq '유저테스트중' || dayRequest.statusName eq '유저테스트완료'}">
																	<a href="${pageContext.request.contextPath}/usertestdetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
																</c:if>
																<c:if test="${dayRequest.statusName eq '배포중' || dayRequest.statusName eq '배포완료'}">
																	<a href="${pageContext.request.contextPath}/distributedetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
																</c:if>
																<c:if test="${dayRequest.statusName eq '완료' || dayRequest.statusName eq '반려'}">
																	<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${dayRequest.rno}">${dayRequest.reqTitle}</a>
																</c:if>
															</td>
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
															<td>											
																<c:if test="${dayRequest.statusName eq '접수중' || dayRequest.statusName eq '접수완료' }">
																	<span class="badge badge-warning">${dayRequest.statusName}</span>
																</c:if>
																<c:if test="${dayRequest.statusName eq '개발재검토' || dayRequest.statusName eq '반려' }">
																	<span class="badge badge-danger">${dayRequest.statusName}</span>
																</c:if>
																<c:if test="${dayRequest.statusName eq '개발중' || dayRequest.statusName eq '개발완료' }">
																	<span class="badge badge-primary">${dayRequest.statusName}</span>
																</c:if>
																<c:if test="${dayRequest.statusName eq '테스트중' || dayRequest.statusName eq '테스트완료' }">
																	<span class="badge badge-success">${dayRequest.statusName}</span>
																</c:if>
																<c:if test="${dayRequest.statusName eq '유저테스트중' || dayRequest.statusName eq '유저테스트완료' }">
																	<span class="badge badge-info">${dayRequest.statusName}</span>
																</c:if>
																<c:if test="${dayRequest.statusName eq '배포중' || dayRequest.statusName eq '배포완료' }">
																	<span class="badge badge-secondary">${dayRequest.statusName}</span>
																</c:if>
																<c:if test="${dayRequest.statusName eq '완료'}">
																	<span class="badge badge-dark">${dayRequest.statusName}</span>
																</c:if>
															</td>
															<td><fmt:formatDate value="${dayRequest.allExpectDate}" pattern="yyyy-MM-dd"/></td>
														</tr>
													</c:forEach>		
												</tbody>
											</table>
										</div>
										<div class="pager default mt-4">
											<div class="pagingButtonSet d-flex justify-content-center">
												<a onclick="sevenDaysList(1)" type="button" class="btn btn-muted shadow">처음</a>
												<c:if test="${dPager.groupNo > 1}">
													<a onclick="sevenDaysList(${dPager.startPageNo-1})" class="btn btn-muted shadow">이전</a>
				
												</c:if>
				
												<c:forEach var="i" begin="${dPager.startPageNo}" end="${dPager.endPageNo}">
													<c:if test="${dPager.pageNo != i}">
														<a onclick="sevenDaysList(${i})" type="button" class="btn btn-white shadow">${i}</a>
													</c:if>
													<c:if test="${dPager.pageNo == i}">
														<a onclick="sevenDaysList(${i})" type="button" class="btn btn-dark shadow">${i}</a>
													</c:if>
												</c:forEach>
				
												<c:if test="${dPager.groupNo < dPager.totalGroupNo }">
													<a onclick="sevenDaysList(${dPager.endPageNo+1})" type="button" class="btn btn-muted shadow">다음</a>
				
												</c:if>
												<a onclick="sevenDaysList(${dPager.totalPageNo})" type="button" class="btn btn-muted shadow">맨끝</a>
											</div>
										</div>
										<!-- 개발리스트 end -->
									</div>
								</div>
							</div>
							<!-- dday7 업무 리스트 end -->
							<!-- 오늘마감end -->
							<!-- 공지사항 start -->
							<div class="col-12 mb-4">
								<div class="card border-left-primary shadow" style="height: 430.896px;">
									<div class="card-header">
										<h3 class="title">공지사항</h3>
									</div>
									<div class="card-body" id="mainNoticeListContainer">
										<div style="height: 290px;">
											<table class="table table-hover usertable table-striped">
												<thead style="background-color: #72B22B;" class="text-white">
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
										</div>
										<div class="pager default mt-4">
											<div class="pagingButtonSet d-flex justify-content-center">
												<a onclick="mainNoticeList(1)" type="button" class="btn btn-muted shadow">처음</a>
												<c:if test="${nPager.groupNo > 1}">
													<a onclick="mainNoticeList(${nPager.startPageNo-1})" class="btn btn-muted shadow">이전</a>
				
												</c:if>
				
												<c:forEach var="i" begin="${nPager.startPageNo}" end="${nPager.endPageNo}">
													<c:if test="${nPager.pageNo != i}">
														<a onclick="mainNoticeList(${i})" type="button" class="btn btn-white shadow">${i}</a>
													</c:if>
													<c:if test="${nPager.pageNo == i}">
														<a onclick="mainNoticeList(${i})" type="button" class="btn btn-dark shadow">${i}</a>
													</c:if>
												</c:forEach>
				
												<c:if test="${nPager.groupNo < nPager.totalGroupNo }">
													<a onclick="mainNoticeList(${nPager.endPageNo+1})" type="button" class="btn btn-muted shadow">다음</a>
				
												</c:if>
												<a onclick="mainNoticeList(${nPager.totalPageNo})" type="button" class="btn btn-muted shadow">맨끝</a>
											</div>
										</div>
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
		function pmRequestProcessList(pageNo, status){
			$.ajax({
				type: "GET", //요청 메소드 방식
				url:"${pageContext.request.contextPath}/pmrequestprocesslist?pmWorkPageNo=" + pageNo + "&status=" + status,
				dataType:"html", 
				success : function(result){
					$('#requestProcessListContainer').html(result);
					console.log("success");
				}
			})
		} 
		function sevenDaysList(pageNo){
			console.log("실행");
			$.ajax({
				type: "GET", //요청 메소드 방식
				url:"${pageContext.request.contextPath}/7dayslist?dDay7PageNo=" + pageNo,
				dataType:"html", 
				success : function(result){
					$('#sevenDaysListListContainer').html(result);
					console.log("success");
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