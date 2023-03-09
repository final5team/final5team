<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<table>
	<tr>
		<th class="ex th_first <c:if test="${listFilter.columnName == 'th_rno' && listFilter.sortState == 'desc'}">th_first_desc</c:if>
					<c:if test="${listFilter.columnName == 'th_rno' && listFilter.sortState == 'asc'}">th_first_asc</c:if>
					<c:if test="${listFilter.columnName == 'th_rno' && listFilter.sortState == 'none'}"></c:if>" id="th_rno">No.</th>




		<th class="ex th_second <c:if test="${listFilter.columnName == 'th_sno' && listFilter.sortState == 'desc'}">th_second_desc</c:if>
					<c:if test="${listFilter.columnName == 'th_sno' && listFilter.sortState == 'asc'}">th_second_asc</c:if>
					<c:if test="${listFilter.columnName == 'th_sno' && listFilter.sortState == 'none'}"></c:if>" id="th_sno">시스템</th>
		<th class="ex th_third <c:if test="${listFilter.columnName == 'th_reqtype' && listFilter.sortState == 'desc'}">th_third_desc</c:if>
					<c:if test="${listFilter.columnName == 'th_reqtype' && listFilter.sortState == 'asc'}">th_third_asc</c:if>
					<c:if test="${listFilter.columnName == 'th_sno' && listFilter.sortState == 'none'}"></c:if>" id="th_reqtype">요청 유형</th>
		<th class="ex th_four <c:if test="${listFilter.columnName == 'th_title' && listFilter.sortState == 'desc'}">th_four_desc</c:if>
					<c:if test="${listFilter.columnName == 'th_title' && listFilter.sortState == 'asc'}">th_four_asc</c:if>
					<c:if test="${listFilter.columnName == 'th_title' && listFilter.sortState == 'none'}"></c:if>" id="th_title">요청 제목</th>
		<th class="ex th_five <c:if test="${listFilter.columnName == 'th_reqdate' && listFilter.sortState == 'desc'}">th_five_desc</c:if>
					<c:if test="${listFilter.columnName == 'th_reqdate' && listFilter.sortState == 'asc'}">th_five_asc</c:if>
					<c:if test="${listFilter.columnName == 'th_reqdate' && listFilter.sortState == 'none'}"></c:if>" id="th_reqdate">요청 일자</th>
		<th class="ex">단계</th>

	</tr>

	<c:forEach var="request" items="${requestList}">
		<tr>
			<td class="rno" style="max-width: 40px; min-width: 40px; white-space: nowrap; overflow: hidden;">${request.rno}</td>
			<td class="client" style="max-width: 95px; min-width: 95px; white-space: nowrap; overflow: hidden;">${request.systemName}</td>
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
			<td class="reqTitle" style="max-width: 190px; min-width: 190px; white-space: nowrap; overflow: hidden;">
				<c:if test="${member.mtype == 'developer' && request.devCheck == 1 && request.developer == member.mid}">
					<strong class="text-danger">N</strong>																
				</c:if>
				<c:if test="${member.mtype == 'tester' && request.tesCheck == 1 && request.tester == member.mid}">
					<strong class="text-danger">N</strong>																
				</c:if>
				<c:if test="${member.mtype == 'usertester' && request.uttCheck == 1 && request.userTester == member.mid}">
					<strong class="text-danger">N</strong>																
				</c:if>
				<c:if test="${member.mtype == 'distributor' && request.disCheck == 1  && request.distributor == member.mid}">
					<strong class="text-danger">N</strong>																
				</c:if>
				<c:if test="${member.mtype == 'pm' && request.pmCheck == 1}">
					<strong class="text-danger">N</strong>																
				</c:if>												
				${request.reqTitle}
			</td>
			<td class="reqDate" style="max-width: 87px; min-width: 87px; white-space: nowrap; overflow: hidden;">
				<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd" />
			</td>
			<td class="step_td">
				<%@ include file="/WEB-INF/views/srm/restatus/stepintable.jsp"%>
			</td>
		</tr>
	</c:forEach>
</table>


<div class="pager">
	<div class="pagingButtonSet d-flex justify-content-center">
		<a onclick="pageChange(1, '${listFilter.sortState}', '${listFilter.columnName}')" type="button" class="btn btn-muted shadow">처음</a>
		<c:if test="${pager.groupNo > 1}">
			<a onclick="pageChange(${pager.startPageNo-1}, '${listFilter.sortState}', '${listFilter.columnName}')" class="btn btn-muted shadow">이전</a>

		</c:if>

		<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
			<c:if test="${pager.pageNo != i}">
				<a onclick="pageChange(${i}, '${listFilter.sortState}', '${listFilter.columnName}')" type="button" class="btn btn-white shadow">${i}</a>
			</c:if>
			<c:if test="${pager.pageNo == i}">
				<a onclick="pageChange(${i}, '${listFilter.sortState}', '${listFilter.columnName}')" type="button" class="btn btn-dark shadow">${i}</a>
			</c:if>
		</c:forEach>

		<c:if test="${pager.groupNo < pager.totalGroupNo }">
			<a onclick="pageChange(${pager.endPageNo+1}, '${listFilter.sortState}', '${listFilter.columnName}')" type="button" class="btn btn-muted shadow">다음</a>

		</c:if>
		<a onclick="pageChange(${pager.totalPageNo}, '${listFilter.sortState}', '${listFilter.columnName}')" type="button" class="btn btn-muted shadow">맨끝</a>
	</div>
</div>

<input type="hidden" id="state" value="${listFilter.sortState}">
<input type="hidden" id="th_first_id" value="${listFilter.columnName}">
<script>
//th_first 클릭
$(document).ready(function() {
	//ajax input 태그 값
	//ajax 매개변수 값
	//테이블 정렬을 위한 변수
	let state_value = document.querySelector('#state');
	let state = state_value.value;
	
	let th_first_id_value = document.querySelector('#th_first_id');
	let th_first_id = th_first_id_value.value;
	
	//console.log("ajax 이후 태그",state_value, th_first_id_value);
	//console.log("ajax 이후 변수값", state, th_first_id);
	
	
	//console.log('ajax로 불러온 페이지');
		
	//rno로 정렬하기
	let ex = document.querySelector('#th_rno');
	//ex.addEventListener('click', th_rno_click);
	ex.addEventListener('click', select_th_click);
	
	//sno로 정렬하기
	let ex2 = document.querySelector('#th_sno');
	//ex2.addEventListener('click', th_sno_click);
	ex2.addEventListener('click', select_th_click);
	
	//reqtype으로 정렬하기
	let ex3 = document.querySelector('#th_reqtype');
	//ex3.addEventListener('click', th_req_type_click);
	ex3.addEventListener('click', select_th_click);
	
	//title로 정렬하기
	let ex4 = document.querySelector('#th_title');
	//ex4.addEventListener('click', th_title_click);
	ex4.addEventListener('click', select_th_click);
	
	//reqdate로 정렬하기
	let ex5 = document.querySelector('#th_reqdate');
	//ex5.addEventListener('click', th_reqdate_click);
	ex5.addEventListener('click', select_th_click);

	function select_th_click(event){
		
		if(event.target.id === 'th_rno'){
			th_first_id = 'th_rno';		
			//console.log(th_first_id);
			th_rno_click(event);
			
		} else if (event.target.id === 'th_sno'){
			th_first_id = 'th_sno';		
			//console.log(th_first_id);
			th_sno_click(event);
			
		} else if (event.target.id === 'th_reqtype'){
			th_first_id = 'th_reqtype';		
			//console.log(th_first_id);
			th_req_type_click(event);
			
		} else if (event.target.id === 'th_title'){
			th_first_id = 'th_title';
			//console.log(th_first_id);
			th_title_click(event);
			
		} else if (event.target.id === 'th_reqdate'){
			th_first_id = 'th_reqdate';
			//console.log(th_first_id);
			th_reqdate_click(event);
			
		}
		
	}	
	
			
	
	
	
	
	
	
	
	//rno sort 함수
	function th_rno_click(event) {
		//console.log('실행');
		if (th_first_id === 'th_rno') {
			// 내림차순 정렬 실행
			if (ex.classList.contains('th_first_asc')) {
				event.preventDefault();
				state = 'desc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'desc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_first_asc');
				ex.classList.add('th_first_desc');
	
				search(state, th_first_id);
	
			} else if (ex.classList.contains('th_first_desc')) {
				event.preventDefault();
				state = 'none';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'none';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_first_desc');
	
				search(state, th_first_id);
			} else {
				event.preventDefault();
				state = 'asc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'asc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_first_asc');
	
				search(state, th_first_id);
			} 
		} 
		//console.log('rno 말고 요청 클릭함')
		
		
	};
	// sno sort 함수
	function th_sno_click(event) {
		if (th_first_id === 'th_sno') {
			// 내림차순 정렬 실행
			if (ex2.classList.contains('th_second_asc')) {
				event.preventDefault();
				state = 'desc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'desc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_second_asc');
				ex.classList.add('th_second_desc');

				search(state, th_first_id);

			} else if (ex2.classList.contains('th_second_desc')) {
				event.preventDefault();
				state = 'none';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'none';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_second_desc');

				search(state, th_first_id);
			} else {
				event.preventDefault();
				state = 'asc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'asc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_second_asc');

				search(state, th_first_id);
			}
		} else {
			//console.log('sno 말고 요청 클릭함')
			
			
			
			
			

		}
	};
	// req_type sort 함수
	function th_req_type_click(event) {
		if (th_first_id === 'th_reqtype') {
			// 내림차순 정렬 실행
			if (ex3.classList.contains('th_third_asc')) {
				event.preventDefault();
				state = 'desc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'desc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_third_asc');
				ex.classList.add('th_third_desc');

				search(state, th_first_id);

			} else if (ex3.classList.contains('th_third_desc')) {
				event.preventDefault();
				state = 'none';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'none';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_third_desc');

				search(state, th_first_id);
			} else {
				event.preventDefault();
				state = 'asc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'asc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_third_asc');

				search(state, th_first_id);
			}
		} else {
			//console.log('reqtype 말고 요청 클릭함')
			
			
			
			
			

		}
	};
	// title sort 함수
	function th_title_click(event) {
		if (th_first_id === 'th_title') {
			// 내림차순 정렬 실행
			if (ex4.classList.contains('th_four_asc')) {
				event.preventDefault();
				state = 'desc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'desc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_four_asc');
				ex.classList.add('th_four_desc');

				search(state, th_first_id);

			} else if (ex4.classList.contains('th_four_desc')) {
				event.preventDefault();
				state = 'none';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'none';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_four_desc');

				search(state, th_first_id);
			} else {
				event.preventDefault();
				state = 'asc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'asc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_four_asc');

				search(state, th_first_id);
			}
		} else {
			//console.log('title 말고 요청 클릭함')
			
			
			
			
			

		}

	};
	// reqdate sort 함수
	function th_reqdate_click(event) {
		if (th_first_id === 'th_reqdate') {
			// 내림차순 정렬 실행
			if (ex5.classList.contains('th_five_asc')) {
				event.preventDefault();
				state = 'desc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'desc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_five_asc');
				ex.classList.add('th_five_desc');

				search(state, th_first_id);

			} else if (ex5.classList.contains('th_five_desc')) {
				event.preventDefault();
				state = 'none';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'none';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_five_desc');

				search(state, th_first_id);
			} else {
				event.preventDefault();
				state = 'asc';
				th_first_id = th_first_id;
				// hidden tag 값 설정
				state_value.value = 'asc';
				th_first_id_value.value = th_first_id;
				// css 설정
				ex.classList.remove('th_five_asc');

				search(state, th_first_id);
			}
		} else {
			//console.log('reqdate 말고 요청 클릭함')
			
			
			
			
			

		}
	}
	
});
		
</script>

