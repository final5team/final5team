<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/member/userregister_recss.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
</style>

<script>
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
				<div class="container">
					<div id="main">
						<!-- id=main div start -->
						<div class="title-block">
							<h3 class="title">사용자 등록</h3>
						</div>
						<section>
							<!-- 개발내역 입력폼 start -->
							<div class="card border-top-dark">
								<div class="card-block">
									<div class="card-title-block">
										<h3 class="title">
											사용자 등록 <i class="fas fa-edit"></i>
										</h3>
										<h6><i class="fas fa-star-of-life"></i> 초기 비밀번호는 000 입니다.</h6>
									</div>
									<div class="card-body">
										<form method="post" action="${pageContext.request.contextPath}/customer/register" enctype="multipart/form-data" onsubmit="return check()">
											<section class="section2">
												<article class="photo">
													<img id="preview" src="${pageContext.request.contextPath}/resources/img/default-image.gif" 
														onerror = "this.src='${pageContext.request.contextPath}/resources/img/default-image.gif'"/>
													<article class="fileBody">
														<div class="file-item">
															<div class="upload_name" id="exist_file" style="display:none" >FileName</div>
															<div class="filebox">
																<input type="file" id="mfile" name="mfile" accept="image/*" onchange="readURL(this);"/>
																<label for="mfile">사진 등록</label> 
															</div>
														</div>
													</article>
												</article>
												
												<article class="label item">
													<h6>*사용자 구분</h6>
													<h6>*아이디</h6>
													<h6>*이름</h6>
													<h6>*이메일</h6>
													<h6>*생년월일</h6>
													<h6>*우편번호</h6>
												</article>


												<article class="data_one">
													<select class="custom-select" id="mtype" name="mtype" onchange="changeUserType()">
														<option value="user" selected>시스템 사용자(고객)</option>
														<option value="pm">PM</option>
														<option value="developer">개발자</option>
														<option value="distributor">배포담당자</option>
														<option value="tester">테스터</option>
														<option value="usertester">품질테스터</option>
													</select>
														<small class="noTypeInput" style="color : red; position : absolute; top : -20%; left : 100%; z-index:5; width:60px;"></small>	
													<div class="data">
														<div class="item">
															<input type="text" class="form-control form-control-user" id="mid" name="mid" onfocusout="checkId()" maxlength='15' placeholder="아이디" >
															<small class="noIdInput" style="color : red; position : absolute; top : 5%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
														<div class="item">
															<input type="text" class="form-control form-control-user" id="mname" name="mname" placeholder="이름" maxlength='4' >
															<small class="noNameInput" style="color : red; position : absolute; top : 29%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
														<div class="item">
															<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="이메일" maxlength='33' >
															<small class="noEmailInput"  style="color : red; position : absolute; top : 55%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
														<div class="item">
															<input type="date" id="birth" name="birth" class="form-control form-control-user" >
															<small class="noBirthInput"  style="color : red; position : absolute; top : 80%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
													</div>
												</article>

												<article class="label_two item">
													<h6 id="system" style="visibility : hidden;">시스템</h6>
													<h6>*성별</h6>
													<h6>*직급</h6>
													<h6>*소속 회사</h6>
													<h6>*휴대폰 번호</h6>
												</article>

											
												<article class="data_two">
													<div class="input-group">
														<select class="custom-select" id="sno" name="sno" style="visibility : hidden;">
															<option value="0" selected>시스템 선택</option>
															<c:forEach var="system" items="${systemList}">
																<option value="${system.sno}">${system.systemName}</option>
															</c:forEach>
														</select>
														<small class="noSystemInput"  style="color : red; position : absolute; top : 20%; left : 100%; z-index:5; width:60px;"></small>	
													</div>
													<div class="item">
														<div class="input-group">
															<select class="custom-select" id="gender" name="gender" >
																<option value="1">남</option>
																<option value="2">여</option>
															</select>
															<small class="noGenderInput"  style="color : red; position : absolute; top : 20%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
													</div>
													
													<div class="item">
														<div class="input-group">
															<select class="custom-select" id="position" name="position" >
																<option selected value="0">직급 선택</option>
																<option value="사원">사원</option>
																<option value="대리">대리</option>
																<option value="과장">과장</option>
																<option value="차장">차장</option>
															</select>
															<small class="noPositionInput"  style="color : red; position : absolute; top : 20%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
													</div>
													
													<div class="item">
														<div class="input-group">
															<select class="custom-select" id="organ" name="organ" >
																<option selected value="0">소속 기관 선택</option>
																<option value="오티아이">오티아이</option>
																<option value="쇼핑몰">쇼핑몰</option>
																<option value="학사관리">학사관리</option>
															</select>
															<small class="noOrganInput"  style="color : red; position : absolute; top : 19%; left : 100%; z-index:5; width:60px;"></small>	
														</div>
													</div>
													
													<div class="item" style="margin-top: 10px;">
														<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="핸드폰" maxlength='13' >
														<small class="noPhoneInput"  style="color : red; position : absolute; top : 97%; left : 100%; z-index:5; width:60px;"></small>	
													</div>
												</article>
												 
												<article class="address-input">
													<div class="item address1">
														<input type="text" class="form-control form-control-user" id="postcode" name="postcode" maxlength='5' placeholder="우편번호" readonly>
													</div>
													<div class="item address2">
														<input type="text" class="form-control form-control-user" id="addr1" name="addr1" maxlength='35' placeholder="도로명 주소" readonly>
													</div>
													<div class="item address3">
														<input type="text" id="addr2" name="addr2" class="form-control form-control-user"  maxlength='25' placeholder="상세 주소" >
														<small class="noAddressInput"  style="color : red; position : absolute; top : 28%; left : 90%; z-index:5; width:60px;"></small>	
													</div>
													<div class="item address-button">
														<button type="button" class="btn btn-dark btn-sm" id="address" name="address" onclick="findAddress()">우편번호</button>
													</div>
												</article>
												<article class="submit-button">
													<button class="btn btn-dark btn-sm" type="submit">등록</button>
												</article>
												<article class="return-button">
													<c:if test="${sessionScope.member.mtype == 'user'}">
														<button class="btn btn-dark btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/userhome'">취소</button>
													</c:if>
													<c:if test="${sessionScope.member.mtype == 'pm'}">
														<button class="btn btn-dark btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/pmhome'">취소</button>
													</c:if>
													<c:if test="${sessionScope.member.mtype != 'pm' && sessionScope.member.mtype != 'user'}">
														<button class="btn btn-dark btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/'">취소</button>
													</c:if>
													
												</article>
											</section>
											<span id="idconfirm"></span>
										</form>
									</div>
								</div>
							</div>
						</section>
						
						
					</div>
					<!-- id=main div / -->
				</div>
				
				<!-- 여기에 내용 담기 end -->
				<!-- End of Main Content -->

				<!-- Footer -->
				<%@ include file="/WEB-INF/views/common/footer.jsp"%>
				<!-- End of Footer -->
			
			</div>
			<!-- End of Content Wrapper -->
		</div>
		<!-- End of Page Wrapper -->
		<div class="modal fade" id="countCheck" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 id="notice">
							주의 <i class="fas fa-exclamation-triangle"></i>
						</h5>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body" style="display: flex; justify-content: center;">
						<p id="countContent"></p>
					</div>
					<div class="modal-footer" style="justify-content: center;">
						<a class="btn btn-primary" data-dismiss="modal" type="button" id="modal-button">확인</a>
					</div>
				</div>
			</div>
		</div>
		
		
	</div>
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<script>
	
	function findAddress() {
		new daum.Postcode({
			oncomplete : function(data) {
				var addr1 = data.roadAddress; // 도로명 주소
				var addr3 = ''; // 상세 주소

				// 우편번호와 주소 정보 넣기
				document.getElementById("postcode").value = data.zonecode;
				document.getElementById("addr1").value = data.roadAddress;

				if (addr1 !== '') {
					document.getElementById("addr1").value = addr1;
				} else {
					document.getElementById("addr3").value = '';
				}
			}
		}).open();
	}
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview').src = "";
		}
	}

	let selectValue = '';
	function changeUserType() {
		var typeSelect = document.getElementById("mtype");
		selectValue = typeSelect.options[typeSelect.selectedIndex].value;
		if (selectValue !== 'pm' && selectValue !== 'user') {
			$("#sno").css("visibility", "visible");
			$("#system").css("visibility", "visible");
			console.log(selectValue);
		} else {
			$("#sno").css("visibility", "hidden");
			$("#system").css("visibility", "hidden");
			console.log(selectValue);
		}
	}
	
	//이미지 검증
	mfile.addEventListener('change', function() {
		//파일 업로드 제약 자바스크립트
		let mfile = document.querySelector('#mfile');
		let fileList = mfile.files[0].name;
		
		//이미지 파일만 입력받기
		const allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
		if(!allowedExtensions.exec(fileList)){
			alert('jpg, jpeg, png, gif 파일만 업로드할 수 있습니다.');
			mfile.value = '';
			let image = document.querySelector('#preview');
			image.src = '${pageContext.request.contextPath}/resources/img/default-image.gif';
			return false;
		}else{
			// 파일 이름 출력 
			let inputtag = document.querySelector('#exist_file');
			inputtag.innerHTML = fileList;
		}
	});
	

	// 아이디 중복 체크 ajax
	let idTest = '';
	function checkId(){
		let id = $('#mid').val();
		//알파벳 6자 이상 15자 이하
		const idPattern = /^[a-zA-Z0-9]{6,15}$/;
		idTest = idPattern.test(id);
		if(!idTest){
			$('#idconfirm').css('color', 'red');
			$('#idconfirm').html('아이디 형식을 확인해주세요.');
		} else {
			data = {mid : id};	
			$.ajax ({
				url : "/srm/idconfrim",
				method : "post",
				data : JSON.stringify(data),
				contentType: "application/json; charset=UTF-8",
				success : function(result){
					if(result == '0'){
						$('#idconfirm').html('사용 가능한 아이디입니다.');
						$('#idconfirm').css('color', 'blue');
						idTest = 'true';
						/* $('#mid').css('border', '1px solid #ced4da'); */
					} else {
						$('#countCheck').modal();
						$('#countContent').html('아이디 중복');
						$('#idconfirm').html('아이디는 6~15자리 영숫자.');
						$('#idconfirm').css('color', 'red');
						idTest = 'false';
					}
				}
			});
		}
		
	}
	// 이름 유효성 검사
	function checkName(mname){
		const namePattern = /^[가-힣]{3,4}$/;
		let result = namePattern.test(mname);
		if(!result){
			return false;
		} else {
			return true;
		}
		
	}
	//이메일 유효성 검사
	function checkEmail(email){
		const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		let result = emailPattern.test(email);
		if(!result){
			result = 'false';
		} else {
			result = 'true';
		}
		return result;
	}
	
	//핸드폰 번호 유효성 검사
	function checkPhone(phone){
		const phoneNumberPattern = /^\d{3}-\d{3,4}-\d{4}$/;
		let result = phoneNumberPattern.test(phone);
		if(!result){
			result = 'false';
		} else {
			result = 'true';
		}
		return result;
	}
	
	// 주소 입력 확인
	function addCheck(postcode, addr1, addr2){
		let result = 'false';
		if( (postcode != '' && postcode != null) && (addr1 != '' && addr1 != null) && (addr2 != '' && addr2 != null)){
			result = 'true';
		} 
		
		return result;
	}
	
	function check(){
		$('.noTypeInput').html('');
		$('.noSystemInput').html('');
		$('.noIdInput').html('');
		$('.noNameInput').html('');
		$('.noEmailInput').html('');
		$('.noBirthInput').html('');
		$('.noPositionInput').html('');
		$('.noOrganInput').html('');
		$('.noPhoneInput').html('');
		$('.noAddressInput').html('');
		
		let mtype = document.querySelector('#mtype');
		let mtypeValue = mtype.options[mtype.selectedIndex].value;	
		let mid = document.querySelector('#mid').value;
		let mname = document.querySelector('#mname').value;
		let email = document.querySelector('#email').value;
		let birth = document.querySelector('#birth').value;
		let gender = document.querySelector('#gender');
		let genderValue = gender.options[gender.selectedIndex].value;
		let nameResult = checkName(mname);
		let emailResult = checkEmail(email);
		let sno = document.querySelector('#sno');
		let snoValue = sno.options[sno.selectedIndex].value;
		let position = document.querySelector('#position');
		let positionValue = position.options[position.selectedIndex].value;
		let organ = document.querySelector('#organ');
		let organValue = organ.options[organ.selectedIndex].value;
		let phone = document.querySelector('#phone').value;
		let phoneResult = checkPhone(phone);
		let postcode = document.querySelector('#postcode').value;
		let addr1 = document.querySelector('#addr1').value;
		let addr2 = document.querySelector('#addr2').value;
		let addResult = addCheck(postcode, addr1, addr2);
		
		let submitResult = true;
		
		if(mtypeValue == null){
			$('.noTypeInput').html('유저 타입을 확인하세요');
			submitResult = false;
		} 
		if (mid == '' || mid == null ){
			$('.noIdInput').html('아이디입력');
			submitResult = false;		
		} 
		if(mname == '' || mname == null){
 			$('.noNameInput').html('이름 입력');
 			submitResult = false;
 		} 
		if (!checkName(mname)){
 			$('.noNameInput').html('3~4글자');
 			submitResult = false;
 		} 
		if(emailResult != 'true'){
 			$('.noEmailInput').html('이메일 형식 확인');
 			submitResult = false;
 		} 
		if(birth == ''){
 			$('.noBirthInput').html('생년월일');
 			submitResult = false;
 		} 
		if(positionValue == '0'){
 			$('.noPositionInput').html('직급 선택');
 			submitResult = false;
 		}
		if(organValue == '0'){
 			$('.noOrganInput').html('소속 기관 선택');
 			submitResult = false;
		}
		if(phone == '' || phone == null){
 			$('.noPhoneInput').html('번호 입력');
 			submitResult = false;
		} else if (phoneResult != 'true'){
 			$('.noPhoneInput').html('번호 확인');
 			submitResult = false;
		}
		if(addResult != 'true'){
			$('.noAddressInput').html('주소 입력');
			submitResult = false;
		}
		if(idTest != 'true' ) {
			$('#countCheck').modal();
			$('#countContent').html('아이디는 6~15자리 영숫자로 입력하세요');
			submitResult = false;
		} 
		
		if(submitResult == true){
			return true;
		} else {
			return false;
		}
		
	}
	

	</script>
	
	
</body>

</html>
