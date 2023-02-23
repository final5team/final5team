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
	<script>
		function checkDateToDevelope(){
			console.log('버튼 클릭');
		}
	</script>
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
								<div class="card-header d-flex  ">
									<h6 class="mr-auto text-primary font-weight-bold">테스터상세보기 ></h6>
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
												<div class="pl-2 flex-grow-1"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청완료예정일:</div>
												<div class="pl-2 flex-grow-1" id="reqExpectDate"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
											</div>
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
										<c:if test="${member.mid == requestProcess.tester && request.statusNo == 5}">
										<button class="btn btn-primary btn-lg mt-3 ml-3" onclick="getDatemodal()" type="button">테스트시작</button>
										</c:if>
										<c:if test="${member.mid == requestProcess.tester && request.statusNo == 6}">
										<button class="btn btn-info btn-lg mt-3 ml-3" onclick="devEnd(${request.rno})">테스트완료</button>
										</c:if>
									</div>
								</div>
							</div>
							<!-- 테스터의 개발 요청 글 작성 start-->
							<c:if test="${member.mtype =='tester' && request.statusNo == 6}">
							<div class="card mt-4 mb-5">
								<div class="card-header">결함내용 작성하기</div>
								<div class="card-body row">
									<div class="col-sm-3 d-flex align-items-center" style="text-align:center;">
										<div>
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hoon.png" width="70%">
											<div class="mt-3">${member.mname}</div>
										</div>
									</div>
									<div class="col-sm-9">
										<form role="form" id="writeform" action="${pageContext.request.contextPath}/askreexam" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}">
											<div class="col-sm-12 form-group">
												<label class="control-label" >완료예정일</label>
												<input type="text" class="form-control boxed" value="<fmt:formatDate value="${requestProcess.devExpectDate}" pattern="yyyy-MM-dd"/>" readonly>
											</div>
											<div class="col-sm-12 form-group">
												<label class="control-label">개발내용</label>
												<textarea rows="2" class="form-control boxed" name="reply"></textarea>
											</div>
											<div class="filebox">
												<label for="file">Choose a file</label>
												<input type="file" id="file" name="files" multiple>
											</div>
											<div class="d-flex justify-content-end">
												<button class="btn btn-warning btn-lg mt-3" type="submit">재검토요청</button>
											</div>
										</form>
									</div>
								</div>
							</div>
							</c:if>
							<!-- 개발자의 개발 요청 글 작성 end-->
							<div class="row mb-3">
								<!-- 개발자의 개발내용 start -->
								<div class="col-md-6">
								<c:forEach varStatus="i" var="statusHistory" items="${devToTester}">
									<div class="card mt-3 cardscroller" style="height: 262px;">
										<div class="card-header d-flex justify-content-end">
											<div>${i.count}차 개발</div>
											<div class="ml-auto ml-1">완료일: <fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
										</div>
										<div class="card-body p-1 cardscroller-block">
											<div class="row mr-3">
												<div class="col-sm-3 d-flex align-items-center" style="text-align: center;">
													<div>
														<img class="rounded-circle mt-1" src="${pageContext.request.contextPath}/resources/img/hoon.png" width="60%">
														<div class="ml-2">${requestProcess.developer}</div>
													
													</div>
												</div>
												<div class="col-sm-9">
													<div class="d-flex justify-content-end">
													</div>
													<div>
														<label class="control-label">개발내용</label>
														<textarea class="form-control boxed " readonly style="background-color: transparent;" rows="2">${statusHistory.reply}</textarea>
													</div>
													<div class="mt-2">
														<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
															<span>${statusHistoryFile.fileName}</span>
															<a href="#" role="button">
																<i class="fas fa-cloud-download-alt"></i>
															</a><br>
														</c:forEach>
													</div>
												</div>
											</div>	

										</div>
									</div>
								</c:forEach>
								</div>
								<!-- 개발자의 개발내용 end -->
								<!-- 테스터의 개발내용 start -->
								<div class="col-md-6">
								<c:forEach varStatus="i" var="statusHistory" items="${testerToDev}">							

									<div class="card mt-3 cardscroller" style="height: 262px;">
										<div class="card-header d-flex justify-content-end">
											<div>${i.count}차 결함</div>
											<div class="ml-auto ml-1">완료일: <fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
										</div>
										<div class="card-body p-1 cardscroller-block">
											<div class="row align-items-center">
												<div class="col-sm-3 d-flex align-items-center" style="text-align: center;">
													<div>
														<img class="rounded-circle mt-1" src="${pageContext.request.contextPath}/resources/img/hoon.png" width="60%">
														<div class="ml-2">${requestProcess.tester}</div>
													
													</div>
												</div>
												<div class="col-sm-9">
													<div class="d-flex justify-content-end">
													</div>
													<div>
														<label class="control-label">결함내용</label>
														<textarea class="form-control boxed " readonly style="background-color: transparent;" rows="3">${statusHistory.reply}</textarea>
													</div>
													<div class="mt-2">
														<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
															<span>${statusHistoryFile.fileName}</span>
															<a href="#" role="button">
																<i class="fas fa-cloud-download-alt"></i>
															</a><br>
														</c:forEach>
													</div>
												</div>
											</div>	

										</div>
									</div>								
								</c:forEach>
								</div>
								<!-- 테스터의 개발내용 end -->
							</div>

						</div>
						<!-- 게시글 상세보기 end -->
						<!-- 상태 단계 이력 start -->						
						<div class="col-xl-3 col-lg-4 col-md-4 col-sm-4">
							<div class="card">
								<div class="card-header">
									<h6 class="m-0 font-weight-bold text-primary">단계 상태</h6>
								</div>
								<div class="card-body mx-auto">
							        <%@ include file="/WEB-INF/views/srm/nowstatusvertical.jsp" %>
								
									<div class="mt-4 text-center small"></div>
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
					<h5 class="modal-title" id="developDueDate">개발 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<form id="formUpdateExpectDate" action="${pageContext.request.contextPath}/testinprogress" method="POST">
						<label class="mt-1" style="color: #343a40;" for="testExpectDate">테스트 완료 예정일</label>
						<input type="date" class="form-control ml-2" id="testExpectDate" name="testExpectDate" style="width: 200px; display: inline;">
						<input type="hidden" name="rno" value="${request.rno}">
					</form>
					<input type="hidden" name="receiptDoneDate" value="<fmt:formatDate value='${receiptDoneDate}' pattern='yyyy-MM-dd'/>">
				</div>
				<div class="modal-footer">
					<small id="noInputDate" style="color : red;"></small>
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="checkDate()">확인</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- date 입력받는 모달창 end -->
		
	<!-- 경고 모달창 (50% 이상일 경우)-->
	<div class="modal fade" id="alartDateTooMuch" aria-hidden="true" aria-labelledby="alartOfTimeTooMuch">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa fa-exclamation-circle mr-2" aria-hidden="true" style="font-size: 25px; color: red;"></i>
					<h5>경고</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p id="pContent"></p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="getconfirm()" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 경고 모달창 (50% 이상일 경우) -->
	<!-- 데이트 입력 확인 -->
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
	function checkDate(){
		$('#noInputDate').text("");
		
		if($('#testExpectDate').val() == ""){
			$('#noInputDate').text("날짜를 입력해주세요.");
			return;
		}
		
		let today = new Date().getTime();   
		var testExpectDate = new Date($('#testExpectDate').val()).getTime();
		var reqExpectDate = new Date($('#reqExpectDate').text()).getTime();
		var receiptDoneDate = new Date($('input[name="receiptDoneDate"]').val()).getTime();

		//오늘보다 이전 날짜를 입력할 경우
		if(today > testExpectDate){
			$('#noInputDate').text("현재보다 앞선 날짜를 입력해주세요.");
			return;
		}
		//총완료예정일보다 큰 일정을 입력할 경우
		if(reqExpectDate <= testExpectDate){
			$('#noInputDate').text("완료예정일보다 과거여야 합니다.");
			return;
		}
		if(((testExpectDate-receiptDoneDate)/(reqExpectDate-receiptDoneDate))>=0.2){
			$('#pContent').text('');
			$('#pContent').text('입력 시간이 완료 예정일 대비 20% 이상 차지합니다. 확인을 누르시면 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		} else{
			$('#pContent').text('');
			$('#pContent').text('입력하시겠습니까?. 확인을 누르시면 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		}
		
	}
	function getconfirm(){
		$('#alartDateTooMuch').modal('hide');
		//컨트롤러로 값 전달하기
		$('#formUpdateExpectDate').submit();
		
		$('#completeDueDate').modal('show');
	}
	function devEnd(rno){
		let rnoNum = rno;
		location.href='${pageContext.request.contextPath}/testdone?rno=' + rnoNum;
	}
	
	
	</script>
</body>

</html>
