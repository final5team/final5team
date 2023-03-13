<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/member/mypage_recss.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


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
							<h3 class="title">개인정보</h3>
						</div>
						<section>
							<!-- 개발내역 입력폼 start -->
							<div class="card border-top-dark">
								<div class="card-block">
									<div class="card-title-block">
										<h3 class="title">
											개인정보 조회 <i class="fas fa-edit"></i>
										</h3>
									</div>
									<div class="card-body">
										<form onsubmit="return check()" method="post" action="${pageContext.request.contextPath}/customer/mypageupdate" enctype="multipart/form-data">
											<section class="section2">
												<article class="photo">
													<img id="preview" src="${pageContext.request.contextPath}/customer/mypage/${returnMember.mid}" onerror="this.src='${pageContext.request.contextPath}/resources/img/default-image.gif'" />
													<article class="fileBody">
														<div class="file-item">
															<div class="upload_name" id="exist_file" style="display: none;">FileName</div>
															<div class="filebox">
																<input type="file" id="mfile" name="mfile" accept="image/*" onchange="readURL(this);" /> <label for="mfile">사진 등록</label>
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
													<h6>*비밀번호</h6>
													<h6>*우편번호</h6>
												</article>

												<article class="data_one">
													<select class="custom-select" id="mtype" name="mtype" onchange="changeUserType()">
														<option value="${returnMember.mtype}" selected>${returnMember.mtype}</option>
														<c:if test="${sessionScope.member.mtype == 'pm'}">
															<option value="user">시스템 사용자(고객)</option>
															<option value="pm">PM</option>
															<option value="developer">개발자</option>
															<option value="distributer">배포담당자</option>
															<option value="tester">테스터</option>
															<option value="user_tester">품질테스터</option>
														</c:if>
													</select>
													<div class="data">
														<div class="item">
															<input type="text" class="form-control form-control-user" id="mid" name="mid" maxlength='15' onfocusout="checkId()" placeholder="아이디" value="${returnMember.mid}">
														</div>
														<div class="item">
															<input type="text" class="form-control form-control-user" id="mname" name="mname" maxlength='4' placeholder="이름" value="${returnMember.mname}">
														</div>
														<div class="item">
															<input type="text" class="form-control form-control-user" id="email" name="email" maxlength='33' placeholder="이메일" value="${returnMember.email}">
														</div>
														<div class="item">
															<input type="date" id="birth" name="birth" class="form-control form-control-user" value="<fmt:formatDate value="${returnMember.birth}" pattern="yyyy-MM-dd" />">
														</div>
														<div class="item">
															<input type="password" class="form-control form-control-user" id="password" name="password" onfocusout="passwordCheck()" maxlength='13' placeholder="비밀번호">
														</div>
													</div>
												</article>

												<article class="label_two item">
													<h6 id="system" style="visibility: hidden;">시스템</h6>
													<h6>*성별</h6>
													<h6>*직급</h6>
													<h6>*소속 회사</h6>
													<h6>*휴대폰 번호</h6>
												</article>


												<article class="data_two">
													<div class="input-group">
														<select class="custom-select" id="sno" name="sno" style="visibility: hidden;">
															<option value="0" selected>시스템 선택</option>
															<c:forEach var="system" items="${systemList}">
																<option value="${system.sno}">${system.systemName}</option>
															</c:forEach>
														</select>
													</div>
													<div class="item">
														<div class="input-group">
															<select class="custom-select" id="gender" name="gender">
																<c:if test="${returnMember.gender == '1'}">
																	<option value="1" selected>남</option>
																</c:if>
																<c:if test="${returnMember.gender == '2'}">
																	<option value="2" selected>여</option>
																</c:if>
															</select>
														</div>
													</div>

													<div class="item">
														<div class="input-group">
															<select class="custom-select" id="position" name="position">
																<option selected>${returnMember.position}</option>
																<c:if test="${sessionScope.member.mtype == 'pm'}">
																	<option value="사원">사원</option>
																	<option value="대리">대리</option>
																	<option value="과장">과장</option>
																	<option value="차장">차장</option>
																</c:if>
															</select>
														</div>
													</div>

													<div class="item">
														<div class="input-group">
															<select class="custom-select" id="organ" name="organ" required>
																<option value='${returnMember.organ}'>${returnMember.organ}</option>
																<c:if test="${sessionScope.member.mtype == 'pm'}">
																	<option value="오티아이">오티아이</option>
																	<option value="쇼핑몰">쇼핑몰</option>
																	<option value="학사관리">학사관리</option>
																</c:if>
															</select>
														</div>
													</div>

													<div class="item" style="margin-top: 10px;">
														<input type="text" class="form-control form-control-user" id="phone" name="phone" maxlength='13' placeholder="핸드폰" value="${returnMember.phone}">
													</div>
												</article>

												<article class="address-input">
													<div class="item address1">
														<input type="text" class="form-control form-control-user" id="postcode" name="postcode" maxlength='5' placeholder="우편번호" value="${returnMember.postcode}">
													</div>
													<div class="item address2">
														<input type="text" class="form-control form-control-user" id="addr1" name="addr1" maxlength='35' placeholder="도로명 주소" value="${returnMember.addr1}">
													</div>
													<div class="item address3">
														<input type="text" id="addr2" name="addr2" class="form-control form-control-user" maxlength='25' placeholder="상세 주소" value="${returnMember.addr2}">
													</div>
													<div class="item address-button">
														<button type="button" class="btn btn-dark btn-sm" id="address" name="address" onclick="findAddress()">우편번호</button>
													</div>
												</article>
												<article class="submit-button">
													<button class="btn btn-dark btn-sm" type="submit">저장</button>
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
						<!-- 개발내역 입력폼 end -->
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
						<a class="btn btn-primary" data-dismiss="modal" type="button" id="modal-button">확인</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End of Page Wrapper -->
	</div>
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
	<script>
		//이미지 검증
		mfile.addEventListener('change',function() {
		//파일 업로드 제약 자바스크립트
			let mfile = document.querySelector('#mfile');
			let fileList = mfile.files[0].name;
		//이미지 파일만 입력받기
		const allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
			if (!allowedExtensions.exec(fileList)) {
				alert('jpg, jpeg, png, gif 파일만 업로드할 수 있습니다.');
				mfile.value = '';
				let image = document.querySelector('#preview');
				image.src = '${pageContext.request.contextPath}/resources/img/default-image.gif';
				return false;
			} else {
				// 파일 이름 출력 
				let inputtag = document.querySelector('#exist_file');
					inputtag.innerHTML = fileList;
					}
				});
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

		function changeUserType() {
			var typeSelect = document.getElementById("mtype");
			var selectValue = typeSelect.options[typeSelect.selectedIndex].value;
			console.log(selectValue);
			if (selectValue !== 'pm' && selectValue !== 'user') {
				$("#sno").css("visibility", "visible");
				$("#system").css("visibility", "visible");

			} else {
				$("#sno").css("visibility", "hidden");
				$("#system").css("visibility", "hidden");
			}
		}
		
		
		// 이름 유효성 검사
		function checkName(mname){
			const namePattern = /^[가-힣]{3,4}$/;
			let result = namePattern.test(mname);
			if(!result){
				result = 'false';
			} else {
				result = 'true';
			}
			return result;
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
			console.log(postcode, addr1, addr2);
			console.log(addr2);
			let result = 'false';
			if( (postcode != '' && postcode != null) && (addr1 != '' && addr1 != null) && (addr2 != '' && addr2 != null)){
				result = 'true';
			} 
			
			return result;
		}
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
						if(result <='1'){
							$('#idconfirm').html('사용 가능한 아이디입니다.');
							$('#idconfirm').css('color', 'blue');
							idTest = 'true';
							/* $('#mid').css('border', '1px solid #ced4da'); */
						} else {
							$('#idconfirm').html('중복된 아이디입니다.');
							$('#idconfirm').css('color', 'red');
							idTest = 'false';
						}
					}
				});
			}
		}
		//비밀번호 동일 체크 ajax
		let passwordResult = '';
		function passwordCheck(){
			let password = document.querySelector('#password').value;
			if(password == '' || password == null){
				return false;
			} else {
				data = {password : password};
				$.ajax({
					url : "/srm/passwordConfirm",
					method : "post",
					data : JSON.stringify(data),
					contentType : "application/json; charset=UTF-8",
					success : function(result){
						if(!result){
							$('#countCheck').modal();
							$('#countContent').html('변경 가능한  비밀번호입니다.');
							passwordResult = 'true';
						} else {
							$('#countCheck').modal();
							$('#countContent').html('기존과 동일한  비밀번호입니다.');
							passwordResult = 'false';
						}
					}
				})	;
			}
		}
		
		
		
		function check(){
			
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
			let password = document.querySelector('#password').value;
			
			
			
			if(mtypeValue == null){
				$('#countCheck').modal();
				$('#countContent').html('유저 타입을 확인하세요');
				return false;
			}
			if(mtypeValue != 'user' && mtypeValue != 'pm'){
				if(snoValue == "0"){
					$('#countCheck').modal();
					$('#countContent').html('시스템을 선택하세요');
					return false;
				}
			} 
			if (mid == '' || mid == null ){
				$('#countCheck').modal();
				$('#countContent').html('아이디를 입력하세요');
				return false;
			} 
			if(idTest != 'true' ) {
				$('#countCheck').modal();
				$('#countContent').html('아이디 형식을 확인하세요');
				return false;
			} 
			if(mname == '' || mname == null){
	 			$('#countCheck').modal();
	 			$('#countContent').html('이름을 입력하세요');
	 			return false;
	 		} 
			if (nameResult != 'true'){
	 			$('#countCheck').modal();
	 			$('#countContent').html('이름을 정확히 입력하세요');
	 			return false;
	 		} 
			if(emailResult != 'true'){
	 			$('#countCheck').modal();
	 			$('#countContent').html('이메일 형식을 확인하세요');
	 			return false;
	 		} 
			if(birth == ''){
	 			$('#countCheck').modal();
	 			$('#countContent').html('생년월일을 입력하세요');
	 			return false;
	 		} 
			if(positionValue == '0'){
	 			$('#countCheck').modal();
	 			$('#countContent').html('직급을 선택하세요');
	 			return false;
	 		}
			if(organValue == '0'){
				$('#countCheck').modal();
	 			$('#countContent').html('소속 기관을 선택하세요');
	 			return false;
			}
			if(phone == '' || phone == null){
				$('#countCheck').modal();
	 			$('#countContent').html('핸드폰 번호를 입력하세요');
	 			return false;
			} else if (phoneResult != 'true'){
				$('#countCheck').modal();
	 			$('#countContent').html('핸드폰 번호를 확인하세요');
	 			return false;
			}
			if(addResult != 'true'){
				$('#countCheck').modal();
				$('#countContent').html('주소를 입력하세요');
				return false;
			}
			if(password == '' || password == null){
				$('#countCheck').modal();
				$('#countContent').html('변경할 비밀번호를 입력하세요');
				return false;
			} 
			if(passwordResult != 'true'){
				$('#countCheck').modal();
				$('#countContent').html('변경 비밀번호를 확인 하세요');
				return false;
			} 
			
			return true;			
		}
	</script>


</body>

</html>
