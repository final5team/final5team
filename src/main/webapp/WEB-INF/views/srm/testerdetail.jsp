<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
     <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
    <style>
   	.navUl{
   		list-style:none;
   		display: flex;
 		margin-left: auto;
 		margin-bottom: 0px;
   	}
   	.navBtn{
   		border: 1px solid #85ce36;
   	}
   	.navBtn.active {
   		background-color: #85ce36;
   	}
   	.navBtn.active .btn{
   		color: white;
   	}
   	.check-group{
   		margin:auto;
   	}
    </style>
</head>

<body id="page-top">
	<script>
		function checkDateToDevelope(){
			console.log('버튼 클릭');
		}
	</script>
    <!-- Page Wrapper -->
    <div id="wrapper">
		
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
                <!-- End of Topbar -->

                <!-- 여기에 내용 담기 start -->
                <div class="container">
					<div id="main">
						<div class="title-block">
                	 		<h3 class="title">테스트 상세 보기</h3>
                	 	</div>
						<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
						
						<section>	<!-- 테스터의 재검토 요청 글 작성 start-->
							<c:if test="${member.mtype =='tester' && request.statusNo == 6}">
							<div class="card border-top-dark my-3" id="reDevelopRequestWrite">
								<div class="card-block">
									<div class="d-flex">
										<div class="card-title-block">
		                	 				<h3 class="title">
			                	 				테스트 내역 작성 <i class="fas fa-edit"></i>
		                	 				</h3>
		                	 			</div>
		                	 			<div class="check-group">
		                	 				<input type="radio" id="normal" name="check-group">
		                	 				<label for ="normal" class=" text-lg">정상</label>
		                	 				<input type="radio" id="reexam" name="check-group">
		                	 				<label for ="reexam" class="ml-3 text-lg">재검토</label>
		                	 			</div>
		                	 			<ul class=" navUl">
		                	 				<li class="navBtn "><a class="btn">정상</a></li>
		                	 				<li class="navBtn active"><a class="btn">재검토</a></li>
		                	 			</ul>
									</div>
									<div class="card-body ">
										<form role="form" id="writeform" action="${pageContext.request.contextPath}/askreexam" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}">
											<div class="form-group d-flex">
												<div class="label">재검토 사유 </div>
												<textarea rows="3" class="form-control boxed flex-grow-1" name="reply"></textarea>
											</div>
											<div class="filebox d-flex">
												<div class="label">첨부파일 등록</div>
												<input type="file" id="file" class="flex-grow-1" name="files" multiple>
											</div>
											<div class="d-flex justify-content-end">
												<button class="btn btn-dark btn-md " type="submit">목록</button>
												<button class="btn btn-warning btn-md mx-3 " type="submit">임시저장</button>
												<button class="btn btn-primary btn-md " type="submit">테스트 완료</button>
											</div>
										</form>
									</div>
								</div>
							</div>
							</c:if>
						</section>   <!-- 테스터의 재검토 요청 글 작성  end-->
						<div class="d-flex justify-content-center mt-4"> <!-- 히스토리 버튼 start -->
               	 			<div class="btn btn-primary-outline history-button">
               	 				테스트 히스토리 보기  <i class="fas fa-history"></i>
               	 			</div>
               	 		</div> <!-- 히스토리 버튼 end -->
						
						<section ><!-- 재검토 내역 start -->
							<div class="title-block">
	                	 		<h3 class="title">테스트 히스토리</h3>
	                	 	</div>
	                	 	<div class="card border-top-warning my-3"> <!-- foreach한다면 여기부터 end -->
	                	 		<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<h3 class="title text-warning">
	                	 					 1차 내역  <i class="far fa-bookmark "></i>
	                	 				</h3>
	                	 			</div>
	                	 			
	                	 			<div class="card-body">
                	 					<div>
                	 						<div class="row">
                	 							<div class="col-5 p-2">
		                	 						<span class="label">작성자</span>
		                	 						<span class="p-2">송영훈</span>
                	 							</div>
                	 							<div class="col-5 p-2">
		                	 						<span class="label">테스트 완료일</span>
		                	 						<span class="p-2">2023-02-02</span>
	                	 						</div>
                	 						</div>
                	 						<div class="row">
	                	 						<span class="label" style="text-align :left; width: 10%;">결함내용</span>
	                	 						<textarea rows="2" class="form-control boxed mr-5" readonly>내용 여기</textarea>
                	 						</div>
                	 						<div class="row mt-3">
	                	 						<span class="label" style="text-align :left; width: 10%;">첨부파일</span>
	                	 						<div>
	                	 							<div >
	                	 								<span>첨부파일</span>
	                	 								<a  href="#"><i class="fas fa-cloud-download-alt text-info"></i></a>
                	 								</div>
	                	 						</div>
                	 						</div>
                	 					</div>
                	 				</div>
	                	 		</div>
	                	 	</div> <!-- foreach한다면 여기부터 end -->
	                	 	
	                	 	<div class="card border-top-success my-3"> <!-- foreach한다면 여기부터 end -->
	                	 		<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<h3 class="title text-success">
	                	 					 2차 내역  <i class="far fa-bookmark "></i>
	                	 				</h3>
	                	 			</div>
	                	 			
	                	 			<div class="card-body">
                	 					<div>
                	 						<div class="row">
                	 							<div class="col-5 p-2">
		                	 						<span class="label">작성자</span>
		                	 						<span class="p-2">송영훈</span>
                	 							</div>
                	 							<div class="col-5 p-2">
		                	 						<span class="label">테스트 완료일</span>
		                	 						<span class="p-2">2023-02-02</span>
	                	 						</div>
                	 						</div>
                	 						<div class="row">
	                	 						<span class="label" style="text-align :left; width: 10%;">결함내용</span>
	                	 						<textarea rows="2" class="form-control boxed mr-5" readonly>내용 여기</textarea>
                	 						</div>
                	 						<div class="row mt-3">
	                	 						<span class="label" style="text-align :left; width: 10%;">첨부파일</span>
	                	 						<div>
	                	 							<div >
	                	 								<span>첨부파일</span>
	                	 								<a  href="#"><i class="fas fa-cloud-download-alt text-info"></i></a>
                	 								</div>
	                	 							<div >
	                	 								<span>첨부파일</span>
	                	 								<a href="#"><i class="fas fa-cloud-download-alt text-info"></i></a>
                	 								</div>
	                	 							
	                	 						</div>
                	 						</div>
                	 					</div>
                	 				</div>
	                	 		</div>
	                	 	</div> <!-- foreach한다면 여기부터 end -->
	                	 	
	                	 	<div class="card border-top-primary my-3"> <!-- status_history내역없을때 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0 d-flex justify-content-center">
	                	 				<h3 class="title">
	                	 					내역이 없습니다. 
	                	 				</h3>
	                	 			</div>
                	 			</div>
                	 		</div><!-- status_history내역없을때 end -->
	                	 	
						</section><!-- 재검토 내역 end -->	
						<div class="card card-block mt-3" id="reDevelopRequestHistory">
								<ul class="p-0">
									<hr/>
									<li>
										<div class="row">
											<div class="col-2 font-weight-bold" style="color:#333333">차수</div>
										 	<div class="col-3 font-weight-bold" style="color:#333333">작성자</div>
										 	<div class="col-3 font-weight-bold" style="color:#333333">작성일</div>
										 	<div class="col-4 font-weight-bold" style="color:#333333">
										 		내용
										 	</div>
										</div>
									</li>
									<hr/>
									<c:forEach var="statusHistory" varStatus="index" items="${testerToDev}">
										<li>
											<div class="row">
												<div class="col-2">${index.count}차</div>
											 	<div class="col-3">${statusHistory.writer}</div>
											 	<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
											 	<div class="col-4">
											 		<button class="showContentButton btn btn-sm btn-primary">보기</button>
											 	</div>
											</div>
										</li>
										<li style="display:none;">
										<hr/>
											<div class="row">
												<div class="col-2">재검토 사유 및 요청사항 :</div>
												<div class="col-10 border" style="min-height:100px;">${statusHistory.reply}</div>
											</div>
											<div class="row mt-3">
												<div class="col-2">첨부파일 : </div>
												<div class="col-10">
													<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
														<div>
															<span>${statusHistoryFile.fileName}</span>
															<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																<i class="fas fa-cloud-download-alt"></i>
															</a>
														</div>
													</c:forEach>
												</div>
											</div>
										</li>
										<hr/>
									</c:forEach>
								</ul>
							</div>
					 </div> <!-- main/ -->
                </div>
                <!-- 여기에 내용 담기 end -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
	<!-- date 입력받는 모달창 start -->
	 <div class="modal fade" id="datemodal" role="dialog" aria-labelledby="developDueDate" aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="developDueDate">개발 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<form id="formUpdateExpectDate" action="${pageContext.request.contextPath}/testinprogress" method="POST">
						<label class="mt-1" style="color: #343a40;" for="testExpectDate">테스트 완료 예정일</label>
						<input type="date" class="form-control ml-2" id="testExpectDate" name="testExpectDate" style="width: 200px; display: inline;">
						<input type="hidden" name="rno" value="${request.rno}">
					</form>
					<input type="hidden" name="receiptDoneDate" value="<fmt:formatDate value='${receiptDoneDate}' pattern='yyyy-MM-dd'/>">
				</div>
				<div class="modal-footer">
					<small id="noInputDate" style="color : red;"></small>
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="checkDate()">확인</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- date 입력받는 모달창 end -->
		
	<!-- 경고 모달창 (50% 이상일 경우)-->
	<div class="modal fade" id="alartDateTooMuch" aria-hidden="true" aria-labelledby="alartOfTimeTooMuch">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa fa-exclamation-circle mr-2" aria-hidden="true" style="font-size: 25px; color: red;"></i>
					<h5>경고</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p id="pContent"></p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="getconfirm()" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 경고 모달창 (50% 이상일 경우) -->
	<!-- 데이트 입력 확인 -->
	<div class="modal fade" id="completeDueDate" aria-hidden="true" aria-labelledby="successOfDueDate">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>확인</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="display: flex; justify-content: center;">
					<p>입력되었습니다.</p>
				</div>
				<div class="modal-footer" style="justify-content: center;">
                    <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<script>
	<!-- 데이트 입력 확인 /-->
	
	function getDatemodal(){
		$('#datemodal').modal('show');
		
	}
	function checkDate(){
		$('#noInputDate').text("");
		
		if($('#testExpectDate').val() == ""){
			$('#noInputDate').text("날짜를 입력해주세요.");
			return;
		}
		
		let today = new Date().getTime();   
		var testExpectDate = new Date($('#testExpectDate').val()).getTime();
		var reqExpectDate = new Date($('#reqExpectDate').text()).getTime();
		var receiptDoneDate = new Date($('input[name="receiptDoneDate"]').val()).getTime();

		//오늘보다 이전 날짜를 입력할 경우
		if(today > testExpectDate){
			$('#noInputDate').text("현재보다 앞선 날짜를 입력해주세요.");
			return;
		}
		//총완료예정일보다 큰 일정을 입력할 경우
		if(reqExpectDate <= testExpectDate){
			$('#noInputDate').text("완료예정일보다 과거여야 합니다.");
			return;
		}
		if(((testExpectDate-receiptDoneDate)/(reqExpectDate-receiptDoneDate))>=0.2){
			$('#pContent').text('');
			$('#pContent').text('입력 시간이 완료 예정일 대비 20% 이상 차지합니다. 확인을 누르시면 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		} else{
			$('#pContent').text('');
			$('#pContent').text('입력하시겠습니까?. 확인을 누르시면 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		}
		
	}
	function getconfirm(){
		$('#alartDateTooMuch').modal('hide');
		//컨트롤러로 값 전달하기
		$('#formUpdateExpectDate').submit();
		
		$('#completeDueDate').modal('show');
	}
	function devEnd(rno){
		let rnoNum = rno;
		location.href='${pageContext.request.contextPath}/testdone?rno=' + rnoNum;
	}
	
	$('.showContentButton').click(function(){
		var fno = $(this).parent().parent().parent().next().toggle();
		}
	);
	

	
	
	</script>
</body>

</html>