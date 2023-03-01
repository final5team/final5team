<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
    	:root {
          --line-fill: #87cd36;
           --line-empty: #e0e0e0;
           --now-fill: #F40730;
      }
       
       .circle {
            margin-left : 25px;
           background-color: #fff;
           color: #999;
           height: 40px;
           width: 150px;
           font-size : 20px;
           line-height : 40px;
           border: 3px solid var(--line-empty);
           transition: 0.4s ease;
           border-radius: 10px;
      }
      .bar {
           margin-left : 93px;
           padding : 0px;
           margin: 2px 0
           background-color: #fff;
           color: #999;
           height: 10px;
           width: 10px;
           align-items: center;
           justify-content: center;
           border: 3px solid var(--line-empty);
           transition: 0.4s ease;
           border-radius: 50%;
      }
      .bar:after{
      	margin-bottom: 5px;
      }
      .circle.done {
           border-color: var(--line-fill);
           color : var(--line-fill);
      }
      
      .circle.now {
         border-color : var(--line-fill);
         color : white;
         background-color : var(--line-fill);
      }
      
      .bar.active {
           border-color: var(--line-fill);
      }
	 
	 li {
	 	list-style : none;
	 }
	 /* 스테퍼 임시 */
	 .stepper-wrapper {
	  margin-top: auto;
	  display: flex;
	  justify-content: space-between;
	  margin-bottom: 20px;
	}
	.stepper-item {
	  position: relative;
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  flex: 1;
	
	}
	
	.stepper-item::before {
	  position: absolute;
	  content: "";
	  border-bottom: 2px solid #ccc;
	  width: 100%;
	  top: 20px;
	  left: -50%;
	  z-index: 2;
	}
	
	.stepper-item::after {
	  position: absolute;
	  content: "";
	  border-bottom: 2px solid #ccc;
	  width: 100%;
	  top: 20px;
	  left: 50%;
	  z-index: 2;
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
                	 		<div class="stepper-wrapper">
	                	 		<div class="btn btn-md btn-primary stepper-item">1</div>
	                	 		<div class="btn btn-md btn-primary stepper-item">2</div>
	                	 		<div class="btn btn-md btn-primary stepper-item">3</div>
	                	 		<div class="btn btn-md btn-primary stepper-item">4</div>
	                	 		<div class="btn btn-md btn-primary stepper-item">5</div>
	                	 		<div class="btn btn-md btn-primary stepper-item">6</div>
	                	 		<div class="btn btn-md btn-primary stepper-item">7</div>
	                	 	</div>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
                	 	<section> <!-- 입력폼 start -->
                	 		<div class="card border-left-dark">
                	 			<div class="card-body">
                	 				<form>
                	 					<div class="form-grouop d-flex">
                	 						<div>완료예정일</div>
                	 						<div>2021-02-09</div>
                	 					</div>
                	 					<div class="form-grouop d-flex">
                	 						<div>배포소스</div>
                	 						<div>asdfasdfasdf.java</div>
                	 					</div>
                	 					<div class="form-grouop d-flex">
                	 						<div>개발 내용</div>
                	 						<div>여기보세요~~</div>
                	 					</div>
                	 					<div class="form-grouop">
                	 						<div>첨부파일</div>
                	 						<input type ="file">
                	 					</div>
                	 				</form>
                	 			</div>
                	 		</div>
                	 	</section><!-- 입력폼 end --> 
                	 	
                	 	
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
	<script>
	<!-- 데이트 입력 확인 /-->
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
	
	
	
	
	</script>
</body>

</html>