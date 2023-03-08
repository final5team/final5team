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
					<section class="filter border-left-dark shadow">
						<form>
							<article class="filter-head">
								<h4 class="filtering-name">업무 검색</h4>
							</article>

							<article class="filter-name">
								<h6>요청 유형</h6>
								<h6>요청 일자</h6>
							</article>

							<article class="filter-name2">
								<h6>단계</h6>

								<c:if test="${sessionScope.member.mtype != 'user'}">
								<!-- pm이 아닌 경우, 초기 시스템 선택 숨김상태 -->
									<c:if test="${sessionScope.member.mtype == 'pm'}">
										<h6>시스템</h6>
									</c:if>
									<c:if test="${sessionScope.member.mtype != 'pm'}">
										<h6 id="sno_label" style="visibility : hidden;">시스템</h6>
									</c:if>
								</c:if>
							</article>
							<article class="search-button">
								<button class="btn btn-dark btn-sm" type="button" onclick="search()">검색</button>
							</article>
							<article class="write-button">
								<a type="button" href="<c:url value='/customer/request'/>" class="btn btn-dark btn-sm write">요청 작성</a>
							</article>
							<article class="filter-body">
								<div class="input-group">
									<c:if test="${listFilter.reqType == null}">
										<select class="custom-select_re" id="req_type" name="req_type">
											<option value="전체" selected>전체</option>
											<option value="정규">정규</option>
											<option value="긴급">긴급</option>
										</select>
									</c:if>
									<c:if test="${listFilter.reqType != null}">
										<select class="custom-select_re" id="req_type" name="req_type">
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
									<input type="date" id="date_first" name="date_first" style="border: 1px solid #d1d3e2; border-radius: 5px;" value="<fmt:formatDate value="${listFilter.date_first}" pattern="yyyy-MM-dd" />"> 
									<i class="fa fa-minus date_icon"></i> 
									<input type="date" id="date_last" name="date_last" style="border: 1px solid #d1d3e2; border-radius: 5px;" value="<fmt:formatDate value="${listFilter.date_last}" pattern="yyyy-MM-dd" />">
								</div>
							</article>
							<article class="filter-body2">
								<div class="input-group">
									<c:if test="${listFilter.statusValue == null}">
										<select class="custom-select_re" id="statusNo" name="statusNo">
											<option value="0" selected>전체</option>
											<option value="1">접수</option>
											<option value="2">개발</option>
											<option value="5">테스트</option>
											<option value="8">품질테스트</option>
											<option value="10">배포</option>
											<option value="11">완료</option>
											<option value="12">반려</option>
										</select>
									</c:if>

									<c:if test="${listFilter.statusValue != null}">
										<select class="custom-select_re" id="statusNo" name="statusNo">
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
												<option value="8">품질테스트</option>
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
											<select class="custom-select_re sno" id="sno" name="sno">
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
									</c:if>
									<c:if test="${sessionScope.member.mtype != 'pm'}">
									<!-- pm이 아닌 경우, 초기 시스템 선택 숨김상태 -->
										<div class="input-group">
											<select class="custom-select_re sno" id="sno" name="sno" style="visibility : hidden;">
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
									</c:if>
								
								
								<!-- 지워야 함-->
								<%-- <c:if test="${sessionScope.member.mtype != 'pm'}">
									<input type="hidden" class="sno" value="${sessionScope.member.sno}"> 
								</c:if> --%>
								
							</article>
						</form>
					</section>
					<section class="table border-left-dark shadow">

						<!-- 유저가 아닌 경우, 요청 목록과 업무 목록 스위치 -->
						<c:if test="${sessionScope.member.mtype != 'user'}">
							<article class="table-header">
								<h4 class="table-name">담당 업무 목록</h4>
								<div class="switch_div">
									<label class="switch"> <input type="checkbox" checked onclick="myRequestList(`${sessionScope.member.mtype}`)" id="myRequest" /> 
									<span class="slider round"></span>
									</label>
								</div>
							</article>
						</c:if>

						<!-- 유저인 경우, 내 요청 목록만 출력 -->
						<c:if test="${sessionScope.member.mtype == 'user'}">
							<article class="table-header">
								<h4 class="table-name">내 요청 목록</h4>
							</article>
						</c:if>
						<!-- ajax 수정 목록 -->
						<table class="member" id="table_content">
							<!-- 기존 페이지-->
							<tr >
								<th class="ex th_first" id="th_rno">No.</th>
								<th class="ex th_second" id="th_sno">시스템</th>
								<th class="ex th_third" id="th_reqtype">요청 유형</th>
								<th class="ex th_four" id="th_title">요청 제목</th>
								<th class="ex th_five" id="th_reqdate">요청 일자</th>
								<th class="ex">단계</th>
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
									</c:if>
									<td class="reqTitle" style="max-width: 190px; min-width : 190px; white-space: nowrap; overflow: hidden;">${request.reqTitle}</td>
									<td class="reqDate" style="max-width: 87px; min-width : 87px; white-space: nowrap; overflow: hidden;">
										<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd" />
									</td>
									<td class="step_td">
										<%@ include file="/WEB-INF/views/srm/restatus/stepintable.jsp"%>
									</td>
								</tr>
							</c:forEach>
						</table>
						<div class="pager default">
							<div class="pagingButtonSet d-flex justify-content-center">
								<a onclick="pageChange(1)" type="button" class="btn btn-muted shadow">처음</a>
								<c:if test="${pager.groupNo > 1}">
									<a onclick="pageChange(${pager.startPageNo-1}  )" class="btn btn-muted shadow">이전</a>

								</c:if>

								<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
									<c:if test="${pager.pageNo != i}">
										<a onclick="pageChange(${i} )" type="button" class="btn btn-white shadow">${i}</a>
									</c:if>
									<c:if test="${pager.pageNo == i}">
										<a onclick="pageChange(${i} )" type="button" class="btn btn-dark shadow">${i}</a>
									</c:if>
								</c:forEach>

								<c:if test="${pager.groupNo < pager.totalGroupNo }">
									<a onclick="pageChange(${pager.endPageNo+1} )" type="button" class="btn btn-muted shadow">다음</a>

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
					<input type="hidden" id="state" value=""> 
					<input type="hidden" id="th_first_id" value=""> 
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
	$(document).ready(function() {
		//테이블 정렬을 위한 변수
		let state_value = document.querySelector('#state');
		let state = state_value.value;
		
		let th_first_id_value = document.querySelector('#th_first_id');
		let th_first_id = th_first_id_value.value;
				
		
		
		//글 번호 정렬 선택
		let th_rno = document.querySelector('#th_rno');
		th_rno.addEventListener('click', (event) => {
			event.preventDefault();
			
			console.log('rno');
			//변수값 설정
			state = 'asc';
			th_first_id = 'th_rno';
			//hidden 태그 값 설정
			state_value.value = 'asc';
			th_first_id_value.value = 'th_rno';
 			//css 변경
			th_rno.classList.remove('th_first');
			th_rno.classList.add('th_first_asc');
			
 			search(state, th_first_id);
 			
 			
		});
		
		//시스템 정렬 선택
		let th_sno = document.querySelector('#th_sno');
		th_sno.addEventListener('click', (event)=> {
			event.preventDefault();
			
			console.log('sno');
			//변수값 설정
			state = 'asc';
			th_first_id = 'th_sno';
			//hidden 태그 값 설정
			state_value.value = 'asc';
			th_first_id_value.value = 'th_sno';
			//css 변경
			th_rno.classList.remove('th_second');
			th_rno.classList.add('th_second_asc');
			
			search(state, th_first_id);
		});
		
		//요청 유형 정렬 선택
		let th_reqtype = document.querySelector('#th_reqtype');
		th_reqtype.addEventListener('click', (event)=> {
			event.preventDefault();
			
			console.log('reqtype');
			//변수값 설정
			state = 'asc';
			th_first_id = 'th_reqtype';
			//hidden 태그 값 설정
			state_value.value = 'asc';
			th_first_id_value.value = 'th_reqtype';
			//css 변경
			th_rno.classList.remove('th_third');
			th_rno.classList.add('th_third_asc');
			
			search(state, th_first_id);
		});
		
		//요청 제목 정렬 선택
		let th_title = document.querySelector('#th_title');
		th_title.addEventListener('click', (event)=> {
			event.preventDefault();
			
			console.log('th_title');
			//변수값 설정
			state = 'asc';
			th_first_id = 'th_title';
			//hidden 태그 값 설정
			state_value.value = 'asc';
			th_first_id_value.value = 'th_title';
			//css 변경
			th_rno.classList.remove('th_four');
			th_rno.classList.add('th_four_asc');
			
			search(state, th_first_id);
		});
		
		//요청 일자 정렬 선택
		let th_reqdate = document.querySelector('#th_reqdate');
		th_reqdate.addEventListener('click', (event)=> {
			event.preventDefault();
			console.log('th_reqdate');
			//변수값 설정
			state = 'asc';
			th_first_id = 'th_reqdate';
			//hidden 태그 값 설정
			state_value.value = 'asc';
			th_first_id_value.value = 'th_reqdate';
			//css 변경
			th_rno.classList.remove('th_five');
			th_rno.classList.add('th_five_asc');
			
			search(state, th_first_id);
		});
		
		
		
	})
 
// 내 요청 목록 ajax 호출 : switch 
	function myRequestList(mtype){
		let memberType = mtype;
		let loading = document.querySelector(".loading");
		loading.style.visibility = 'visible';
		// mtype 전달, 페이징 처리 
		if($('#myRequest').is(":checked")){
			
			//filter 초기화
			$('#req_type option:eq(0)').prop("selected", true);
			$('#statusNo option:eq(0)').prop("selected", true);
			$('#sno option:eq(0)').prop('selected', true);
			let date_first = document.querySelector('#date_first');
			date_first.value = null;
			let date_last = document.querySelector('#date_last');
			date_last.value = null;
			
			if(memberType != 'pm'){
				//담당자들 시스템 필터 hidden처리
				let sno_label = document.querySelector("#sno_label");
				let sno_input = document.querySelector('#sno');
				sno_label.style.visibility = 'hidden';
				sno_input.style.visibility = 'hidden';
			}
			
			//테이블 색상 되돌리기
			let tableHead = document.querySelectorAll(".ex");
			for(let i = 0; i < tableHead.length; i++){
				tableHead[i].classList.remove('bc');
			}
			// 테이블 h4 태그 글자 바꾸기 
			let name = document.getElementsByClassName("table-name")[0];
			name.innerText='담당 업무 목록';
			name.classList.remove('fc');
			//테이블 왼쪽 border 색 바꾸기
			let tableBorder = document.querySelector(".table");
			tableBorder.classList.add('border-left-dark');
			tableBorder.classList.remove('border-left-primary');
			// 검색 h4 태그 글자 바꾸기
			let filterName = document.getElementsByClassName("filtering-name")[0];
			filterName.innerText='업무 검색';
			data = {reqType : '전체', dateFirst: '', dateLast : '', sno : '0', statusNo : '0',  pageNo : 1 };	
			$.ajax({
		  		url : "myworklist",
				method : "post",
				data : JSON.stringify(data),
				contentType: "application/json; charset=UTF-8",
				success : function (){
					loading.style.visibility = 'hidden';
				}
			}).done((data) => {
				let table = document.querySelector('#table_content');
				$('#table_content').html(data);
				//기존 페이지 태그 삭제하기
				const pageDefault = document.querySelector('.default');
				if(pageDefault != null){
					pageDefault.remove();
				}
			});
			// 내 요청 목록 호출 
		} else {
			//filter 초기화
			$('#req_type option:eq(0)').prop("selected", true);
			$('#statusNo option:eq(0)').prop("selected", true);
			$('#sno option:eq(0)').prop('selected', true);
			let date_first = document.querySelector('#date_first');
			date_first.value = null;
			let date_last = document.querySelector('#date_last');
			date_last.value = null;
			
			//담당자들 시스템 필터 hidden처리
			if(memberType != 'pm'){
				let sno_label = document.querySelector("#sno_label");
				let sno_input = document.querySelector('#sno');
				sno_label.style.visibility = 'visible';
				sno_input.style.visibility = 'visible';
			}
			// h4 태그 글자 바꾸기 
			let name = document.getElementsByClassName("table-name")[0];
			name.innerText='내 요청 목록';
			name.classList.add('fc');
			// 검색 h4 태그 글자 바꾸기
			let filterName = document.getElementsByClassName("filtering-name")[0];
			filterName.innerText='요청 검색';
			//테이블 왼쪽 border 색 바꾸기
			let tableBorder = document.querySelector(".table");
			tableBorder.classList.remove('border-left-dark');
			tableBorder.classList.add('border-left-primary');
			/* console.log("내 요청 목록 호출"); */
			
			data = {reqType : '전체', dateFirst: '', dateLast : '', sno : '0', statusNo : '0',  pageNo : 1}
			$.ajax({
		  		url : "workerrequestlist",
				method : "post",
				data : JSON.stringify(data),
				contentType: "application/json; charset=UTF-8",
				success : function (){
					loading.style.visibility = 'hidden';
				}
			}).done((data) => {
				$('#table_content').html(data);
				//테이블 색상 변경하기
				let tableHead = document.querySelectorAll(".ex");
				console.log(tableHead);
				for(let i = 0; i < tableHead.length; i++){
					tableHead[i].classList.add('bc');
				}
				//기존 페이지 태그 삭제하기
				const pageDefault = document.querySelector('.default');
				if(pageDefault != null){
					pageDefault.remove();
				}
			});
		}
	} 
	
		// 페이지 이동 ajax
		function pageChange(i, state, th_first_id){
			console.log('페이지 이동 ajax');
			console.log(state, th_first_id);
			
			//hidden tag 가져오기
			let state_value = document.querySelector('#state');
			let th_first_id_value = document.querySelector('#th_first_id');
			
			//가져온 hedden tag에 값 넣어주기
			state_value.value = state;
			th_first_id_value.value = th_first_id;
			console.log("넣어준 값" ,state_value, th_first_id_value);
			
			
			let loading = document.querySelector(".loading");
			loading.style.visibility = 'visible';
			let pageNo = i;
			
			let filterReqType = document.getElementById('req_type');
			let ReqType = filterReqType.options[filterReqType.selectedIndex].text;
			
			let filterDateFirst = document.getElementById('date_first');
			let dateFirst = filterDateFirst.value
			
			let filterDateLast = document.getElementById('date_last');
			let dateLast = filterDateLast.value
			
			let sno = '0';
			if(document.getElementById('sno') != null) {
				let filterSno = document.getElementById('sno');
				let sno = filterSno.options[filterSno.selectedIndex].value
			} else {
				sno = document.querySelector('.sno').value
				console.log(sno);
			}
			let filterStatusNo = document.getElementById('statusNo');  
			let statusNo = filterStatusNo.options[filterStatusNo.selectedIndex].value
			
			
			
			
			data = {pageNo : i, reqType : ReqType, dateFirst : dateFirst, dateLast : dateLast, sno : parseInt(sno), 
					statusNo : parseInt(statusNo), columnName : th_first_id, sortState : state}
			
			// 담당 업무 목록으로 검색 
			if($('#myRequest').is(":checked")){ 
				console.log("담당 업무 목록 페이지 이동" + i);
				//테이블 색상 되돌리기
				let tableHead = document.querySelectorAll(".ex");
				console.log(tableHead);
				for(let i = 0; i < tableHead.length; i++){
					tableHead[i].classList.remove('bc');
				}
				
				$.ajax({
					url : "myworklist",
					method : "post",
					data : JSON.stringify(data),
					contentType: "application/json; charset=UTF-8",
					success : function (){
						loading.style.visibility = 'hidden';
					}
					
				}).done((data) => {
					$('#table_content').html(data);
					
					//기존 페이지 태그 삭제하기
					const pageDefault = document.querySelector('.default');
					if(pageDefault != null){
						pageDefault.remove();
					}
					
					
				});
			} else {
				console.log("내 요청 목록 페이지 이동" + i);
				$.ajax({
					url : "workerrequestlist",
					method : "post",
					data : JSON.stringify(data),
					contentType: "application/json; charset=UTF-8",
					success : function (){
						loading.style.visibility = 'hidden';
					}
					
				}).done((data) => {
					$('#table_content').html(data);
					
					//테이블 색상 변경하기
					let tableHead = document.querySelectorAll(".ex");
					console.log(tableHead);
					for(let i = 0; i < tableHead.length; i++){
						tableHead[i].classList.add('bc');
					}
					
					//기존 페이지 태그 삭제하기
					const pageDefault = document.querySelector('.default');
					if(pageDefault != null){
						pageDefault.remove();
					}
					
				});
			}
		}	
	// filter 검색 기능 ajax
	function search(state, th_first_id){
			//테이블 정렬을 위한 변수
			let state_value = document.querySelector('#state');
			state = state_value.value;
			let th_first_id_value = document.querySelector('#th_first_id');
			th_first_id = th_first_id_value.value;
			
			console.log("검색 전 태그값" , state_value, th_first_id_value);
			console.log("검색 전 매개변수 값" ,state, th_first_id);
		
		
			let loading = document.querySelector(".loading");
			loading.style.visibility = 'visible';
	//		검색 filter 값 가져오기
			let filterReqType = document.getElementById('req_type');
			let ReqType = filterReqType.options[filterReqType.selectedIndex].text;
			
			let filterDateFirst = document.getElementById('date_first');
			let dateFirst = filterDateFirst.value
			
			let filterDateLast = document.getElementById('date_last');
			let dateLast = filterDateLast.value
			
			let sno = '0';
			if(document.getElementById('sno') != null) {
				console.log("pm인 경우");
				let filterSno = document.getElementById('sno');
				sno = filterSno.options[filterSno.selectedIndex].value
			} else {
				console.log("pm이 아닌 경우");
				sno = document.querySelector('.sno').value
				console.log(sno);
			}
			
			let filterStatusNo = document.getElementById('statusNo');  
			let statusNo = filterStatusNo.options[filterStatusNo.selectedIndex].value
			
			
			
			if(typeof state == 'undefined' || typeof th_first_id == 'undefined'){
				console.log('검색에 정렬 입력값 들어옴');
				console.log(state);
				console.log(th_first_id);
			} 
			
			
			data = {reqType : ReqType, dateFirst : dateFirst, dateLast : dateLast, sno : parseInt(sno), statusNo : parseInt(statusNo), 
					columnName : th_first_id, sortState : state }
			
			// 담당 업무 목록 검색 기능
			if($('#myRequest').is(":checked")){ 
				
				//테이블 색상 되돌리기
				let tableHead = document.querySelectorAll(".ex");
				for(let i = 0; i < tableHead.length; i++){
					tableHead[i].classList.remove('bc');
				}
				$.ajax({
					url : "myworklist",
					method : "post",
					data : JSON.stringify(data),
					contentType: "application/json; charset=UTF-8",
					success : function (){
						loading.style.visibility = 'hidden';
					}
					
				}).done((data) => {
					$('#table_content').html(data);
					//기존 페이지 태그 삭제하기
					const pageDefault = document.querySelector('.default');
					if(pageDefault != null){
						pageDefault.remove();
					}
					let ex = document.querySelector('#th_rno');
					console.log(ex);
				});
			// 내 요청 목록 검색 기능
			} else {
				console.log("내 요청 목록 검색")
				$.ajax({
					url : "workerrequestlist",
					method : "post",
					data : JSON.stringify(data),
					contentType: "application/json; charset=UTF-8",
					success : function (){
						loading.style.visibility = 'hidden';
					}
					
					
				}).done((data) => {
					$('#table_content').html(data);
					//기존 페이지 태그 삭제하기
					const pageDefault = document.querySelector('.default');
					if(pageDefault != null){
						pageDefault.remove();
					}
					//테이블 색상 변경하기
					let tableHead = document.querySelectorAll(".ex");
					for(let i = 0; i < tableHead.length; i++){
						tableHead[i].classList.add('bc');
					}
				});
			}
	}	

</script>


</body>

</html>
