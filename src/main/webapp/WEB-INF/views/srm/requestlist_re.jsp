<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<style>
a {
	text-decoration: none;
}

main {
	display: flex;
	height: 800px;
	width: 1050px;
	position: relative;
	justify-content: center;
	align-items: center;
	font-size: 15px;
}

.filter {
	width: 1050px;
	height: 200px;
	overflow: hidden;
	text-align: start;
	align-items: center;
	position: absolute;
	top: 0;
	left: 0;
	background-color: #fff;
	border-bottom: 1px solid #e3e6f0;
	border-radius: 5px;
	border: 1px solid rgba(0, 0, 0, 0.125);
	border-radius: 0.25rem;
	-webkit-box-shadow: 1px 1px 5px rgba(126, 142, 159, 0.1);
	box-shadow: 1px 1px 5px rgba(126, 142, 159, 0.1);
}

.filter .filter-head {
	background-color: #f8f9fc;
	border-bottom: 1px solid #e3e6f0;
}

.filter .filter-head h4 {
	color: #68a329;
	font: bold;
	padding-top: 10px;
	padding-left: 15px;
	font-size: 15px;
}

.filter .filter-name {
	width: 100px;
	height: 200px;
	position: absolute;
	margin: 0;
	left: 2%;
	top: 22%;
}

.filter .filter-name h6 {
	font-size: 15px;
	margin: 20px 10px;
}

.filter .filter-name2 {
	width: 100px;
	height: 200px;
	position: absolute;
	margin: 0;
	left: 42%;
	top: 22%;
}

.filter .filter-name2 h6 {
	font-size: 15px;
	margin: 20px 10px;
	font-size: 15px;
}

.filter .filter-body {
	width: 300px;
	height: 200px;
	overflow: hidden;
	position: absolute;
	left: 13%;
	top: 23%;
	float: left;
}

.filter .filter-body .input-group {
	width: 100px;
	margin: 8px;
}

.filter .filter-body .date_form {
	margin: 6px;
}

.filter .filter-body2 {
	width: 300px;
	height: 200px;
	overflow: hidden;
	position: absolute;
	left: 50%;
	top: 23%;
	float: left;
}

.filter .filter-body2 .input-group {
	width: 100px;
	margin: 5px;
}

.table {
	text-align: center;
	width: inherit;
	height: 500px;
	overflow: hidden;
	text-align: start;
	align-items: center;
	position: absolute;
	top: 28%;
	left: 0;
	background-color: #fff;
	border-bottom: 1px solid #e3e6f0;
	border-radius: 5px;
	border: 1px solid rgba(0, 0, 0, 0.125);
	border-radius: 0.25rem;
	-webkit-box-shadow: 1px 1px 5px rgba(126, 142, 159, 0.1);
	box-shadow: 1px 1px 5px rgba(126, 142, 159, 0.1);
}

.table .table-header {
	background-color: #f8f9fc;
	border-bottom: 1px solid #e3e6f0;
	border-bottom: 1px solid #e3e6f0;
}

.table .table-header h4 {
	color: #68a329;
	font: bold;
	padding-top: 10px;
	padding-left: 15px;
	font-size: 15px;
}

.table .table-body {
	height: inherit;
}

.member {
	margin: 5px 10px;
	width: inherit;
	background-color: #fff;
	border-collapse: collapse;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.15);
	border-radius: 5px;
	overflow: hidden;
}

.member caption {
	font-size: 30px;
	margin-bottom: 30px;
}

.member tr {
	width: 1050px;
	border-bottom: 1px solid #eee;
	transition: 0.3s;
}

.member tr:hover {
	background-color: #eee;
}

.member th, .member td {
	font-size: 12px;
	width: 1050px;
	padding: 5px;
	text-align: center;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.member tr th {
	background-color: var(--gray-dark);
	color: #fff;
}

.member .step_td {
display: inline-block;
width: 500px;
}

.member tr:hover {
	background-color: rgba(211, 211, 211, 0.438);
}

.filter .search-button {
	position: absolute;
	width: 80px;
	height: 50px;
	left: 61%;
	top: 70%;
	z-index: 5;
}
.pager{
position: absolute;
left: 50%;
top : 75%;
width : inherit;
}
.pager .write{
position: absolute;
left: 110%;
top : 0%;
width: 60px;
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
					<main class="all">
					<section class="filter">
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
									<input type="date" id="date_first" name="date_first" value="<fmt:formatDate value="${listFilter.date_first}" pattern="yyyy-MM-dd" />"> <i class="fa fa-minus"></i> <input type="date" id="date_last" name="date_last" value="<fmt:formatDate value="${listFilter.date_last}" pattern="yyyy-MM-dd" />">
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
												<option value="${listFilter.sno}" selected>${listFilter.sno}</option>
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
					<section class="table">
						<article class="table-header">
							<h4>리스트</h4>
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
									<td class="rno">${request.rno}</td>
									<!-- 나중에 시스템 이름으로 바꾸어 줘야 함. -->
									<td class="client">${request.sno}</td>

									<!-- 요청 유형 테이블에서 req type 가져와야 함. -->

									<c:if test="${request.statusNo == 1}">
										<td class="sysType">미정</td>
									</c:if>
									<c:if test="${request.statusNo == 12}">
										<td class="sysType">반려</td>
									</c:if>
									<c:if test="${request.statusNo != 1 && request.statusNo != 12}">
										<td class="sysType">${request.reqType}</td>
									</c:if>

									<td class="reqTitle" style="max-width: 100px; white-space: nowrap; overflow: hidden;">${request.reqTitle}</td>
									<td class="reqDate" style="max-width: 100px; white-space: nowrap; overflow: hidden;">
										<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd" />
									</td>

									<td class="step_td">
										<%@ include file="/WEB-INF/views/srm/restatus/stepintable.jsp"%>
									</td>

								</tr>
							</c:forEach>
						</table>
					</section>
					</main>
				</div>
				<div class="pager">
					<div class="pagingButtonSet d-flex justify-content-center">
						<a href="requestlist?pageNo=1" type="button" class="btn btn-muted shadow">◀◀</a>
						<c:if test="${pager.groupNo > 1}">
							<a href="requestlist?pageNo=${pager.startPageNo-1}" type="button" class="btn btn-muted shadow">◀</a>
						</c:if>

						<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
							<c:if test="${pager.pageNo != i}">
								<a href="requestlist?pageNo=${i}" type="button" class="btn btn-white shadow">${i}</a>
							</c:if>
							<c:if test="${pager.pageNo == i}">
								<a href="requestlist?pageNo=${i}" type="button" class="btn btn-dark shadow">${i}</a>
							</c:if>
						</c:forEach>

						<c:if test="${pager.groupNo < pager.totalGroupNo }">
							<a href="requestlist?pageNo=${pager.endPageNo+1}" type="button" class="btn btn-muted shadow">▶</a>

						</c:if>
						<a href="requestlist?pageNo=${pager.totalPageNo}" type="button" class="btn btn-muted shadow">▶▶</a>
					</div>
					<a type="button" href="<c:url value='/customer/request'/>" class="btn btn-muted shadow write">글 작성</a>
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

</html>
