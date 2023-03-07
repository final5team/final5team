<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>    
    
    
    <style>
    .progress-group{
    padding: 0px 140px;
    margin: 15px 0px;
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
                	 <div id="main"> <!-- id=main div start -->
                	 	<div class="title-block">
                	 		<h3 class="title">개발 상세 보기</h3>
                	 	</div>
                	 	<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
                	 	<c:if test="${ member.mid eq requestProcess.developer &&(request.statusNo == 3 ||request.statusNo == 2||request.statusNo == 4)}">
                	 	<section> <!-- 개발내역 입력폼 start -->
                	 		<div class="card border-top-dark">
                	 			<div class="card-block">
	                	 			<div class="card-title-block">
	                	 				<h3 class="title">
		                	 				개발 내역 작성 <i class="fas fa-edit"></i>
	                	 				</h3>
	                	 			</div>
	                	 			<div class="card-body">
	                	 				<form id="dueDateForm" action="${pageContext.request.contextPath}/devinprogress" method="POST" >
											<input type="hidden" name="rno" value="${request.rno}">
											<div class="form-group d-flex">
												<div class="label label-write">완료예정일</div>
												<div class="flex-grow-1">
													
													<c:if test="${request.statusNo ==2 || request.statusNo ==3}">
													<input type="date" class="date-form control" name="devExpectDate" id="devExpectDate">
													<div class="btn btn-sm btn-primary" onclick="checkDate()">개발 시작</div>
													</c:if>

													<c:if test="${request.statusNo == 4}">
													<input type="date" class="date-form control" name="devExpectDate" value="<fmt:formatDate value='${requestProcess.devExpectDate}' pattern='yyyy-MM-dd'/>" readonly>
													</c:if>
													<small id="noInputDate" style="color : red;"></small>
													
												</div>
											</div>
	                	 				</form>
										<form role="form" id="writeform" action="${pageContext.request.contextPath}/devdone" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}">
											<input type="hidden" name ="nextStatus" value="14">
											<div class="form-group d-flex">
												<div class="label label-write">개발 사항</div>
												<div class="flex-grow-1">
													<textarea rows="3" class="form-control boxed flex-grow-1" name="reply" id="reply">${devTemp.reply}</textarea>
												</div>
											</div>
											<div class="form-group d-flex">
												<div class="label label-write">배포소스(url)</div>
												<div class="flex-grow-1">
													<input class="form-control boxed" name="distSource" id="distSource" style="height: 20px;" value="${devTemp.distSource}">
													<div class="d-flex justify-content-end">
														<small class=" mr-5" id="counterSource">(0 / 100)</small>
													</div>
												</div>
											</div>
											
											<div class="filebox d-flex mb-3">
												<div class="label label-write" id="fileLable">
													<div>첨부파일</div>
													<div class="btn btn-sm btn-info" id="btn-upload">파일 추가</div>
													<input type="file" name="files" id="fileInput" multiple style="display: none;">
												</div>
												
												<div class="border flex-grow-1 border-success" id="file-list">
			  									
			  									</div>	
											</div>
										</form>
										<c:if test="${request.statusNo == 4}">
										<form id="progressForm" action="${pageContext.request.contextPath}/updatedevprogress" method="POST">
											<div class="d-flex">
												<div class="label label-write">진척률</div>
												<div class="flex-grow-1 d-flex">
													<input type="hidden" value="${request.rno}" name="rno">
													<input type="text" class="form-control boxed" style="width: 100px; height: 20px;" value="${requestProcess.devProgress}" name="devProgress" id="devProgress">
													<span>%</span>
													<span class="btn btn-sm btn-primary ml-2" onclick="updateProgress()">확인</span>
													
												</div>
											</div>
											<div class="progress-group">
												<div class="progress">
													<div class="progress-bar bg-success" style="width:${requestProcess.devProgress}%"></div>
												</div>
											</div>
										</form>
										</c:if>
										
										<c:if test="${request.statusNo == 4}">
										<div class="d-flex justify-content-end">
										<button class="btn btn-warning btn-md mx-3" onclick="tempStore()">임시 저장</button>
										<c:if test="${requestProcess.devProgress == 100}">
										<button class="btn btn-primary btn-md " onclick="devEnd()">개발 완료</button>
										</c:if>

										</div>
										</c:if>
										
	                	 			</div>
                	 			</div>
                	 		</div>
                	 	</section><!-- 개발내역 입력폼 end -->
                	 	</c:if>
                	 	
                	 	<c:if test="${devToTester != null}">
               	 		<div class="d-flex justify-content-center mt-4"> <!-- 히스토리 버튼 start -->
               	 			<div class="btn btn-primary-outline history-button" onclick="openHistories()">
               	 				개발 내역 보기  <i class="fas fa-history"></i>
               	 			</div>
               	 		</div> <!-- 히스토리 버튼 end -->
                	 	</c:if>
               	 		
               	 		
                	 	<section id="histories" > <!-- 개발히스토리 start-->
                	 		<div class="title-block">
	                	 		<h3 class="title">개발 내역</h3>
	                	 	</div>
	                	 	<c:forEach var="statusHistory" varStatus="index" items="${devToTester}">
                	 		<div class="card border-top-primary my-3"> <!-- foreach한다면 여기부터 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<h3 class="title">
	                	 					 ${index.count}차 내역  <i class="far fa-bookmark success"></i>
	                	 				</h3>
	                	 			</div>   	 	
	                	 			<form method="post" action="<c:url value='/updatehistory'/>" enctype="multipart/form-data">
	                	 				<div class="card-body">
	                	 					<div>
	                	 						<div class="row mb-2">
		                	 						<div class="col-2 label">작성자</div>
		                	 						<div class="col-3 ">${statusHistory.writer}</div>
		                	 						<div class="col-2 label">개발 완료일</div>
		                	 						<div class="col-3 "><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
	                	 						</div>
	                	 						<c:if test="${member.mid != requestProcess.developer}">
		                	 						<div class="row">
			                	 						<div class="col-2 label" >개발내용</div>
			                	 						<textarea class="col-8 form-control boxed" rows="2" readonly>${statusHistory.reply}</textarea>
		                	 						</div>
		                	 						<div class="row mt-3">
			                	 						<div class="col-2 label">배포소스(url)</div>
			                	 						<input class="col-8 form-control boxed mr-5" style=" height: 20px;" value="${statusHistory.distSource}" readonly>
		                	 						</div>
	                	 						</c:if>
	                	 						<c:if test="${requestProcess.developer == member.mid}">
	                	 								<c:if test="${!index.last || request.statusNo != 5}">
	                	 									<div class="row">
				                	 							<div class="col-2 label" >개발내용</div>
				                	 							<textarea class="col-8 form-control boxed" rows="2" readonly>${statusHistory.reply}</textarea>
				                	 						</div>
				                	 						<div class="row mt-3">
					                	 						<div class="col-2 label">배포소스(url)</div>
					                	 						<input class="col-8 form-control boxed mr-5" style=" height: 20px;" value="${statusHistory.distSource}" readonly>
				                	 						</div>
				                	 						<div class="row mt-3">
					                	 						<div class="col-2 label">첨부파일</div>
					                	 						<div class="col-8">
				                	 								<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																	<div>
																		<span>${statusHistoryFile.fileName}</span>
																		<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																			<i class="fas fa-cloud-download-alt text-info"></i>
																		</a>
																	</div>
																	</c:forEach>
					                	 						</div>
				                	 						</div>
	                	 								</c:if>
			                	 				
			                	 						<c:if test="${index.last && request.statusNo == 5}">
			                	 							<input type="hidden" name="rno" value="${request.rno}"/>
			                	 							<input type="hidden" name="hno" value="${statusHistory.hno}"/>
				                	 						<div class="row">
					                	 						<div class="col-2 label" >개발내용</div>
					                	 						<textarea name="reply"class="col-8 form-control boxed" rows="2">${statusHistory.reply}</textarea>
				                	 						</div>
				                	 						<div class="row mt-3">
					                	 						<div class="col-2 label">배포소스(url)</div>
					                	 						<input name="distSource" class="col-8 form-control boxed mr-5" style=" height: 20px;" value="${statusHistory.distSource}">
				                	 						</div>
				                	 						<div class="row mt-3">
				                	 							<div class="col-2 label">첨부파일</div>
					                	 						<div class="col-8">
				                	 								<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																	<div>
																		<span>${statusHistoryFile.fileName}</span>
																		<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																			<i class="fas fa-cloud-download-alt text-info"></i>
																		</a>
																	</div>
																	</c:forEach>
					                	 						</div>
				                	 						</div>
				                	 						<div class="filebox d-flex mb-3">
																<div class="label label-write" id="fileLable">
																	<div class="btn btn-sm btn-info" id="btn-upload-update">파일 수정</div>
																	<input type="file" name="files" id="fileInputUpdate" multiple style="display: none;">
																</div>
																<div class="border flex-grow-1 border-success" id="file-list-update"></div>	
															</div>
			                	 						</c:if>
	                	 						</c:if>
	                	 								
	                	 						<c:if test="${request.statusNo == 5 && requestProcess.developer == member.mid && index.last}">
	                	 							<div class="d-flex justify-content-end">
	                	 								<button type="submit" class="btn btn-primary btn-sm mx-3">수정</button>	
	                	 							</div>
	                	 						</c:if>	
	                	 					</div>
	                	 				</div>
                	 				</form>
                	 			</div>
                	 		
                	 		</div><!-- foreach한다면 여기부터 end -->
                	 		</c:forEach>
                	 		
                	 		<c:if test="${devToTester[0].reply == null}">
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
                	 		
                	 	</section> <!-- 개발히스토리end -->
                	 	<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
					 </div> <!-- id=main div / -->
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
					<h5>Alert</h5>
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
	<!-- 데이트 입력 확인 /-->
	<!-- 글자수 입력 확인 -->
	<div class="modal fade" id="countCheck" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>
						주의 <i class="fas fa-exclamation-triangle"></i>
					</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="display: flex; justify-content: center;">
					<p id="countContent"></p>
				</div>
				<div class="modal-footer" style="justify-content: center;">
                    <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 글자수 입력 확인 /-->
	<script>

	function checkDate(){
		$('#noInputDate').text("");
		console.log("startWork 실행");
		if($('#devExpectDate').val() == ""){
			$('#noInputDate').text("날짜를 입력해주세요.");
			return;
		}
		
		let today = new Date().getTime();   
		var devExpectDate = new Date($('#devExpectDate').val()).getTime();
		var reqExpectDate = new Date($('#reqExpectDate').text()).getTime();
		var receiptDoneDate = new Date($('input[name="receiptDoneDate"]').val()).getTime();
		console.log(receiptDoneDate);
		
		//오늘보다 이전 날짜를 입력할 경우
		if(today > devExpectDate){
			$('#noInputDate').text("현재보다 앞선 날짜를 입력해주세요.");
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
		$('#dueDateForm').submit();
		
		$('#completeDueDate').modal('show');
	}
	
	/* 개발 완료 버튼 클릭시 form데이터 전달 */
	function devEnd(){
		$('#writeform').attr('action', '${pageContext.request.contextPath}/devdone');
		
		//선택된 파일 지우기
		var fileInput = $('#fileInput')[0];
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
		
		$('#writeform').submit();
	}
	/* 임시저장 버튼 클릭시 form 데이터 전달 */
	function tempStore(){
		$('#writeform').attr('action', '${pageContext.request.contextPath}/tempstore');
		$('#writeform').submit();
	}
	
	
	function getDevContent(index){
		var content = "#" + index;
		$(content).toggle();
	}
	
	$('.showContentButton').click(function(){
			var fno = $(this).parent().parent().parent().next().toggle();
		}
	);
	
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
   	$('#distSource').keyup(function (e){
   		let content = $(this).val();
   		$('#counterSource').html("("+content.length+" / 100)");
   		if(content.length > 100){
   			$('#countCheck').modal();
 			$('#countContent').html("최대 100자까지 입니다.");
 			$(this).val(content.substring(0,150));
 			$('#counterSource').html("(100 / 100)");
   		}
   	});
   	
	/* devProgress업데이트 */
 	function updateProgress(){
		
		let devProgress = $('#devProgress').val();
		
		let check = /^[0-9]+$/; 
		/* 숫자만 입력했는지 확인하는 유효성 체크 */
		if (!check.test(devProgress)){
			$('#completeContent').text('');
			$('#completeContent').text('숫자만 입력 가능합니다.');
			$('#completeModal').modal();
			$('#devProgress').val("");
			
		} else{
			/* String 타입에서 int타입으로 변환 */
			let intDevProgress = parseInt(devProgress);
			
			if (intDevProgress >=0 && intDevProgress <= 100){
				$('#progressForm').submit();
				return;
				
			} else{
				$('#completeContent').text('');
				$('#completeContent').text('0~100사이의 숫자만 입력 가능합니다.');
				$('#completeModal').modal();
			}
			
		}
	}
	
 	
	/****** 업로드된 파일 리스트 출력하기 *****/
	$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
	{
		$("#fileInput").on("change", fileCheck);
		$("#fileInputUPdate").on("change", fileUpdate);
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
	    	$('#completeModal').modal();
	    	$('#completeContent').html('파일은 최대 '+totalCount+ '개까지 업로드 할 수 있습니다.')
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
	/********* 파일 수정 *********/
	
	/* '파일수정' 버튼 누를 때마다 파일input 실행 */
	$(function () {
	    $('#btn-upload-update').click(function (e) {
	        e.preventDefault();
	        $('#fileInputUpdate').click();
	    });
	})
	function fileCheck (e){
		
		//파일 객체 갖고오기
		var files = e.target.files;
		
		// 파일 배열 담기
	    var filesArr = Array.prototype.slice.call(files);
		
		//기존에 있던 파일 객체
	    var existfiles = $('.existfiles');
	}
	
	</script>
</body>

</html>