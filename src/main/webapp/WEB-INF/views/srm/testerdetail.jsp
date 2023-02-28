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
					<div id="main">
						<!-- 네비게이션 start -->
						<ul class="nav nav-tabs">
						   <li class="nav-item">
						      <button id="requestInfoNav" class="btn nav-link" onclick="openRequestInfo()">요청 정보 및 PM검토 내용</button>
						   </li>
						   <li class="nav-item">
						      <button id="developHistoryNav" class="btn nav-link" onclick="openDevelopHistory()">개발 완료 내역</button>
						   </li>
						   <li class="nav-item">
						      <button id="RedevelopHistoryNav" class="btn nav-link active" onclick="openReDevelopRequestHistory()">재검토 요청 내역</button>
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
							<div class="d-flex justify-content-end">
								<c:if test="${member.mid == requestProcess.tester && request.statusNo == 5}">
								<button class="btn btn-primary btn-lg mt-3 ml-3" onclick="getDatemodal()" type="button">테스트시작</button>
								</c:if>
								<c:if test="${member.mid == requestProcess.tester && request.statusNo == 6}">
								<button class="btn btn-info btn-lg mt-3 ml-3" onclick="devEnd(${request.rno})">테스트완료</button>
								</c:if>
							</div>
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
						<div class="card card-block mt-3" id="developHistory" style="display:none;">
							<h3 class="font-weight-bold m-0">						
								 개발 히스토리
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
								<c:forEach var="statusHistory" varStatus="index" items="${devToTester}">
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
											<div class="col-2">개발사항 :</div>
											<div class="col-10 border" style="min-height:100px;">${statusHistory.reply}</div>
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
						
						
						<!-- 재검토 내역 start -->
						<div class="card card-block mt-3" id="reDevelopRequestHistory">
							<h3 class="font-weight-bold m-0">						
								 재검토 요청 히스토리
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
								<c:forEach var="statusHistory" varStatus="index" items="${testerToDev}">
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
											<div class="col-2">재검토 사유 및 요청사항 :</div>
											<div class="col-10 border" style="min-height:100px;">${statusHistory.reply}</div>
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
						<!-- 재검토 내역 end -->	
						
						
						<!-- 테스터의 재검토 요청 글 작성 start-->
						<c:if test="${member.mtype =='tester' && request.statusNo == 6}">
						<div class="card card-block mt-3 mb-3" id="reDevelopRequestWrite">
							<div class="card-body">
								<form role="form" id="writeform" action="${pageContext.request.contextPath}/askreexam" method="POST" enctype="multipart/form-data">
									<input type="hidden" name="rno" value="${request.rno}">
									<div class="form-group d-flex">
										<div style="width:350px;">재검토 사유 및 요청사항</div>
										<textarea rows="5" class="form-control boxed flex-grow-1" name="reply"></textarea>
									</div>
									<div class="filebox d-flex">
										<div style="width:250px;">첨부파일 등록</div>
										<input type="file" id="file" class="flex-grow-1" name="files" multiple>
									</div>
									<div class="d-flex justify-content-end">
										<button class="btn btn-warning btn-lg mt-3" type="submit">재검토요청</button>
									</div>
								</form>
							</div>
						</div>
						</c:if>
						<!-- 테스터의 재검토 요청 글 작성  end-->
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
	
	$('.showContentButton').click(function(){
		var fno = $(this).parent().parent().parent().next().toggle();
		}
	);
	
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
		
	function openReDevelopRequestHistory(){
		$('#requestInfoNav').removeClass("active");
		$('#developHistoryNav').removeClass("active");
		$('#RedevelopHistoryNav').addClass("active");
		$('#requestInfo').hide();
		$('#pmConfirmInfo').hide();
		$('#developHistoryWrite').hide();
		$('#developHistory').hide();
		$('#reDevelopRequestHistory').show();
	}
	
	
	</script>
</body>

</html>
