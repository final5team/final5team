<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    
    <style type="text/css">
     	#devList #myDevList{
     		border-top: 1px solid RGB(214 217 220);
     		margin-top: 10px;
     	}
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
	 /* 토글 온오프 start*/
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  margin-bottom: 0px;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #72B22B;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}	 
	 /* 토글 온오프 done*/
.uppermain{
	width: 250px;
}	 

.uppermain2{
	width: 330px;
}
	tr{
	text-align: center;
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
               			<!-- 상단 업무 현황 바 start -->
               			<div class=" d-flex justify-content-between" style="flex-wrap: nowrap;">
	               			<!-- 처리 대기 건 -->
               				<div 
               					<c:if test="${member.mtype == 'developer'}">class="uppermain mb-4 ml-3"</c:if>
               					<c:if test="${member.mtype != 'developer'}">class="uppermain2 mb-4 ml-3"</c:if>
               				 >
	                            <div class="card border-left-primary shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
	                                             	 <c:if test="${member.mtype == 'developer'}">
	                                             	 	개발 대기
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'tester'}">
	                                             	 	테스트 대기
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'usertester'}">
	                                             	 	품질검토 대기
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'distributor'}">
	                                             	 	배포 대기
	                                             	 </c:if>
                                             	</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:if test="${member.mtype == 'developer'}">
	                                             	 	<c:set var="waiting" 
	                                             	 	value="${workingStatus['1'] + workingStatus['2']}"/> 
	                                             	 	<c:out value="${waiting} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'tester'}">
	                                             	 	<c:set var="waiting" 
	                                             	 	value="${workingStatus['1'] + workingStatus['2'] + workingStatus['3'] + workingStatus['4'] + workingStatus['5']}"/> 
	                                             	 	<c:out value="${waiting} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'usertester'}">
	                                             	 	<c:set var="waiting" 
	                                             	 	value="${workingStatus['1'] + workingStatus['2'] + workingStatus['3'] + workingStatus['4'] + workingStatus['5'] + workingStatus['6'] + workingStatus['7']}"/> 
	                                             	 	<c:out value="${waiting} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'distributor'}">
	                                             	 	<c:set var="waiting" 
	                                             	 	value="${workingStatus['1'] + workingStatus['2'] + workingStatus['3'] + workingStatus['4'] + workingStatus['5'] + workingStatus['6'] + workingStatus['7'] + workingStatus['8'] + workingStatus['9']}"/> 
	                                             		<c:out value="${waiting} 건"></c:out>
	                                             	 </c:if>                                            	
                                            	</div>
	                                        </div>
	                                        <div class="col-auto">
	                                           <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
               			
               				<!-- 진행요청건 -->
	               			 <div 
               					<c:if test="${member.mtype == 'developer'}">class="uppermain mb-4"</c:if>
               					<c:if test="${member.mtype != 'developer'}">class="uppermain2 mb-4"</c:if>
               				 >
	                            <div class="card border-left-success shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-success text-uppercase mb-1">
                                               		<c:if test="${member.mtype == 'developer'}">
	                                             	 	개발 중
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'tester'}">
	                                             	 	테스트 중
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'usertester'}">
	                                             	 	품질검토 중
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'distributor'}">
	                                             	 	배포 중
	                                             	 </c:if>
                                               	</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:if test="${member.mtype == 'developer'}">
	                                             	 	<c:out value="${workingStatus['4']} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'tester'}">
	                                             	 	<c:out value="${workingStatus['6']} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'usertester'}">
	                                             	 	<c:out value="${workingStatus['8']} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'distributor'}">
	                                             		<c:out value="${workingStatus['10']} 건"></c:out>
	                                             	 </c:if>
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-spinner fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	               			
	               			<!-- 완료건 -->
	               			 <div 
               					<c:if test="${member.mtype == 'developer'}">class="uppermain mb-4"</c:if>
               					<c:if test="${member.mtype != 'developer'}">class="uppermain2 mb-4"</c:if>
               				 >
	                            <div class="card border-left-info shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-info text-uppercase mb-1">
                                                	 <c:if test="${member.mtype == 'developer'}">
	                                             	 	개발 완료
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'tester'}">
	                                             	 	테스트 완료
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'usertester'}">
	                                             	 	품질검토 완료
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'distributor'}">
	                                             	 	배포 완료
	                                             	 </c:if>
	                                            </div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:if test="${member.mtype == 'developer'}">
	                                             	 	<c:set var="done" 
	                                             	 	value="${workingStatus['5'] + workingStatus['6'] + workingStatus['7'] + workingStatus['8'] + workingStatus['9'] + workingStatus['10'] + workingStatus['11'] + workingStatus['13']}"/> 
	                                             	 	<c:out value="${done} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'tester'}">
	                                             	 	<c:set var="done" 
	                                             	 	value="${workingStatus['7'] + workingStatus['8'] + workingStatus['9'] + workingStatus['10'] + workingStatus['11'] + workingStatus['13']}"/> 
	                                             	 	<c:out value="${done} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'usertester'}">
	                                             	 	<c:set var="done" 
	                                             	 	value="${workingStatus['9'] + workingStatus['10'] + workingStatus['11'] + workingStatus['13']}"/> 
	                                             	 	<c:out value="${done} 건"></c:out>
	                                             	 </c:if>
	                                             	 <c:if test="${member.mtype == 'distributor'}">
	                                             	 	<c:set var="done" 
	                                             	 	value="${workingStatus['11'] + workingStatus['13']}"/> 
	                                             		<c:out value="${done} 건"></c:out>
	                                             	 </c:if>
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
							<!-- mtype이 developer라면 재검토요청건 존재 -->
							<c:if test="${member.mtype == 'developer'}">
	               			<div class="uppermain mb-4">
	                            <div class="card border-left-warning shadow h-100 py-2">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center">
	                                        <div class="col mr-2">
	                                            <div class="text-lg font-weight-bold text-warning text-uppercase mb-1">
	                                                	개발 재검토</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
	                                            	<c:out value="${workingStatus['3']}"/> 건
	                                            </div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
							</c:if>
	                        
               			</div>
               			<!-- 상단 업무 현황 바 end -->
               			
               			<!-- 하단 오늘 마감 and 공지사항 start-->
							<!-- 오늘마감start -->
							<div class="col-12 my-4">
								<div class="card tasks border-left-dark shadow" style="height: 420.896px;">
									<div class="card-header d-flex">
			                			<h5 class="title ml-3 mr-auto" id="devTitle">
			                				<c:if test="${member.mtype == 'developer'}">
			                					<input type="hidden" value="developer" id="memberType"/>
			                					<span id="title">나의 개발 리스트</span>
			                				</c:if>
			                				<c:if test="${member.mtype == 'tester'}">
			                					<input type="hidden" value=tester id="memberType"/>
			                					<span id="title">나의 테스트 리스트</span>
			                				</c:if>
			                				<c:if test="${member.mtype =='usertester'}">
			                					<input type="hidden" value="usertester" id="memberType"/>
			                					<span id="title">나의 품질검토 리스트</span>
			                				</c:if>
			                				<c:if test="${member.mtype == 'distributor'}">
			                					<input type="hidden" value="distributor" id="memberType"/>
			                					<span id="title">나의 배포 리스트</span>
			                				</c:if>
			                			</h5>
				                		<div class="toggle-group d-flex align-items-center mr-4">
				                			<label class="switch" >
											  <input type="checkbox" id="toggleButton" onclick="requestProcessList(1)" checked>
											  <span class="slider round"></span>
											</label>
				                		</div>
			                			
									</div>
									<div class="card-block pt-2" style="height: 350px;" id="requestProcessListContainer">
										<!-- 리스트 start -->
										<div style="height: 305px;">
											<table class="table tasks-block table-striped table-hover"  >
												<thead style="background-color: #3A4651;" class="text-white">
													<tr style="text-align: center;">
														<th>번호</th>
														<th>요청유형</th>
														<th>제목</th>
														<th>우선순위</th>
														<th>요청일</th>
														<th>완료예정일</th>
														<th>담당자</th>
														<th>진행상황</th>
													</tr>
												</thead>
												<tbody >
													<c:forEach var="requestProcess" items="${requestProcessList}" varStatus="i">
													<tr style="text-align: center;">
														<td>${i.count}</td>
														<td <c:if test="${requestProcess.reqType == '긴급'}"> class="text-danger"</c:if>>
														${requestProcess.reqType}
														</td>
														<td class="tableContent">
															<c:if test="${member.mtype == 'developer'}">
																<a href="${pageContext.request.contextPath}/developerdetail?rno=${requestProcess.rno}">
																	${requestProcess.reqTitle}
																</a>
															</c:if>
															<c:if test="${member.mtype == 'tester'}">
																<a href="${pageContext.request.contextPath}/testerdetail?rno=${requestProcess.rno}">
																	${requestProcess.reqTitle}
																</a>
															</c:if>
															<c:if test="${member.mtype == 'usertester'}">
																<a href="${pageContext.request.contextPath}/usertestdetail?rno=${requestProcess.rno}">
																	${requestProcess.reqTitle}
																</a>
															</c:if>
															<c:if test="${member.mtype == 'distributor'}">
																<a href="${pageContext.request.contextPath}/distributedetail?rno=${requestProcess.rno}">
																	${requestProcess.reqTitle}
																</a>
															</c:if>
														</td>
														<td>
															<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
																<span class="fa fa-star checked" style="color: orange;"></span>
															</c:if>
															<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
																<span class="fa fa-star checked" style="color: orange;"></span>
															</c:if>
															<c:if test="${requestProcess.priority eq '상'}">
																<span class="fa fa-star checked" style="color: orange;"></span>
															</c:if>
														</td>
														<td><fmt:formatDate value="${requestProcess.reqDate}" pattern="yyyy-MM-dd"/></td>
														<td><fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/></td>
														<td>${requestProcess.mname}</td>
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
											<ul class="pagination pagination-sm d-flex justify-content-center mt-2">
											    <li class="page-item"><a class="page-link" onclick="requestProcessList(1)">처음</a></li>
											    <c:if test="${rpPager.groupNo>1}">
												    <li class="page-item">
												    	<a class="page-link" onclick="requestProcessList(${rpPager.startPageNo-1})">
												    		<i class="fas fa-caret-left"></i>
												    	</a>
												    </li>
											    </c:if>
											    <c:forEach var="i" begin="${rpPager.startPageNo}" end="${rpPager.endPageNo}">
											    	<c:if test="${rpPager.pageNo != i}">
												    	<li class="page-item"><a class="page-link" onclick="requestProcessList(${i})">${i}</a></li>
											    	</c:if>
											    	<c:if test="${rpPager.pageNo == i}">
												    	<li class="page-item"><a class="page-link" style="background-color: #3A4651; color: white;" onclick="requestProcessList(${i})">${i}</a></li>
											    	</c:if>
											    </c:forEach>
											    <c:if test="${rpPager.groupNo<rpPager.totalGroupNo}">
												    <li class="page-item">
												    	<a class="page-link" onclick="requestProcessList(${rpPager.endPageNo + 1})">
												    		<i class="fas fa-caret-right"></i>
												   	 	</a>
												    </li>
											    </c:if>
											    <li class="page-item"><a class="page-link" onclick="requestProcessList(${rpPager.totalPageNo})">맨끝</a></li>
											</ul>
										</div>	

										<!--리스트 end -->
									</div>
								</div>
							</div>
							<!-- 오늘마감end -->
							<!-- 공지사항 start -->
							<div class="col-12">
								<div class="card border-left-primary shadow mb-4" style="height: 420.896px;" >
									<div class="card-header">
			                			<h5 class="title ml-3">공지사항</h5>
			                		</div>
			                		<div class="card-body" id="mainNoticeListContainer">
			                			<div style="height: 290px;">
				                			<table class="table table-hover usertable table-striped">
												<thead style="background-color: #72B22B;" class="text-white">
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
															<td>${notice.nno}</td>
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
											    	<li class="page-item"><a class="page-link" style="background-color: #72B22B; color: white;" onclick="mainNoticeList(${i})">${i}</a></li>
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
    	function requestProcessList(pageNo){
    		var checkbox = '';
    		if($('#toggleButton').is(":checked")){
    			checkbox = 'y';
    			if($('#memberType').val() == 'developer'){
    				$('#title').text("나의 개발 리스트");
    			}
    			else if($('#memberType').val() == 'tester'){
    				$('#title').text("나의 테스트 리스트");
				    			}
    			else if($('#memberType').val() == 'usertester'){
    				$('#title').text("나의 품질검토 리스트");
				}
    			else if($('#memberType').val() == 'distributor'){
    				$('#title').text("나의 배포 리스트");
				}
    		}
    		else{
    			checkbox = 'n';
    			if($('#memberType').val() == 'developer'){
    				$('#title').text("전체 개발 리스트");
    			}
    			else if($('#memberType').val() == 'tester'){
    				$('#title').text("전체 테스트 리스트");
				    			}
    			else if($('#memberType').val() == 'usertester'){
    				$('#title').text("전체 품질검토 리스트");
				}
    			else if($('#memberType').val() == 'distributor'){
    				$('#title').text("전체 배포 리스트");
				}
    		}
    		console.log(checkbox);
    		$.ajax({
    			type: "GET", //요청 메소드 방식
    			url:"${pageContext.request.contextPath}/requestprocesslist?workPageNo=" + pageNo + "&checkbox=" + checkbox,
    			dataType:"html", 
    			success : function(result){
    				$('#requestProcessListContainer').html(result);
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