<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
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
						<div class="col-lg-7">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">사용자 등록</h1>
							</div>
							<hr>
							<form class="user" method="post" action="${pageContext.request.contextPath}/customer/register">
								<div class="text-center">
									<img src="${pageContext.request.contextPath}/resources/img/undraw_profile.svg" style="width: 100px; height: 100px;">
									<button class="btn-dark btn-sm">이미지 등록</button>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="mid" name="mid" placeholder="userId">
									</div>
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user" id="password" name="password" value="1234">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="mname" name="mname" placeholder="userName">
									</div>
									<!-- 시스템 목록 선택으로 수정. -->
									<div class="col-sm-6">
										<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
										<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" value="시스템">
											<a href="#none" class="dropdown-item">1번 시스템</a> <a href="#none" class="dropdown-item">2번 시스템</a> <a href="#none" class="dropdown-item">2번 시스템</a>
										</div>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="date" class="form-control form-control-user" id="birth" name="birth" placeholder="생년월일">
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="userGender" id="man" value="option1" checked> <label class="form-check-label" for="exampleRadios2"> 남 </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="userGender" id="woman" value="option2"> <label class="form-check-label" for="exampleRadios2"> 여 </label>
										</div>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="전화번호">
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="address" name="address" placeholder="주소">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="userRank" placeholder="직급">
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="userPart" placeholder="소속기관">
									</div>
								</div>
								<button class="btn btn-dark btn-sm" type="submit">회원 등록</button>
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="${pageContext.request.contextPath}/resources/forgot-password">Forgot Password?</a>
							</div>
							<div class="text-center">
								<a class="small" href="${pageContext.request.contextPath}/resources/login">Already have an account? Login!</a>
							</div>
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
