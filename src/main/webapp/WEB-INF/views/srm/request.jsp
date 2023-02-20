<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/request.css" rel="stylesheet" type="text/css">
<style>
a {
	text-decoration: none;
}

form {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 600px;
	width: 1050px;
	position: relative;
	background-color: #fff;
	border-radius: 5px;
	border: 1px solid rgba(0, 0, 0, 0.125);
	border-radius: 0.25rem;
	-webkit-box-shadow: 1px 1px 5px rgba(126, 142, 159, 0.1);
	box-shadow: 1px 1px 5px rgba(126, 142, 159, 0.1);
	margin-bottom: 50px;
}

.section1 {
	width: 1047px;
	overflow: hidden;
	text-align: start;
	align-items: center;
	position: absolute;
	top: 0;
	left: 0;
	background-color: #f8f9fc;
	border-bottom: 1px solid #e3e6f0;
}
.section1 h4{
	color: #68a329;
	font: bold;
	margin: 15px 15px;
}

.section1 .step {
	width: 1047px;
	overflow: hidden;
	text-align: start;
	justify-content: center;
}

.section1 button {
	margin: 0px 10px;
	background-color: #85ce36;
	color: white;
	border: none;
}

.section1 .step span {
	display: inline-block;
	background-color: #85ce36;
	width: 8px;
	height: 6px;
}

.section2 .label {
	position: absolute;
	width: 100px;
	left: 8%;
	top: 15%;
	overflow: hidden;
	text-align: start;
}

.section2 h6 {
	margin-bottom : 10px;
	font-size : 15px;
	font : bold;
}

.section2 .inputData {
	position: absolute;
	width: 250px;
	left: 18%;
	top: 15%;
	overflow: hidden;
	text-align: start;
	
}

.section2 .label2 {
	position: absolute;
	width: 110px;
	left: 60%;
	top: 15%;
	overflow: hidden;
	text-align: start;
}

.section2 .inputData2 {
	position: absolute;
	width: 250px;
	left: 72%;
	top: 15%;
	overflow: hidden;
	text-align: start;
}
.section2 .inputData2 input {
	height: 25px;
	width : 200px;
	font-size : 13px;
}
.section2 .inputData input {
	height: 25px;
	width : 200px;
	font-size : 13px;
}

.section2 .titleLabel {
	position: absolute;
	width: 50px;
	left: 8%;
	top: 35%;
	overflow: hidden;
	text-align: start;
	font-size : 15px;
}
.section2 .titleLabel h6{
	font: bold; 
}


.section2 .titleInput {
	position: absolute;
	width: 700px;
	left: 18%;
	top: 34%;
	overflow: hidden;
	text-align: start;
	font-size : 15px;
	font: bold;  
	
}

.section2 .titleInput input {
	width: 700px;
	height : 25px;
}

.section2 .titleBody {
	position: absolute;
	width: 700px;
	left: 8%;
	top: 45%;
	overflow: hidden;
	text-align: start;
	font-size : 15px;
	font: bold;  
}

.section2 .bodyInput {
	position: absolute;
	width: 700px;
	left: 18%;
	top: 44%;
	overflow: hidden;
	text-align: start;
	font-size : 15px;
	font: bold;  
}
.section2 .bodyInput textarea{
    width: 100%;
	font-size : 15px;
	font: bold;  
	height : 50px;
	resize : none;
}
.section2 .submit-button {
	position: absolute;
	width: 80px;
	height: 50px;
	left: 85%;
	top: 47%;
}
.section2 .return-button{
	position: absolute;
	width: 80px;
	height: 50px;
	left: 90%;
	top: 47%;
}



[type="text"]:focus::placeholder {
	visibility: hidden;
}

textarea:focus::placeholder {
	visibility: hidden;
}

.item select, .item textarea, .item input {
	border: 1px solid lightgray;
	height: 40px;
	width: inherit;
	border-radius: 5px;
	padding: 10px;
	box-sizing: border-box;
	padding-left: 40px;
	outline: none;
	transition: 0.3s;
}

.item {
	/* border: 1px solid red; */
	width: 250px;
	margin-bottom: 10px;
	position: relative;
}

.item input {
	height: 40px;
	width: inherit;
	border-radius: 5px;
	padding: 10px;
	box-sizing: border-box;
	padding-left: 40px;
	outline: none;
	transition: 0.3s;
}

.item .fa {
	position: absolute;
	top: -8px;
	left: -3px;
	color: gray;
	font-size: 20px;
	width: 40px;
	height: 40px;
	/* border: 1px solid blue; */
	text-align: center;
	line-height: 40px;
	transition: 0.3s;
	z-index: 3;
}

.item input:focus {
	border: 1px solid #85ce36;
	box-shadow: 0 0 5px #85ce36;
}

.item input:focus::placeholder {
	visibility: hidden;
}

.item textarea:focus {
	border: 1px solid #85ce36;
	box-shadow: 0 0 5px #85ce36;
}

.item input:focus {
	box-shadow: 0 0 5px #85ce36;
}

.item input:focus+.fa {
	color: #85ce36;
}
.item select:focus {
	box-shadow: 0 0 5px #85ce36;
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


					<form method="post" action="${pageContext.request.contextPath}/customer/register">
						<section class="section1">
							<h4>요청 작성</h4>
							<!-- <article class="step">
								<button>접수</button>
								<span class="dash"></span>
								<button>개발</button>
								<span class="dash"></span>
								<button>테스트</button>
								<span class="dash"></span>
								<button>유저</button>
								<span class="dash"></span>
								<button>배포</button>
								<span class="dash"></span>
								<button>최종</button>
							</article> -->
						</section>
						<section class="section2">
							<article class="label item">
								<h6>작성자</h6>
								<h6>전화번호</h6>
								<h6>직급</h6>
							</article>
							<article class="inputData">
								<div class="item">
									<input type="text" class="form-control form-control-user" id="clientName" name="clientName" placeholder="default" readonly> 
									<i class="fa fa-phone"></i>
								</div>
								<div class="item">
									<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="010-1234-1234" readonly> 
									<i class="fa fa-phone"></i>
								</div>
								<div class="item">
									<input type="text" class="form-control form-control-user" id="position" name="position" placeholder="직급" readonly>
									<i class="fa fa-phone"></i>
								</div>
							</article>
							<article class="label2">
								<h6>소속기관</h6>
								<h6>이메일</h6>
								<h6>완료 희망 일자</h6>
							</article>
							<article class="inputData2">
								<div class="item">
									<input type="text" class="form-control form-control-user" id="organ" name="organ" placeholder="소속기관" readonly> 
									<i class="fa fa-phone"></i>
								</div>
								<div class="item">
									<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="email@oti.com" readonly> 
									<i class="fa fa-phone"></i>
								</div>
								<div class="item">
									<input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate" readonly>
									<i class="fa fa-phone"></i>
								</div>
							</article>
							<article class="titleLabel">
								<h6>제목</h6>
							</article>
							<article class="titleInput">
								<div class="item">
									<input type="text" id="reqTitle" name="reqTitle" placeholder="제목">
								</div>
							</article>
							<article class="titleBody">
								<h6>내용</h6>
							</article>
							<article class="bodyInput">
								<div class="item">
									<textarea id="reqContent" cols="30" name="reqContent" placeholder="내용"></textarea>
								</div>
							</article>

							<article class="submit-button">
								<button class="btn btn-dark btn-sm" type="submit">작성</button>
							</article>
							<article class="return-button">
								<button class="btn btn-dark btn-sm" type="submit">취소</button>
							</article>
						</section>
					</form>
				</div>
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
