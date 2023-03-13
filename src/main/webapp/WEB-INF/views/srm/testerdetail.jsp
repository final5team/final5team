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
						<!-- 테스터 승인/재검토 글 작성 start-->
						<section>	
							<c:if test="${member.mid == requestProcess.tester && (request.statusNo == 6 || request.statusNo == 5)}">
							<div class="card border-top-dark my-3" id="reDevelopRequestWrite">
								<div class="card-block">
									<div class="d-flex">
										<div class="card-title-block d-flex">
		                	 				<h3 class="title">
			                	 				테스트 내역 작성 <i class="fas fa-edit"></i>
		                	 				</h3>
		                	 				<small class="ml-3">*는 필수 입력 사항입니다.</small>
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
												<div class="label label-write">*완료예정일</div>
												<div class="flex-grow-1">
													<c:if test="${request.statusNo == 5}">
													<input type="date" class="date-form control" id="testExpectDate" name="testExpectDate" >
													<div class="btn btn-md btn-warning"  onclick="checkDate()" id="testStartButton">테스트 시작</div>
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
												<div class="label label-write" id="replylabel">*내용 작성 </div>
												<div class="flex-grow-1" >
													<textarea class="form-control boxed flex-grow-1" name="reply" id="reply">${tempNormal.reply}</textarea>
												</div>
											</div>
											<div id="tempNormalFile">
												<div class="d-flex mt-3" >
		                	 						<div class="label-write label">첨부파일</div>
		                	 						<div>
	                	 								<c:forEach var="statusHistoryFile" items="${tempNormal.fileList}">
														<div class="flex-grow-1">
															<span>${statusHistoryFile.fileName}</span>
															<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																<i class="fas fa-cloud-download-alt text-info"></i>
															</a>
															<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a> 
															<input type="hidden" name="fno" value="${statusHistoryFile.fno}">
														</div>
														</c:forEach>
		                	 						</div>
	                	 						</div>
											</div>
               
											<div class="filebox d-flex mb-3">
												<div class="label label-write">
													<div class="btn btn-sm btn-info" id="btn-upload">파일 추가</div>
													<input type="file" name="files" id="fileInput" multiple style="display: none;">
												</div>
												
												<div class="border flex-grow-1 border" id="file-list"></div>	
											</div>
											
											<div class="d-flex justify-content-end">
												<c:if test="${member.mid == requestProcess.tester && request.statusNo == 6}">
												<button class="btn btn-warning btn-md " onclick="tempStore(${request.rno})" type="button" >임시저장</button>
												<button class="btn btn-primary btn-md mx-3" id="testButton" onclick="testdone()">테스트 완료</button>
												<!-- <button class="btn btn-dark btn-md " type="button" onclick="location.href='{pageContext.request.contextPath}/customer/requestlist'">취소</button> -->
												<button class="btn btn-dark btn-md " type="button">취소</button>
												</c:if>
											</div>
										</form>
									</div>
								</div>
							</div>
							</c:if>
						</section>   
						<!-- 테스터 승인/재검토 글 작성  end-->
						
						<!-- 테스터 승인/재검토 내역 start -->
						<section id="histories">
							<div class="title-block">
	                	 		<h3 class="title">테스트 내역</h3>
	                	 	</div>
	                	 	<c:forEach var="statusHistory" varStatus="index" items="${testerToDev}">
		                	 	<div <c:if test="${statusHistory.nextStatus == 3}">class="card border-top-success my-3"</c:if>
		                	 	<c:if test="${statusHistory.nextStatus == 7}">class="card border-top-dark my-3"</c:if>> 
		                	 		<div class="card-block">
		                	 			<div class="card-block-title mb-0">
		                	 				<c:if test="${statusHistory.nextStatus == 3}">
			                	 				<h3 class="title">
			                	 					 ${index.count}차 재검토 내역  <i class="far fa-bookmark text-danger "></i>
			                	 				</h3>
		                	 				</c:if>
		                	 				<c:if test="${statusHistory.nextStatus == 7}">
			                	 				<h3 class="title ">
			                	 					 승인 내역  <i class="far fa-bookmark success"></i>
			                	 				</h3>
		                	 				</c:if>
		                	 				
		                	 			</div>
		                	 			<div class="card-body">
	                	 					<div>
	                	 						<div class="row">
		                	 						<div class="col-2 label">작성자</div>
		                	 						<div class="col-3">${statusHistory.writer}</div>
		                	 						<div class="col-2 label">테스트 완료일</div>
		                	 						<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
	                	 						</div>
	                	 						<div class="row mt-3">
		                	 						<div class="col-2 label">내용</div>
		                	 						<div class="col-8 border scroller p-2" style="min-height: 100px;">${statusHistory.reply}</div>
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
	                	 						<c:if test="${requestProcess.tester == member.mid && index.last
			                	 				&& (request.statusNo == 7 || request.statusNo == 3)}">
					                	 			<form method="post" action="${pageContext.request.contextPath}/rollbackstep" class="d-flex justify-content-end">
					                	 				<input type="hidden" name="hno" value="${statusHistory.hno}"/>
					                	 				<button type="submit" class="btn btn-primary btn-md">수정</button>
					                	 			</form>
					                	 		</c:if>
	                	 					</div>
	                	 				</div>
		                	 		</div>
		                	 	</div> 
	                	 	</c:forEach>
                	 		<!-- status_history내역없을때 start -->
	                	 	<c:if test="${testerToDev[0].reply == null}">
		                	 	<div class="card border-top-primary my-3"> 
	                	 			<div class="card-block">
		                	 			<div class="card-block-title mb-0 d-flex justify-content-center">
		                	 				<h3 class="title text-gray-400">
		                	 					내역이 없습니다. 
		                	 				</h3>
		                	 			</div>
	                	 			</div>
	                	 		</div>
	                	 	</c:if>
                	 		<!-- status_history내역없을때 end -->
						</section><!-- 테스트 승인/재검토 내역 end -->
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
		$('#normal').addClass('active');
		$('#reexam').removeClass('active');
		$('#replylabel').text('내용작성');
		/* 버튼 바꿔주기 */
		$('#testButton').text('테스트 완료');
		$('#testButton').attr('formaction', '${pageContext.request.contextPath}/testdone');
		
	}
	function turnReexam(){
		$('#reexam').addClass('active');
		$('#normal').removeClass('active');
		$('#replylabel').text('재검토사유');
		/* 버튼 바꾸기 */
		$('#testButton').attr('formaction', '${pageContext.request.contextPath}/askreexam');
		$('#testButton').text('재검토 요청');
		
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
		
		/****** window로딩 시, 개발시작 버튼 눌렀는지 확인하고, 작성칸 readonly 만들어주기 *****/
		var testExpectDate = $('#testExpectDate').val();
		if(testExpectDate == ''){
			tinymce.get("reply").setMode('readonly');
			$('#distSource').attr('disabled',true);
			$('#btn-upload').hide();
			$('#writeform').mousedown(function(){
				$('#noInputDate').text('테스트 시작을 눌러야 입력 가능합니다.');
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
	
	/* 테스트 완료 버튼 누를 시 */
	function testdone(){
		$('#writeform').attr('action','${pageContext.request.contextPath}/testdone');
		
		//reply에 대한 글자수 유효성 검사
		var result = checkReplyLength();
		console.log("result: "+result);
		
		if(result){
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

	
	/******* 임시저장 *******/
	function tempStore(rno){
		var reply = tinymce.activeEditor.getContent();
		var nextStatus = $('#nextStatus').val();
		console.log("rno : " + rno);
		console.log("tempStore");
		
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
		
		//FormData 객체 안에 form태그 넣어주기
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
	</script>
</body>

</html>