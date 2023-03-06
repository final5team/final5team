<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
<style>
</style>
</head>
<style>
a {
	text-decoration: none;
}

.card-block {
	height: 600px;
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
	margin-bottom: 10px;
	border: none;
	background-color: white;
}

.card-body .inputData input {
	height: 20px;
	width: 200px;
	font-size: 13px;
	margin-bottom: 10px;
	border: none;
	background-color: white;
}

.card-body .titleLabel {
	position: absolute;
	width: 50px;
	left: 8%;
	top: 48%;
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
	top: 48%;
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
	top: 57%;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.card-body .bodyInput {
	position: absolute;
	width: 800px;
	left: 18%;
	top: 57%;
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
	top: 75%;
	overflow: hidden;
	text-align: center;
	font-size: 15px;
	font: bold;
}

.card-body .fileBody {
	position: absolute;
	width: 700px;
	left: 18%;
	top: 75%;
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
	top: 90%;
}

.card-body .return-button {
	position: absolute;
	width: 80px;
	height: 50px;
	left: 55%;
	top: 90%;
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

.titleConfirm {
	width: 100px;
	position: absolute;
	left: 83%;
}

.textConfirm {
	width: 100px;
	position: absolute;
	left: 83%;
}

.section2 .fileTitle {
	position: absolute;
	width: 80px;
	left: 8%;
	top: 63%;
	overflow: hidden;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.section2 .fileBody {
	position: absolute;
	width: 590px;
	left: 18%;
	height: 200px;
	top: 63%;
	overflow: hidden;
	text-align: start;
	font-size: 15px;
	font: bold;
}

.upload_name {
	position: absolute;
	left: 15%;
	z-index: 2;
	display: inline-block;
	height: 80px;
	width: 495px;
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
	height: 100px;
	top: 20%;
	border-radius: 5px;
	z-index : 5;
}
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
						<div>
							<!-- 여기에 단계 상태 이력 넣기 -->
							<%@ include file="/WEB-INF/views/srm/request/stepperprogress.jsp"%>
						</div>

						<!-- 여기에 단계 상태 이력 넣기 /-->
						<section>
							<!-- 개발내역 입력폼 start -->
							<div class="card border-top-dark">
								<div class="card-block">
									<div class="card-title-block">
										<h3 class="title">
											요청 내역 조회 <i class="fas fa-edit"></i>
										</h3>
									</div>
									<div class="card-body">
										<form method="post" action="${pageContext.request.contextPath}/customer/requestupdate" >
											<article class="label item">
												<h6>작성자</h6>
												<h6>전화번호</h6>
												<h6>직급</h6>
												<h6>시스템</h6>
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
													<input type="text" class="form-control form-control-user" id="organ" name="organ" placeholder="${sessionScope.member.organ}" value="${sessionScope.member.organ}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="${sessionScope.member.email}" value="${sessionScope.member.email}" readonly>
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
											<article class="fileTitle">
												<h6>파일첨부</h6>
											</article>
											<article class="fileBody">
												<div class="file-item">
													<div class="upload_name" id="exist_file" >
														<c:forEach var="file" items="${request.fileList}">
											    			<div>
												    			<a href="${pageContext.request.contextPath}/customer/requestdetail/filedownload/${file.fno}">${file.fileName}</a>
											    			</div>
											    		</c:forEach>
													</div>
													<div class="filebox">
														<input multiple="multiple" type="file" id="mfile" name="mfile[]"/>
														<label for="mfile">파일찾기</label> 
													</div>
												</div>
											</article>

											<article class="submit-button">
											<!-- 승인이 아닌경우 수정 가능하도록 변경 c:if 사용 -->
												<button class="btn btn-dark btn-sm" type="submit">수정</button>
												
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
		/* 파일 버튼 변경*/
		$(document).ready(function() {
			$(".file-delete").on("click", function(e) {
				e.preventDefault();
				deleteFile($(this));
			});
		})
		//파일 업로드 제약 자바스크립트
		let mfile = document.querySelector('#mfile');
		mfile.addEventListener('change', function() {
			// 파일 업로드 개수 제한 (3) 
			if(mfile.files.length >3 ){
				alert("파일 업로드 개수는 최대 3개입니다.");
				mfile.value='';
				return false;
			} else {
				// 파일 이름 출력 
				let fileList ='';
				for(i=0; i< mfile.files.length; i++){
					fileList += mfile.files[i].name + '<br>'
					console.log(fileList);
				}
				let inputtag = document.querySelector('#exist_file');
				inputtag.innerHTML = fileList;
			}
		});
		
	</script>
</body>

</html>