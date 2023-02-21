<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
		function receiptCancel(){
			$("#receiptdiv").hide();
			$("input").val("");
			$("textarea").val("");		
		}
		function rejectCancel(){
			$("#rejectdiv").hide();
			$("input").val("");
			$("textarea").val("");
		}
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
										<h3 class="mr-auto font-weight-bold">${request.reqTitle}</h3>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
											<span class="font-weight-bold ml-2">${request.clientName}</span>
											<span class="ml-3">request.organ</span>
										</div>
										<div class="col-sm-6 ml-auto">
											<div class="d-flex">
												<div class="pl-5">시스템:</div>
												<div class="pl-2 flex-grow-1">${request.systemName}</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청일:</div>
												<div class="pl-2 flex-grow-1"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>												
											</div>
											<div class="d-flex">
												<div class="pl-5">요청완료희망일:</div>
												<div class="pl-2 flex-grow-1"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
											</div>
										</div>
									</div>
									<div class="mt-2 ml-5">${request.reqContent}</div>
									<div class="mt-3 ml-5">
										<span>첨부파일: <c:forEach var="file" items="${request.files}">${file.fileName}</c:forEach></span>
										<a href="#" role="button">
											<i class="fas fa-cloud-download-alt"></i>
										</a>
									</div>
									<div class="d-flex justify-content-end">
										<button class="btn btn-primary btn-lg mt-3 ml-3" type="button" id="receiptbtn">접수</button>
										<button class="btn btn-danger btn-lg mt-3 ml-3" type="button" id="rejectbtn">반려</button>
									</div>
								</div>
							</div>							

							<!-- 접수 -->
							<div id="receiptdiv"> 						            
								
									<!-- 요청 접수 card start-->
									<div class="card mt-4 mb-1">
										<div class="card-header">서비스 요청 접수</div>
										<div class="card-body">
										<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data">
											<div class="row">
												<div class="col-sm-3" style="text-align:center;">
													<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
													<div class="ml-3">PM</div>
												</div>
												<div class="col-sm-9">
													
													<div class="row col-sm-12 form-group">
														<div class="col">
															<label class="control-label">요청 유형</label>
															<input list="process" name="reqType">
															  <datalist id="process">
															    <option value="정규">
															    <option value="긴급">												   
															  </datalist>											
														</div>
														<div class="col">
															<label class="control-label">중요도</label>
															<input list="importance" name="priority">
															  <datalist id="importance">
															    <option value="상">
															    <option value="중">	
															    <option value="하">											   
															  </datalist>													
														</div>												
													</div>
													<div class="col-sm-12 form-group">
														<label class="control-label" >완료예정일</label>
														<input type="date" class="form-control ml-2" style="width: 200px; display: inline;" name="allExpectDate">
													</div>
													
													<div class="col-sm-12 form-group">
														<label class="control-label" >개발 담당자 선택</label>
														<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="developer">
															<c:forEach var="staff" varStatus="index" items="${devStaffList}">
																<option value="${index.count}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>															
														</select>
													</div>
													<div class="col-sm-12 form-group">
														<label class="control-label" >테스트 담당자 선택</label>
														<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester">
															<c:forEach var="staff" varStatus="index" items="${tesStaffList}">
																<option value="${index.count}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-12 form-group">
														<label class="control-label" >유저테스트 담당자 선택</label>
														<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="userTester">
															<c:forEach var="staff" varStatus="index" items="${uteStaffList}">
																<option value="${index.count}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-12 form-group">
														<label class="control-label" >배포 담당자 선택</label>
														<select class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="distributor">
															<c:forEach var="staff" varStatus="index" items="${disStaffList}">
																<option value="${index.count}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
												
													<div class="col-sm-12 form-group">
														<label class="control-label">의견 내용</label>
														<textarea rows="2" class="form-control boxed" name="reply"></textarea>
													</div>											
													<div class="filebox">
														<label for="file">첨부파일</label>
														<input type="file" id="fileList" multiple>
														<input type="hidden" name="rno" value="${request.rno}">
													</div>
													
												</div>
											</div>
											<div class="d-flex justify-content-end">						
												<button class="btn btn-primary btn-lg mt-3 ml-3" type="submit" value=2 name="nextStatus">접수 완료</button>
												<a class="btn btn-secondary btn-lg mt-3 ml-3" onclick="receiptCancel()">취소</a>												
											</div>
											</form>											
										</div>										
									</div>
									<!-- 요청 접수 card end-->
																
							</div>
							
							<!-- 반려 -->
							<div id="rejectdiv"> 						            
								<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data">
									<!-- 요청 접수 card start-->
									<div class="card mt-4 mb-1">
										<div class="card-header">서비스 요청 반려</div>
										<div class="card-body">
											<div class="row">
												<div class="col-sm-3" style="text-align:center;">
													<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
													<div class="ml-3">PM</div>
												</div>
												<div class="col-sm-9">	
													<div class="col-sm-12 form-group">
														<label class="control-label">반려 사유</label>
														<textarea rows="2" class="form-control boxed" name="reply"></textarea>
													</div>											
													<div class="filebox">
														<label for="file">첨부파일</label>
														<input type="file" id="file">
														<input type="hidden" name="rno" value="${request.rno}">
													</div>
													
												</div>
											</div>
											<div class="d-flex justify-content-end">									
												<button class="btn btn-danger btn-lg mt-3 ml-3" type="submit" value=12 name="nextStatus">반려 완료</button>												
												<a class="btn btn-secondary btn-lg mt-3 ml-3" onclick="rejectCancel()">취소</a>									
											</div>
										</div>
									</div>
									<!-- 요청 접수 card end-->
									
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
