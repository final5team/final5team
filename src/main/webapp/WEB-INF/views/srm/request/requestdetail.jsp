<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>
<script>tinymce.init({forced_root_block : "",selector:'textarea'});</script>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/requestdetail.css" rel="stylesheet">
<style>
</style>
</head>
<style>

</style>
<!-- 글자수 입력 확인 -->
<div class="modal fade" id="checkModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5>
					주의 <i class="fas fa-exclamation-triangle"></i>
				</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body" style="display: flex; justify-content: center;">
				<p id="content"></p>
			</div>
			<div class="modal-footer" style="justify-content: center;">
				<a class="btn btn-primary" data-dismiss="modal" type="button" id="modal-button">확인</a>
			</div>
		</div>
	</div>
</div>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/topbar.jsp"%>
				<!-- End of Topbar -->

				<!-- 여기에 내용 담기 start -->
				<div class="container">
					<div id="main">
						<!-- id=main div start -->
						<div class="title-block">
							<h3 class="title">요청 조회</h3>
						</div>
						<!-- 여기에 단계 상태 이력 넣기 -->
						<div>
							 <%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
						</div>
						<!-- 여기에 단계 상태 이력 넣기 /-->
						<!-- 요청정보 조회 START-->
						<section id="requestDetailForm">
							<div class="card border-top-dark sameheight-item">
								<div class="card-block"> <!-- card-block  -->
									<div class="card-title-block">
	                	 				<h3 class="title">
		                	 				요청번호 No. ${request.rno}
	                	 				</h3>
	                	 			</div>
	                	 			<div class="card-body">
										<div class="row mt-3">
											<div class="col-3 label">요청자</div>
											<div class="col-2">${request.rname}</div>
											<div class="col-3 label">소속 기관</div>
											<div class="col-2">${request.rorgan}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">직급</div>
											<div class="col-2">${request.rposition}</div>
											<div class="col-3 label">전화번호</div>
											<div class="col-2">${request.rorgan}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">이메일</div>
											<div class="col-8">${request.remail}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">요청일</div>
											<div class="col-2"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
											<div class="col-3 label">완료 희망일 </div>
											<div class="col-2"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">시스템</div>
											<div class="col-8">${request.systemName}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">제목</div>
											<div class="col-8">${request.reqTitle}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">내용</div>
											<div class="col-8 border p-2 scroller">${request.reqContent}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">요청 첨부파일</div>
											<div class="col-7">
												<c:forEach var="statusHistoryFile" items="${request.fileList}">
													<div>
														<span>${statusHistoryFile.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
															<i class="fas fa-cloud-download-alt text-info"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</div>	
										<c:if test="${request.statusNo == 1 && member.mid == request.client}">
										<div class="d-flex justify-content-end">
											<button type="button" class="btn btn-md btn-primary" onclick="showUpdateForm()">수정</button>	
										</div>
										</c:if>								
	                	 			</div>
								</div> <!-- card-block / -->
							</div>				
						</section>
						<!-- 요청정보 조회 END-->
						<!-- 요청정보 수정 START-->
						<section id="requestUpdateForm" style="display:none;"> 
							<div class="card border-top-dark mb-3">
								<div class="card-block js">
									<div class="card-title-block">
										<h3 class="title">
											요청 내역 조회 <i class="fas fa-edit"></i>
										</h3>
									</div>
									
									<div class="card-body">
										<form method="post" id="updateForm" action="${pageContext.request.contextPath}/customer/requestupdate" enctype="multipart/form-data">
											<article class="label js item">
												<h6>작성자</h6>
												<h6>전화번호</h6>
												<h6>직급</h6>
												<h6>시스템</h6>
												<small id="noInputSno" style="color : red; position: absolute; left:35%; bottom:1%"></small>
											</article>
											<article class="inputData">
												<div class="item">
													<input type="text" class="form-control form-control-user" placeholder="${request.rname}" value="${request.rname}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user"  placeholder="${request.rphone}" value="${request.rphone}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user"  placeholder="${request.rposition}" value="${request.rposition}" readonly>
												</div>
												
												<div class="item">
													<div class="select-group">
														<select class="custom-select" id="sno" name="sno">
															<option value="">시스템 선택</option>
															<c:forEach var="system" items="${systemList}">
																<option <c:if test="${request.sno == system.sno}">selected</c:if> value="${system.sno}">${system.systemName}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</article>
											<article class="label2">
												<h6>소속기관</h6>
												<h6>이메일</h6>
												<h6>완료 희망 일자</h6>
												<small id="noInputReqExpectDate" style="color : red;  position: absolute; left:10%; top:85%"></small>
											</article>
											<article class="inputData2">
												<div class="item">
													<input type="text" class="form-control form-control-user"  placeholder="${request.rorgan}" value="${request.rorgan}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user"  placeholder="${request.remail}" value="${request.remail}" readonly>
												</div>
												<div class="item">
													<input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate" value="<fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd" />">
												</div>
											</article>
											<article class="titleLabel">
												<h6>제목</h6>
												<small id="noInputReqTitle" style="color : red; position: absolute;  top:60%"></small>
											</article>
											<article class="titleInput">
												<div class="item">
													<input type="text" id="reqTitle" name="reqTitle" placeholder="제목" value="${request.reqTitle}">
												</div>
											</article>
											<article class="titleBody">
												<h6>내용</h6>
												<small id="noInputReqContent" style="color : red; position: absolute; bottom:5%"></small>
											</article>
											<article class="bodyInput">
												<div class="item">
													<textarea id="reqContent" name="reqContent">${request.reqContent}</textarea>
												</div>
											</article>
											<article class="fileBody">
	                	 							<div class="label" style="text-align:start;">첨부파일</div>
	                	 							<div class="default_file">
	                	 								<c:forEach var="file" items="${request.fileList}">
															<div>
																<span>${file.fileName}</span>
																<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${file.fno}" role="button">
																	<i class="fas fa-cloud-download-alt text-info" style="cursor:pointer;"></i>
																</a>
																<a class="deletefileButton"><i class="fas fa-times ml-1" style="cursor:pointer;"></i></a>
																<input type="hidden" name = "fno" value="${file.fno}">
															</div>
														</c:forEach>
														<div class="border flex-grow-1 write_adjust" id="file-list" style="min-height:50px; width : 720px;"></div>
													</div>
											</article>
											
											<div class="label-write_adjust" id="fileLable" >
												<div class="btn btn-sm btn-info" id="btn-upload-update" style="margin-left:5px;">파일 수정</div>
												<input type="file" name="mulfiles" id="fileInputUpdate" multiple style="display: none;">
											</div>
													
											<article class="submit-button">
												<button class="btn btn-dark btn-md" type="button" onclick="updateRequest()">수정</button>
											</article>
											<article class="return-button">
													<button type="button" class="btn btn-md btn-primary" onclick="hideUpdateForm()">취소</button>
											</article>
											<input type="hidden" value="${request.rno}" id="rno" name ="rno">
										</form> 
									</div>
								</div>
							</div>
						</section>
						<!-- 요청정보 수정 START-->
						
						<c:if test="${member.mtype == 'user'}">
							<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'">목록</button>
						</c:if>
						<c:if test="${member.mtype != 'user'}">
							<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
						</c:if>
					</div>
				</div>
				<!-- 여기에 내용 담기 end -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	
	<script>
	/******* 글자수 유효성 검사 *******/
	function checkReplyLength(){
		//글자
		var reply = tinymce.activeEditor.getContent();
		/* var reply = reply; */
		//1.태그가 없는 경우(글자 없음)
		if(reply.length == 0){
			console.log("내용 없음");
			$('#content').text('내용을 입력해주세요.');
			$('#checkModal').modal();
			return false;
		} else{
			//2.태그가 있는 경우(글자 있음)
			//태그들 제거해서 순수 글자수 빼오기
			var realReply = reply.replace(/<[^>]*>?/g, '');
			
			//순수 글자수가 300이 넘는지 확인
			if(realReply.length>300){
			//1. 글자수 300이 넘을 경우
				console.log("300자 초과");
				$('#content').text('300자를 초과하였습니다.');
				$('#checkModal').modal();
				return false;
			} else{
				//2. 글자수 0보다 크며 300안일 경우(정상)
				console.log("정상");
				return true;
			}
			
		}
	}
	
	/******* 제목 30자 이하 유효성 검사 *******/
	let titleLength = '';
	$('#reqTitle').keyup(function(e) {
		let content = $(this).val();
		$('#counterTitle').html("(" + content.length + " / 30)");
		
		if (content.length > 30) {
			$('#content').html("최대 30자까지 입니다.");
			$('#checkModal').modal();
			$(this).val(content.substring(0, 30));
			$('#counterTitle').html("(30 / 30)");
		}
	});
	// 요청 수정 
	function updateRequest(){
		$('#noInputSno').text("");
 		$('#noInputReqExpectDate').text("");
 		$('#noInputReqTitle').text("");
 		$('#noInputReqContent').text("");
 		// 유효한 입력 내용
		var result = true;			
		// 의견 내용 길이가 300자 이상일 경우 제출 불가
		if(!checkReplyLength()){
			result = false;
		}
		var content=tinymce.activeEditor.getContent().length;
		console.log(content);
		// 작성내용 미입력 시 
		if(content == 0){
			$('#noInputReqContent').text("작성 내용 입력");
			result = false;
		}

		if($('#sno').val()==""){
			$('#noInputSno').text("시스템 선택");
			result = false;
		}

		if($('#reqExpectDate').val()==""){
			$('#noInputReqExpectDate').text("요청 희망일 입력");
			result = false;
		}


		if($('#reqTitle').val()==""){
			$('#noInputReqTitle').text("제목 입력");
			result = false;
		}	
		if(result){
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
	}
		
	/****** 업로드된 파일 리스트 출력하기 *****/
	/* '파일추가' 버튼 누를 때마다 파일input 실행 */
	$(function () {
	    $('#btn-upload-update').click(function (e) {
	        e.preventDefault();
	        $('#fileInputUpdate').click();
	    });
	    $("#fileInputUpdate").on("change", fileCheck);
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
	    	$('#checkModal').modal();
	    	$('#content').html('파일은 최대 '+totalCount+ '개까지 업로드 할 수 있습니다.')
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
	
	// 작성 파일 삭제 함수
	function fileDelete(fileId){
	    var fileNum = fileId.replace("file", "");
	    content_files[fileNum].is_delete = true;
		$('#' + fileId).remove();
		fileCount--;
	}
	 	
	/***************** 기존 파일 삭제 *****************/
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
	
	function showUpdateForm(){
		$('#requestDetailForm').hide();
		$('#requestUpdateForm').show();
	}
	function hideUpdateForm(){
		$('#requestDetailForm').show();
		$('#requestUpdateForm').hide();
	}
	</script>
</body>

</html>