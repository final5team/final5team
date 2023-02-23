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
			// 접수 입력 항목 숨기기
		  $("#receiptdiv").hide();
			// 반려 입력 항목 숨기기
		  $("#rejectdiv").hide();
			// 접수 입력 항목 열고 반려 입력 항목 숨기기
		  $("#receiptbtn").click(function(){
			  $("#rejectdiv").hide();
		      $("#receiptdiv").toggle();
		  });
			// 반려 입력 항목 열고 접수 입력 항목 숨기기
		  $("#rejectbtn").click(function(){
			  $("#receiptdiv").hide();
			  $("#rejectdiv").toggle();
		   });
			// 완료 예정일에 현재 날짜 이후 날짜만 선택 가능하게 만들기
		  document.getElementById("allExpectDate").min
		  = new Date().toISOString().slice(0, 10);
			
			
		});
		// 접수 토글 숨기고 입력 내용 삭제하기
		function receiptCancel(){
			$("#receiptdiv").hide();
			$("input").val("");
			$("textarea").val("");		
		}
		// 반려 토글 숨기고 입력 내용 삭제하기
		function rejectCancel(){
			$("#rejectdiv").hide();
			$("input").val("");
			$("textarea").val("");
		}	
		// 요청 유형에 따른 유저 테스터 선택 여부
		function rtype(){
			var reqType = $("#reqType").val();
			// 요청 유형이 긴급일 때 유저 테스터 선택하지 않기
			if(reqType == '긴급'){
				// 유저 테스터 선택 불가
				$("#utester").hide();
				// 유저 테스터 값 null
				$("#userTester").val("");
				// 유저 테스터 미입력 가능
				$("#userTester").removeAttr("required");
			}
			// 요청 유형이 정규일 때 유저 테스터 선택하기
			if(reqType == '정규'){
				// 유저 테스터 선택 가능
				$("#utester").show();
				// 유저 테스터 필수 입력
				$("#userTester").attr("required", "required")
			}			
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
									<div>접수 상세보기 ></div>
									<div>
										<h3 class="mr-auto font-weight-bold">${request.reqTitle}</h3>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
											<span class="font-weight-bold ml-2">${request.clientName}</span>
											<span class="ml-3">${request.organ}</span>
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
										<c:if test="${request.files != null}">
											<c:forEach var="file" items="${request.files}">
												<p>
													<span>${file.fileName}</span>
													<a href="#" role="button">
														<i class="fas fa-cloud-download-alt"></i>
													</a>
												</p>
											</c:forEach>
										</c:if>
									</div>									
									<c:if test="${request.statusNo==1 && member.mtype =='pm'}">
										<div class="d-flex justify-content-end">
											<button class="btn btn-primary btn-lg mt-3 ml-3" type="button" id="receiptbtn">접수</button>
											<button class="btn btn-danger btn-lg mt-3 ml-3" type="button" id="rejectbtn">반려</button>
										</div>
									</c:if>
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
												<div class="col-sm-3 d-flex align-items-center" style="text-align:center;">
													<div>
														<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
														<div class="ml-3">[PM] ${member.mname}</div>
													</div>
												</div>
												<div class="col-sm-9">
													
													<div class="row col-sm-12 form-group">
														<div class="col">
															<label class="control-label">요청 유형</label>
															<select class="dropdown-toggle ml-4" data-toggle="dropdown" name="reqType" id="reqType" style="width: 200px" onchange="rtype()">															
																<option value="정규" class="text-center">정규</option>
															    <option value="긴급" class="text-center">긴급</option>																																																						
															</select>																								
														</div>
														<div class="col">
															<label class="control-label">중요도</label>
															<select class="dropdown-toggle ml-5" data-toggle="dropdown" name="priority" style="width: 200px">															
																<option value="상" class="text-center">상 (★★★)</option>
																<option value="중" class="text-center">중 (★★)</option>
																<option value="하" class="text-center">하 (★)</option>															    																																																						
															</select>												
														</div>												
													</div>
													<div class="col-sm-12 form-group row">
														<label class="control-label col-lg-6" >완료예정일</label>
														<input type="date" class="form-control col-lg-6" name="allExpectDate" id="allExpectDate" required pattern="\d{4}-\d{2}-\d{2}">
														<span class="validity"></span>
													</div>
													
													<div class="col-sm-12 form-group row">
														<label class="control-label col-lg-6">개발 담당자 선택</label>
														<select class="dropdown-toggle col-lg-6" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="developer">
															<c:forEach var="staff" items="${devStaffList}">
																<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>															
														</select>
													</div>
													<div class="col-sm-12 form-group row">
														<label class="control-label col-lg-6">테스트 담당자 선택</label>
														<select class="dropdown-toggle col-lg-6" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester">
															<c:forEach var="staff" items="${tesStaffList}">
																<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-12 form-group row" id="utester">
														<label class="control-label col-lg-6">유저테스트 담당자 선택</label>
														<select class="dropdown-toggle col-lg-6" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="userTester" id="userTester">
															<c:forEach var="staff" items="${uteStaffList}">
																<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													<div class="col-sm-12 form-group row">
														<label class="control-label col-lg-6">배포 담당자 선택</label>
														<select class="dropdown-toggle col-lg-6" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="distributor">
															<c:forEach var="staff" items="${disStaffList}">
																<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
												
													<div class="col-sm-12 form-group">
														<label class="control-label">의견 내용</label>
														<textarea rows="2" class="form-control boxed" name="reply" required></textarea>
													</div>											
													<div class="filebox">
														<label for="file">첨부파일</label>
														<input type="file" id="files" name="files" multiple>
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
												<div class="col-sm-3 d-flex align-items-center" style="text-align:center;">
													<div>
														<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
														<div class="ml-3">[PM] ${member.mname}</div>
													</div>
												</div>
												<div class="col-sm-9">	
													<div class="form-group">
														<label class="control-label">반려 사유</label>
														<textarea rows="2" class="form-control boxed" name="reply" required></textarea>
													</div>											
													<div class="filebox">
														<label for="file">첨부파일</label>
														<input type="file" id="files" name="files" multiple>
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
							
							<!-- 서비스 요청 접수 완료 후 start-->
							<c:if test="${request.statusNo!=1 && member.mtype !='user' && request.statusNo!=12}">
								<div class="card mt-4 mb-1">
									<div class="card-header">서비스 요청 접수 완료</div>
									<div class="card-body">									
										<div class="row">
											<div class="col-sm-3 d-flex align-items-center" style="text-align:center;">
												<div>
													<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
													<div class="ml-3">[PM] ${reqProcess.pm}</div>
												</div>
											</div>
											<div class="col-sm-9">
												
												<div class="row col-sm-12 form-group">
													<div class="col">
														<label class="control-label">요청 유형</label>
														<input value="${reqProcess.reqType}" style="width: 200px" class="text-center ml-4" readonly>																																													
													</div>
													<div class="col">
														<label class="control-label">중요도</label>
														<input value="${reqProcess.priority}" style="width: 200px" class="text-center ml-5" readonly>																																																														
													</div>												
												</div>
												<div class="col-sm-12 form-group row">
													<label class="control-label col-lg-6" >완료예정일</label>
													<input name="allExpectDate" class="col-lg-6 text-center" value="<fmt:formatDate value="${reqProcess.allExpectDate}" pattern="yyyy-MM-dd"/>" readonly>
												</div>
												
												<div class="col-sm-12 form-group row">
													<label class="control-label col-lg-6">개발 담당자 선택</label>
													<input name="developer" value="${reqProcess.developer}" class="col-lg-6 text-center" readonly>	
												</div>
												<div class="col-sm-12 form-group row">
													<label class="control-label col-lg-6">테스트 담당자 선택</label>
													<input name="tester" value="${reqProcess.tester}" class="col-lg-6 text-center" readonly>
												</div>
												<div class="col-sm-12 form-group row">
													<label class="control-label col-lg-6">유저테스트 담당자 선택</label>
													<input name="userTester" value="${reqProcess.userTester}" class="col-lg-6 text-center" readonly>
												</div>
												<div class="col-sm-12 form-group row">
													<label class="control-label col-lg-6">배포 담당자 선택</label>
													<input name="distributor" value="${reqProcess.distributor}" class="col-lg-6 text-center" readonly>
												</div>										
											</div>
										</div>																					
									</div>										
								</div>
							</c:if>
							<!-- 서비스 요청 반려 완료 후 end-->
							<c:if test="${request.statusNo==12}">
								<div class="card mt-4 mb-1">
									<div class="card-header">서비스 요청 반려</div>
									<div class="card-body">									
										<div class="row">
											<div class="col-sm-3 d-flex align-items-center" style="text-align:center;">
												<div>
													<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="50%">
													<div class="ml-3">[PM] ${staHistory.writer}</div>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="form-group">
													<label class="control-label">반려 사유</label>
													<textarea rows="2" class="form-control boxed" name="reply" readonly>${staHistory.reply}</textarea>
												</div>											
												<div class="mt-3">
													<c:if test="${request.files != null}">
														<c:forEach var="file" items="${request.files}">
															<p>
																<span>${file.fileName}</span>
																<a href="#" role="button">
																	<i class="fas fa-cloud-download-alt"></i>
																</a>
															</p>
														</c:forEach>
													</c:if>
												</div>
											</div>											
										</div>																					
									</div>										
								</div>
							</c:if>
							<!-- 서비스 요청 반려 완료 후 end-->
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
