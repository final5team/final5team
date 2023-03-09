<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
     <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>
    
    <style>
   	.navUl{
   		list-style:none;
   		display: flex;
 		margin-left: auto;
 		margin-right: 30px;
 		margin-bottom: 0px;
   	}
   	.navBtn{
   		border: 1px solid #85ce36;
   	}
   	.navBtn.active {
   		background-color: #85ce36;
   	}
   	.navBtn.active .btn{
   		color: white;
   	}
   	.check-group{
   		margin:auto;
   	}
   	 .label-write{
    width: 100px;
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
                <div class="container">
					<div id="main">
						<div class="title-block">
                	 		<h3 class="title">테스트 상세 보기</h3>
                	 	</div>
						<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
						
						<section>	<!-- 테스터의 재검토 요청 글 작성 start-->
							<c:if test="${member.mid == requestProcess.tester && (request.statusNo == 6 || request.statusNo == 5)}">
							<div class="card border-top-dark my-3" id="reDevelopRequestWrite">
								<div class="card-block">
									<div class="d-flex">
										<div class="card-title-block">
		                	 				<h3 class="title">
			                	 				테스트 내역 작성 <i class="fas fa-edit"></i>
		                	 				</h3>
		                	 			</div>
		                	 			<ul class=" navUl">
		                	 				<li class="navBtn active" id="normal"><a class="btn" onclick="turnNormal()">정상</a></li>
		                	 				<li class="navBtn" id="reexam" ><a class="btn" onclick="turnReexam()">재검토</a></li>
		                	 			</ul>
									</div>
									<div class="card-body ">
										<form id="dueDateForm" action="${pageContext.request.contextPath}/testinprogress"  method="POST">
											<input type="hidden" name="rno" value="${request.rno}" id="rno">
											<div class="form-group d-flex" id="expectDateForm"> 
												<div class="label label-write">완료예정일</div>
												<div class="flex-grow-1">
													<c:if test="${request.statusNo == 5}">
													<input type="date" class="date-form control" id="testExpectDate" name="testExpectDate" >
													<div class="btn btn-sm btn-primary"  onclick="checkDate()" id="testStartButton">테스트 시작</div>
													</c:if>
													<c:if test="${request.statusNo == 6}">
													<input type="date" class="date-form control" id="testExpectDate" value="<fmt:formatDate value='${requestProcess.testExpectDate}' pattern='yyyy-MM-dd'/>" readonly>
													</c:if>
													<small id="noInputDate" style="color : red;"></small>
												</div>
											</div>
										</form>												
										<form role="form" id="writeform" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="nextStatus" value="15" id="nextStatus">
											<input type="hidden" name="rno" value="${request.rno}" id="rno">
											<div class="form-group d-flex">
												<div class="label label-write" id="replylabel">내용 작성 </div>
												<!-- <textarea rows="3" class="form-control boxed flex-grow-1" name="reply"></textarea> -->
												<div class="flex-grow-1">
													<textarea rows="3" class="form-control boxed flex-grow-1" name="reply" id="reply">${tempNormal.reply}</textarea>
													<input type="hidden" id="tempNormal" value="${tempNormal.reply}">
													<input type="hidden" id="tempReexam" value="${tempReexam.reply}">
												</div>
											</div>
											
											<div class="filebox d-flex mb-3">
												<div class="label label-write">
													<div id="fileLabel">첨부파일</div>
													<div class="btn btn-sm btn-info" id="btn-upload">파일 추가</div>
													<input type="file" name="files" id="fileInput" multiple style="display: none;">
												</div>
												
												<div class="border flex-grow-1 border-success" id="file-list"></div>	
											</div>
											
											<div class="d-flex justify-content-end">
												<c:if test="${member.mid == requestProcess.tester && request.statusNo == 6}">
												<button class="btn btn-warning btn-md mx-3 " onclick="tempStore(${request.rno})" type="button" >임시저장</button>
												<button class="btn btn-primary btn-md " id="testButton" onclick="testdone()">테스트 완료</button>
												</c:if>
											</div>
										</form>
									</div>
								</div>
							</div>
							</c:if>
						</section>   <!-- 테스터의 재검토 요청 글 작성  end-->
						
						<c:if test="${testerToDev != null}">
						<div class="d-flex justify-content-center mt-4"> <!-- 히스토리 버튼 start -->
               	 			<div class="btn btn-primary-outline history-button" onclick="openHistories()">
               	 				테스트 내역 보기  <i class="fas fa-history"></i>
               	 			</div>
               	 		</div> <!-- 히스토리 버튼 end -->
						</c:if>
						
						
						<section id="histories"><!-- 재검토 내역 start -->
							<div class="title-block">
	                	 		<h3 class="title">테스트 내역</h3>
	                	 	</div>
	                	 	<c:forEach var="statusHistory" varStatus="index" items="${testerToDev}">
	                	 	<div <c:if test="${statusHistory.nextStatus == 3}">class="card border-top-success my-3"</c:if>
	                	 	<c:if test="${statusHistory.nextStatus == 7}">class="card border-top-primary my-3"</c:if>> <!-- foreach한다면 여기부터 end -->
	                	 		<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<c:if test="${statusHistory.nextStatus == 3}">
	                	 				<h3 class="title">
	                	 					 ${index.count}차 재검토 내역  <i class="far fa-bookmark text-warning "></i>
	                	 				</h3>
	                	 				</c:if>
	                	 				<c:if test="${statusHistory.nextStatus == 7}">
	                	 				<h3 class="title ">
	                	 					 승인 내역  <i class="far fa-bookmark success"></i>
	                	 				</h3>
	                	 				</c:if>
	                	 			</div>
	                	 			<form method="post" action="<c:url value='/updatehistory'/>" id="updateForm" enctype="multipart/form-data">
	                	 			<div class="card-body">
                	 					<div>
                	 						<div class="row">
	                	 						<div class="col-2 label">작성자</div>
	                	 						<div class="col-3">${statusHistory.writer}</div>
	                	 						<div class="col-2 label">테스트 완료일</div>
	                	 						<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
                	 						</div>
                	 						<c:if test="${member.mid != requestProcess.tester}">
	                	 						<div class="row mt-3">
		                	 						<div class="col-2 label">내용</div>
		                	 						<textarea class="col-8 form-control boxed" rows="2"  readonly>${statusHistory.reply}</textarea>
	                	 						</div>
	                	 						<div class="row mt-3">
		                	 						<span class="col-2 label">첨부파일</span>
		                	 						<div>
	                	 								<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
														<div>
															<span>${statusHistoryFile.fileName}</span>
															<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																<i class="fas fa-cloud-download-alt text-info"></i>
															</a>
															<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a>
															<input type="hidden" name = "fno" value="${statusHistoryFile.fno}">
														</div>
														</c:forEach>
		                	 						</div>
	                	 						</div>
                	 						</c:if>
                	 						<c:if test="${member.mid == requestProcess.tester}">
                	 							<c:if test="${index.last}">
                	 								<c:if test="${statusHistory.nextStatus == 7}">
                	 										<c:if test="${request.statusNo == 7}">
                	 											<div class="row mt-3">
                	 												<input type="hidden" name="rno" value="${request.rno}"/>
			                	 									<input type="hidden" name="hno" value="${statusHistory.hno}"/>
						                	 						<div class="col-2 label">내용</div>
						                	 						<textarea name="reply" class="col-8 form-control boxed" rows="2">${statusHistory.reply}</textarea>
					                	 						</div>
					                	 						<div class="row mt-3">
						                	 						<span class="col-2 label">첨부파일</span>
						                	 						<div>
					                	 								<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																		<div>
																			<span>${statusHistoryFile.fileName}</span>
																			<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																				<i class="fas fa-cloud-download-alt text-info"></i>
																			</a>
																			<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a>
																			<input type="hidden" name = "fno" value="${statusHistoryFile.fno}">
																		</div>
																		</c:forEach>
						                	 						</div>
					                	 						</div>
					                	 						<div class="filebox row mb-3">
																	<div class="col-2 label label-write" id="fileLable">
																		<div class="btn btn-sm btn-info" id="btn-upload-update">파일 수정</div>
																		<input type="file" name="files" id="fileInputUpdate" multiple style="display: none;">
																	</div>
																	<div class="border flex-grow-1 border-success col-8" id="file-list-update"></div>	
																</div>
                	 										</c:if>
                	 										<c:if test="${request.statusNo != 7}">
                	 											<div class="row mt-3">
						                	 						<div class="col-2 label">내용</div>
						                	 						<textarea class="col-8 form-control boxed" rows="2"  readonly>${statusHistory.reply}</textarea>
					                	 						</div>
					                	 						<div class="row mt-3">
						                	 						<div class="col-2 label">첨부파일</div>
						                	 						<div class="col-8">
						                	 							<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																		<div>
																			<span>${statusHistoryFile.fileName}</span>
																			<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																				<i class="text-info fas fa-cloud-download-alt"></i>
																			</a>
																		</div>
																		</c:forEach>
						                	 						</div>
					                	 						</div>
                	 										</c:if>
                	 								</c:if>
                	 								<c:if test="${statusHistory.nextStatus == 3}">
                	 									<c:if test="${request.statusNo == 3}">
	                	 									<div class="row mt-3">
		                	 									<input type="hidden" name="rno" value="${request.rno}"/>
		                	 									<input type="hidden" name="hno" value="${statusHistory.hno}"/>
					                	 						<div class="col-2 label">내용</div>
					                	 						<textarea name="reply" class="col-8 form-control boxed" rows="2">${statusHistory.reply}</textarea>
	               	 										</div>
	               	 										<div class="row mt-3">
					                	 						<span class="col-2 label" >첨부파일</span>
					                	 						<div>
				                	 								<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																	<div>
																		<span>${statusHistoryFile.fileName}</span>
																		<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																			<i class="fas fa-cloud-download-alt text-info"></i>
																		</a>
																		<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a>
																		<input type="hidden" name = "fno" value="${statusHistoryFile.fno}">
																	</div>
																	</c:forEach>
					                	 						</div>
				                	 						</div>
				                	 						<div class="filebox row mb-3">
																<div class="col-2 label label-write" id="fileLable">
																	<div class="btn btn-sm btn-info" id="btn-upload-update">파일 수정</div>
																	<input type="file" name="files" id="fileInputUpdate" multiple style="display: none;">
																</div>
																<div class="border flex-grow-1 border-success col-8" id="file-list-update"></div>	
															</div>
               	 										</c:if>
               	 										<c:if test="${request.statusNo != 3}">
               	 											<div class="row mt-3">
					                	 						<div class="col-2 label">내용</div>
					                	 						<textarea class="col-8 form-control boxed" rows="2"  readonly>${statusHistory.reply}</textarea>
				                	 						</div>
				                	 						<div class="row mt-3">
					                	 						<div class="col-2 label">첨부파일</div>
					                	 						<div class="col-8">
					                	 							<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																	<div>
																		<span>${statusHistoryFile.fileName}</span>
																		<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																			<i class="text-info fas fa-cloud-download-alt"></i>
																		</a>
																	</div>
																	</c:forEach>
					                	 						</div>
				                	 						</div>
               	 										</c:if>
                	 								</c:if>
                	 								<c:if test="${statusHistory.nextStatus != 7 && statusHistory.nextStatus != 3}">
                	 									<div class="row mt-3">
				                	 						<div class="col-2 label">내용</div>
				                	 						<textarea class="col-8 form-control boxed" rows="2"  readonly>${statusHistory.reply}</textarea>
			                	 						</div>
                	 								</c:if>
                	 							</c:if>
                	 							<c:if test="${!index.last}">
                	 								<div class="row mt-3">
			                	 						<div class="col-2 label">내용</div>
			                	 						<textarea class="col-8 form-control boxed" rows="2"  readonly>${statusHistory.reply}</textarea>
		                	 						</div>
                	 							</c:if>
                	 						</c:if>
                	 						
                	 						<c:if test="${(request.statusNo == 3 && requestProcess.tester == member.mid && index.last && statusHistory.nextStatus == 3)
                	 						|| (request.statusNo == 7 && requestProcess.tester == member.mid && index.last && statusHistory.nextStatus == 7)}">
                	 							<div class="d-flex justify-content-end">
                	 								<button onclick="update(${request.statusNo})" class="btn btn-primary btn-sm mx-3" type="button">수정</button>	
                	 							</div>
                	 						</c:if>	
                	 					</div>
                	 				</div>
                	 				</form>
	                	 		</div>
	                	 	</div> <!-- foreach한다면 여기부터 end -->
	                	 	</c:forEach>
	                	 	<c:if test="${testerToDev[0].reply == null}">
	                	 	<div class="card border-top-primary my-3"> <!-- status_history내역없을때 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0 d-flex justify-content-center">
	                	 				<h3 class="title text-gray-400">
	                	 					내역이 없습니다. 
	                	 				</h3>
	                	 			</div>
                	 			</div>
                	 		</div><!-- status_history내역없을때 end -->
	                	 	</c:if>
						</section><!-- 재검토 내역 end -->
						<button class="btn btn-dark btn-sm ml-5 mb-3" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
					 </div> <!-- main/ -->
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
    
		
	<!-- 경고 모달창 (50% 이상일 경우)-->
	<div class="modal fade" id="alartDateTooMuch" aria-hidden="true" aria-labelledby="alartOfTimeTooMuch">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa fa-exclamation-circle mr-2" aria-hidden="true" style="font-size: 25px; color: red;"></i>
					<h5>Alart</h5>
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
					<h5>check</h5>
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
	<!-- 데이트 입력 확인 /-->
	<div class="modal fade" id="completeModal" aria-hidden="true" aria-labelledby="successOfDueDate">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>Check</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="display: flex; justify-content: center;">
					<p id="completeContent"></p>
				</div>
				<div class="modal-footer" style="justify-content: center;">
	                <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<script>
	
	function checkDate(){
		$('#noInputDate').text("");
		console.log("checkDate 실행");
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
		 else{
			$('#pContent').text('');
			$('#pContent').text('입력하시겠습니까?. 확인을 누르시면 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		}
		
	}
	function getconfirm(){
		$('#alartDateTooMuch').modal('hide');
		//컨트롤러로 값 전달하기
		var rno = $('#rno').val();
		let expectDate = $('#testExpectDate').val();
		console.log("rno: " + rno);
		$("#dueDateForm").submit();
		$('#completeDueDate').modal('show');
		
	}
	
	$('.showContentButton').click(function(){
		var fno = $(this).parent().parent().parent().next().toggle();
		}
	);
	
	/* 정상 & 재검토 버튼 눌렀을 시 */
	function turnNormal(){
		$('input[name="nextStatus"]').val("15");
		$('#normal').addClass('active');
		$('#reexam').removeClass('active');
		$('#replylabel').text('내용작성');
		$('#replylabel').removeClass('text-danger');
		$('#fileLabel').removeClass('text-danger');
		/* 버튼 바꿔주기 */
		$('#testButton').text('테스트 완료');
		$('#testButton').attr('formaction', '${pageContext.request.contextPath}/testdone');
		/* textarea 값 바꿔주기 */
		var content = $('#tempNormal').val();
		tinymce.get('reply').setContent(content);

		
	}
	function turnReexam(){
		$('input[name="nextStatus"]').val("16");
		$('#reexam').addClass('active');
		$('#normal').removeClass('active');
		$('#replylabel').text('재검토사유');
		$('#replylabel').addClass('text-danger');
		$('#fileLabel').addClass('text-danger');
		/* 버튼 바꾸기 */
		$('#testButton').attr('formaction', '${pageContext.request.contextPath}/askreexam');
		$('#testButton').text('재검토 요청');
		/* textarea 값 바꿔주기 */
		var content = $('#tempReexam').val();
		tinymce.get('reply').setContent(content);
		
	}
	
    /* 테스트 내역 받기 */
    function openHistories(){
    	$('#histories').toggle();
    }
	/* 글자수 세기 */
   	$('#reply').keyup(function (e){
   		let content = $(this).val();
   		$('#counter').html("("+content.length+" / 300)");
 		if(content.length > 300){
 			$('#countCheck').modal();
 			$('#countContent').html("최대 300자까지 입니다.");
 			$(this).val(content.substring(0,300));
 			$('#counter').html("(300 / 300)");
 		}
   	});
	
	/* form 제출 시 글자수 체크 */
	$('#testButton').click(function(){
		let content = $('#reply').val();
		if(content.length > 300){
 			$('#countCheck').modal();
 			$('#countContent').html("최대 300자까지 입니다.");
 			$(this).val(content.substring(0,300));
 			$('#counter').html("(300 / 300)");
 		} else{
 			$('#writeform').submit();
 		}
		
		
	});
	
	/****** 업로드된 파일 리스트 출력하기 *****/
	$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
	{
		$("#fileInput").on("change", fileCheck);
		$("#fileInputUpdate").on("change", fileUpdate);
	});
	
	/* '파일추가' 버튼 누를 때마다 파일input 실행 */
	$(function () {
	    $('#btn-upload').click(function (e) {
	        e.preventDefault();
	        $('#fileInput').click();
	    });
	})
	
	// 파일 현재 필드 숫자 totalCount랑 비교값
	var fileCount = 0;
	// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
	var totalCount = 5;
	// 파일 고유넘버
	var fileNum = 0;
	// 첨부파일 배열
	var content_files = new Array();

	function fileCheck(e) {
	    var files = e.target.files;
	    
	    // 파일 배열 담기
	    var filesArr = Array.prototype.slice.call(files);
	    
	    // 파일 개수 확인 및 제한
	    if (fileCount + filesArr.length > totalCount) {
	    	$('#completeDueDate').modal();
	    	$('.modal-body>p').html('파일은 최대 '+totalCount+ '개까지 업로드 할 수 있습니다.')
	      return;
	    } else {
	    	 fileCount = fileCount + filesArr.length;
	    }
	    
	    // 각각의 파일 배열담기 및 기타
	    filesArr.forEach(function (f) {
	      var reader = new FileReader();
	      
	      reader.onload = function (e) {
		        content_files.push(f);
		        $('#file-list').append(
		       		'<div id="file' + fileNum + '">'
		       		+ '<font style="font-size:15px">' + f.name + '</font>'  
		       		+ '<a onclick ="fileDelete(\'file' + fileNum + '\')">'+'<i class="fas fa-times ml-1 text-success"></i></a>' 
		       		+ '<div/>'
				);
		        fileNum ++;
	      };
	      
	      reader.readAsDataURL(f);
	    });
	  }

	// 파일 부분 삭제 함수
	function fileDelete(fileId){
	    var fileNum = fileId.replace("file", "");
	    content_files[fileNum].is_delete = true;
	    
		$('#' + fileId).remove();
		fileCount --;
	}
	/* 테스트 완료 버튼 누를 시 */
	function testdone(){
		$('#writeform').attr('action','${pageContext.request.contextPath}/testdone');
		
		//input안에 파일 지우기
		var fileInput = $('#fileInput')[0];
		var fileBuffer = new DataTransfer();
		fileInput.files = fileBuffer.files;
		
		//input 안에 파일 채우기
		fileBuffer = new DataTransfer();
		for(var i = 0; i <content_files.length; i ++){
			if(!content_files[i].is_delete){
				fileBuffer.items.add(content_files[i]);
			}
		}
		fileInput.files = fileBuffer.files;
		$('#writeform').submit();
	}
/********* 파일 수정 *********/
	
	/* '파일수정' 버튼 누를 때마다 파일input 실행 */
	$(function () {
	    $('#btn-upload-update').click(function (e) {
	        e.preventDefault();
	        $('#fileInputUpdate').click();
	    });
	})
	function fileUpdate (e){
		console.log("fileUpdate");
		//파일 객체 갖고오기
		var files = e.target.files;
		
		// 파일 배열 담기
	    var filesArr = Array.prototype.slice.call(files);
		
		//기존에 있던 파일 객체
	    var existfiles = $('.existfiles');
	    
	    if(fileCount + filesArr.length > totalCount - existfiles.length ){
	    	$('#completeModal').modal();
	    	$('#completeContent').html('파일은 최대 '+totalCount+ '개까지 업로드 할 수 있습니다.')
	      return;
	    }else {
	    	 fileCount = fileCount + filesArr.length;
	    }
	 	// 각각의 파일 배열담기 및 기타
	    filesArr.forEach(function (f) {
	      var reader = new FileReader();
	      
	      reader.onload = function (e) {
		        content_files.push(f);
		        $('#file-list-update').append(
		       		'<div id="file' + fileNum + '">'
		       		+ '<font style="font-size:15px">' + f.name + '</font>'  
		       		+ '<a onclick ="fileDelete(\'file' + fileNum + '\')">'+'<i class="fas fa-times ml-1 text-success"></i></a>' 
		       		+ '<div/>'
				);
		        fileNum ++;
	      };
	      
	      reader.readAsDataURL(f);
	    });
	}
	
	/***************** 올린 파일 삭제 *****************/
	$('.deletefileButton').click(function(){
		var deleteDiv = $(this).parent();
		var fno = $(this).next().val();
		let distinguish = 1;
		
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/noticefiledelete?fno=" + fno,
			dataType: "json",
			data: {
				distinguish : distinguish
			},
			success: function(result){
				deleteDiv.remove();
			}
		});
		
		
	});
	/****** update() '수정'버튼 클릭 ******/
	function update(){
		//선택된 파일 지우기
		var fileInput = $('#fileInputUpdate')[0];
		var fileBuffer = new DataTransfer();
		fileInput.files = fileBuffer.files;
		
		//배열의 항목으로 채우기
		fileBuffer = new DataTransfer();
		for(var i = 0; i < content_files.length; i ++){
			if(!content_files[i].is_delete){
				fileBuffer.items.add(content_files[i]);
			} 
		}
		fileInput.files = fileBuffer.files;
		console.log("fileInput.files" + fileInput.files.length);
		 $('#updateForm').submit();
	}
	
	/******* 임시저장 *******/
	function tempStore(rno){
		var reply = tinymce.activeEditor.getContent();
		var nextStatus = $('#nextStatus').val();
		console.log("rno : " + rno);
		console.log("reply : " + reply);
		console.log("nextStatus : " + nextStatus);
		
		
		 $.ajax({
			type: "POST",
			url: "${pageContext.request.contextPath}/tempstore",
			data: {
				rno : rno,
				reply : reply,
				nextStatus : nextStatus
			},
			dataType: "json",
			success : function(result){
				console.log(result.result);
				$('#completeContent').text('저장되었습니다.');
				$('#completeModal').modal();
				const timerId1 = window.setTimeout(reload, 1500);
				function reload(){
					location.reload();
				} 
			}
		}); 
	}
	</script>
</body>

</html>