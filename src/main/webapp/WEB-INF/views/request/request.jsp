<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<style>
.body {
	line-height: 1.5em;
	margin: 0;
	font-weight: 300;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

a {
	text-decoration: none;
}

form {
	width: 700px;
	margin-bottom: 10px;
}
</style>
</head>

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
				<div class="container-fluid">
					<div class="row" style="justify-content: center;">

						<div class="card shadow h-100 py-2">
							<div class="card-header">
								<div>SR 요청 작성</div>
							</div>
							<form method="post">
								<div class="card-body">
									<div class="form-group row">
										<div class="col-sm-6 mb-3 mb-sm-0">
											<div class="row">
												<div>이름</div>
												<input type="text" class="form-control form-control-user" id="clientName" name="clientName" value="default">
											</div>
										</div>
										<div class="col-sm-6 mb-3 mb-sm-0">
											<div class="row">
												<div>전화번호</div>
												<input type="text" class="form-control form-control-user" id="phone" name="phone" value="010-1234-1234">
											</div>
										</div>
									</div>
									<div class="form-group row">
										<div class="col-sm-6 mb-3 mb-sm-0">
											<div class="row">
												<div>직급</div>
												<input type="text" class="form-control form-control-user" id="position" name="position" placeholder="직급" value="직급">
											</div>
										</div>
										<div class="col-sm-6 mb-3 mb-sm-0">
											<div class="row">
												<div>소속기관</div>
												<input type="text" class="form-control form-control-user" id="organ" name="organ" placeholder="소속기관" value="소속기관">
											</div>
										</div>
									</div>
									<div class="form-group row">
										<div class="col-sm-6 mb-3 mb-sm-0">
											<div class="row">
												<div>이메일</div>
												<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="이메일" value="email@oti.com">
											</div>
										</div>
										<div class="col-sm-6 mb-3 mb-sm-0">
											<div class="row">
												<div>요청 완료 희망일</div>
												<input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate">
											</div>
										</div>
									</div>

									<div class="card-header">
										<div>제목</div>
										<input type="text" id="reqTitle" name="reqTitle" value="제목">
									</div>
									<div class="card-body">
										<div class="form-group row">
											<div class="col-sm-6 mb-3 mb-sm-0">
												<div class="row">
													<div>요청내역</div>
													<textarea id="reqContent" name="reqContent"></textarea>
												</div>
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend">
													<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
												</div>
												<div class="custom-file">
													<input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01"> <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
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


</body>

</html>
