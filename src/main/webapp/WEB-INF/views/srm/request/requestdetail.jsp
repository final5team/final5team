<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/requestdetail.css" rel="stylesheet">
<style>
</style>
</head>
<style>

</style>
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
						<c:if test="${request.statusNo == 1}">
							<c:if test="${request.rname == member.mname}">
								<section> <!-- 개발내역 입력폼 start -->
									<div class="card border-top-dark mb-3">
										<div class="card-block js">
											<div class="card-title-block">
												<h3 class="title">
													요청 내역 조회 <i class="fas fa-edit"></i>
												</h3>
											</div>
											
											<div class="card-body">
												<form method="post" action="${pageContext.request.contextPath}/customer/requestupdate" enctype="multipart/form-data">
													<article class="label js item">
														<h6>작성자</h6>
														<h6>전화번호</h6>
														<h6>직급</h6>
														<h6>시스템</h6>
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
																<select class="custom-select" id="sno" name="sno" required>
																	<option selected value="${request.sno}">${request.systemName}</option>
																	<c:forEach var="system" items="${systemList}">
																		<option value="${system.sno}">${system.systemName}</option>
																	</c:forEach>
																</select>
															</div>
														</div>
													</article>
													<article class="label2">
														<h6>소속기관</h6>
														<h6>이메일</h6>
														<h6>완료 희망 일자</h6>
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
													</article>
													<article class="titleInput">
														<div class="item">
															<input type="text" id="reqTitle" name="reqTitle" placeholder="제목" value="${request.reqTitle}">
														</div>
													</article>
													<article class="titleBody">
														<h6>내용</h6>
													</article>
													<article class="bodyInput">
														<div class="item">
															<textarea id="reqContent" cols="30" name="reqContent" placeholder="내용">${request.reqContent}</textarea>
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
																<div class="border flex-grow-1 border-success write_adjust" id="file-list-update_adjust" style="min-height:50px; width : 720px; " ></div>
															</div>
													</article>
													
														<div class="label-write_adjust" id="fileLable" >
															<div class="btn btn-sm btn-info" id="btn-upload-update-adjust" onclick="fileAjax()">파일 수정</div>
															<input type="file" name="filesInput" id="fileInputUpdate-adjust" multiple style="display: none;">
														</div>
															
														
													<article class="submit-button">
														<button class="btn btn-dark btn-sm" type="button" onclick="updateRequest()">수정</button>
														
													</article>
													<article class="return-button">
														<button class="btn btn-dark btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">취소</button>
													</article>
													<input type="hidden" value="${request.rno}" id="rno" name ="rno">
												</form> 
											</div>
										</div>
									</div>
								</section>
							</c:if>
							<c:if test="${request.rname != member.mname}">
								<section>
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
													<textarea class="col-7 form-control boxed mr-5" rows="3" readonly>${request.reqContent}</textarea>
												</div>
												<hr/>
												<div class="row">
													<div class="col-3 label">요청 첨부파일</div>
													<div class="col-7">
														<c:forEach var="statusHistoryFile" items="${request.fileList}">
															<div>
																<span>${statusHistoryFile.fileName}</span>
																<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																	<i class="fas fa-cloud-download-alt"></i>
																</a>
															</div>
														</c:forEach>
													</div>
												</div>										
			                	 			</div>
										</div> <!-- card-block / -->
									</div>				
								</section>
							</c:if>
						</c:if>
						<c:if test="${request.statusNo != 1}">
						<section>
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
											<textarea class="col-7 form-control boxed mr-5" rows="3" readonly>${request.reqContent}</textarea>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">요청 첨부파일</div>
											<div class="col-7">
												<c:forEach var="statusHistoryFile" items="${request.fileList}">
													<div>
														<span>${statusHistoryFile.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</div>										
	                	 			</div>
								</div> <!-- card-block / -->
							</div>				
						</section>
						</c:if>
						<c:if test="${member.mtype == 'user'}">
							<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'">목록</button>
						</c:if>
						<c:if test="${member.mtype != 'user'}">
							<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
						</c:if>
					</div><!-- id=main div / -->
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
	<script>
	// 요청 수정 ajax
	function updateRequest(){
		
		let rno = document.querySelector('#rno').value;
		let snoValue = document.querySelector('#sno');
		let sno = snoValue.options[snoValue.selectedIndex].value;
		let reqExpectDate = document.querySelector('#reqExpectDate').value;
		let reqTitle = document.querySelector('#reqTitle').value;
		let reqContent = tinymce.activeEditor.getContent();
		
		data = {rno : rno , sno : sno, reqExpectDate : reqExpectDate, reqTitle, reqContent};	
		
			$.ajax({
				url : "requestupdate",
				method : "post",
				data : JSON.stringify(data),
				contentType: "application/json; charset=UTF-8",
				success : function (data){
					location.reload();
				}
				
			});
		
		};
	// 파일 추가 ajax
	function fileAjax(){
			
		let filesInput = document.querySelector('#filesInput');
			console.log(filesInput);
			filesInput.onclick();
		
		
		
	}
	
	
	
	
	
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
		       		+ '<a onclick ="fileDelete(\'file' + fileNum + '\')">'+'<i class="fas fa-times ml-1 text-success" style="cursor:pointer;"></i></a>' 
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