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
		
		li {
	 		list-style : none;
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
						<!-- 네비게이션 start -->
						<ul class="nav nav-tabs">
						   <li class="nav-item">
						      <button id="requestInfoNav" class="btn nav-link" onclick="openRequestInfo()">요청 정보 및 PM검토 내용</button>
						   </li>
						   <li class="nav-item">
						      <button id="developHistoryNav" class="btn nav-link active" onclick="openDevelopHistory()">배포 소스 정보</button>
						   </li>
						</ul>
						<!-- 네비게이션 start -->
						<!-- 요청정보 DIV START -->
						<div class="card card-block sameheight-item mt-3" style="display:none;" id="requestInfo">
							<h3 class="font-weight-bold">						
								 요청 정보
							</h3>
							<div class="row mt-3">
								<div class="col-3 font-weight-bold">요청자 :</div>
								<div class="col-3">${request.clientName}</div>
								<div class="col-3 font-weight-bold">소속 기관 :</div>
								<div class="col-3">${request.organ}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-3 font-weight-bold">요청일 :</div>
								<div class="col-3"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
								<div class="col-3 font-weight-bold">완료 희망일 :</div>
								<div class="col-3"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-3 font-weight-bold">시스템 :</div>
								<div class="col-9">${request.systemName}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-3 font-weight-bold">요청 유형 :</div>
								<div class="col-3">
									<c:if test="${requestProcess.reqType eq '정규'}">
										<div>정규<i class="far fa-registered text-secondary"></i></div>
									</c:if>
									<c:if test="${requestProcess.reqType eq '긴급'}">
										<div>긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
									</c:if>
								</div>
								<div class="col-3 font-weight-bold">중요도 :</div>
								<div class="col-3">
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
							<hr/>
							<div class="row">
								<div class="col-3 font-weight-bold">제목 :</div>
								<div class="col-9">${request.reqTitle}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-3 font-weight-bold">내용 :</div>
								<div class="col-9 border" style="min-height:100px;">${request.reqContent}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-3 font-weight-bold">첨부파일 :</div>
								<div class="col-9">
									<c:forEach var="statusHistoryFile" items="${request.files}">
										<div>
											<span>${statusHistoryFile.fileName}</span>
											<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
												<i class="fas fa-cloud-download-alt"></i>
											</a>
										</div>
									</c:forEach>
								</div>
							</div>
							<!-- 단계 처리 버튼 start -->
							<div class="d-flex justify-content-end">
								<!-- 배포 요청 상태(7(긴급) or 9(정규)) -->
								<c:if test="${(requestProcess.reqType == '긴급' && request.statusNo == 7 && member.mid == requestProcess.distributor) ||
								 (requestProcess.reqType == '정규' && request.statusNo == 9 && member.mid == requestProcess.distributor)}">
								 	<button class="btn btn-primary btn-lg mt-3" onclick="getDatemodal()" type="button">배포 시작</button>
								</c:if>
								<!-- 배포 중 상태(10) -->
								<c:if test="${request.statusNo == 10 && member.mid == requestProcess.distributor}">
									<form action="${pageContext.request.contextPath}/endwork" method="post" class="mt-3">
										<input type="hidden" name="rno" value="${request.rno}"/>
										<button class="btn btn-info btn-lg mt-3">배포 완료</button>
									</form>
								</c:if>
							</div>
							<!-- 단계 처리 버튼 end -->
						</div>
						<!-- 요청정보 DIV END -->
						
						
						
						<!-- PM 검토 정보 start -->	
						<div class="card card-block sameheight-item mt-3 mb-3" style="display:none;" id="pmConfirmInfo">
							<h3 class="font-weight-bold">						
								 PM 검토 정보
							</h3>
							<c:forEach var="statusHistory" items="${pmToAllHistories}">
								<div class="row">
									<div class="col-3 font-weight-bold">PM :</div>
									<div class="col-3">${requestProcess.pm}</div>
									<div class="col-3 font-weight-bold">접수 일자 :</div>
									<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
								</div>
								<hr/>
								<div class="row">
									<div class="col-3 font-weight-bold">요청 완료 예정일 :</div>
									<div class="col-9"><fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/></div>
								</div>
								<hr/>
								<div class="row">
									<div class="col-3 font-weight-bold">검토 의견 :</div>
									<div class="col-9 border" style="min-height:100px;">${statusHistory.reply}</div>
								</div>
								<hr/>
								<div class="row">
									<div class="col-3 font-weight-bold">첨부파일 :</div>
									<div class="col-9">
										<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
											<div>
												<span>${statusHistoryFile.fileName}</span>
												<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
													<i class="fas fa-cloud-download-alt"></i>
												</a>
											</div>
										</c:forEach>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- PM 검토 정보 end -->	
						

						<!-- 개발 내역 start -->
						<div class="card card-block mt-3" id="developHistory">
							<h3 class="font-weight-bold m-0">						
								 배포 소스 정보
							</h3>
							<ul class="p-0">
								<hr/>
								<li>
									<div class="row">
										<div class="col-2 font-weight-bold" style="color:#333333">차수</div>
									 	<div class="col-3 font-weight-bold" style="color:#333333">작성자</div>
									 	<div class="col-3 font-weight-bold" style="color:#333333">작성일</div>
									 	<div class="col-4 font-weight-bold" style="color:#333333">
									 		내용
									 	</div>
									</div>
								</li>
								<hr/>
								<c:forEach var="statusHistory" varStatus="index" items="${devToTesterHistories}">
									<li>
										<div class="row">
											<div class="col-2">${index.count}차</div>
										 	<div class="col-3">${statusHistory.writer}</div>
										 	<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
										 	<div class="col-4">
										 		<button class="showContentButton btn btn-sm btn-primary">보기</button>
										 	</div>
										</div>
									</li>
									<li style="display:none;">
									<hr/>
										<div class="row">
											<div class="col-2">배포 요청 소스 :</div>
											<div class="col-10 border" style="min-height:100px;">${statusHistory.distSource}</div>
										</div>
										<div class="row mt-3">
											<div class="col-2">첨부파일 : </div>
											<div class="col-10">
												<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
													<div>
														<span>${statusHistoryFile.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</div>
									</li>
									<hr/>
								</c:forEach>
							</ul>
						</div>	
						<!-- 개발 내역 end -->
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
					<h5 class="modal-title" id="developDueDate">배포 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<form action="${pageContext.request.contextPath}/startwork" method="post" class="mt-3" id="startWork">
						<label class="mt-1" style="color: #343a40;" for="expectDate">배포 완료 예정일</label>
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
		
		$('.showContentButton').click(function(){
			var fno = $(this).parent().parent().parent().next().toggle();
		}
		);

		function startWork(){
			$('#alartDateTooMuch').modal('hide');
			$('#completeDueDate').modal('show');
			$('#startWork').submit();
		}
		
		function openRequestInfo(){
			$('#requestInfoNav').addClass("active");
			$('#developHistoryNav').removeClass("active");
			$('#RedevelopHistoryNav').removeClass("active");
			$('#requestInfo').show();
			$('#pmConfirmInfo').show();
			$('#developHistoryWrite').hide();
			$('#developHistory').hide();
			$('#reDevelopRequestHistory').hide();
		}
		
		function openDevelopHistory(){
			$('#requestInfoNav').removeClass("active");
			$('#developHistoryNav').addClass("active");
			$('#RedevelopHistoryNav').removeClass("active");
			$('#requestInfo').hide();
			$('#pmConfirmInfo').hide();
			$('#developHistoryWrite').show();
			$('#developHistory').show();
			$('#reDevelopRequestHistory').hide();		
		}
			

	</script>
</body>

</html>
