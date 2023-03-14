<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>    
<style>
</style>
</head>
<style>
a {
	text-decoration: none;
}
.card-block {
	height: 800px;
}
.card-body .label {
	position: absolute;
	width: 110px;
	left: 2%;
	top: 15%;
	overflow: hidden;
	text-align: center;
	margin-bottom: 24px;
}

.card-body h6 {
	margin-top: 3px;
	margin-bottom: 24px;
	font-weight: 600;
    font-size: 1.0rem;
}

.card-body .inputData {
	position: absolute;
	width: 250px;
	height: 200px;
	left: 18%;
	top: 15%;
	overflow: hidden;
	text-align: start;
}

.card-body .label2 {
	position: absolute;
	width: 110px;
	left: 57%;
	top: 15%;
	overflow: hidden;
	text-align: center;
	margin-bottom: 24px;
}

.card-body .inputData2 {
	position: absolute;
	width: 250px;
	height: 200px;
	left: 70%;
	top: 15%;
	overflow: hidden;
	text-align: start;
}

.card-body .inputData2 input {
	height: 20px;
	width: 200px;
	font-size: 13px;
	margin-bottom : 10px;
}

.card-body .inputData input {
	height: 20px;
	width: 200px;
	font-size: 13px;
	margin-bottom : 10px;
}

.card-body .titleLabel {
	position: absolute;
	width: 50px;
	left: 8%;
	top: 36.5%;
	overflow: hidden;
	text-align: start;
	font-size: 15px;
}

.card-body .titleLabel h6 {
	font: bold;
}

.card-body .titleInput {
	position: absolute;
	width: 800px;
	left: 18%;
	top: 36.5%;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.card-body .titleInput input {
	width: 710px;
	height: 25px;
}

.card-body .titleBody {
	position: absolute;
	width: 300px;
	left: 8%;
	top: 44%;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.card-body .bodyInput {
	position: absolute;
	width: 800px;
	left: 18%;
	top: 44%;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.card-body .bodyInput textarea {
	width: 710px;
	font-size: 15px;
	font: bold;
	height: 100px;
	resize: none;
}

.card-body .fileTitle {
	position: absolute;
	width: 110px;
	left: 4%;
	top: 77%;
	overflow: hidden;
	text-align: center;
	font-size: 15px;
	font: bold;
}

.card-body .fileBody {
	position: absolute;
	width: 800px;
	left: 18%;
	top: 77%;
	overflow: hidden;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.card-body .submit-button {
	position: absolute;
	width: 80px;
	height: 50px;
	left: 50%;
	top: 92%;
}

.card-body .return-button {
	position: absolute;
	width: 80px;
	height: 50px;
	left: 55%;
	top: 92%;
}

.card-body .item .select-group select {
	width: 200px;
	height: 35px;
	font-size: 13px;
	padding-top: 0;
	padding-bottom: 0;
}

.card-body .include {
	position: absolute;
	width: 240px;
	height: 500px;
	left: 76%;
	top: 15%;
	z-index: 5;
	width: 240px;
	height: 500px;
	left: 76%;
	top: 15%;
}

[type="text"]:focus::placeholder {
	visibility: hidden;
}

textarea:focus::placeholder {
	visibility: hidden;
}
.titleConfirm{
	width : 100px;
	position : absolute;
	left : 83%;
}
.textConfirm{
	width : 100px;
	position : absolute;
	left : 83%;
}

.upload_name {
	position: absolute;
	left: 15%;
	z-index: 2;
	display: inline-block;
	height: 120px;
	width: 595px;
	vertical-align: middle;
	border: 1px solid #d1d3e2;
	border-radius: 5px;
	color: #999999;
}

.filebox label {
	position: absolute;
	left: -1%;
	display: inline-block;
	padding: 5px 5px;
	color: #fff;
	vertical-align: middle;
	background-color: #999999;
	border-radius: 5px;
	cursor: pointer;
	height: 20px;
	margin-left: 10px;
}

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

.file-item {
	width: 400px;
	height: 190px;
	top: 20%;
	border-radius: 5px;
	z-index : 5;
}
#counterContent{
	position : absolute;
	left : 81%;
	
}


</style>
<!-- 체크 모달 -->
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
				<a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
			</div>
		</div>
	</div>
</div>
<!-- 체크 모달 /-->
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
							<h3 class="title">요청 작성</h3>
						</div>
						<div>
							<!-- 여기에 단계 상태 이력 넣기 -->
							<%@ include file="/WEB-INF/views/srm/request/requestdefaultstepper.jsp" %>
						</div>
						
						<!-- 여기에 단계 상태 이력 넣기 /-->
						<section>
							<!-- 개발내역 입력폼 start -->
							<div class="card border-top-dark">
								<div class="card-block">
									<div class="card-title-block">
										<h3 class="title">
											요청 내역 작성 <i class="fas fa-edit"></i>
										</h3>
									</div>
									<div class="card-body">
										<form method="post" id="writeform" action="${pageContext.request.contextPath}/customer/request" enctype="multipart/form-data">
											<article class="label item">
												<h6>작성자</h6>
												<h6>전화번호</h6>
												<h6>직급</h6>
												<h6>시스템</h6>
												<small id="noInputSno" style="color : red; position: absolute; left:35%; bottom:1%"></small>
											</article>
											<article class="inputData">
												<div class="item">
													<input type="text" class="form-control form-control-user" id="clientName" name="clientName" placeholder="${sessionScope.member.mname}" value="${sessionScope.member.mname}" readonly> 
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="${member.phone}" value="${member.phone}" readonly> 
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="position" name="position" placeholder="${sessionScope.member.position}" value="${sessionScope.member.position}" readonly> 
												</div>
												<div class="item">
													<div class="select-group">
														<select class="custom-select" id="sno" name="sno">
															<option selected value="">시스템 선택</option>
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
												<small id="noInputReqExpectDate" style="color : red;  position: absolute; left:10%; top:85%"></small>
											</article>
											<article class="inputData2">
												<div class="item">
													<input type="text" class="form-control form-control-user" id="organ" name="organ" placeholder="${sessionScope.member.organ}" value="${sessionScope.member.organ}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="${sessionScope.member.email}" value="${sessionScope.member.email}" readonly> 
												</div>
												<div class="item">
													<input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate">
												</div>
											</article>
											<article class="titleLabel">
												<h6>제목</h6>
												<small id="noInputReqTitle" style="color : red; position: absolute;  top:60%"></small>
											</article>
											<article class="titleInput">
												<div class="item">
													<input type="text" id="reqTitle" name="reqTitle" placeholder="제목" maxlength='30'>
													<div class="titleConfirm">
														<small class=" mr-5" style="font-size : 13px;" id="counterTitle">(0 / 30)</small>
													</div>
												</div>
											</article>
											<article class="titleBody">
												<h6>내용</h6>
												<small id="noInputReqContent" style="color : red; position: absolute; bottom:5%"></small>
											</article>
											<article class="bodyInput">
												<div class="item">
													<textarea id="reqContent" name="reqContent" placeholder="내용" maxlength='300'></textarea>
												</div>
											</article>
											
											<article class="fileTitle">
												<h6>파일첨부</h6>
											</article>
											
											<article class="fileBody">
												<div class="file-item">
													<div class="upload_name" id="file-list" ></div>
													<div class="filebox">
														<input multiple="multiple" type="file" id="mfile" name="mfile[]"/>
														<label style="background-color : #2c9faf;" for="mfile" id="btn-upload">파일찾기</label> 
													</div>
												</div>
											</article>
											
											<article class="submit-button">
												<button class="btn btn-dark btn-sm" type="button" onclick="requestWrite()">작성</button>
											</article>
											<article class="return-button">
												<button class="btn btn-dark btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'">취소</button>
											</article>
										</form>
									</div>
								</div>
							</div>
						</section>
						<!-- 개발내역 입력폼 end -->
						
						
					</div>
					<!-- id=main div / -->
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
		
		/* let bodyLength = '';
		function checkReplyLength(reply){
			//글자
			var reply = reply;
			//1.태그가 없는 경우(글자 없음)
			if(reply.length == 0){
				console.log("내용 없음");
				$('#countContent').text('내용을 입력해주세요.');
				$('#countCheck').modal();
				return false;
			}
			//2.태그가 있는 경우(글자 있음)
			//태그들 제거해서 순수 글자수 빼오기
			var realReply = reply.replace(/<[^>]*>?/g, '');
			//int 형태로 변환
			let intReply = parseInt(realReply);
			
			//순수 글자수가 300이 넘는지 확인
			if(intReply>300){
			//1. 글자수 300이 넘을 경우
				console.log("300자 초과");
				tinymce.activeEditor.setContent(realReply.substring(0,300));
				return false;
			} else{
				//2. 글자수 0보다 크며 300안일 경우(정상)
				return true;
			}
		} */
		
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
		
	 	function requestWrite() {
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
				var fileInput = $('#mfile')[0];
				var fileBuffer = new DataTransfer();
				fileInput.files = fileBuffer.files;
				
				//input 안에 파일 채우기
				fileBuffer = new DataTransfer();
				for(var i = 0; i < content_files.length; i ++){
					if(!content_files[i].is_delete){
						fileBuffer.items.add(content_files[i]);
					}
				}
				fileInput.files = fileBuffer.files;
			    $('#writeform').submit(); 
			}
		}
	
		
	 	/****** 업로드된 파일 리스트 출력하기 *****/
		/* '파일추가' 버튼 누를 때마다 파일input 실행 */
		$(function () {
		    $('#btn-upload').click(function (e) {
		        e.preventDefault();
		        $('#mfile').click();
		    });
		    $("#mfile").on("change", fileCheck);
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