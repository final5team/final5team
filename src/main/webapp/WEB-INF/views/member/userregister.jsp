<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<style>
form .text-center {
	margin-bottom: 20px;
}

form .div {
	font-size: 15px;
}

.input-group-text, .custom-select {
	margin-top: 25px;
}

select#gender, label[for="gender"] {
	margin-top: 0px;
}

[name="mtype"] {
	justify-content: center;
}

[name="imageRegister"] {
	margin-top: 10px;
}
</style>
<script>
	function imageRegist(){
		let myInput = document.getElementById('i_file');
		myInput.click();
	}
	
	
</script>

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
				<input type="file" id="i_file" name="file" style="visibility: hidden;" accept="image/*"> 
					<div class="row" style="justify-content: center;">
						<div class="col-lg-7">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">사용자 등록</h1>
							</div>
							<hr>
							<form method="post" action="${pageContext.request.contextPath}/customer/register">
								<div class="text-center">
									<img id="img_file" src="${pageContext.request.contextPath}/resources/img/undraw_profile.svg" style="width: 150px; height: 150px;"> <br>
										<button name="imageRegister" class="btn-dark btn-sm" onclick="imageRegist()">이미지 등록</button>
									<hr>
								</div>
								<div name="mtype" class="form-group row">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="mtype" id="user" value="user">
										<label class="form-check-label" for="user">고객</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="mtype" id="pm" value="pm">
										<label class="form-check-label" for="pm">관리자</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="mtype" id="developer" value="developer"> 
										<label class="form-check-label" for="developer">개발자</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="mtype" id="distributer" value="distributer"> 
										<label class="form-check-label" for="distributer">배포자</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="mtype" id="tester" value="tester"> 
										<label class="form-check-label" for="tester">테스터</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="mtype" id="user_tester" value="user_tester"> 
										<label class="form-check-label" for="user_tester">고객 테스터</label>
									</div>
								</div>
								<hr>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<div>아이디</div>
										<input type="text" class="form-control form-control-user" id="mid" name="mid" placeholder="아이디">
									</div>
									<div class="col-sm-6">
										<div>비밀번호</div>
										<input type="password" class="form-control form-control-user" id="password" name="password" value="1234">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<div>이름</div>
										<input type="text" class="form-control form-control-user" id="mname" name="mname" placeholder="이름">
									</div>
									<div class="col-sm-6">
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<label class="input-group-text" for="sno">시스템 선택</label>
											</div>
											<select class="custom-select" id="sno" name="sno">
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</div>
									</div>

								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="date" class="form-control form-control-user" id="birth" name="birth" placeholder="생년월일">
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0" name="gender">
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<label class="input-group-text" for="gender">성별</label>
											</div>
											<select class="custom-select gender" id="gender" name="gender">
												<option id="man" value="man" selected>남</option>
												<option id="woman" value="woman">여</option>
											</select>
										</div>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="전화번호" value="010-1234-1234">
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="address" name="address" placeholder="주소" value="주소">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<label class="input-group-text" for="position">직급 선택</label>
											</div>
											<select class="custom-select" id="position" name="position">
												<option value="사원">사원</option>
												<option value="대리">대리</option>
												<option value="과장">과장</option>
												<option value="차장">차장</option>
											</select>
										</div>
									</div>
									<div class="col-sm-6 mb-3 mb-sm-0">
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<label class="input-group-text" for="position">소속 기관 선택</label>
											</div>
											<select class="custom-select" id="organ" name="organ">
												<option value="oti">OTI</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</div>
										
									</div>
								</div>
								<hr>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="이메일" value="email@oti.com">
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
