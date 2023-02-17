<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
    	:root {
		 	--line-fill: #3498db;
		  	--line-empty: #e0e0e0;
		  	--now-fill: #F40730;
		}
    	.container {
		 	 text-align: center;
		}
		
    	
    	.circle {
    		  margin-left : 25px;
			  background-color: #fff;
			  color: #999;
			  border-radius: 50%;
			  height: 30px;
			  width: 150px;
			  border: 3px solid var(--line-empty);
			  transition: 0.4s ease;
		}
		.bar {
			  margin-left : 100px;
			  padding : 0px;
			  background-color: #fff;
			  color: #999;
			  height: 60px;
			  width: 1px;
			  align-items: center;
			  justify-content: center;
			  border: 3px solid var(--line-empty);
			  transition: 0.4s ease;
		}
		
		.circle.active {
		  	border-color: var(--line-fill);
		}
		
		.circle.now {
		  	border-color: var(--now-fill);
		}
		
		.bar.active {
		  	border-color: var(--line-fill);
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
                <div class="container-fluid">
				
					<div class="row">
						<!-- 게시글 상세보기 start -->
						<div class="col-xl-9 col-lg-8 col-md-8 col-sm-8">
							<div class="card">
								<div class="card-header d-flex">
									<div class="mr-auto">개발상세보기 ></div>
								</div>
								<div class="card-body">
									<div class="d-flex">
										<div class="ml-3">정규</div>
										<div class="ml-5">중요도: 상</div>
									</div>
									<div>
										<h3 class="mr-auto font-weight-bold">여기는 제목 자리입니다.</h3>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
											<span class="font-weight-bold ml-2">홍길동</span>
											<span class="ml-3">서울강남고용센터</span>
										</div>
										<div class="col-sm-6 ml-auto">
											<div class="d-flex">
												<div class="pl-5">시스템:</div>
												<div class="pl-2 flex-grow-1">무슨시스템</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청일:</div>
												<div class="pl-2 flex-grow-1">2023-02-03</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청완료예정일:</div>
												<div class="pl-2 flex-grow-1">2023-04-10</div>
											</div>
										</div>
									</div>
									<div class="mt-2 ml-5">여기는 내용이지요~~</div>
									<div class="mt-3 ml-5">
										<span>파일이름</span>
										<a href="#" role="button">
											<i class="fas fa-cloud-download-alt"></i>
										</a>
									</div>
								</div>
							</div>
							<form>
								<div>
									<div class="d-flex justify-content-end">
										 <button class="btn btn-gradient-danger btn-gradient btn-lg mt-3 ml-3" onclick="getDatemodal()" type="button">테스트시작</button>
									<!-- <button class="btn btn-gradient-success btn-gradient btn-lg mt-3">개발 완료</button> -->
									</div>
									<label style="color: #343a40;">개발 완료 예정일</label>
									<input type="date" class="form-control ml-2" style="width: 200px; display: inline;">
								</div>
							</form>
							<div class="card mt-4">
								<div class="card-header">3차 개발 내용</div>
								<div class="card-body row">
									<div class="col-sm-3" style="text-align: center;">
										<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
										<div class="ml-3">김레지나</div>
									</div>
									<div class="col-sm-9">
										<div class="ml-3">개발자가 3차때 작성했었던 내용 보입니다.</div>
									</div>
								</div>
							</div>

							<div class="card mt-4">
								<div class="card-header">3차 결함 내용</div>
								<div class="card-body row">
									<div class="col-sm-3" style="text-align: center;">
										<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
										<div class="ml-3">박말자</div>
									</div>
									<div class="col-sm-9">
										<div class="ml-3">테스터가 3차때 작성했었던 내용 보입니다.</div>
									</div>
								</div>
							</div>
							<!-- 개발자의 개발 요청 글 작성 start-->
							<div class="card mt-4 mb-5">
								<div class="card-header">작성하기</div>
								<div class="card-body row">
									<div class="col-sm-3" style="text-align:center;">
										<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
										<div class="ml-3">나</div>
									</div>
									<div class="col-sm-9">
										<form role="form">
											<div class="col-sm-12 form-group">
												<label class="control-label" >완료예정일</label>
												<input type="text" class="form-control boxed" value="2023-02-09" readonly>
											</div>
											<div class="col-sm-12 form-group">
												<label class="control-label">개발내용</label>
												<textarea rows="2" class="form-control boxed"></textarea>
											</div>
											<div class="col-sm-12 form-group">
												<label class="control-label">배포소스</label>
												<input type="text" class="form-control boxed">
											</div>
											<div class="filebox">
												<label for="file">Choose a file</label>
												<input type="file" id="file">
											</div>
										</form>
									</div>
								</div>
							</div>
							<!-- 개발자의 개발 요청 글 작성 end-->
						</div>
						<!-- 게시글 상세보기 end -->
						<!-- 상태 단계 이력 start -->						
						<div class="col-xl-3 col-lg-4 col-md-4 col-sm-4">
							<div class="card">
								<div class="card-header">
									<h6 class="m-0 font-weight-bold text-primary">단계 상태</h6>
								</div>
								<div class="card-body">
									<div></div>
									<div class="mt-4 text-center small"></div>
								</div>
							</div>
						</div>
						<!-- 상태 단계 이력 end -->						
					</div>
					
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
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="developDueDate">개발 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
				</div>
				<div class="modal-body d-flex justify-content-center">
					<label class="mt-1" style="color: #343a40;">개발 완료 예정일</label>
					<input type="date" class="form-control ml-2" id="developDueDate" style="width: 200px; display: inline;">
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="closedatemodal()">확인</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- date 입력받는 모달창 end -->
		
	<!-- 경고 모달창 -->
	<div class="modal fade" id="alartDateTooMuch" aria-hidden="true" aria-labelledby="alartOfTimeTooMuch">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>
						<i class="fa-solid fa-triangle-exclamation"></i>
						경고
					</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
				</div>
				<div class="modal-body">
					<p>입력 시간이 완료 예정일 대비 50% 이상 차지합니다. 확인을 누르시면 수정이 불가능합니다.</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
		

	<!-- 경고 모달창 -->
	<script>
	function getDatemodal(){
		$('#datemodal').modal('show');
		
	}
	function closedatemodal(){
		$('#datemodal').modal('hide');
		$('#alartDateTooMuch').modal('show');
	}
	</script>
</body>

</html>
