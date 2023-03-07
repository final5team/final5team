<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<table>
	<tr>
		<th class="ex th_first <c:if test="${listFilter.columnName == 'th_no' && listFilter.sortState == 'desc'}">th_first_desc</c:if>
						<c:if test="${listFilter.columnName == 'th_no' && listFilter.sortState == 'asc'}">th_first_asc</c:if>
						<c:if test="${listFilter.columnName == 'th_no' && listFilter.sortState == 'none'}"></c:if>" 
			id="th_no">
			No.
		</th>
																		
								
							
						
		<th class="ex th_second">시스템</th>
		<th class="ex th_third">요청 유형</th>
		<th class="ex th_four">요청 제목</th>
		<th class="ex th_five">요청 일자</th>
		<th class="ex">단계</th>

	</tr>

	<c:forEach var="request" items="${requestList}">
		<tr>
			<td class="rno">${request.rno}</td>
			<td class="client">${request.systemName}</td>
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
			<td class="reqTitle" style="max-width: 200px; white-space: nowrap; overflow: hidden;">${request.reqTitle}</td>
			<td class="reqDate" style="max-width: 100px; white-space: nowrap; overflow: hidden;">
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
	
	console.log("ajax 이후 태그",state_value, th_first_id_value);
	console.log("ajax 이후 변수값", state, th_first_id);
		
	//정렬 기능 적용하기 위한 css
	let ex = document.querySelector('#th_no');
	console.log('ajax로 불러온 페이지');
	
	ex.addEventListener('click', (event) => {
		
		//내림차순 정렬 실행
		if(ex.classList.contains('th_first_asc')){
			event.preventDefault();
			state = 'desc';
			th_first_id = th_first_id;
			//hidden tag 값 설정
			state_value.value = 'desc';
			th_first_id_value.value = th_first_id;
			//css 설정
			ex.classList.remove('th_first_asc');
			ex.classList.add('th_first_desc');
			
			search(state, th_first_id);
			
		} else if(ex.classList.contains('th_first_desc')){
			event.preventDefault();
			state = 'none';
			th_first_id = th_first_id;
			//hidden tag 값 설정
			state_value.value = 'none';
			th_first_id_value.value = th_first_id;
			//css 설정
			ex.classList.remove('th_first_desc');

			search(state, th_first_id);
		} else {
			event.preventDefault();
			state = 'asc';
			th_first_id = th_first_id;
			//hidden tag 값 설정
			state_value.value = 'asc';
			th_first_id_value.value = th_first_id;
			//css 설정
			ex.classList.remove('th_first_asc');
			
			search(state, th_first_id);
		}
		
		
	});
	
})

</script>

