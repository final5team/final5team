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
				<form method="post">
					<div class="mb-4">
						<div class="card border-left-primary shadow h-100 py-2">
							<div class="card-body">
								<div class="row">
									<div>성명</div>
									<input id="clientName" name="clientName" type="text" value="default">
									<div>연락처</div>
									<input type="text" value="default">
								</div>

									<div class="row">
										<div>시스템</div>
										<select class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="sno">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
										</select>
										
										<div>요청 완료<br>희망일</div>
										<input id="reqExpectDate" name="reqExpectDate" type="date" >
										
									</div>
									<div class="row">
									<div>제목</div>
									<input type="text" id="reqTitle" name="reqTitle" value="제목">
								</div>
								<div class="row">
									<div>요청내역</div>
									<textarea id="reqContent" name="reqContent"></textarea>
								</div>
								<div class="row">
									<div>첨부파일</div>
									<input type="text">
									<button class="btn btn-sm btn-dark">파일 첨부하기</button>
								</div>
								<button type="submit" class="btn btn-sm btn-dark">요청 등록</button>
							</div>
						</div>
						</div>
					</form>
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
<style>
.row {
	width: auto;
	overflow: hidden;
	margin: 5px;
}

.row div {
	width: 100px;
	text-align: center;
	display: inline-block;
	align-items: center;
}

.row input {
	width: 150px;
}

.row textarea {
	height: 300px;
	width: 500px;
}
select{
	width :150px;	
}


</style>
</html>
