<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/member/userregistercss.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
	
	function changeUserType(){
		var typeSelect = document.getElementById("mtype");
		var selectValue = typeSelect.options[typeSelect.selectedIndex].value;
		console.log(selectValue);
		if(selectValue == 'pm'){
			$("#sno").css("visibility", "hidden");
			$("#sno_icon").css("visibility","hidden");

		} else {
			$("#sno").css("visibility", "visible");
			$("#sno_icon").css("visibility","visible");
		}
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
				<div class="wrapper border-left-dark">
					<form class="border-left-dark" method="post" action="${pageContext.request.contextPath}/customer/register" enctype="multipart/form-data">
						<section class="section1">
							<h4>User Register</h4>
						</section>

						<section class="section2">
							<article class="photo">
								<img id="preview" src="${pageContext.request.contextPath}/resources/img/default-image.gif" /> 
								<input type="file" class="btn btn-sm btn-dark" id="mfile" name="mfile" onchange="readURL(this);">
							</article>

							<article class="userData">
								<div class="item">
									<div class="input-group">
										<select class="custom-select" id="mtype" name="mtype" onchange="changeUserType()">
											<option selected>사용자 구분</option>
											<option value="user">user</option>
											<option value="pm">pm</option>
											<option value="developer">developer</option>
											<option value="distributer">distributer</option>
											<option value="tester">tester</option>
											<option value="user_tester">user_tester</option>
										</select>
										<i class="fa fa-user"></i>
									</div>
								</div>
								<div class="data">
									<div class="item">
										<input type="text" class="form-control form-control-user" id="mid" name="mid" placeholder="아이디" required> <i class="fa fa-user"></i>
									</div>
									<div class="item">
										<input type="password" class="form-control form-control-user" id="password" name="password" placeholder="비밀번호" required> <i class="fa fa-unlock"></i>
									</div>
									<!-- 비밀번호 확인 -->
									<div class="item">
										<input type="password" class="form-control form-control-user" id="password_confirm" name="password_confirm" placeholder="비밀번호 확인" required> <i class="fa fa-unlock-alt"></i>
									</div>
									<div class="item">
										<input type="text" class="form-control form-control-user" id="mname" name="mname" placeholder="이름" required> <i class="fa fa-phone"></i>
									</div>
									<div class="item">
										<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="이메일" required> <i class="fa fa-phone"></i>
									</div>
								</div>
							</article>
							<article class="userData2">
								
							<div class="item">
									<div class="input-group">
										<select class="custom-select" id="sno" name="sno">
											<option selected>시스템 선택</option>
											<c:forEach var="system" items="${systemList}">
												<option value="${system.sno}">${system.systemName}</option>
											</c:forEach>
										</select>
										<i class="fa fa-user" id="sno_icon"></i>
									</div>
								</div>
								<div class="item">
									<div class="input-group">
										<select class="custom-select" id="gender" name="gender" required>
											<option value="1">남</option>
											<option value="2">여</option>
										</select>
										<i class="fa fa-venus-mars"></i>
									</div>
								</div>
								<div class="item">
									<div class="input-group">
										<select class="custom-select" id="position" name="position" required>
											<option selected>직급 선택</option>
											<option value="사원">사원</option>
											<option value="대리">대리</option>
											<option value="과장">과장</option>
											<option value="차장">차장</option>
										</select>
										<i class="fa fa-address-card"></i>
									</div>


								</div>
								<div class="item">
									<div class="input-group">
										<i class="fa fa-user"></i>
										<select class="custom-select" id="organ" name="organ" required>
											<option selected>소속 기관 선택</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
										</select>
										<i class="fa fa-building"></i>
									</div>


								</div>
								<div class="item">
									<div class="input-group">
										<div class="date_form">
											<input type="date" id="birth" name="birth" style="border: 1px solid #d1d3e2;" required><i class="fa fa-calendar"></i>
										</div>
									</div>
									<div class="input-group">
										<div class="item" style="margin-top: 10px;">
											<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="핸드폰" required> <i class="fa fa-phone"></i>
										</div>
									</div>
								</div>
							</article>
							<article class="address-input">
								<div class="item address1">
									<input type="text" class="form-control form-control-user" id="postcode" name="postcode" placeholder="우편번호" readonly> <i class="fa fa-map-marker"></i>
								</div>
								<div class="item address2">
									<input type="text" class="form-control form-control-user" id="addr1" name="addr1" placeholder="도로명 주소" readonly> <i class="fa fa-map-marker"></i>
								</div>
								<div class="item address3">
									<input type="text" id="addr2" name="addr2" style="border: 1px solid #d1d3e2;" placeholder="상세 주소" required> <i class="fa fa-map-marker"></i>
								</div>
								<div class="item address-button">
									<button type="button" class="btn btn-dark btn-sm" id="address" name="address" onclick="findAddress()" >우편번호</button>
								</div>
							</article>

							<article class="submit-button">
								<button class="btn btn-dark btn-sm" type="submit">회원 등록</button>
							</article>
							<article class="return-button">
								<button class="btn btn-dark btn-sm" type="submit">취소</button>
							</article>
						</section>
					</form>
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
	</div>
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
</body>

</html>
