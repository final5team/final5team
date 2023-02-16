<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script>
		$(document).ready(function(){
		  $("#receiptdiv").hide();
		  $("#rejectdiv").hide();
		  $("#receiptbtn").click(function(){
			  $("#rejectdiv").hide();
		      $("#receiptdiv").toggle();
		  });
		  $("#rejectbtn").click(function(){
			  $("#receiptdiv").hide();
			  $("#rejectdiv").toggle();
		   });
		});
	</script>
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
                <div class="container-fluid">
				
					<div class="row">
						<!-- 게시글 상세보기 start -->
						<div class="col-xl-9 col-lg-8 col-md-8 col-sm-8 mb-4">
							<div class="card">
								<div class="card-header d-flex">
									<div class="mr-auto">서비스 요청</div>									
								</div>
								<div class="card-body">
									<div>접수상세보기 ></div>
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
												<div class="pl-5">요청완료희망일:</div>
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
										<button class="btn btn-gradient-success btn-gradient btn-lg mt-3 " type="button" id="receiptbtn">접수</button>
										<button class="btn btn-gradient-danger btn-gradient btn-lg mt-3 ml-3" type="button" id="rejectbtn">반려</button>									
									</div>								
								</div>
							</form>

							<!-- 접수 -->
							<div id="receiptdiv"> 						            
								<form>
									<!-- 요청 접수 card start-->
									<div class="card mt-4 mb-1">
										<div class="card-header">서비스 요청 접수</div>
										<div class="card-body row">
											<div class="col-sm-3" style="text-align:center;">
												<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
												<div class="ml-3">PM</div>
											</div>
											<div class="col-sm-9">
												
												<div class="row col-sm-12 form-group">
													<div class="col">
														<label class="control-label">요청 유형</label>
														<input list="process" name="process">
														  <datalist id="process">
														    <option value="정규">
														    <option value="긴급">												   
														  </datalist>											
													</div>
													<div class="col">
														<label class="control-label">중요도</label>
														<input list="importance" name="importance">
														  <datalist id="importance">
														    <option value="상">
														    <option value="중">	
														    <option value="하">											   
														  </datalist>													
													</div>												
												</div>
												<div class="col-sm-12 form-group">
													<label class="control-label" >완료예정일</label>
													<input type="date" class="form-control ml-2" style="width: 200px; display: inline;">
												</div>
												
												<div class="col-sm-12 form-group">
													<label class="control-label" >개발 담당자 선택</label>
													<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="dev">
														<option value="1">장영훈 | 현재담당건수(5)</option>
														<option value="2">장영훈 | 현재담당건수(5)</option>
														<option value="3">장영훈 | 현재담당건수(5)</option>
														<option value="4">장영훈 | 현재담당건수(5)</option>
													</select>
												</div>
												<div class="col-sm-12 form-group">
													<label class="control-label" >테스트 담당자 선택</label>
													<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester">
														<option value="1">장영훈 | 현재담당건수(5)</option>
														<option value="2">장영훈 | 현재담당건수(5)</option>
														<option value="3">장영훈 | 현재담당건수(5)</option>
														<option value="4">장영훈 | 현재담당건수(5)</option>
													</select>
												</div>
												<div class="col-sm-12 form-group">
													<label class="control-label" >유저테스트 담당자 선택</label>
													<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="utester">
														<option value="1">장영훈 | 현재담당건수(5)</option>
														<option value="2">장영훈 | 현재담당건수(5)</option>
														<option value="3">장영훈 | 현재담당건수(5)</option>
														<option value="4">장영훈 | 현재담당건수(5)</option>
													</select>
												</div>
												<div class="col-sm-12 form-group">
													<label class="control-label" >배포 담당자 선택</label>
													<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="dist">
														<option value="1">장영훈 | 현재담당건수(5)</option>
														<option value="2">장영훈 | 현재담당건수(5)</option>
														<option value="3">장영훈 | 현재담당건수(5)</option>
														<option value="4">장영훈 | 현재담당건수(5)</option>
													</select>
												</div>
											
												<div class="col-sm-12 form-group">
													<label class="control-label">의견 내용</label>
													<textarea rows="2" class="form-control boxed"></textarea>
												</div>											
												<div class="filebox">
													<label for="file">첨부파일</label>
													<input type="file" id="file">
												</div>
												
											</div>
										</div>
									</div>
									<!-- 요청 접수 card end-->
									<div class="d-flex justify-content-end">
										<button class="btn btn-gradient-success btn-gradient btn-lg mt-3" type="button">접수 완료</button>
										<button class="btn btn-gradient btn-lg mt-3 ml-3" style="background-image: linear-gradient(to right, #859398  51%, #616161  100%);" id="receiptbtn">취소</button>									
									</div>
								</form>
							</div>
							
							<!-- 반려 -->
							<div id="rejectdiv"> 						            
								<form>
									<!-- 요청 접수 card start-->
									<div class="card mt-4 mb-1">
										<div class="card-header">서비스 요청 반려</div>
										<div class="card-body row">
											<div class="col-sm-3" style="text-align:center;">
												<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
												<div class="ml-3">PM</div>
											</div>
											<div class="col-sm-9">	
												<div class="col-sm-12 form-group">
													<label class="control-label">반려 사유</label>
													<textarea rows="2" class="form-control boxed"></textarea>
												</div>											
												<div class="filebox">
													<label for="file">첨부파일</label>
													<input type="file" id="file">
												</div>
												
											</div>
										</div>
									</div>
									<!-- 요청 접수 card end-->
									<div class="d-flex justify-content-end">
										<button class="btn btn-gradient-danger btn-gradient btn-lg mt-3" type="button">반려 완료</button>
										<button class="btn btn-gradient btn-lg mt-3 ml-3" style="background-image: linear-gradient(to right, #859398  51%, #616161  100%);" id="rejectbtn">취소</button>									
									</div>
								</form>
							</div>

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


</body>

</html>