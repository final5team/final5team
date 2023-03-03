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
 		margin-right: 30px;
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
							<c:if test="${member.mid == requestProcess.tester && (request.statusNo == 6 || request.statusNo == 5)}">
							<div class="card border-top-dark my-3" id="reDevelopRequestWrite">
								<div class="card-block">
									<div class="d-flex">
										<div class="card-title-block">
		                	 				<h3 class="title">
			                	 				테스트 내역 작성 <i class="fas fa-edit"></i>
		                	 				</h3>
		                	 			</div>
		                	 			<ul class=" navUl">
		                	 				<li class="navBtn active" id="normal"><a class="btn" onclick="turnNormal()">정상</a></li>
		                	 				<li class="navBtn" id="reexam" ><a class="btn" onclick="turnReexam()">재검토</a></li>
		                	 			</ul>
									</div>
									<div class="card-body ">
										<form id="dueDateForm" action="${pageContext.request.contextPath}/testinprogress"  method="POST">
											<input type="hidden" name="rno" value="${request.rno}" id="rno">
											<div class="form-group d-flex" id="expectDateForm"> 
												<div class="label">완료예정일</div>
												<div class="flex-grow-1">
													<c:if test="${request.statusNo == 5}">
													<input type="date" class="date-form control" id="testExpectDate" name="testExpectDate" >
													<div class="btn btn-sm btn-primary"  onclick="checkDate()" id="testStartButton">테스트 시작</div>
													</c:if>
													<c:if test="${request.statusNo == 6}">
													<input type="date" class="date-form control" id="testExpectDate" value="<fmt:formatDate value='${requestProcess.testExpectDate}' pattern='yyyy-MM-dd'/>" readonly>
													</c:if>
													<small id="noInputDate" style="color : red;"></small>
												</div>
											</div>
										</form>												
										<form role="form" id="writeform" action="${pageContext.request.contextPath}/testdone" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}" id="rno">
											<div class="form-group d-flex">
												<div class="label" id="reply">내용 작성 </div>
												<!-- <textarea rows="3" class="form-control boxed flex-grow-1" name="reply"></textarea> -->
												<div class="flex-grow-1">
													<textarea rows="3" class="form-control boxed flex-grow-1" name="reply" id="reply"></textarea>
													<div class="d-flex justify-content-end">
														<small class=" mr-5" id="counter">(0 / 300)</small>
													</div>
												</div>
											</div>
											
											<div class="filebox d-flex">
												<div class="label" id="fileLabel">첨부파일</div>
												<div class="form-group" id="file-list">
											        <a href="#this" onclick="addFile()">파일추가</a>
											        <div class="file-group">
											            <input type="file" name="files"><a href='#this' class='file-delete'>x</a>
											        </div>
			  									</div>	
											</div>
											<div class="d-flex justify-content-end">
												<c:if test="${member.mid == requestProcess.tester && request.statusNo == 6}">
												<button class="btn btn-warning btn-md mx-3 " type="submit">임시저장</button>
												<button class="btn btn-primary btn-md " type="submit" id="testButton">테스트 완료</button>
												</c:if>
											</div>
										</form>
									</div>
								</div>
							</div>
							</c:if>
						</section>   <!-- 테스터의 재검토 요청 글 작성  end-->
						
						<c:if test="${testerToDev != null}">
						<div class="d-flex justify-content-center mt-4"> <!-- 히스토리 버튼 start -->
               	 			<div class="btn btn-primary-outline history-button" onclick="openHistories()">
               	 				테스트 내역 보기  <i class="fas fa-history"></i>
               	 			</div>
               	 		</div> <!-- 히스토리 버튼 end -->
						</c:if>
						
						
						<section id="histories"><!-- 재검토 내역 start -->
							<div class="title-block">
	                	 		<h3 class="title">테스트 내역</h3>
	                	 	</div>
	                	 	<c:forEach var="statusHistory" varStatus="index" items="${testerToDev}">
	                	 	<c:if test="${statusHistory.nextStatus == 3}">
	                	 	<div class="card border-top-success my-3"> <!-- foreach한다면 여기부터 end -->
	                	 	</c:if>
	                	 	<c:if test="${statusHistory.nextStatus == 7}">
	                	 	<div class="card border-top-primary my-3"> <!-- foreach한다면 여기부터 end -->
	                	 	</c:if>
	                	 		<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<c:if test="${statusHistory.nextStatus == 3}">
	                	 				<h3 class="title text-success">
	                	 					 ${index.count}차 재검토 내역  <i class="far fa-bookmark "></i>
	                	 				</h3>
	                	 				</c:if>
	                	 				<c:if test="${statusHistory.nextStatus == 7}">
	                	 				<h3 class="title text-primary">
	                	 					 ${index.count}차 승인 내역  <i class="far fa-bookmark "></i>
	                	 				</h3>
	                	 				</c:if>
	                	 			</div>
	                	 			
	                	 			<div class="card-body">
                	 					<div>
                	 						<div class="row mb-2">
	                	 						<div class="col-2 label">작성자</div>
	                	 						<div class="col-3">${statusHistory.writer}</div>
	                	 						<div class="col-2 label">테스트 완료일</div>
	                	 						<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
                	 						</div>
                	 						<div class="row mt-3">
	                	 						<div class="col-2 label">내용</div>
	                	 						<textarea class="col-8 form-control boxed" rows="2"  readonly>${statusHistory.reply}</textarea>
                	 						</div>
                	 						<div class="row mt-3">
	                	 						<div class="col-2 label">첨부파일</div>
	                	 						<div class="col-8">
	                	 							<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
													<div>
														<div>${statusHistoryFile.fileName}</div>
														<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
													</c:forEach>
	                	 						</div>
                	 						</div>
                	 					</div>
                	 				</div>
	                	 		</div>
	                	 	</div> <!-- foreach한다면 여기부터 end -->
	                	 	</c:forEach>
	                	 	<c:if test="${testerToDev == null}">
	                	 	<div class="card border-top-primary my-3"> <!-- status_history내역없을때 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0 d-flex justify-content-center">
	                	 				<h3 class="title">
	                	 					내역이 없습니다. 
	                	 				</h3>
	                	 			</div>
                	 			</div>
                	 		</div><!-- status_history내역없을때 end -->
	                	 	</c:if>
						</section><!-- 재검토 내역 end -->
						<button class="btn btn-dark btn-sm ml-5" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
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
	
	
	function checkDate(){
		$('#noInputDate').text("");
		console.log("checkDate 실행");
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
		 else{
			$('#pContent').text('');
			$('#pContent').text('입력하시겠습니까?. 확인을 누르시면 수정이 불가능합니다.');
			$('#alartDateTooMuch').modal('show');
		}
		
	}
	function getconfirm(){
		$('#alartDateTooMuch').modal('hide');
		//컨트롤러로 값 전달하기
		var rno = $('#rno').val();
		let expectDate = $('#testExpectDate').val();
		console.log("rno: " + rno);
		$("#dueDateForm").submit();
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
	
	/* 정상 & 재검토 버튼 눌렀을 시 */
	function turnNormal(){
		$('#normal').addClass('active');
		$('#reexam').removeClass('active');
		$('#reply').text('내용작성');
		$('#reply').removeClass('text-danger');
		$('#fileLabel').removeClass('text-danger');
		$('#writeform').attr("action", "${pageContext.request.contextPath}/testdone");
		$('#testButton').text('테스트 완료');
	}
	function turnReexam(){
		$('#reexam').addClass('active');
		$('#normal').removeClass('active');
		$('#reply').text('재검토사유');
		$('#reply').addClass('text-danger');
		$('#fileLabel').addClass('text-danger');
		$('#writeform').attr("action", "${pageContext.request.contextPath}/askreexam");
		$('#testButton').text('재검토 요청');
	}
	
	/* 파일 */
	$(document).ready(function() {
	    $(".file-delete").on("click", function(e) {
	        e.preventDefault();
	        deleteFile($(this));
	    });
	})
	 function addFile() {
        var str = "<div class='file-group'><input type='file' name='files'><a href='#this' name='file-delete'>x</a></div>";
        $("#file-list").append(str);
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    }
 
    function deleteFile(obj) {
        obj.parent().remove();
    }

    /* 테스트 내역 받기 */
    function openHistories(){
    	$('#histories').toggle();
    }
    
	</script>
</body>

</html>