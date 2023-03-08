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
    padding: 0px 220px;
    margin: 15px 0px;
    
    }
 .label-write{
  	width: 100px;
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
                	 		<h3 class="title">품질검토 상세 보기</h3>
                	 	</div>
                	 	<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
                	 	<c:if test="${member.mid eq requestProcess.userTester && (request.statusNo == 7 || request.statusNo == 8)}">
                	 	<section> <!-- 품질검토 내역 입력폼 start -->
                	 		<div class="card border-top-dark">
                	 			<div class="card-block">
	                	 			<div class="card-title-block">
	                	 				<h3 class="title">
		                	 				품질 검토 내역 작성 <i class="fas fa-edit"></i>
	                	 				</h3>
	                	 			</div>
	                	 			<div class="card-body">
	                	 				<form id="dueDateForm" action="${pageContext.request.contextPath}/startwork" method="POST" >
											<input type="hidden" name="rno" value="${request.rno}">
											<div class="form-group d-flex">
												<div class="label label-write">완료예정일</div>
												<div class="flex-grow-1">
													<c:if test="${request.statusNo == 7}">
														<input type="date" class="date-form control" name="expectDate" id="userTestExpectDate">
														<div class="btn btn-sm btn-primary" onclick="checkDate()">작업 시작</div>
													</c:if>

													<c:if test="${request.statusNo == 8}">
														<input type="date" class="date-form control" name="userTestExpectDate" value="<fmt:formatDate value='${requestProcess.userTestExpectDate}' pattern='yyyy-MM-dd'/>" readonly>
													</c:if>
													<small id="noInputDate" style="color : red;"></small>						
												</div>
											</div>
	                	 				</form>
										<form role="form" id="writeform" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}">
											<!-- 임시 저장 글 status_no -->
											<input type="hidden" name="nextStatus" value="17"/>
											<div class="form-group d-flex">
												<div class="label label-write">품질 검토 사항</div>
												<div class="flex-grow-1">
													<textarea rows="3" class="form-control boxed flex-grow-1" name="reply" id="reply">${userTesterTemp.reply}</textarea>
													<div class="d-flex justify-content-end">
														<small class=" mr-5" id="counter">(0 / 300)</small>
													</div>
												</div>
											</div>
											
											<div class="filebox d-flex mb-3">
												<div class="label label-write" id="fileLable">
													<div>첨부파일</div>
													<div class="btn btn-sm btn-info" id="btn-upload">파일 추가</div>
													<input type="file" name="files" id="fileInput" multiple style="display: none;">
												</div>
												<div class="border flex-grow-1 border-success" id="file-list"></div>	
											</div>
											<c:if test="${request.statusNo == 8}">
												<div class="d-flex justify-content-end">
													<button class="btn btn-warning btn-md mx-3"  formaction="${pageContext.request.contextPath}/tempstore">임시 저장</button>
													<button class="btn btn-primary btn-md " formaction="${pageContext.request.contextPath}/endwork">개발 완료</button>
												</div>
											</c:if>
										</form>				
	                	 			</div>
                	 			</div>
                	 		</div>
                	 	</section><!-- 품질검토 내역 입력폼 end -->
                	 	</c:if>
                	 	
                	 	<c:if test="${userTesterToDistributorHistories != null}">
               	 		<div class="d-flex justify-content-center mt-4"> <!-- 히스토리 버튼 start -->
               	 			<div class="btn btn-primary-outline history-button" onclick="openHistories()">
               	 				품질 검토 내역 보기  <i class="fas fa-history"></i>
               	 			</div>
               	 		</div> <!-- 히스토리 버튼 end -->
                	 	</c:if>
               	 		
               	 		<!-- 품질 검토 내역 start-->
                	 	<section id="histories" > 
                	 		<div class="title-block">
	                	 		<h3 class="title">품질 검토 내역</h3>
	                	 	</div>
	                	 	<c:forEach var="statusHistory" varStatus="index" items="${userTesterToDistributorHistories}">
                	 		<div class="card border-top-primary my-3"> <!-- foreach한다면 여기부터 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<h3 class="title">
	                	 					 ${index.count}차 내역  <i class="far fa-bookmark success"></i>
	                	 				</h3>
	                	 			</div>
	                	 			<form method="post" action="<c:url value='/updatehistory'/>">
	                	 				<div class="card-body">
	                	 					<div>
	                	 						<div class="row">
	                	 							<div class="col-5 p-2">
			                	 						<span class="label">작성자</span>
			                	 						<span class="p-2">${statusHistory.writer}</span>
	                	 							</div>
	                	 							<div class="col-5 p-2">
			                	 						<span class="label">품질검토 완료일</span>
			                	 						<span class="p-2"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></span>
		                	 						</div>
	                	 						</div>
	                	 						<div class="row">
	                	 							<c:if test="${requestProcess.userTester != member.mid}">
	                	 								<span class="label" style="text-align :left; width: 10%;">검토 내용</span>
		                	 							<textarea rows="2" class="form-control boxed mr-5" readonly>${statusHistory.reply}</textarea>
	                	 							</c:if>
                	 								<c:if test="${requestProcess.userTester == member.mid}">
                	 									<c:if test="${request.statusNo == 9}">
	                	 									<input type="hidden" name="rno" value="${request.rno}"/>
		                	 								<input type="hidden" name="hno" value="${statusHistory.hno}"/>
	                	 									<span class="label" style="text-align :left; width: 10%;">검토 내용</span>
		                	 								<textarea rows="2" class="form-control boxed mr-5" name="reply">${statusHistory.reply}</textarea>
	                	 								</c:if>
	                	 								<c:if test="${request.statusNo != 9}">
	                	 									<span class="label" style="text-align :left; width: 10%;">검토 내용</span>
		                	 								<textarea rows="2" class="form-control boxed mr-5" readonly>${statusHistory.reply}</textarea>
	                	 								</c:if>
	                	 							</c:if>
	                	 						</div>
	                	 						<div class="row mt-3">
		                	 						<span class="label" style="text-align :left; width: 10%;">첨부파일</span>
		                	 						<div>
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
	                	 						<c:if test="${request.statusNo == 9 && requestProcess.userTester == member.mid}">
	                	 							<button type="submit" class="btn btn-primary btn-md mx-3">수정</button>	
	                	 						</c:if>	
	                	 					</div>
	                	 				</div>
                	 				</form>
                	 			</div>
                	 		
                	 		</div><!-- foreach한다면 여기부터 end -->
                	 		</c:forEach>
                	 		
                	 		<c:if test="${userTesterToDistributorHistories[0].reply == null}">
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
                	 		
                	 	</section> 
                	 	<!-- 품질 검토 내역 end-->
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
	<script>

	function checkDate(){
		$('#noInputDate').text("");
		console.log("startWork 실행");
		if($('#userTestExpectDate').val() == ""){
			$('#noInputDate').text("날짜를 입력해주세요.");
			return;
		}
		
		let today = new Date().getTime();   
		var userTestExpectDate = new Date($('#userTestExpectDate').val()).getTime();
		
		//오늘보다 이전 날짜를 입력할 경우
		if(today > userTestExpectDate){
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
	
	/* 파일 */
	$(document).ready(function() {
	    $(".file-delete").on("click", function(e) {
	        e.preventDefault();
	        deleteFile($(this));
	    });
	})
	 function addFile() {
        var str = "<div class='file-group'><input type='file' name='files'><a href='#this' name='file-delete'>x</a></div>";
        $("#file-list").append(str);
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    }
 
    function deleteFile(obj) {
        obj.parent().remove();
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
   	/****** 업로드된 파일 리스트 출력하기 *****/
	$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
	{
		$("#fileInput").on("change", fileCheck);
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
	</script>
</body>

</html>
