<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<style>
	body {
		font-size: 15px;
	}
	
	.table {
		text-align: start;
		border: none;
	}
	
	.table tr, td {
		display: inline-block;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		text-align: center;
		border: none;
	}
	
	.table td.rno {
		width: 50px;
		border: none;
	}
	
	.table td.client {
		width: 100px;
		border: none;
	}
	
	.table tr td.sysType {
		width: 100px;
		border: none;
	}
	
	.table tr td.reqTitle {
		width: 500px;
		border: none;
	}
	
	.table tr td.reqDate {
		width: 100px;
		border: none;
	}
	
	.table tr td.stepButton {
		width: 120px;
		border: none;
	}
	
	#table_name {
		background-color: #5a5c69;
		color: white;
		border: none;
	}
	
	.collapse .card .row .col-2 {
		text-align: center;
		align-items: center;
	}
	
	.collapse .card .row button {
		border-radius: 10px;
	}
	
	.collapse .card .row .col-2 #status_one {
		width: 120px;
	}
	
	.collapse .card .row .col-2 #status_two {
		width: 120px;
	}
	
	.collapse .card .row .col-2 #status_three {
		width: 120px;
	}
	
	.collapse .card .row .col-2 #status_four {
		width: 120px;
	}
	
	.collapse .card .row .col-2 #status_five {
		width: 120px;
	}
	
	.collapse .card .row .col-2 #status_six {
		width: 120px;
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
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">필터</h6>
					</div>
					<div class="card-body">
						<div class="row">
							
						</div>
					</div>
				</div>
				
				
				
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">내 담당 요청 관리</h6>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-sm">
									<table class="table table-bordered" id="table_name">
										<tr>
											<td class="rno">no</td>
											<td class="client">시스템</td>
											<td class="sysType">요청 유형</td>
											<td class="reqTitle">요청 제목</td>
											<td class="reqDate">요청 일자</td>
											<td class="stepButton">단계 확인</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-sm">
									<c:forEach var="request" items="${requestList}">
										<table class="table table-bordered" id="table_content">
											<tr>
												<td class="rno">${request.rno}</td>
												<!-- 나중에 시스템 이름으로 바꾸어 줘야 함. -->
												<td class="client">${request.sno}이름추가</td>
												<!-- 요청 유형 테이블에서 req type 가져와야 함. -->
												<td class="sysType">일반, 긴급</td>
												<td class="reqTitle">${request.reqTitle}</td>
												<td class="reqDate">${request.reqDate}</td>
												<td class="stepButton">
													<button class="btn btn-dark btn-sm" type="button" data-toggle="collapse" data-target="#collapseExample${request.rno}" aria-expanded="false" aria-controls="collapseExample">단계</button>
												</td>
											</tr>
										</table>
										<div class="collapse" id="collapseExample${request.rno}">
											<div class="card card-body">
                                                <div class="row row-col-1 row-cols-sm-3 row-cols-md-6 row-cols-xl-6">
                                                    <div class="col-2">
                                                        <button id="status_one" class="btn-md">접수중</button>
                                                    </div>
                                                    <div class="col-2">
                                                        <button id="status_two" class="btn-md">개발중</button>
                                                    </div>
                                                    <div class="col-2">
                                                        <button id="status_three" class="btn-md">테스트중</button>
                                                    </div>
                                                    <div class="col-2">
                                                        <button id="status_four" class="btn-md">유저테스트중</button>
                                                    </div>
                                                    <div class="col-2">
                                                        <button id="status_five" class="btn-md">배포중</button>
                                                    </div>
                                                    <div class="col-2">
                                                        <button id="status_six" class="btn-md">완료중</button>
                                                    </div>
                                                </div>
											</div>
										</div>
										<br>
									</c:forEach>
								</div>
							</div>
						</div>
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

	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>


</body>
<!-- row collapse 추가 JS -->
<script>
	
</script>

</html>
