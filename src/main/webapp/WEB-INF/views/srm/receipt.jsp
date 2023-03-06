<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>
	
	<style>
	span::after {
	  padding-left: 5px;
	}
	

	input:valid + span::after {
	  content: "✓";
	}
    </style>
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
                <div class="container">
                	<div id="main">
                	 	<div class="title-block">
                	 		<h3 class="title">요청 정보 조회</h3>
                	 	</div>
                	 	<div> <!-- 여기에 단계 상태 이력 넣기 -->
                	 		<%@ include file="/WEB-INF/views/srm/restatus/stepperprogress.jsp" %>
                	 	</div>	<!-- 여기에 단계 상태 이력 넣기 /-->
                	 	
                	 	<section><!-- 게시글 상세보기 start -->
							<div class="card border-top-dark sameheight-item">
								<div class="card-block"> <!-- card-block  -->
									<div class="card-title-block">
	                	 				<h3 class="title">
		                	 				요청번호 No. ${request.rno}
	                	 				</h3>
	                	 			</div>
	                	 			<div class="card-body">
										<div class="row mt-3">
											<div class="col-3 label">요청자</div>
											<div class="col-2">${request.clientName}</div>
											<div class="col-3 label">소속 기관</div>
											<div class="col-2">${request.organ}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">요청일</div>
											<div class="col-2"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
											<div class="col-3 label">완료 희망일 </div>
											<div class="col-2"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">시스템</div>
											<div class="col-8">${request.systemName}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">제목</div>
											<div class="col-8">${request.reqTitle}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">내용</div>
											<textarea class="col-7 form-control boxed mr-5" rows="3" readonly>${request.reqContent}</textarea>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">요청 첨부파일</div>
											<div class="col-7">
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
								</div> <!-- card-block / -->
							</div>				
						</section><!-- 게시글 상세보기 end -->
						<!-- 접수 -->
						<c:if test="${member.mtype == 'pm' && request.statusNo == 1}">
							<div id="receiptdiv"> 						            
								<!-- 요청 접수 card start-->
								<div class="card border-top-primary mt-3 mb-3">
									<div class="card-block">
										<div class="card-title-block">
		                	 				<h3 class="title">
			                	 				요청 처리 계획 작성<i class="ml-1  fas fa-pen-alt"></i>
		                	 				</h3>
		                	 			</div>
										<div class="card-body">
											<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data">
												<div class="row form-group">
													<div class="col-3 label">
														<label>*요청 유형</label>
													</div>
													<div class="col-2">
														<select class="dropdown-toggle" style="width: 175px;" data-toggle="dropdown" name="reqType" id="reqType" onchange="rtype()" required>															
															<option value="" class="text-center">요청 유형</option>
															<option value="정규" class="text-center">정규</option>
														    <option value="긴급" class="text-center">긴급</option>																																																						
														</select>																								
													</div>
													<div class="col-3 label">
														<label >*중요도</label>
													</div>
													<div class="col-2">
														<select class="dropdown-toggle" style="width: 175px;" data-toggle="dropdown" name="priority" required>															
															<option value="" class="text-center">중요도</option>
															<option value="상" class="text-center">상 (★★★)</option>
															<option value="중" class="text-center">중 (★★)</option>
															<option value="하" class="text-center">하 (★)</option>															    																																																						
														</select>												
													</div>												
												</div>
												<div class="row">
													<div class="col-3 label">*완료예정일</div>
													<div class="col-7">
														<input type="date" class="form-control boxed" name="allExpectDate" id="allExpectDate" required pattern="\d{4}-\d{2}-\d{2}" style="width: 220px; padding: 0;">
														<span class="validity m-2"></span>
													</div>	
												</div>
													
												<div class="row mb-2">
													<label class="label col-3">*개발 담당자 선택</label>
													<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="developer" required>
														<option value="">개발 담당자 선택 | 현재담당건수 </option>		
														<c:forEach var="staff" items="${devStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>															
													</select>
												</div>
												<div class="row mb-2">
													<label class="label col-3">*테스트 담당자 선택</label>
													<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester" requried>
														<option value="">테스트 담당자 선택 | 현재담당건수 </option>	
														<c:forEach var="staff" items="${tesStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>
													</select>
												</div>
												<div class="row mb-2" id="utester">
													<label class="label col-3">*품질 검토 담당자 선택</label>
													<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="userTester" id="userTester">
														<option value="">품질 검토 담당자 선택 | 현재담당건수 </option>	
														<c:forEach var="staff" items="${uteStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>
													</select>
												</div>
												<div class="row mb-2">
													<label class="label col-3">*배포 담당자 선택</label>
													<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="distributor" required>
														<option value="">배포 담당자 선택 | 현재담당건수 </option>	
														<c:forEach var="staff" items="${disStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>
													</select>
												</div>
											
												<div class="row mb-2">
													<div class="label col-3">*의견 내용</div>
													<textarea class="form-control boxed col-7 pmcontent" name="reply" style="padding: 0px"></textarea>
												</div>											
												<div class="row form-group filebox">
													<div class="label col-3">첨부파일</div>
													<div class="col-7">
														<input type="file" id="files" name="files" multiple>
														<input type="hidden" name="rno" value="${request.rno}">
													</div>
												</div>
											<div class="d-flex justify-content-end">						
												<button class="btn btn-primary btn-lg mt-3 ml-3" type="submit" value=2 name="nextStatus">접수 완료</button>
												<a class="btn btn-secondary btn-lg mt-3 ml-3" onclick="receiptCancel()">취소</a>												
											</div>
										</form>											
									</div><!-- card-body -->
								</div><!-- card-block -->										
							</div>
							<!-- 요청 접수 card end-->								
						</div>
						
						<!-- 반려 -->
							<div id="rejectdiv"> 						            
								<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data">
									<!-- 요청 접수 card start-->
									<div class="card border-top-danger mt-3 mb-1">
										<div class="card-block">
											<div class="card-title-block">
			                	 				<h3 class="title">
				                	 				반려 사유 작성<i class="ml-1 fas fa-external-link-alt"></i>
			                	 				</h3>
			                	 			</div>
											<div class="card-body">
												<div class="form-group d-flex">
													<label class="label">반려 사유</label>
													<textarea  class="form-control boxed pmcontent" name="reply" style="width: 80%; margin: auto;" required></textarea>
												</div>											
												<div class="filebox row">
													<label for="file" class=" col-3 label">첨부파일</label>
													<div class="col-7">
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
									</div>
									<!-- 요청 접수 card end-->									
								</form>
							</div>
						</c:if>
						<!-- 요청 처리 계획 start-->
						<c:if test="${member.mtype !='user' && member.mtype != 'pm'}">
								<div class="card border-top-dark my-3">
									<div class="card-block"> <!-- card-block -->
										<div class="card-title-block">
			               	 				<h3 class="title">
			                	 				요청 처리 계획 <i class="far fa-calendar-check"></i>
			               	 				</h3>
			               	 			</div>
										<div class="card-body">
											<div class="row mt-3">
												<div class="col-3 label">요청 유형</div>
												<div class="col-2">
													<c:if test="${requestProcess.reqType eq '정규'}">
														<div>정규<i class="far fa-registered text-secondary"></i></div>
													</c:if>
													<c:if test="${requestProcess.reqType eq '긴급'}">
														<div>긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
													</c:if>
												</div>
												<div class="col-3 label">중요도</div>
												<div class="col-2">
													<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
														<span class="fa fa-star checked" style="color: orange;"></span>
													</c:if>
													<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
														<span class="fa fa-star checked" style="color: orange;"></span>
													</c:if>
													<c:if test="${requestProcess.priority eq '상'}">
														<span class="fa fa-star checked" style="color: orange;"></span>
													</c:if>
												</div>
											</div>
											<hr/>
			
											<div class="row">
												<div class="col-3 label">요청 완료 예정일</div>
												<div class="col-7">
													<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
											<hr/>
											<div class="row">
												<div class="col-3 label">개발 담당자</div>
												<div class="col-2">${requestProcess.developer}</div>
												<div class="col-3 label">테스트 담당자</div>
												<div class="col-2">${requestProcess.tester}</div>
											</div>	
											<hr/>
											<div class="row">
												<c:if test="${requestProcess.reqType eq '정규'}">
													<div class="col-3 label">품질검토 담당자</div>
													<div class="col-2">${requestProcess.userTester}</div>
												</c:if>
												<div class="col-3 label">배포 담당자</div>
												<div class="col-2">${requestProcess.distributor}</div>
											</div>	
											<hr/>
											<c:forEach var="statusHistory" items="${pmToAllHistories}">
											<div class="row">
												<div class="col-3 label">검토 의견</div>
												<div class="col-7 border" style="min-height:100px;">${statusHistory.reply}</div>
											</div>
											<hr/>
											<div class="row">
												<div class="col-3 label">검토 첨부파일</div>
												<div class="col-7">
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
									</div> <!-- card-block -->						
								</div>
							</c:if>
							<c:if test="${member.mtype == 'pm' && request.statusNo > 2}">
								<div class="card border-top-dark my-3">
									<div class="card-block"> <!-- card-block -->
										<div class="card-title-block">
			               	 				<h3 class="title">
			                	 				요청 처리 계획 <i class="far fa-calendar-check"></i>
			               	 				</h3>
			               	 			</div>
										<div class="card-body">
											<div class="row mt-3">
												<div class="col-3 label">요청 유형</div>
												<div class="col-2">
													<c:if test="${requestProcess.reqType eq '정규'}">
														<div>정규<i class="far fa-registered text-secondary"></i></div>
													</c:if>
													<c:if test="${requestProcess.reqType eq '긴급'}">
														<div>긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
													</c:if>
												</div>
												<div class="col-3 label">중요도</div>
												<div class="col-2">
													<c:if test="${requestProcess.priority eq '하' || requestProcess.priority eq '중' ||requestProcess.priority eq '상'}">
														<span class="fa fa-star checked" style="color: orange;"></span>
													</c:if>
													<c:if test="${requestProcess.priority eq '중' || requestProcess.priority eq '상'}">
														<span class="fa fa-star checked" style="color: orange;"></span>
													</c:if>
													<c:if test="${requestProcess.priority eq '상'}">
														<span class="fa fa-star checked" style="color: orange;"></span>
													</c:if>
												</div>
											</div>
											<hr/>
			
											<div class="row">
												<div class="col-3 label">요청 완료 예정일</div>
												<div class="col-7">
													<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
											<hr/>
											<div class="row">
												<div class="col-3 label">개발 담당자</div>
												<div class="col-2">${requestProcess.developer}</div>
												<div class="col-3 label">테스트 담당자</div>
												<div class="col-2">${requestProcess.tester}</div>
											</div>	
											<hr/>
											<div class="row">
												<c:if test="${requestProcess.reqType eq '정규'}">
													<div class="col-3 label">품질검토 담당자</div>
													<div class="col-2">${requestProcess.userTester}</div>
												</c:if>
												<div class="col-3 label">배포 담당자</div>
												<div class="col-2">${requestProcess.distributor}</div>
											</div>	
											<hr/>
											<c:forEach var="statusHistory" items="${pmToAllHistories}">
											<div class="row">
												<div class="col-3 label">검토 의견</div>
												<div class="col-7 border" style="min-height:100px;">${statusHistory.reply}</div>
											</div>
											<hr/>
											<div class="row">
												<div class="col-3 label">검토 첨부파일</div>
												<div class="col-7">
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
									</div> <!-- card-block -->						
								</div>
							</c:if>
							<c:if test="${member.mtype == 'pm' && request.statusNo == 2}">
								<div id="receiptdiv2"> 						            
									<!-- 요청 접수 card start-->
									<div class="card border-top-primary mt-3 mb-3">
										<div class="card-block">
											<div class="card-title-block">
			                	 				<h3 class="title">
				                	 				요청 처리 계획<i class="ml-1  fas fa-pen-alt"></i>
			                	 				</h3>
			                	 			</div>
											<div class="card-body">
												<form method="post" action="<c:url value='/updatehistory'/>" enctype="multipart/form-data">
													<div class="row form-group">
														<div class="col-3 label">
															<label>*요청 유형</label>
														</div>
														<div class="col-2">
															<select class="dropdown-toggle" style="width: 175px;" data-toggle="dropdown" name="reqType" id="reqType" onchange="rtype()" required>															
																<option value="" class="text-center">요청 유형</option>
																<option value="정규" class="text-center" <c:if test="${requestProcess.reqType == '정규'}">selected</c:if>>정규</option>
															    <option value="긴급" class="text-center" <c:if test="${requestProcess.reqType == '긴급'}">selected</c:if>>긴급</option>																																																						
															</select>																								
														</div>
														<div class="col-3 label">
															<label >*중요도</label>
														</div>
														<div class="col-2">
															<select class="dropdown-toggle" style="width: 175px;" data-toggle="dropdown" name="priority" required>															
																<option value="" class="text-center">중요도</option>
																<option value="상" class="text-center" <c:if test="${requestProcess.priority == '상'}">selected</c:if>>상 (★★★)</option>
																<option value="중" class="text-center" <c:if test="${requestProcess.priority == '중'}">selected</c:if>>중 (★★)</option>
																<option value="하" class="text-center" <c:if test="${requestProcess.priority == '하'}">selected</c:if>>하 (★)</option>															    																																																						
															</select>												
														</div>												
													</div>
													<div class="row">
														<div class="col-3 label">*완료예정일</div>
														<div class="col-7">
															<input type="date" class="form-control boxed" name="allExpectDate" id="allExpectDate" required pattern="\d{4}-\d{2}-\d{2}" style="width: 220px; padding: 0;" value="<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>">
															<span class="validity m-2"></span>
														</div>	
													</div>
														
													<div class="row mb-2">
														<label class="label col-3">*개발 담당자 선택</label>
														<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="developer" required>
															<option value="">개발 담당자 선택 | 현재담당건수 </option>		
															<c:forEach var="staff" items="${devStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.developer}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>															
														</select>
													</div>
													<div class="row mb-2">
														<label class="label col-3">*테스트 담당자 선택</label>
														<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester" requried>
															<option value="">테스트 담당자 선택 | 현재담당건수 </option>	
															<c:forEach var="staff" items="${tesStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.tester}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													<div class="row mb-2" id="utester">
														<label class="label col-3">*품질 검토 담당자 선택</label>
														<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="userTester" id="userTester">
															<option value="">품질 검토 담당자 선택 | 현재담당건수 </option>	
															<c:forEach var="staff" items="${uteStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.userTester}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													<div class="row mb-2">
														<label class="label col-3">*배포 담당자 선택</label>
														<select class="dropdown-toggle col-7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="distributor" required>
															<option value="">배포 담당자 선택 | 현재담당건수 </option>	
															<c:forEach var="staff" items="${disStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.distributor}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
												
													<c:forEach var="statusHistory" items="${pmToAllHistories}">
														<input type="hidden" name="hno" value="${statusHistory.hno}"/>
															<div class="row">
															<div class="col-3 label">검토 의견</div>
															<textarea class="col-7" name="reply">${statusHistory.reply}</textarea>
														</div>
														<hr/>
														<div class="row">
															<div class="col-3 label">검토 첨부파일</div>
															<div class="col-7">
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
												<div class="d-flex justify-content-end">						
													<button class="btn btn-primary btn-lg mt-3 ml-3" type="submit">수정</button>										
												</div>
												<input type="hidden" name="rno" value="${request.rno}">
											</form>											
										</div><!-- card-body -->
									</div><!-- card-block -->										
								</div>
								<!-- 요청 접수 card end-->								
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
										<textarea rows="2" class="form-control boxed" name="reply" readonly>${rejectHistory.reply}</textarea>
									</div>											
									<div class="mt-3 row">
										<c:if test="${request.files != null}">
											<div class="col-3 label">첨부 파일
												<c:forEach var="file" items="${rejectHistory.fileList}">
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
						<c:if test="${sessionScope.member.mtype != 'user'}">
							<button class="btn btn-dark btn-sm ml-5 mb-3" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
						</c:if>
						<c:if test="${sessionScope.member.mtype == 'user'}">
							<button class="btn btn-dark btn-sm ml-5 mb-3" onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'">목록</button>
						</c:if>
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
