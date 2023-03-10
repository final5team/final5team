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
		                                                	진행 중
		                                            </div>
		                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
		                                            	<c:set var="operating" value=
		                                            	"${userRequestStatusCount['1'] 
		                                            	+ userRequestStatusCount['2'] 
		                                            	+ userRequestStatusCount['3']
		                                            	+ userRequestStatusCount['4'] 
		                                            	+ userRequestStatusCount['5'] 
		                                            	+ userRequestStatusCount['6'] 
		                                            	+ userRequestStatusCount['7']
		                                            	+ userRequestStatusCount['8'] 
		                                            	+ userRequestStatusCount['9']
		                                            	+ userRequestStatusCount['10'] 
		                                            	+ userRequestStatusCount['11']}"></c:set>
		                                            	<c:out value="${operating} 건"/>
		                                            </div>
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
		                                             	 완료</div>
		                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
		                                            	<c:out value="${userRequestStatusCount['12'] + userRequestStatusCount['13']}"></c:out> 건
		                                            </div>
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
									<div class="topnav ml-4">
										  <a id="one" class="active" onclick="userRequestList('전체', 1)">전체</a>
										  <a id="two" onclick="userRequestList('진행중', 1)">진행중</a>
										  <a id="three" onclick="userRequestList('완료', 1)">완료</a>
										  <a id="four" onclick="userRequestList('반려', 1)">반려</a>
									</div>
									<div class="card-body py-0 " id="userRequestListContainer">
										<div style="height: 280px;">
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
														<tr style="text-align: center;">
															<td>${request.rno}</td>
															<td class="tableContent">
																<c:if test="${request.usrCheck == 1}">
																	<strong class="text-danger">N</strong>
																</c:if>
																<c:if test="${request.statusNo != 12 &&  request.statusNo != 13}">
																	<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
																		${request.reqTitle}
																	</a>
																</c:if>
																<c:if test="${request.statusNo == 12 || request.statusNo == 13}">
																	<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
																		${request.reqTitle}
																	</a>
																</c:if>																
															</td>
															<td>${request.systemName}</td>
															<td><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></td>
															<td>
																<c:if test="${request.statusNo == 12}">
																	<span class="badge badge-warning">반려</span>
																</c:if>
																<c:if test="${request.statusNo == 13}">
																	<span class="badge badge-success">완료</span>
																</c:if>
																<c:if test="${request.statusNo != 12 && request.statusNo != 13}">
																	<span class="badge badge-primary">진행중</span>
																</c:if>
														    </td>
														</tr>
													</c:forEach>
													</tbody>
												</table>
										</div>
										<div class="pager default mt-1">
											<div class="pagingButtonSet d-flex justify-content-center">
												<a onclick="userRequestList('${searchStatus}', 1)" type="button" class="btn btn-muted shadow">처음</a>
												<c:if test="${uPager.groupNo > 1}">
													<a onclick="userRequestList('${searchStatus}', ${uPager.startPageNo-1})" class="btn btn-muted shadow">이전</a>
				
												</c:if>
				
												<c:forEach var="i" begin="${uPager.startPageNo}" end="${uPager.endPageNo}">
													<c:if test="${uPager.pageNo != i}">
														<a onclick="userRequestList('${searchStatus}', ${i})" type="button" class="btn btn-white shadow">${i}</a>
													</c:if>
													<c:if test="${uPager.pageNo == i}">
														<a onclick="userRequestList('${searchStatus}', ${i})" type="button" class="btn btn-dark shadow">${i}</a>
													</c:if>
												</c:forEach>
				
												<c:if test="${uPager.groupNo < uPager.totalGroupNo }">
													<a onclick="userRequestList('${searchStatus}', ${uPager.endPageNo+1})" type="button" class="btn btn-muted shadow">다음</a>
				
												</c:if>
												<a onclick="userRequestList('${searchStatus}', ${uPager.totalPageNo})" type="button" class="btn btn-muted shadow">맨끝</a>
											</div>
										</div>
									</div>
								</div>
							</div>	               			
							<div class="col-12 my-4">
								<div class="card border-left-primary" style="height: 430.896px;">
									<div class="card-header">
										<h3 class="title">공지사항</h3>
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
    
    <script>
    	function userRequestList(searchStatus, pageNo){
    		if(searchStatus == '전체'){
    			$('#one').css("background-color", "#98def7");
    			$('#one').css("color", "white");
    			$('#two').css("background-color", "white");
    			$('#two').css("color", "#858796");
    			$('#three').css("background-color", "white");
    			$('#three').css("color", "#858796");
    			$('#four').css("background-color", "white");
    			$('#four').css("color", "#858796");
	    	}
    		else if(searchStatus == '진행중'){
				$('#one').css("background-color", "white");
				$('#one').css("color", "#858796");
    			$('#two').css("background-color", "#98def7");
    			$('#two').css("color", "white");
    			$('#three').css("background-color", "white");
				$('#three').css("color", "#858796");
    			$('#four').css("background-color", "white");    			
				$('#four').css("color", "#858796");
			}
    		else if(searchStatus == '완료'){
				$('#one').css("background-color", "white");
				$('#one').css("color", "#858796");
    			$('#two').css("background-color", "white");
    			$('#two').css("color", "#858796");
    			$('#three').css("background-color", "#98def7");
    			$('#three').css("color", "white");
    			$('#four').css("background-color", "white");
    			$('#four').css("color", "#858796");
			}
    		else if(searchStatus == '반려'){
				$('#one').css("background-color", "white");
				$('#one').css("color", "#858796");
    			$('#two').css("background-color", "white");
    			$('#two').css("color", "#858796");
    			$('#three').css("background-color", "white");
    			$('#three').css("color", "#858796");
    			$('#four').css("background-color", "#98def7");
    			$('#four').css("color", "white");
			}
    		
    		$.ajax({
    			type: "GET", //요청 메소드 방식
    			url:"${pageContext.request.contextPath}/userrequestlist?myRequestPageNo=" + pageNo + "&searchStatus=" + searchStatus,
    			dataType:"html", 
    			success : function(result){
    				$('#userRequestListContainer').html(result);
    				console.log("success");
    			}
    		});
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