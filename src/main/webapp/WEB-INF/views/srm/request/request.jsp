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
	height : 600px;
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
	top: 80%;
}

.card-body .return-button {
	position: absolute;
	width: 80px;
	height: 50px;
	left: 55%;
	top: 80%;
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
							<h3 class="title">요청 작성</h3>
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
											요청 내역 작성 <i class="fas fa-edit"></i>
										</h3>
									</div>
									<div class="card-body">
										<form method="post" action="${pageContext.request.contextPath}/customer/request" enctype="multipart/form-data">
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
													<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="${sessionScope.member.phone}" value="${sessionScope.member.phone}" readonly> 
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="position" name="position" placeholder="${sessionScope.member.position}" value="${sessionScope.member.position}" readonly> 
												</div>
												<div class="item">
													<div class="select-group">
														<select class="custom-select" id="sno" name="sno" required>
															<option selected value="0">전체</option>
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
													<input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate" required>
												</div>
											</article>
											<article class="titleLabel">
												<h6>제목</h6>
											</article>
											<article class="titleInput">
												<div class="item">
													<input type="text" id="reqTitle" name="reqTitle" placeholder="제목" required>
													<div class="titleConfirm">
														<small class=" mr-5" id="counterTitle">(0 / 30)</small>
													</div>
												</div>
											</article>
											<article class="titleBody">
												<h6>내용</h6>
											</article>
											<article class="bodyInput">
												<div class="item">
													<textarea id="reqContent" cols="30" name="reqContent" placeholder="내용" required></textarea>
													<div class="textConfirm">
														<small class=" mr-5" id="counterContent">(0 / 300)</small>
													</div>
												</div>
											</article>
											<article class="fileTitle">
												<h6>파일첨부</h6>
											</article>
											<article class="fileBody">
												<div class="item">
													<input class="btn btn-dark btn-sm" multiple="multiple" type="file" id="mfile" name="mfile[]" />
												</div>
											</article>

											<article class="submit-button">
												<button class="btn btn-dark btn-sm" type="submit">작성</button>
											</article>
											<article class="return-button">
												<button class="btn btn-dark btn-sm" onclick="javascript:history.go(-1)">취소</button>
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
		/* 파일 */
		$(document).ready(function() {
			$(".file-delete").on("click", function(e) {
				e.preventDefault();
				deleteFile($(this));
			});
		})

		$('#reqContent').keyup(function(e) {
			let content = $(this).val();
			$('#counterContent').html("(" + content.length + " / 300)");
			if (content.length > 100) {
				$('#countCheck').modal();
				$('#counterContent').html("최대 300자까지 입니다.");
				$(this).val(content.substring(0, 300));
				$('#counter').html("(300 / 300)");
			}
		});
		$('#reqTitle').keyup(function(e) {
			let content = $(this).val();
			$('#counterTitle').html("(" + content.length + " / 30)");
			console.log(content.length);
			
			if (content.length > 30) {
				$('#countCheck').modal();
				$('#countContent').html("최대 30자까지 입니다.");
				$(this).val(content.substring(0, 30));
				$('#counterTitle').html("(30 / 30)");
			}
		});

		function openRegister() {

		}
	</script>
</body>

</html>