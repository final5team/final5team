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
    padding: 0px 0px 0px 140px;
    margin: 15px 0px;
    }
    .tox-statusbar__branding {
    display: none;
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
	                	 			<div class="card-title-block d-flex">
	                	 				<h3 class="title">
		                	 				개발 내역 작성 <i class="fas fa-edit"></i>
	                	 				</h3>
	                	 				<small class="ml-3">*는 필수 입력 사항입니다.</small>
	                	 			</div>
	                	 			<div class="card-body">
	                	 				<form id="dueDateForm" action="${pageContext.request.contextPath}/devinprogress" method="POST" >
											<input type="hidden" name="rno" value="${request.rno}">
											<div class="form-group d-flex">
												<div class="label label-write">*완료예정일</div>
												<div class="flex-grow-1">
													
													<c:if test="${request.statusNo ==2 || request.statusNo ==3}">
													<input type="date" class="date-form control" name="devExpectDate" id="devExpectDate" value="<fmt:formatDate value='${requestProcess.devExpectDate}' pattern='yyyy-MM-dd'/>">
													<div class="btn btn-md btn-warning" onclick="checkDate()">개발 시작</div>
													</c:if>

													<c:if test="${request.statusNo == 4}">
													<input class="date-form control" id="afterDevExpectDate" value="<fmt:formatDate value='${requestProcess.devExpectDate}' pattern='yyyy-MM-dd'/>" readonly>
													</c:if>
													<small id="noInputDate" style="color : red;"></small>
													
												</div>
											</div>
	                	 				</form>
										<form role="form" id="writeform" action="${pageContext.request.contextPath}/devdone" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}">
											<input type="hidden" name ="nextStatus" value="14">
											<div class="form-group d-flex">
												<div class="label label-write">*개발 사항</div>
												<div class="flex-grow-1">
													<textarea name="reply" id="reply">${devTemp.reply}</textarea>
												</div>
											</div>
											<div class="form-group d-flex">
												<div class="label label-write">*배포소스</div>
												<div class="flex-grow-1">
													<input class="form-control boxed" name="distSource" id="distSource" style="height: 20px;" value="${devTemp.distSource}">
													<div class="d-flex justify-content-end">
														<small class=" mr-5 text-right" id="counterSource">(0 / 100)</small>
													</div>
												</div>
											</div>
											<div class="d-flex">
												<div class="label label-write">*진척률</div>
												<div class="flex-grow-1 d-flex">
													<input type="text" class="form-control boxed" style="width: 100px; height: 20px;" value="${requestProcess.devProgress}" name="devProgress" id="devProgress">
													<span>%</span>
												</div>
											</div>
											<div class="progress-group">
												<div class="progress">
													<div class="progress-bar bg-success" style="width:${requestProcess.devProgress}%"></div>
												</div>
											</div>
											<div id="filebox">
												<div class="d-flex">
													<div class="label label-write" id="fileLable">첨부파일</div>
													<div class="flex-grow-1 p-2">
														<c:forEach var="statusHistoryFile" items="${devTemp.fileList}">
															<div>
																<span>${statusHistoryFile.fileName}</span> 
																<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button"> <i class="fas fa-cloud-download-alt text-info"></i></a>
																<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a> 
																<input type="hidden" name="fno" value="${statusHistoryFile.fno}">
															</div>
														</c:forEach>
													</div>
												</div>
												<div class="d-flex mb-3 mt-1">
													<div class="label-write label ">
														<div class="btn btn-sm btn-info" id="btn-upload">파일 추가</div>
														<input type="file" name="files" id="fileInput" multiple style="display: none;">
													</div>
													<div class="border flex-grow-1 border" id="file-list"></div>	
												</div>
											</div>
										</form>
										
										<c:if test="${request.statusNo == 4}">
										<div class="d-flex justify-content-end">
										<button class="btn btn-dark btn-md" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">취소</button>
										<button class="btn btn-warning btn-md mx-3" onclick="tempStore(${request.rno},14)">임시 저장</button>
										<button class="btn btn-primary btn-md " onclick="checkModal()">개발 완료</button>
										</div>
										</c:if>
										
	                	 			</div>
                	 			</div>
                	 		</div>
                	 	</section><!-- 개발내역 입력폼 end -->
                	 	</c:if>
                	 	
               	 		
                	 	<section id="histories" > <!-- 개발히스토리 start-->
                	 		<div class="title-block">
	                	 		<h3 class="title">개발 내역</h3>
	                	 	</div>
	                	 	<c:forEach var="statusHistory" varStatus="index" items="${devToTester}">
                	 		<div class="card border-top-dark my-3"> <!-- foreach한다면 여기부터 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<h3 class="title">
	                	 					 ${index.count}차 내역  <i class="far fa-bookmark success"></i>
	                	 				</h3>
	                	 			</div>   	 	
                	 				<div class="card-body">
                	 					<div>
                	 						<div class="row">
	                	 						<div class="col-2 label">작성자</div>
	                	 						<div class="col-3 ">${statusHistory.writer}</div>
	                	 						<div class="col-2 label">개발 완료일</div>
	                	 						<div class="col-3 "><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
                	 						</div>
                	 						<div class="row mt-3">
                	 							<div class="col-2 label" >개발내용</div>
                	 							<div class="col-8 border p-2 scroller" style="min-height: 100px;">${statusHistory.reply}</div>
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
                	 						<c:if test="${requestProcess.developer == member.mid && request.statusNo == 5 && index.last}">
				                	 			<form method="post" action="${pageContext.request.contextPath}/rollbackstep" class="d-flex justify-content-end">
				                	 				<input type="hidden" name="hno" value="${statusHistory.hno}"/>
				                	 				<button type="submit" class="btn btn-primary btn-md">수정</button>
				                	 			</form>
				                	 		</c:if>
                	 					</div>
                	 				</div>
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
			$('#pContent').text('입력하시겠습니까? 완료 예정일은 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		}
		
	}
	function getconfirm(){
		$('#alartDateTooMuch').modal('hide');
		//컨트롤러로 값 전달하기
		$('#dueDateForm').submit();
		
		$('#completeDueDate').modal('show');
	}
	
	/******* reply 글자수 유효성 검사 *******/
	function checkReplyLength(){
		//글자
		var reply = tinymce.activeEditor.getContent();
		/* var reply = reply; */
		//1.태그가 없는 경우(글자 없음)
		if(reply.length == 0){
			console.log("내용 없음");
			$('#completeContent').text('내용을 입력해주세요.');
			$('#completeModal').modal();
			return false;
		} else{
			//2.태그가 있는 경우(글자 있음)
			//태그들 제거해서 순수 글자수 빼오기
			var realReply = reply.replace(/<[^>]*>?/g, '');
			
			//순수 글자수가 300이 넘는지 확인
			if(realReply.length>300){
			//1. 글자수 300이 넘을 경우
				console.log("300자 초과");
				$('#completeContent').text('300자를 초과하였습니다.');
				$('#completeModal').modal();
				return false;
			} else{
				//2. 글자수 0보다 크며 300안일 경우(정상)
				console.log("정상");
				return true;
			}
			
		}
	}
	function checkDistSource(){
		var dist = $('#distSource').val();
		if(dist.length == 0){
			$('#completeContent').text('배포소스 내용을 입력해주세요.');
			$('#completeModal').modal();
			return false;
		} else{
			return true;
		}
	}
	
	/* 개발 완료 버튼 클릭시 form데이터 전달 */
	function devEnd(){
		$('#writeform').attr('action', '${pageContext.request.contextPath}/devdone');
		
		//진척률 100% 인지 검사하기
		let devProgress = $('#devProgress').val();
		
		//배포소스 입력했는지 확인
		var distResult = checkDistSource();
		console.log("distResult: "+distResult);
		
		//reply에 대한 글자수 유효성 검사
		var result2 = checkReplyLength();
		
		
		console.log("result2: "+result2);
		if(result2 && distResult){
			console.log("여기까지 result2 나옴22");
			//숫자에 대한 유효성 검사하기
			let result = updateProgress (devProgress);
			//result 가 true 면 0과 100 사이의 숫자라는 의미 -> 100일 때만 실행시키기
			if(result){
				if( devProgress == 100) {
					
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
					$('#completeContent').text('개발 완료 하시겠습니까?');
					$('#completeModal').modal();
					$('#writeform').submit();
					
				} else{
					$('#completeContent').text('진척률 100% 일때 개발 완료가 가능합니다.');
					$('#completeModal').modal();
				}
			}
		}
		
		
		
	}
	
	
	/****** 임시저장 버튼 클릭시 form 데이터 전달 ******/
	function tempStore(rno,nextStatus){
		var reply = tinymce.activeEditor.getContent();
		var distSource = $('#distSource').val();
		var devProgress = $('#devProgress').val();
		
		//devProgress 유효성 검사
		var result1 = updateProgress(devProgress);
		
		if(result1){
			console.log(result1);
			
			/* input.files에 존재하는 파일들 넣어주기 */
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
			
			var form = $('#writeform')[0];
			var formData = new FormData(form);
			
			 formData.set("reply", reply);
			
			$.ajax({
				type: "POST",
				enctype: "multipart/form-data",
				url: "${pageContext.request.contextPath}/tempstore",
				contentType:false,
				processData: false,
				data:formData,
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
   	
	/* devProgress업데이트  숫자 유효성 체크할 때 유용*/
 	function updateProgress(data){
		
		let devProgress = data;
		
		let check = /^[0-9]+$/; 
		/* 숫자만 입력했는지 확인하는 유효성 체크 */
		if (!check.test(devProgress)){
			$('#completeContent').text('');
			$('#completeContent').text('숫자만 입력 가능합니다.');
			$('#completeModal').modal();
			$('#devProgress').val("");
			
			return false;
		} else{
			/* String 타입에서 int타입으로 변환 */
			let intDevProgress = parseInt(devProgress);
			
			if (intDevProgress >=0 && intDevProgress <= 100){
				return true;
			} else{
				$('#completeContent').text('');
				$('#completeContent').text('0~100사이의 숫자만 입력 가능합니다.');
				$('#completeModal').modal();
				return false;
			}
			
		}
	}
	
 	
	/****** 업로드된 파일 리스트 출력하기 *****/
	$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
	{
		$("#fileInput").on("change", fileCheck);
		
		
		/****** window로딩 시, 개발시작 버튼 눌렀는지 확인하고, 작성칸 readonly 만들어주기 *****/
		var devExpectDate = $('#devExpectDate').val();
		if(devExpectDate == ""){
			tinymce.get("reply").setMode('readonly');
			$('#distSource').attr('disabled',true);
			$('#btn-upload').hide();
			$('#writeform').mousedown(function(){
				$('#noInputDate').text('개발 시작을 눌러야 입력 가능합니다.');
			});
		} else{
			tinymce.get("reply").setMode('design');
			$('#distSource').attr('disabled',false);
			$('#btn-upload').show();
			$('#writeform').off( "mousedown");
			$('#noInputDate').text('');
		}
		
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
	    
		  //기존에 있던 파일 객체
	    var existfiles = $('.existfiles');
	    
	    // 파일 개수 확인 및 제한
	    if (fileCount + filesArr.length > totalCount - existfiles.length) {
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
		console.log("fileDelete-fileCount: " + fileCount);
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
	    
    	console.log("fileCount: "+ fileCount);	
    	console.log("filesArr.length: "+filesArr.length);
    	console.log("existfiles.length: "+existfiles.length);
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
		
		$('#updateForm').submit();
	}
	</script>
</body>

</html>