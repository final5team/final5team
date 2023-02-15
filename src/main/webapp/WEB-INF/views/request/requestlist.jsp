<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<div class="row">
									<div class="col-sm">
										<h3>Basic example</h3>
										<p>Default options</p>
										<table class="table table-bordered" id="table_accordion_01">
											<thead>
												<tr>
													<th></th>
													<th>Order no.</th>
													<th>시스템</th>
													<th>유형</th>
													<th>요청 제목</th>
													<th>요청 일자</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="request" items="${requestList}">
													<tr>
														<td onclick="viewStep(${request.rno})">+</td>
														<td class="rno">${request.rno}</td>
														<!-- 나중에 시스템 이름으로 바꾸어 줘야 함. -->														
														<td class="sno">${request.sno}이름추가</td>
														<!-- 요청 유형 테이블에서 req type 가져와야 함. -->
														<td class="type">요청타입 (join필요)</td>
														<td class="reqTitle">${request.reqTitle}</td>
														<td class="reqDate">${request.reqDate}</td>
													</tr>
													<div id="viewStep${request.rno}"></div>
												</c:forEach>
											</tbody>
										</table>
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

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>


</body>
<!-- row collapse 추가 JS -->
<script>
	function viewStep(i){
		let rno =  i;
		console.log(rno);
		$.ajax({
			url : "/srm/customer/viewstep",
			type : "get",
			datatype : "html",
			success : function(data){
				
		}
			
		});
		
	}


</script>


</html>
