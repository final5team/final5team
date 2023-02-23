<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
    	:root {
		 	--line-fill: #87cd36;
		  	--line-empty: #e0e0e0;
		  	--now-fill: #F40730;
		}
    	.container {
		 	 text-align: center;
		}
		
    	
    	.circle {
    		  margin-left : 25px;
			  background-color: #fff;
			  color: #999;
			  height: 40px;
			  width: 150px;
			  font-size : 20px;
			  line-height : 40px;
			  border: 3px solid var(--line-empty);
			  transition: 0.4s ease;
		}
		.bar {
			  margin-left : 100px;
			  padding : 0px;
			  background-color: #fff;
			  color: #999;
			  height: 30px;
			  width: 1px;
			  align-items: center;
			  justify-content: center;
			  border: 3px solid var(--line-empty);
			  transition: 0.4s ease;
		}
		
		.circle.done {
		  	border-color: var(--line-fill);
		  	color : var(--line-fill);
		}
		
		.circle.now {
			border-color : white;
			color : white;
		  	background-color : var(--line-fill);
		}
		
		.bar.active {
		  	border-color: var(--line-fill);
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
				
					<div class="row">
						<!-- 게시글 상세보기 start -->
						<div class="col-xl-9 col-lg-8 col-md-8 col-sm-8">
							<div class="card">
								<div class="card-header d-flex">						
									<h6 class="mr-auto text-primary font-weight-bold">고객테스트 상세보기 ></h6>
									<c:if test="${requestProcess.reqType eq '정규'}">
										<div class="ml-3">정규<i class="far fa-registered text-secondary"></i></div>
									</c:if>
									<c:if test="${requestProcess.reqType eq '긴급'}">
										<div class="ml-3">긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
									</c:if>
									<div class="ml-5 mr-4">중요도:
										<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
										<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
										<c:if test="${requestProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
									</div>				
								</div>
								<div class="card-body">
									<div>
										<h3 class="mr-auto font-weight-bold">${request.reqTitle}</h3>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
											<span class="font-weight-bold ml-2">${request.clientName}</span>
											<span class="ml-3">${request.organ}</span>
										</div>
										<div class="col-sm-6 ml-auto">
											<div class="d-flex">
												<div class="pl-5">시스템:</div>
												<div class="pl-2 flex-grow-1">${request.systemName}</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청일:</div>
												<div class="pl-2 flex-grow-1">
													<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청 완료 예정일:</div>
												<div class="pl-2 flex-grow-1" id="allExpectDate">
													<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
											<c:if test="${request.statusNo == 8 || request.statusNo == 9}">
												<div class="d-flex">
													<div class="pl-5">유저테스트 완료 예정일 :</div>
													<div class="pl-2 flex-grow-1">
														<fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/>
													</div>
												</div>
											</c:if>
											<c:if test="${request.statusNo >= 9}">
												<div class="d-flex">
													<div class="pl-5">유저테스트 완료일 :</div>
													<div class="pl-2 flex-grow-1">
														<fmt:formatDate value="${requestProcess.userTestCompDate}" pattern="yyyy-MM-dd"/>
													</div>
												</div>
											</c:if>
										</div>
									</div>
									<div class="mt-2 ml-5">${request.reqContent}</div>
									<div class="mt-3 ml-5">
										<c:if test="${request.files != null}">
											<c:forEach var="statusHistoryFile" items="${request.files}">
												<span>${statusHistoryFile.fileName}</span>
												<a href="#" role="button">
													<i class="fas fa-cloud-download-alt"></i>
												</a>
											</c:forEach>
										</c:if>
									</div>
									<div class="d-flex justify-content-end">
										<!-- 유저테스트 요청 상태(7) -->
										<c:if test="${request.statusNo == 7 && member.mid == requestProcess.userTester}">
										 	<button class="btn btn-primary btn-lg mt-3" onclick="getDatemodal()" type="button">유저테스트 시작</button>
										</c:if>
										<!-- 유저테스트 중 상태(8) -->
										<c:if test="${request.statusNo == 8 && member.mid == requestProcess.userTester}">
											<form action="${pageContext.request.contextPath}/endwork" method="post" class="mt-3">
												<input type="hidden" name="rno" value="${request.rno}"/>
												<button class="btn btn-info btn-lg mt-3">유저테스트 완료</button>
											</form>
										</c:if>
									</div>
								</div>
							</div>

							<div class="row mb-3">
								<!-- 고객테스트 단계 처리 내역 end -->
									<h2>고객테스트 완료 내역</h2>
									<table class="table">
										<thead class="thead-dark">
										   <tr>
										   	  <th scope="col">유저테스트 완료 예정일</th>
										      <th scope="col">유저테스트 완료일</th>
										      <th scope="col">담당자</th>
										   </tr>
										</thead>
										<tbody>
										    <c:forEach var="statusHistory" items="${userTesterToDistributorHistories}" varStatus="index">
										    	<tr>
										    		<td><fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/></td>
										    		<td><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></td>
										    		<td>${statusHistory.writer}</td>
										    		<td> 
										    			<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
															<span>${statusHistoryFile.fileName}</span>
															<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																<i class="fas fa-cloud-download-alt"></i>
															</a><br>
														</c:forEach>
										    		</td>
										    	</tr>
										    </c:forEach>
										</tbody>
									</table>
								<!-- 고객테스트 단계 처리 내역 end -->
									
								<!-- 고객테스트 단계 처리에 필요한 정보(개발 내용) start -->
									<h2>개발 완료 내역</h2>
									<table class="table">
										<thead class="thead-dark">
										   <tr>
										   	  <th scope="col">개발 차수</th>
										      <th scope="col">개발 내용</th>
										      <th scope="col">작성일</th>
										      <th scope="col">작성자</th>
										      <th scope="col">첨부파일</th>
										   </tr>
										</thead>
										<tbody>
										    <c:forEach var="statusHistory" items="${devToTesterHistories}" varStatus="index">
										    	<tr>
										    		<td>${index.count}차</td>
										    		<td style="word-break:break-all">${statusHistory.reply}</td>
										    		<td><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></td>
										    		<td>${statusHistory.writer}</td>
										    		<td> 
										    			<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
															<span>${statusHistoryFile.fileName}</span>
															<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																<i class="fas fa-cloud-download-alt"></i>
															</a><br>
														</c:forEach>
										    		</td>
										    	</tr>
										    </c:forEach>
										</tbody>
									</table>
								<!-- 고객테스트 단계 처리에 필요한 정보(개발 내용) start -->
							</div>
							
						</div>
						<!-- 게시글 상세보기 end -->
						<!-- 상태 단계 이력 start -->						
						<div class="col-xl-3 col-lg-4 col-md-4 col-sm-4">
							<div class="card">
								<div class="card-header">
									<h6 class="m-0 font-weight-bold text-primary">단계 상태</h6>
								</div>
								<div class="card-body">
									<!-- request.statusName(현재 상태)에 따라 다른 단계 화면 표시-->
									<%@ include file="/WEB-INF/views/srm/nowstatusvertical.jsp" %>
								</div>
							</div>
						</div>
						<!-- 상태 단계 이력 end -->						
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
    <!-- date 입력받는 모달창 start -->
	 <div class="modal fade" id="datemodal" role="dialog" aria-labelledby="developDueDate" aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="developDueDate">유저테스트 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<form action="${pageContext.request.contextPath}/startwork" method="post" class="mt-3" id="startWork">
						<label class="mt-1" style="color: #343a40;" for="expectDate">유저테스트 완료 예정일</label>
						<input type="date" id= "expectDate" name="expectDate" class="form-control ml-2" style="width: 200px; display: inline;"/>
						<input type="hidden" name="rno" value="${request.rno}"/>
					</form>
				</div>
				<div class="modal-footer">
					<small id="noInputDate" style="color : red;"></small>
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" 
                    	onclick="validationCheck()">
                     	확인</a>
				</div>
			</div>
		</div>
	</div>
	
		
	<!-- form 제출하는 모달창 -->
	<div class="modal fade" id="alartDateTooMuch" aria-hidden="true" aria-labelledby="alartOfTimeTooMuch">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa-solid fa-message-exclamation"></i>
					<h5>경고</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p></p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="startWork()" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>

	<!-- 완료창 -->
	<div class="modal fade" id="completeDueDate" aria-hidden="true" aria-labelledby="successOfDueDate">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>확인</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="display: flex; justify-content: center;">
					<p>입력되었습니다.</p>
				</div>
				<div class="modal-footer" style="justify-content: center;">
                    <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<script>
		<!-- 데이트 입력 확인 /-->
		function getDatemodal(){
			$('#datemodal').modal('show');
		}
		function validationCheck(){
			// 1. 날짜 선택했는지 여부 
			if($('#expectDate').val() == ""){
				$('#noInputDate').text("유저테스트 완료 예정일을 입력하세요");
				return;
			}
			
			var aed = new Date($('#allExpectDate').text()).getTime(); 
			var ied = new Date($('#expectDate').val()).getTime();
			var today = new Date().getTime();
			// 2. 요청완료 예정일 이하 
			if(aed < ied){
				$('#noInputDate').text("요청 완료 예정일 이전으로 선택해주세요.");
				return;
			}
			// 3. 오늘 날짜 이상
			if(today > ied){
				$('#noInputDate').text("오늘날짜 이후로 선택해주세요.");
				return;
			}
			// 4. (입력 완료 예정일 - 현재날짜) / (요청완료 예정일 - 현재날짜) >= 50%
			if(((ied - today)/ (aed - today)) >= 0.5){
				$('#datemodal').modal('hide');
				$('#alartDateTooMuch').modal('show');
			}else{
				$('#datemodal').modal('hide');
				$('#alartDateTooMuch').modal('show');
			}
		}

		function startWork(){
			$('#alartDateTooMuch').modal('hide');
			$('#completeDueDate').modal('show');
			$('#startWork').submit();
		}
	</script>
</body>

</html>
