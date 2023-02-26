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
                	<div id="main">
					<!-- 게시글 상세보기 start -->
						<img src="${pageContext.request.contextPath}/resources/img/finished.jpg"
									style="width:200px; height:150px;"/>
						<div class="card card-block sameheight-item">
							<h3 class="font-weight-bold">						
								 요청 정보
							</h3>
							<div class="row mt-3">
								<div class="col-2 font-weight-bold">요청자 :</div>
								<div class="col-4">${request.clientName}</div>
								<div class="col-2 font-weight-bold">소속 기관 :</div>
								<div class="col-4">${request.organ}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-2 font-weight-bold">요청일 :</div>
								<div class="col-4"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
								<div class="col-2 font-weight-bold">완료 희망일 :</div>
								<div class="col-4"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-2 font-weight-bold">시스템 :</div>
								<div class="col-10">${request.systemName}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-2 font-weight-bold">제목 :</div>
								<div class="col-10">${request.reqTitle}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-2 font-weight-bold">내용 :</div>
								<div class="col-10 border" style="min-height:100px;">${request.reqContent}</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-2 font-weight-bold">요청 첨부파일 :</div>
								<div class="col-10">
									<c:forEach var="statusHistoryFile" items="${request.files}">
										<div>
											<span>${statusHistoryFile.fileName}</span>
											<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
												<i class="fas fa-cloud-download-alt"></i>
											</a>
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="d-flex justify-content-end">
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
							<div class="card card-block mt-3 mb-1">
								<h3 class="font-weight-bold">						
									요청 처리 계획 작성
								</h3>
								<div class="card-body">
									<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data">
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
										<div class="col-sm-12 form-group filebox">
											<label for="file">첨부파일</label>
											<div>
												<input type="file" id="files" name="files" multiple>
												<input type="hidden" name="rno" value="${request.rno}">
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
								<div class="card card-block mt-3 mb-1">
									<h3 class="font-weight-bold">						
										반려 사유 작성
									</h3>
									<div class="card-body">
										<div class="form-group">
											<label class="control-label">반려 사유</label>
											<textarea rows="2" class="form-control boxed" name="reply" required></textarea>
										</div>											
										<div class="filebox">
											<label for="file">첨부파일</label>
											<div>
												<input type="file" id="files" name="files" multiple>
												<input type="hidden" name="rno" value="${request.rno}">
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
						
						<!-- 요청 처리 계획 start-->
						<c:if test="${request.statusNo!=1 && member.mtype !='user' && request.statusNo!=12}">
							<div class="card card-block sameheight-item mt-3">
								<h3 class="font-weight-bold">						
									 요청 처리 계획
								</h3>
								<div class="row mt-3">
									<div class="col-2 font-weight-bold">요청 유형 :</div>
									<div class="col-4">
										<c:if test="${reqProcess.reqType eq '정규'}">
											<div>정규<i class="far fa-registered text-secondary"></i></div>
										</c:if>
										<c:if test="${reqProcess.reqType eq '긴급'}">
											<div>긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
										</c:if>
									</div>
									<div class="col-2 font-weight-bold">중요도 :</div>
									<div class="col-4">
										<c:if test="${reqProcess.priority eq '하' || reqProcess.priority eq '중' ||reqProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
										<c:if test="${reqProcess.priority eq '중' || reqProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
										<c:if test="${reqProcess.priority eq '상'}">
											<span class="fa fa-star checked" style="color: orange;"></span>
										</c:if>
									</div>
								</div>
								<hr/>

								<div class="row">
									<div class="col-2 font-weight-bold">요청 완료 예정일 :</div>
									<div class="col-10">
										<fmt:formatDate value="${reqProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
									</div>
								</div>
								<hr/>
								<div class="row">
									<div class="col-2 font-weight-bold">개발 담당자 :</div>
									<div class="col-4">${reqProcess.developer}</div>
									<div class="col-2 font-weight-bold">테스트 담당자 :</div>
									<div class="col-4">${reqProcess.tester}</div>
								</div>	
								<hr/>
								<div class="row">
									<c:if test="${reqProcess.reqType eq '정규'}">
										<div class="col-2 font-weight-bold">유저테스트 담당자 :</div>
										<div class="col-4">${reqProcess.userTester}</div>
									</c:if>
									<div class="col-2 font-weight-bold">배포 담당자 :</div>
									<div class="col-4">${reqProcess.distributor}</div>
								</div>	
								<hr/>
								<c:forEach var="statusHistory" items="${pmToAllHistories}">
									<div class="row">
										<div class="col-2 font-weight-bold">검토 의견 :</div>
										<div class="col-10 border" style="min-height:100px;">${statusHistory.reply}</div>
									</div>
									<hr/>
									<div class="row">
										<div class="col-2 font-weight-bold">검토 첨부파일 :</div>
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
								</c:forEach>						
							</div>
						</c:if>
						<!-- 요청 처리 계획 end-->
						<!-- 반려 처리 정보 start -->
						<c:if test="${request.statusNo==12}">
							<div class="card mt-3 mb-1">
								<h3 class="font-weight-bold">						
									반려 처리 내역
								</h3>
								<div class="card-body">									
									<div class="form-group">
										<label class="control-label">반려 사유</label>
										<textarea rows="2" class="form-control boxed" name="reply" readonly>${staHistory.reply}</textarea>
									</div>											
									<div class="mt-3 row">
										<c:if test="${request.files != null}">
											<div class="col-3">첨부 파일:
												<c:forEach var="file" items="${request.files}">
													<div>
														<span>${file.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${file.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</c:if>
									</div>																														
								</div>										
							</div>
						</c:if>
						<!-- 반려 처리 정보 end-->
					<!-- 게시글 상세보기 end -->
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
