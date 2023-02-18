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
	height: 800px;
	width : 1050px;
	position : relative;
}

.section1 {
	width: 800px;
	overflow: hidden;
	text-align: center;
	align-items: center;
	position : absolute;
}

.section1 .step {
	width: 800px;
	overflow: hidden;
	text-align: center;
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
	left: 0%;
	top: 10%;
	overflow: hidden;
	text-align: start;
}

.section2 h6 {
	margin-bottom: 15px;
}

.section2 .inputData {
	position: absolute;
	width: 250px;
	left: 10%;
	top: 9%;
	overflow: hidden;
	text-align: start;
}

.section2 .label2 {
	position: absolute;
	width: 110px;
	left: 45%;
	top: 10%;
	overflow: hidden;
	text-align: start;
}

.section2 .inputData2 {
	position: absolute;
	width: 250px;
	left: 55%;
	top: 9%;
	overflow: hidden;
	text-align: start;
}

.section2 .inputData input {
	height: 35px;
}

.section2 .titleLabel {
	position: absolute;
	width: 50px;
	left: 20%;
	top: 30%;
	overflow: hidden;
	text-align: start;
}

.section2 .titleInput {
	position: absolute;
	width: 500px;
	left: 25%;
	top: 30%;
	overflow: hidden;
	text-align: start;
}

.section2 .titleInput input {
	width: inherit;
}

.section2 .titleBody {
	position: absolute;
	width: 50px;
	left: 20%;
	top: 35%;
	overflow: hidden;
	text-align: start;
}

.section2 .bodyInput {
	position: absolute;
	width: 500px;
	left: 25%;
	top: 35%;
	overflow: hidden;
	text-align: start;
}

.section2 .bodyInput textarea {
	width: inherit;
}

.section2 .submit-button {
	position: absolute;
	width: 200px;
	height: 50px;
	left: 30%;
	top: 40%;
}

.section2 .submit-button button {
	position: absolute;
	left: 30%;
	top: 50%;
	transform: translate(-50%, -50%);
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
					<section class="section1">
						<h4>요청 작성</h4>
						<article class="step">
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


						</article>

					</section>

					<form method="post" action="${pageContext.request.contextPath}/customer/register">
						<section class="section2">
							<article class="label item">
								<h6>작성자</h6>
								<h6>전화번호</h6>
								<h6>직급</h6>
							</article>
							<article class="inputData item">
								<input type="text" class="form-control form-control-user" id="clientName" name="clientName" placeholder="default"> <input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="010-1234-1234"> <input type="text" class="form-control form-control-user" id="position" name="position" placeholder="직급">

							</article>
							<article class="label2 item">
								<h6>소속기관</h6>
								<h6>이메일</h6>
								<h6>완료 희망 일자</h6>
							</article>
							<article class="inputData2 item">
								<input type="text" class="form-control form-control-user" id="organ" name="organ" placeholder="소속기관"> <input type="text" class="form-control form-control-user" id="email" name="email" placeholder="email@oti.com"> <input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate">
							</article>
							<article class="titleLabel item">
								<h6>제목</h6>
							</article>
							<article class="titleInput item">
								<input type="text" id="reqTitle" name="reqTitle" placeholder="제목">
							</article>
							<article class="titleBody item">
								<h6>내용</h6>
							</article>
							<article class="bodyInput item">
								<textarea id="reqContent" name="reqContent" placeholder="내용"></textarea>
							</article>

							<article class="submit-button">
								<button class="btn btn-dark btn-sm" type="submit">요청 작성</button>
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
