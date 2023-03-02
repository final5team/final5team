<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/listcss/myrequestlistcss.css" rel="stylesheet">

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
				<div class="wrapper">
					<main class="all">
					<section class="filter border-left-dark">
						<form>
							<article class="filter-head">
								<h4>요청 검색</h4>
							</article>

							<article class="filter-name">
								<h6>요청 유형</h6>
								<h6>요청 일자</h6>
							</article>

							<article class="filter-name2">
								<h6>단계</h6>
								<h6>시스템</h6>
							</article>
							<article class="search-button">
								<button class="btn btn-dark btn-sm" type="button" onclick="search()">검색</button>
							</article>
							<article class="write-button">
								<a type="button" href="<c:url value='/customer/request'/>" class="btn btn-dark btn-sm write">요청 작성</a>
							</article>
							<article class="filter-body">
								<div class="input-group">
									<select class="custom-select" id="req_type" name="req_type">
										<option value="전체" selected>전체</option>
										<option value="정규">정규</option>
										<option value="긴급">긴급</option>
									</select>
								</div>
								<div class="date_form">
									<input type="date" id="date_first" name="date_first" style="border: 1px solid #d1d3e2; border-radius: 5px;"> 
									<i class="fa fa-minus"></i> 
									<input type="date" id="date_last" name="date_last" style="border: 1px solid #d1d3e2; border-radius: 5px;">
								</div>
							</article>
							<article class="filter-body2">
								<div class="input-group">
									<select class="custom-select" id="statusNo" name="statusNo">
										<option value="0" selected>전체</option>
										<!-- 진행중 단계에 접수, 개발, 테스트, 배포 모두 포함 -->
										<option value="2">진행중</option>
										<option value="11">완료</option>
										<option value="12">반려</option>
									</select>
								</div>
								<div class="input-group">
									<select class="custom-select" id="sno" name="sno">
										<c:if test="${listFilter.sno == 0}">
												<option value="0" selected>전체</option>
												<c:forEach var="system" items="${systemList}">
													<option value="${system.sno}">${system.systemName}</option>
												</c:forEach>
											</c:if>
											<c:if test="${listFilter.sno != 0}">
												<option value="${listFilter.sno}" selected>${listFilter.systemName}</option>
												<c:forEach var="system" items="${systemList}">
													<c:if test="${system.sno != listFilter.sno}">
														<option value="${system.sno}">${system.systemName}</option>
													</c:if>
												</c:forEach>
											</c:if>
									</select>
								</div>
							</article>
						</form>
					</section>
					<section class="table border-left-dark">
						<article class="table-header">
							<h4>내 요청 목록</h4>
						</article>
						<table class="member" id="table_content">
						</table>
					</section>
					</main>
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



	<script>
// 유저 로그인 시, 내 요청 목록 불러오기
	$(document).ready(function () {
		/* member의 type은 controller에서 넣어줌, 설정 필요 없음  */
		console.log("유저의 목록 요청 실행");
		data = {reqType : '전체', dateFirst: '', dateLast : '', sno : '0', statusNo : '0',  pageNo : 1 };	
		$.ajax({
			url : "myrequestlist",
			method : "post",
			data : JSON.stringify(data),
			contentType: "application/json; charset=UTF-8"
		}).done((data) => {
			$('#table_content').html(data);
		});
	});

// 페이지 이동 ajax
	function pageChange(i){
		console.log("페이지 이동" + i);
		let pageNo = i;
		
		let filterReqType = document.getElementById('req_type');
		let ReqType = filterReqType.options[filterReqType.selectedIndex].text;
		
		let filterDateFirst = document.getElementById('date_first');
		let dateFirst = filterDateFirst.value
		
		let filterDateLast = document.getElementById('date_last');
		let dateLast = filterDateLast.value
		
		let filterSno = document.getElementById('sno');
		let sno = filterSno.options[filterSno.selectedIndex].value
		
		let filterStatusNo = document.getElementById('statusNo');  
		let statusNo = filterStatusNo.options[filterStatusNo.selectedIndex].value
		
		data = {pageNo : i, reqType : ReqType, dateFirst : dateFirst, dateLast : dateLast, sno : parseInt(sno), statusNo : parseInt(statusNo)}
		$.ajax({
			url : "myrequestlist",
			method : "post",
			data : JSON.stringify(data),
			contentType: "application/json; charset=UTF-8"
			
		}).done((data) => {
			$('#table_content').html(data);
		});
	}	
	
// filter 검색 기능 ajax
	function search(){
		console.log("검색 실행")
//		검색 filter 값 가져오기
		let filterReqType = document.getElementById('req_type');
		let ReqType = filterReqType.options[filterReqType.selectedIndex].text;
		
		let filterDateFirst = document.getElementById('date_first');
		let dateFirst = filterDateFirst.value
		
		let filterDateLast = document.getElementById('date_last');
		let dateLast = filterDateLast.value
		
		let filterSno = document.getElementById('sno');
		let sno = filterSno.options[filterSno.selectedIndex].value
		
		let filterStatusNo = document.getElementById('statusNo');  
		let statusNo = filterStatusNo.options[filterStatusNo.selectedIndex].value
		
// 		console.log("페이지 번호 : "+ pageNo);
// 		console.log("유형 : " + ReqType);
// 		console.log("시작 날짜 : " + dateFirst);
// 		console.log(typeof dateFirst)
// 		console.log("종료 날짜 : " + dateLast);
// 		console.log("시스템 번호 : " + parseInt(sno));
// 		console.log(typeof parseInt(sno));
// 		console.log("단계 : " + parseInt(statusNo));
// 		console.log(typeof parseInt(statusNo));
		
		data = {reqType : ReqType, dateFirst : dateFirst, dateLast : dateLast, sno : parseInt(sno), statusNo : parseInt(statusNo)}
		$.ajax({
			url : "myrequestlist",
			method : "post",
			data : JSON.stringify(data),
			contentType: "application/json; charset=UTF-8"
			
		}).done((data) => {
			$('#table_content').html(data);
			
			
		});
	}
	



</script>




</body>

</html>
