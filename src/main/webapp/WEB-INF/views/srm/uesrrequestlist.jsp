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
					<section class="filter border-left-dark shadow">
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
									<select class="custom-select_re" id="req_type" name="req_type">
										<option value="전체" selected>전체</option>
										<option value="정규">정규</option>
										<option value="긴급">긴급</option>
									</select>
								</div>
								<div class="date_form">
									<input type="date" id="date_first" name="date_first" style="border: 1px solid #d1d3e2; border-radius: 5px;"> 
									<i class="fa fa-minus date_icon"></i> 
									<input type="date" id="date_last" name="date_last" style="border: 1px solid #d1d3e2; border-radius: 5px;">
								</div>
							</article>
							<article class="filter-body2">
								<div class="input-group">
									<select class="custom-select_re" id="statusNo" name="statusNo">
										<option value="0" selected>전체</option>
										<!-- 진행중 단계에 접수, 개발, 테스트, 배포 모두 포함 -->
										<option value="2">진행중</option>
										<option value="11">완료</option>
										<option value="12">반려</option>
									</select>
								</div>
								<div class="input-group">
									<select class="custom-select_re" id="sno" name="sno">
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
					<section class="table border-left-dark shadow">
						<article class="table-header">
							<h4>내 요청 목록</h4>
						</article>
						<table class="member" id="table_content">
							<tr>
								<th>No.</th>
								<th>시스템</th>
								<th>요청 유형</th>
								<th>요청 제목</th>
								<th>요청 일자</th>
								<th>단계</th>
							</tr>

							<c:forEach var="request" items="${requestList}">
								<tr>
									<td class="rno" style="max-width: 40px;  min-width : 40px; white-space: nowrap; overflow: hidden;">${request.rno}</td>
									<td class="client" style="max-width: 95px;  min-width : 95px; white-space: nowrap; overflow: hidden;">${request.systemName}</td>
									<c:if test="${request.statusNo == 1}">
										<td class="sysType">
											<span class="badge badge-warning">대기</span>
										</td>
									</c:if>
									<c:if test="${request.statusNo == 12}">
										<td class="sysType">
											<span class="badge badge-warning">반려</span>
										</td>
									</c:if>
									<c:if test="${request.statusNo != 1 && request.statusNo != 12}">
										<c:if test="${request.reqType eq '정규'}">
											<td class="sysType">
												<span class="badge badge-primary">${request.reqType}</span>
											</td>
										</c:if>
										<c:if test="${request.reqType eq '긴급'}">
											<td class="sysType">
												<span class="badge badge-danger">${request.reqType}</span>
											</td>
										</c:if>

									</c:if>
									<td class="reqTitle" style="max-width: 190px; min-width : 190px; white-space: nowrap; overflow: hidden;">
										<c:if test="${request.usrCheck == 1}">
											<strong class="text-danger">N</strong>
										</c:if>									
										${request.reqTitle}
									</td>
									<td class="reqDate" style="max-width: 87px; min-width : 87px; white-space: nowrap; overflow: hidden;">
										<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd" />
									</td>
									<td class="step_td">
										<%@ include file="/WEB-INF/views/srm/restatus/stepintable_user.jsp"%>
									</td>
								</tr>
							</c:forEach>
						</table>
						<div class="pager default">
							<div class="pagingButtonSet d-flex justify-content-center">
								<a onclick="pageChange(1)" type="button" class="btn btn-muted shadow">처음</a>
								<c:if test="${pager.groupNo > 1}">
									<a onclick="pageChange(${pager.startPageNo-1})" class="btn btn-muted shadow">이전</a>

								</c:if>

								<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
									<c:if test="${pager.pageNo != i}">
										<a onclick="pageChange(${i})" type="button" class="btn btn-white shadow">${i}</a>
									</c:if>
									<c:if test="${pager.pageNo == i}">
										<a onclick="pageChange(${i})" type="button" class="btn btn-dark shadow">${i}</a>
									</c:if>
								</c:forEach>

								<c:if test="${pager.groupNo < pager.totalGroupNo }">
									<a onclick="pageChange(${pager.endPageNo+1})" type="button" class="btn btn-muted shadow">다음</a>

								</c:if>
								<a onclick="pageChange(${pager.totalPageNo})" type="button" class="btn btn-muted shadow">맨끝</a>
							</div>
						</div>
						<div class="loading">
							<span></span>
						    <span></span>
						    <span></span>
						</div>

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
/* 
	$(document).ready(function () {
		// member의 type은 controller에서 넣어줌, 설정 필요 없음
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
*/

// 페이지 이동 ajax
	function pageChange(i){
		let loading = document.querySelector(".loading");
		loading.style.visibility = 'visible';	
		console.log(loading);
	
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
			contentType: "application/json; charset=UTF-8",
			success : function (){
				loading.style.visibility = 'hidden';
			}
			
		}).done((data) => {
			$('#table_content').html(data);
			if(document.querySelector('.default')) {
				const pageDefault = document.querySelector('.default');
				pageDefault.remove();
			}
		});
	}	
	
// filter 검색 기능 ajax
	function search(){
		let loading = document.querySelector(".loading");
		loading.style.visibility = 'visible';	
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
			contentType: "application/json; charset=UTF-8",
			success : function (){
				loading.style.visibility = 'hidden';
			}
			
		}).done((data) => {
			$('#table_content').html(data);
			if(document.querySelector('.default')) {
				const pageDefault = document.querySelector('.default');
				pageDefault.remove();
			}
		});
	}
	



</script>




</body>

</html>
