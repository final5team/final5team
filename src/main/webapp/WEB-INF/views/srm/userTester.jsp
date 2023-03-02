<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
		li {
	 		list-style : none;
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
					<div id="main"><!-- main start -->
						<section>
							<div class="card border-top-dark my-3">
								<div class="card-block">
									<div class="card-title-block">
										<h3 class="title">
		                	 				테스트 내역 작성 <i class="fas fa-edit"></i>
	                	 				</h3>
									</div>
									<div class="card-body"></div>
								</div>
							</div>
						</section>
					 </div> <!-- main end -->
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
					<h5 class="modal-title" id="developDueDate">유저테스트 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<form action="${pageContext.request.contextPath}/startwork" method="post" class="mt-3" id="startWork">
						<label class="mt-1" style="color: #343a40;" for="expectDate">유저테스트 완료 예정일</label>
						<input type="date" id= "expectDate" name="expectDate" class="form-control ml-2" style="width: 200px; display: inline;"/>
						<input type="hidden" name="rno" value="${request.rno}"/>
					</form>
				</div>
				<div class="modal-footer">
					<small id="noInputDate" style="color : red;"></small>
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" 
                    	onclick="validationCheck()">
                     	확인</a>
				</div>
			</div>
		</div>
	</div>
	
		
	<!-- form 제출하는 모달창 -->
	<div class="modal fade" id="alartDateTooMuch" aria-hidden="true" aria-labelledby="alartOfTimeTooMuch">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa-solid fa-message-exclamation"></i>
					<h5>경고</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p></p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="startWork()" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>

	<!-- 완료창 -->
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
		function validationCheck(){
			// 1. 날짜 선택했는지 여부 
			if($('#expectDate').val() == ""){
				$('#noInputDate').text("유저테스트 완료 예정일을 입력하세요");
				return;
			}
			
			var aed = new Date($('#allExpectDate').text()).getTime(); 
			var ied = new Date($('#expectDate').val()).getTime();
			var today = new Date().getTime();
			// 2. 요청완료 예정일 이하 
			if(aed < ied){
				$('#noInputDate').text("요청 완료 예정일 이전으로 선택해주세요.");
				return;
			}
			// 3. 오늘 날짜 이상
			if(today > ied){
				$('#noInputDate').text("오늘날짜 이후로 선택해주세요.");
				return;
			}
			// 4. (입력 완료 예정일 - 현재날짜) / (요청완료 예정일 - 현재날짜) >= 50%
			if(((ied - today)/ (aed - today)) >= 0.5){
				$('#datemodal').modal('hide');
				$('#alartDateTooMuch').modal('show');
			}else{
				$('#datemodal').modal('hide');
				$('#alartDateTooMuch').modal('show');
			}
		}
		
		$('.showContentButton').click(function(){
			var fno = $(this).parent().parent().parent().next().toggle();
		}
		);

		function startWork(){
			$('#alartDateTooMuch').modal('hide');
			$('#completeDueDate').modal('show');
			$('#startWork').submit();
		}
		
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
			

	</script>
</body>

</html>
