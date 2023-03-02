<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
    <style>
    .progress-group{
    padding: 0px 220px;
    margin: 15px 0px;
    
    }
    </style>
</head>

<body id="page-top">
	
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
                	 <div id="main"> <!-- id=main div start -->
                	 	<div class="title-block">
                	 		<h3 class="title">개발 상세 보기</h3>
                	 	</div>
                	 	<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
                	 	<section> <!-- 개발내역 입력폼 start -->
                	 		<div class="card border-top-dark">
                	 			<div class="card-block">
	                	 			<div class="card-title-block">
	                	 				<h3 class="title">
		                	 				개발 내역 작성 <i class="fas fa-edit"></i>
	                	 				</h3>
	                	 			</div>
	                	 			<div class="card-body">
										<form role="form" id="writeform" action="${pageContext.request.contextPath}/devdone" method="POST" enctype="multipart/form-data">
											<input type="hidden" name="rno" value="${request.rno}">
											<div class="form-group d-flex">
												<div class="label">완료예정일</div>
												<div class="flex-grow-1">
													<input type="date" class="date-form control">
													<div class="btn btn-sm btn-primary">개발 시작</div>
												</div>
											</div>
											<div class="form-group d-flex">
												<div class="label">개발 사항</div>
												<div class="flex-grow-1">
													<textarea rows="3" class="form-control boxed flex-grow-1" name="reply" id="reply"></textarea>
													<div class="d-flex justify-content-end">
														<small class=" mr-5" id="counter">(0 / 300)</small>
													</div>
												</div>
											</div>
											<div class="form-group d-flex">
												<div class="label">배포소스(url)</div>
												<div class="flex-grow-1">
													<input class="form-control boxed" name="distSource" id="distSource" style="height: 20px;">
													<div class="d-flex justify-content-end">
														<small class=" mr-5" id="counterSource">(0 / 100)</small>
													</div>
												</div>
											</div>
											
											<div class="filebox d-flex">
												<div class="label" id="fileLable">첨부파일</div>
												<div class="form-group" id="file-list">
											        <a href="#this" onclick="addFile()">파일추가</a>
											        <div class="file-group">
											            <input type="file" name="files"><a href='#this' class='file-delete'>x</a>
											        </div>
			  									</div>	
											</div>
											<div class="d-flex">
												<div class="label">진행률</div>
												<div class="flex-grow-1 d-flex">
													<input type="text" class="form-control boxed" style="width: 100px; height: 20px;">
													<span>%</span>
													<span class="btn btn-sm btn-primary ml-2">확인</span>
												</div>
											</div>
											<div class="progress-group">
												<div class="progress">
													<div class="progress-bar bg-success" style="width:50%"></div>
												</div>
											</div>
										</form>
										<div class="d-flex justify-content-end">
										<button class="btn btn-dark btn-md " >목록</button>
										<button class="btn btn-warning btn-md mx-3">임시 저장</button>
										<button class="btn btn-primary btn-md " onclick="devEnd()">개발 완료</button>
										</div>
	                	 			</div>
                	 			</div>
                	 		</div>
                	 	</section><!-- 개발내역 입력폼 end -->
               	 		<div class="d-flex justify-content-center mt-4"> <!-- 히스토리 버튼 start -->
               	 			<div class="btn btn-primary-outline history-button">
               	 				개발 히스토리 보기  <i class="fas fa-history"></i>
               	 			</div>
               	 		</div> <!-- 히스토리 버튼 end -->
                	 	<section > <!-- 개발히스토리 start-->
                	 		<div class="title-block">
	                	 		<h3 class="title">개발 히스토리</h3>
	                	 	</div>
                	 		<div class="card border-top-primary my-3"> <!-- foreach한다면 여기부터 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0">
	                	 				<h3 class="title">
	                	 					 1차 내역  <i class="far fa-bookmark success"></i>
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
		                	 						<span class="label">개발 완료일</span>
		                	 						<span class="p-2">2023-02-02</span>
	                	 						</div>
                	 						</div>
                	 						<div class="row">
	                	 						<span class="label" style="text-align :left; width: 10%;">개발내용</span>
	                	 						<textarea rows="2" class="form-control boxed mr-5" readonly>내용 여기</textarea>
                	 						</div>
                	 						<div class="row mt-3">
	                	 						<span class="label" style="text-align :left; width: 10%;">배포소스(url)</span>
	                	 						<input class="form-control boxed mr-5" style=" height: 15px;" readonly>
                	 						</div>
                	 						<div class="row mt-3">
	                	 						<span class="label" style="text-align :left; width: 10%;">첨부파일</span>
	                	 						<div>
	                	 							<div><a href="#">첨부파일.jpg</a></div>
	                	 							<div><a href="#">첨부파일.jpg</a></div>
	                	 						</div>
                	 						</div>
                	 						
                	 					</div>
                	 				</div>
                	 			</div>
                	 		
                	 		</div><!-- foreach한다면 여기부터 end -->
                	 		
                	 		<div class="card border-top-primary my-3"> <!-- status_history내역없을때 start -->
                	 			<div class="card-block">
	                	 			<div class="card-block-title mb-0 d-flex justify-content-center">
	                	 				<h3 class="title">
	                	 					내역이 없습니다. 
	                	 				</h3>
	                	 			</div>
                	 			</div>
                	 		</div><!-- status_history내역없을때 end -->
                	 		
                	 		
                	 		
                	 	</section> <!-- 개발히스토리end -->
                	 	
					 </div> <!-- id=main div / -->
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
					<form id="formUpdateExpectDate" action="${pageContext.request.contextPath}/devinprogress" method="POST">
						<label class="mt-1" style="color: #343a40;" for="developExpectDate">개발 완료 예정일</label>
						<input type="date" class="form-control ml-2" id="developExpectDate" name="developExpectDate" style="width: 200px; display: inline;">
						<input type="hidden" name="rno" value="${request.rno}">
						<input type="hidden" name="receiptDoneDate" value="<fmt:formatDate value='${receiptDoneDate}' pattern='yyyy-MM-dd'/>">
					</form>
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
	<!-- 데이트 입력 확인 /-->
	<!-- 글자수 입력 확인 -->
	<div class="modal fade" id="countCheck" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>
						주의 <i class="fas fa-exclamation-triangle"></i>
					</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="display: flex; justify-content: center;">
					<p id="countContent"></p>
				</div>
				<div class="modal-footer" style="justify-content: center;">
                    <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 글자수 입력 확인 /-->
	<script>
	function getDatemodal(){
		$('#datemodal').modal('show');
		
	}
	function checkDate(){
		$('#noInputDate').text("");
		
		if($('#developExpectDate').val() == ""){
			$('#noInputDate').text("날짜를 입력해주세요.");
			return;
		}
		
		
		let today = new Date().getTime();   
		var developExpectDate = new Date($('#developExpectDate').val()).getTime();
		var reqExpectDate = new Date($('#reqExpectDate').text()).getTime();
		var receiptDoneDate = new Date($('input[name="receiptDoneDate"]').val()).getTime();
		console.log(receiptDoneDate);
		
		//오늘보다 이전 날짜를 입력할 경우
		if(today > developExpectDate){
			$('#noInputDate').text("현재보다 앞선 날짜를 입력해주세요.");
			return;
		}
		//총완료예정일보다 큰 일정을 입력할 경우
		if(reqExpectDate <= developExpectDate){
			$('#noInputDate').text("완료예정일보다 과거여야 합니다.");
			return;
		}
		if(((developExpectDate-receiptDoneDate)/(reqExpectDate-receiptDoneDate))>=0.5){
			$('#pContent').text('');
			$('#pContent').text('입력 시간이 완료 예정일 대비 50% 이상 차지합니다. 확인을 누르시면 수정이 불가능합니다.');
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
	function devEnd(){
		$('#writeform').submit();
	}
	
	function getDevContent(index){
		var content = "#" + index;
		$(content).toggle();
	}
	
	$('.showContentButton').click(function(){
			var fno = $(this).parent().parent().parent().next().toggle();
		}
	);
	
	function openRequestInfo(){
		$('#requestInfoNav').addClass("active");
		$('#developHistoryNav').removeClass("active");
		$('#RedevelopHistoryNav').removeClass("active");
		$('#requestInfo').show();
		$('#pmConfirmInfo').show();
		$('#developHistoryWrite').hide();
		$('#developHistory').hide();
		$('#reDevelopRequestHistory').hide();
	}
	
	function openDevelopHistory(){
		$('#requestInfoNav').removeClass("active");
		$('#developHistoryNav').addClass("active");
		$('#RedevelopHistoryNav').removeClass("active");
		$('#requestInfo').hide();
		$('#pmConfirmInfo').hide();
		$('#developHistoryWrite').show();
		$('#developHistory').show();
		$('#reDevelopRequestHistory').hide();		
	}
		
	function openReDevelopRequestHistory(){
		$('#requestInfoNav').removeClass("active");
		$('#developHistoryNav').removeClass("active");
		$('#RedevelopHistoryNav').addClass("active");
		$('#requestInfo').hide();
		$('#pmConfirmInfo').hide();
		$('#developHistoryWrite').hide();
		$('#developHistory').hide();
		$('#reDevelopRequestHistory').show();
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
	/* 글자수 세기 */
   	$('#reply').keyup(function (e){
   		let content = $(this).val();
   		$('#counter').html("("+content.length+" / 300)");
 		if(content.length > 300){
 			$('#countCheck').modal();
 			$('#countContent').html("최대 300자까지 입니다.");
 			$(this).val(content.substring(0,300));
 			$('#counter').html("(300 / 300)");
 		}
   	});
   	$('#distSource').keyup(function (e){
   		let content = $(this).val();
   		$('#counterSource').html("("+content.length+" / 100)");
   		if(content.length > 100){
   			$('#countCheck').modal();
 			$('#countContent').html("최대 100자까지 입니다.");
 			$(this).val(content.substring(0,150));
 			$('#counterSource').html("(100 / 100)");
   		}
   	});
   	
   	function openRegister(){
   		
   	}
   	
    
	</script>
</body>

</html>