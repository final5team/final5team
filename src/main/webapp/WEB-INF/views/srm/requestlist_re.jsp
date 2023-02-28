<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/listcss/requestlistcss.css" rel="stylesheet">

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
						<form action="requestlist" method="get">
							<article class="filter-head">
								<h4>필터</h4>
							</article>

							<article class="filter-name">
								<h6>유형 선택</h6>
								<h6>작성 날짜</h6>
							</article>

							<article class="filter-name2">
								<h6>단계 선택</h6>

								<c:if test="${sessionScope.member.mtype == 'pm'}">
									<h6>시스템</h6>
								</c:if>
							</article>
							<article class="search-button">
								<button class="btn btn-dark btn-sm" type="submit">검색</button>
							</article>
							<article class="write-button">
								<a type="button" href="<c:url value='/customer/request'/>" class="btn btn-dark btn-sm write">요청 작성</a>
							</article>
							<article class="filter-body">
								<div class="input-group">
									<c:if test="${listFilter.reqType == null}">
										<select class="custom-select" id="req_type" name="req_type">
											<option value="전체" selected>전체</option>
											<option value="정규">정규</option>
											<option value="긴급">긴급</option>
										</select>
									</c:if>
									<c:if test="${listFilter.reqType != null}">
										<select class="custom-select" id="req_type" name="req_type">
											<option value="${listFilter.reqType}" selected>${listFilter.reqType}</option>
											<c:if test="${listFilter.reqType != '전체'}">
												<option value="전체">전체</option>
											</c:if>
											<c:if test="${listFilter.reqType != '정규'}">
												<option value="정규">정규</option>
											</c:if>
											<c:if test="${listFilter.reqType != '긴급'}">
												<option value="긴급">긴급</option>
											</c:if>
										</select>
									</c:if>

								</div>
								<div class="date_form">
									<input type="date" id="date_first" name="date_first" style="border: 1px solid #d1d3e2; border-radius: 5px;" 
									value="<fmt:formatDate value="${listFilter.date_first}" pattern="yyyy-MM-dd" />"> <i class="fa fa-minus"></i> 
									<input type="date" id="date_last" name="date_last" style="border: 1px solid #d1d3e2; border-radius: 5px;"  
									value="<fmt:formatDate value="${listFilter.date_last}" pattern="yyyy-MM-dd" />">
								</div>
							</article>
							<article class="filter-body2">
								<div class="input-group">
									<c:if test="${listFilter.statusValue == null}">
										<select class="custom-select" id="statusNo" name="statusNo">
											<option value="0" selected>전체</option>
											<option value="1">접수</option>
											<option value="2">개발</option>
											<option value="5">테스트</option>
											<option value="8">유저테스트</option>
											<option value="10">배포</option>
											<option value="11">완료</option>
											<option value="12">반려</option>
										</select>
									</c:if>

									<c:if test="${listFilter.statusValue != null}">
										<select class="custom-select" id="statusNo" name="statusNo">
											<option value="${listFilter.statusNo}" selected>${listFilter.statusValue}</option>
											<option value="0">전체</option>
											<c:if test="${listFilter.statusNo != 1}">
												<option value="1">접수</option>
											</c:if>
											<c:if test="${listFilter.statusNo != 2 && listFilter.statusNo != 3 && listFilter.statusNo != 4}">
												<option value="2">개발</option>
											</c:if>
											<c:if test="${listFilter.statusNo != 5 && listFilter.statusNo != 6 && listFilter.statusNo != 7}">
												<option value="5">테스트</option>
											</c:if>
											<c:if test="${listFilter.statusNo != 8}">
												<option value="8">유저테스트</option>
											</c:if>
											<c:if test="${listFilter.statusNo != 10}">
												<option value="10">배포</option>
											</c:if>
											<c:if test="${listFilter.statusNo != 11 && listFilter.statusNo != 13}">
												<option value="11">완료</option>
											</c:if>
											<c:if test="${listFilter.statusNo != 12}">
												<option value="12">반려</option>
											</c:if>
										</select>
									</c:if>

								</div>
								<c:if test="${sessionScope.member.mtype == 'pm'}">
									<div class="input-group">
										<select class="custom-select" id="sno" name="sno">
											<c:if test="${listFilter.sno == 0}">
												<option value="0" selected>시스템</option>
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
								</c:if>
							</article>




						</form>
					</section>
					<section class="table border-left-dark">
						<article class="table-header">
							<h4>담당 업무 목록</h4>
							<div class="switch_div">
									<label class="switch">
									  <input type="checkbox" checked onclick="myRequestList(`${sessionScope.member.mtype}`)" id ="myRequest" />
									  <span class="slider round"></span>
									</label>
								</div>
						</article>
						<!-- ajax 수정 목록 -->
						<table class="member" id="table_content">
						
						</table>
						
													
						
					</section>
					<div class="pager">
						<div class="pagingButtonSet d-flex justify-content-center">
							<a href="requestlist?pageNo=1&req_type=${listFilter.reqType}&date_first=${listFilter.dateFirst}&date_last=${listFilter.dateLast}&statisNo=${listFilter.statusNo}&sno=${listFilter.sno}" 
								type="button" class="btn btn-muted shadow">◀◀</a>
							<c:if test="${pager.groupNo > 1}">
								<a href="requestlist?pageNo=${pager.startPageNo-1}
								&req_type=${listFilter.reqType}&date_first=${listFilter.date_first}$date_last=${listFilter.date_last}&statisNo=${listFilter.statusNo}&sno=${listFilter.sno}"
								 type="button" class="btn btn-muted shadow">◀</a>
							</c:if>

							<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
								<c:if test="${pager.pageNo != i}">
									<a href="requestlist?pageNo=${i}&req_type=${listFilter.reqType}&date_first=${listFilter.dateFirst}&date_last=${listFilter.dateLast}&statisNo=${listFilter.statusNo}&sno=${listFilter.sno}"
							 				type="button" class="btn btn-white shadow">${i}</a>
								</c:if>
								<c:if test="${pager.pageNo == i}">
									<a href="requestlist?pageNo=${i}&req_type=${listFilter.reqType}&date_first=${listFilter.dateFirst}&date_last=${listFilter.dateLast}&statisNo=${listFilter.statusNo}&sno=${listFilter.sno}" 
											type="button" class="btn btn-dark shadow">${i}</a>
								</c:if>
							</c:forEach>

							<c:if test="${pager.groupNo < pager.totalGroupNo }">
								<a href="requestlist?pageNo=${pager.endPageNo+1}&req_type=${listFilter.reqType}&date_first=${listFilter.dateFirst}&date_last=${listFilter.dateLast}&statisNo=${listFilter.statusNo}&sno=${listFilter.sno}" 
										type="button" class="btn btn-muted shadow">▶</a>

							</c:if>
							<a href="requestlist?pageNo=${pager.totalPageNo}&req_type=${listFilter.reqType}&date_first=${listFilter.dateFirst}&date_last=${listFilter.dateLast}&statisNo=${listFilter.statusNo}&sno=${listFilter.sno}"
							 		type="button" class="btn btn-muted shadow">▶▶</a>
						</div>
					</div>
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
/* 내 담당 업무 목록 ajax 호출 : 페이지 로딩 */
	$(document).ready(function () {
		/* member의 type은 controller에서 넣어줌, 설정 필요 없음  */
		console.log("바로 실행");
		data = {reqType : '전체', dateFirst: '', dateLast : '', sno : '0', statusNo : '0',  pageNo : 1 };	
		$.ajax({
	  		url : "myworklist",
			method : "post",
			data : JSON.stringify(data),
			contentType: "application/json; charset=UTF-8"
		}).done((data) => {
			$('#table_content').html(data);
		});
	});


/* 내 요청 목록 ajax 호출 : switch */
	function myRequestList(mtype){
		let memberType = mtype;
		/* mtype 전달, 페이징 처리 */
		if($('#myRequest').is(":checked")){
			console.log("임시, switch 확인용");
			data = {reqType : '전체', dateFirst: '', dateLast : '', sno : '0', statusNo : '0',  pageNo : 1 };	
			$.ajax({
		  		url : "myworklist",
				method : "post",
				data : JSON.stringify(data),
				contentType: "application/json; charset=UTF-8"
			}).done((data) => {
				$('#table_content').html(data);
			});
			
			/* 내 요청 목록 호출 */
		} else {
			console.log("내 요청 목록 호출");
			data = {reqType : '전체', dateFirst: '', dateLast : '', sno : '0', statusNo : '0',  pageNo : 1}
			$.ajax({
		  		url : "myrequestlist",
				method : "post",
				data : JSON.stringify(data),
				contentType: "application/json; charset=UTF-8"
			}).done((data) => {
				$('#table_content').html(data);
			});
		}
		
		
	} 







/*  검색 ajax 시 사용 예정
let reqType = document.getElementById(req_type);
		let dateFirst = document.getElementById(date_first);
		let dateLast = document.getElementById(date_last);
		let sno = document.getElementById(sno);
		let statusNo = document.getElementById(statusNo);
*/



</script>


</body>

</html>
