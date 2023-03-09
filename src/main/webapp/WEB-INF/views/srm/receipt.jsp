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
   	.navBtn{
   		border: 1px solid #85ce36;
   		background-color: white;
   		border-radius: 0px;
   		padding: 10px 15px;
   	}
   	.navBtn.active {
   		background-color: #85ce36;
   		color: white;
   	}
    </style>
    
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    
   
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
                	 	
						<!-- 접수 -->
						<c:if test="${member.mtype == 'pm' && request.statusNo == 1}">
							<div id="receiptdiv"> 						            
								<!-- 요청 접수 card start-->
								<div class="card border-top-dark mt-3 mb-3">
									<div class="card-block">
										<div class="d-flex">
											<div class="card-title-block">
			                	 				<h3 class="title">
			                	 					요청 처리 계획 작성<i class="ml-1  fas fa-pen-alt"></i>
		                	 					</h3>
			                	 			</div>
			                	 			<div class="d-flex justify-content-end" style="margin-left: auto; margin-right: 30px;">
												<button class="navBtn active mt-3" type="button" id="receiptbtn">접수</button>
												<button class="navBtn mt-3" type="button" id="rejectbtn">반려</button>
											</div>
										</div>									
										<div class="card-body">
											<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data" onsubmit="return validate()">
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
													<div class="col-7 row mb-2" style="margin-left: 0.5px">
														<input type="date" class="form-control boxed" name="allExpectDate" id="allExpectDate" pattern="\d{4}-\d{2}-\d{2}" style="width: 250px; padding: 0;" required>
														<span class="validity m-2"></span>
													</div>	
												</div>
													
												<div class="row mb-2">
													<label class="label col-3">*개발 담당자 선택</label>
													<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="developer" required>
														<option value="">개발 담당자 선택 | 현재담당건수 </option>		
														<c:forEach var="staff" items="${devStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>															
													</select>
												</div>
												<div class="row mb-2">
													<label class="label col-3">*테스트 담당자 선택</label>
													<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester" requried>
														<option value="">테스트 담당자 선택 | 현재담당건수 </option>	
														<c:forEach var="staff" items="${tesStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>
													</select>
												</div>
												<div class="row mb-2" id="utester">
													<label class="label col-3">*품질 검토 담당자 선택</label>
													<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="userTester" id="userTester">
														<option value="">품질 검토 담당자 선택 | 현재담당건수 </option>	
														<c:forEach var="staff" items="${uteStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>
													</select>
												</div>
												<div class="row mb-2">
													<label class="label col-3">*배포 담당자 선택</label>
													<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="distributor" required>
														<option value="">배포 담당자 선택 | 현재담당건수 </option>	
														<c:forEach var="staff" items="${disStaffList}">
															<option value="${staff.mid}">${staff.mname} | 현재담당건수(${staff.quota})</option>																												
														</c:forEach>
													</select>
												</div>
											
												<div class="row mb-2">
													<div class="label col-3">의견 내용</div>
													<textarea class="form-control boxed col-7 pmcontent ml-2" id="reply" name="reply" style="padding: 0px" maxlength="300"></textarea>													
												</div>	
												<div class="filebox d-flex mb-3">
													<div class="label label-write" id="fileLable">
														<div>첨부파일</div>
														<div class="btn btn-sm btn-info" id="btn-upload">파일 추가</div>
														<input type="file" name="files" id="fileInput" multiple style="display: none;">
													</div>
													
													<div class="border flex-grow-1" id="file-list">
				  									
				  									</div>	
												</div>																																											
												<div class="d-flex justify-content-end">	
													<input type="hidden" name="rno" value="${request.rno}">					
													<button class="btn btn-primary btn-md mt-3 ml-3" type="submit" value=2 name="nextStatus">접수 완료</button>
													<a class="btn btn-secondary btn-md mt-3 ml-3" 
													<c:if test="${sessionScope.member.mtype != 'user'}">onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'"</c:if>
													<c:if test="${sessionScope.member.mtype == 'user'}">onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'"</c:if>>취소</a>												
												</div>
											</form>											
										</div><!-- card-body -->
									</div><!-- card-block -->										
								</div>
								<!-- 요청 접수 card end-->								
							</div>
							
							<!-- 글자수 경고 모달창 start -->
							 <div class="modal fade" id="cautionModal" role="dialog" aria-labelledby="cautionModal" aria-hidden="true" >
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">											
											<h5 class="modal-title">경고</h5>
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>
										<div class="modal-body text-center">	
											<p>글자수가 초과되었습니다. 300자 이하로 작성해주세요.</p>																				
										</div>
										<div class="modal-footer">																				
											<button class="btn btn-secondary" type="button" data-dismiss="modal">확인</button>					                    
										</div>
									</div>
								</div>
							</div>
							<!-- 글자수 경고 모달창 end -->	
						
							<!-- 반려 -->
							<div id="rejectdiv"> 						            
								<form method="post" action="<c:url value='/pm/receipt'/>" enctype="multipart/form-data" onsubmit="return validate()">
									<!-- 요청 접수 card start-->
									<div class="card border-top-dark mt-3 mb-1">
										<div class="card-block">
											<div class="d-flex">
												<div class="card-title-block">
				                	 				<h3 class="title">
				                	 					반려 사유 작성<i class="ml-1 fas fa-external-link-alt"></i>
			                	 					</h3>
				                	 			</div>
				                	 			<div class="d-flex justify-content-end" style="margin-left: auto; margin-right: 30px;">
													<button class="navBtn mt-3" type="button" onclick="receiptbtn()">접수</button>
													<button class="navBtn active mt-3" type="button">반려</button>
												</div>
											</div>		
											<div class="card-body">
												<div class="form-group d-flex">
													<label class="label">반려 사유</label>
													<textarea class="form-control boxed pmcontent" name="reply" style="width: 65%; margin: auto;" maxlength="300"></textarea>
												</div>											
												<div class="filebox d-flex mb-3">
													<div class="label label-write" id="fileLable">
														<div>첨부파일</div>
														<div class="btn btn-sm btn-info" id="btn-upload2">파일 추가</div>
														<input type="file" name="files" id="fileInput2" multiple style="display: none;">
													</div>
													
													<div class="border flex-grow-1" id="file-list2">
				  									
				  									</div>	
												</div>												
												<div class="d-flex justify-content-end">	
													<input type="hidden" name="rno" value="${request.rno}">								
													<button class="btn btn-danger btn-md mt-3 ml-3" type="submit" value=12 name="nextStatus">반려 완료</button>												
													<a class="btn btn-secondary btn-md mt-3 ml-3" 
													<c:if test="${sessionScope.member.mtype != 'user'}">onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'"</c:if>
													<c:if test="${sessionScope.member.mtype == 'user'}">onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'"</c:if>>취소</a>									
												</div>
											</div>
										</div>
									</div>
									<!-- 요청 접수 card end-->									
								</form>
							</div>
							
						</c:if>
						<!-- 요청 처리 계획 start-->
						<c:if test="${member.mtype !='user' && member.mtype != 'pm' && request.statusNo != 12}">
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
							<c:if test="${member.mtype == 'pm' && request.statusNo > 2 && request.statusNo != 12}">
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
												<form method="post" action="<c:url value='/updatehistory'/>" enctype="multipart/form-data" id="updateForm">
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
														<div class="col-7 row">
															<input type="date" class="form-control boxed ml-2 mb-2" name="allExpectDate" id="allExpectDate" required pattern="\d{4}-\d{2}-\d{2}" style="width: 250px; padding: 0;" value="<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>">
															<span class="validity m-2"></span>
														</div>	
													</div>
														
													<div class="row mb-2">
														<label class="label col-3">*개발 담당자 선택</label>
														<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="developer" required>
															<option value="">개발 담당자 선택 | 현재담당건수 </option>		
															<c:forEach var="staff" items="${devStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.developer}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>															
														</select>
													</div>
													<div class="row mb-2">
														<label class="label col-3">*테스트 담당자 선택</label>
														<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="tester" requried>
															<option value="">테스트 담당자 선택 | 현재담당건수 </option>	
															<c:forEach var="staff" items="${tesStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.tester}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													
													<div class="row mb-2" id="utester">
														<label class="label col-3">*품질 검토 담당자 선택</label>
														<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="userTester" id="userTester">
															<option value="">품질 검토 담당자 선택 | 현재담당건수 </option>	
															<c:forEach var="staff" items="${uteStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.userTester}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
													
													<div class="row mb-2">
														<label class="label col-3">*배포 담당자 선택</label>
														<select class="dropdown-toggle col-7 ml-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" name="distributor" required>
															<option value="">배포 담당자 선택 | 현재담당건수 </option>	
															<c:forEach var="staff" items="${disStaffList}">
																<option value="${staff.mid}" <c:if test="${staff.mid == requestProcess.distributor}">selected</c:if>>${staff.mname} | 현재담당건수(${staff.quota})</option>																												
															</c:forEach>
														</select>
													</div>
												
													<c:forEach var="statusHistory" items="${pmToAllHistories}">
														<input type="hidden" name="hno" value="${statusHistory.hno}"/>
															<div class="row">
															<div class="col-3 label ml-2">검토 의견</div>
															<textarea class="col-7" name="reply" maxlength="300">${statusHistory.reply}</textarea>
														</div>
														<hr/>
														<div class="row mt-3">
		                	 							    <div class="col-2 label">기존 첨부파일</div>
				                	 						<div class="col-8">
			                	 								<c:forEach var="statusHistoryFile" items="${statusHistory.fileList}">
																	<div>
																		<span>${statusHistoryFile.fileName}</span>
																		<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
																			<i class="fas fa-cloud-download-alt text-info"></i>
																		</a>
																		<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a>
																		<input type="hidden" name = "fno" value="${statusHistoryFile.fno}">
																	</div>
																</c:forEach>
				                	 						</div>
			                	 						</div>
			                	 						<div class="filebox row mb-3">
															<div class="col-2 label label-write" id="fileLable">
																<div class="btn btn-sm btn-info" id="btn-upload-update">파일 수정</div>
																<input type="file" name="files" id="fileInputUpdate" multiple style="display: none;">
															</div>
															<div class="border flex-grow-1 border-success col-8" id="file-list-update"></div>	
														</div>	
													</c:forEach>
												<div class="d-flex justify-content-end">						
													<button class="btn btn-primary btn-md mt-3 ml-3" type="button" onclick="update()">수정</button>										
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
							<div class="card border-top-danger mt-3 mb-1">
								<h3 class="title m-3">						
									반려 처리 내역 <i class="ml-1 fas fa-external-link-alt"></i>
								</h3>
								<div class="card-body">									
									<div class="form-group row">
										<label class="label col-3">반려 사유</label>
										<textarea rows="2" class="form-control boxed col-7" name="reply" readonly>${rejectHistory.reply}</textarea>
									</div>											
									<div class="mt-3 row">
										<c:if test="${request.files != null}">
											<div class="col-3 label">첨부 파일</div>
											<div class="col">
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
							<button class="btn btn-dark btn-sm ml-5 m-3" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">목록</button>
						</c:if>
						<c:if test="${sessionScope.member.mtype == 'user'}">
							<button class="btn btn-dark btn-sm ml-5 m-3" onclick="location.href='${pageContext.request.contextPath}/customer/userrequestlist'">목록</button>
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
    <div class="modal fade" id="completeModal" aria-hidden="true" aria-labelledby="successOfDueDate">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>Check</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="display: flex; justify-content: center;">
					<p id="completeContent"></p>
				</div>
				<div class="modal-footer" style="justify-content: center;">
                    <a class="btn btn-primary" data-dismiss="modal" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
 <script>	      
		$(document).ready(function(){
			// 반려 입력 항목 숨기기
		   $("#rejectdiv").hide();	
			// 접수 완료 후 요청 처리 계획 확인 시 품질 검토 담당자 표시 여부 
		   rtype();

			// 반려 입력 항목 열고 접수 입력 항목 숨기기
		   $("#rejectbtn").click(function(){
			  $("#receiptdiv").hide();
			  $("#rejectdiv").show();
		   });
			
			// 현재 날짜 구하기
			var now = new Date();
			// 완료 예정일에 현재 날짜 이후 날짜만 선택 가능하게 만들기(최소값)
		   document.getElementById("allExpectDate").min
		   = now.toISOString().slice(0, 10);		
			
			// 완료 예정일에 현재 날짜 1년 이내 날짜만 선택 가능하게 만들기(최대값)
		   document.getElementById("allExpectDate").max
		   = new Date(now.setFullYear(now.getFullYear() + 1)).toISOString().slice(0, 10);
			
		});
		
		// 접수 입력 항목 열고 반려 입력 항목 숨기기
		function receiptbtn(){
			 $("#rejectdiv").hide();
		     $("#receiptdiv").show();
		}		
						
		// 요청 유형에 따른 품질 검토 담당자 선택 여부
		function rtype(){
			var reqType = $("#reqType").val();
			// 요청 유형이 긴급일 때 품질 검토 담당자 선택하지 않기
			if(reqType == '긴급'){
				// 품질 검토 담당자 선택 불가
				$("#utester").hide();
				// 품질 검토 담당자 값 null
				$("#userTester").val("");
				// 품질 검토 담당자 미입력 가능
				$("#userTester").removeAttr("required");
			}
			// 요청 유형이 정규일 때 품질 검토 담당자 선택하기
			if(reqType == '정규'){
				// 품질 검토 담당자 선택 가능
				$("#utester").show();
				// 품질 검토 담당자 필수 입력
				$("#userTester").attr("required", "required")
			}			
		}		
	 	
	 	// 의견 내용 유효성 검사
	    function validate() {
	 		// 유효한 입력 내용
			var result = true;			
			// 의견 내용 길이 구하기
			var content=tinymce.activeEditor.getContent().length;
			// 의견 내용 길이가 300자 이상일 경우 제출 불가
			if(content > 300){
				// 300자 이하 입력 경고 창 
				$("#cautionModal").modal();			
				// 제출 불가
				result = false;
			}
			// 유효성 검사 결과 반환
			return result;
		}
	 	
	    /****** 업로드된 파일 리스트 출력하기 *****/
		$(document).ready(function(){
			// input file 파일 첨부시 fileCheck 함수 실행		
			$("#fileInput").on("change", fileCheck);
			$("#fileInput2").on("change", fileCheck2);
			$("#fileInputUpdate").on("change", fileUpdate);
		});
		
		/* '파일추가' 버튼 누를 때마다 파일input 실행 */
		$(function () {
			// 접수 시 첨부 파일 추가
		    $('#btn-upload').click(function (e) {
		        e.preventDefault();
		        $('#fileInput').click();
		    });
			// 반려 시 첨부 파일 추가
		    $('#btn-upload2').click(function (e) {
		        e.preventDefault();
		        $('#fileInput2').click();
		    });
		})
		
		// 파일 현재 필드 숫자 totalCount랑 비교값
		// 접수 파일 개수
		var fileCount = 0;
		// 반려 파일 개수
		var fileCount2 = 0;
		// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
		var totalCount = 5;
		// 파일 고유넘버
		var fileNum = 0;
		// 첨부파일 배열
		var content_files = new Array();

		function fileCheck(e) {
		    var files = e.target.files;
		    
		    // 파일 배열 담기
		    var filesArr = Array.prototype.slice.call(files);
		    
		    // 파일 개수 확인 및 제한
		    if (fileCount + filesArr.length > totalCount) {
		      alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
		      return;
		    } else {
		    	 fileCount = fileCount + filesArr.length;
		    }
		    
		    // 각각의 파일 배열담기 및 기타
		    filesArr.forEach(function (f) {
		      var reader = new FileReader();
		      
		      reader.onload = function (e) {
			        content_files.push(f);
			        $('#file-list').append(
			       		'<div id="file' + fileNum + '">'
			       		+ '<font style="font-size:15px">' + f.name + '</font>'  
			       		+ '<a onclick ="fileDelete(\'file' + fileNum + '\')">'+'<i class="fas fa-times ml-1 text-success"></i></a>' 
			       		+ '<div/>'
					);
			        fileNum ++;
		      };
		      
		      reader.readAsDataURL(f);
		    });
		  }
		
		function fileCheck2(e) {
		    var files = e.target.files;
		    
		    // 파일 배열 담기
		    var filesArr = Array.prototype.slice.call(files);
		    
		    // 파일 개수 확인 및 제한
		    if (fileCount2 + filesArr.length > totalCount) {
		      alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
		      return;
		    } else {
		    	 fileCount2 = fileCount2 + filesArr.length;
		    }
		    
		    // 각각의 파일 배열담기 및 기타
		    filesArr.forEach(function (f) {
		      var reader = new FileReader();
		      
		      reader.onload = function (e) {
			        content_files.push(f);
			        $('#file-list2').append(
			       		'<div id="file' + fileNum + '">'
			       		+ '<font style="font-size:15px">' + f.name + '</font>'  
			       		+ '<a onclick ="fileDelete(\'file' + fileNum + '\')">'+'<i class="fas fa-times ml-1 text-success"></i></a>' 
			       		+ '<div/>'
					);
			        fileNum ++;
		      };
		      
		      reader.readAsDataURL(f);
		    });
		  }

		// 파일 부분 삭제 함수
		function fileDelete(fileId){
		    var fileNum = fileId.replace("file", "");
		    content_files[fileNum].is_delete = true;
		    
			$('#' + fileId).remove();
			fileCount --;
		}
		
		/********* 파일 수정 *********/
		
		/* '파일수정' 버튼 누를 때마다 파일input 실행 */
		$(function () {
		    $('#btn-upload-update').click(function (e) {
		        e.preventDefault();
		        $('#fileInputUpdate').click();
		    });
		})
		function fileUpdate (e){
			console.log("fileUpdate");
			//파일 객체 갖고오기
			var files = e.target.files;
			
			// 파일 배열 담기
		    var filesArr = Array.prototype.slice.call(files);
			
			//기존에 있던 파일 객체
		    var existfiles = $('.existfiles');
		    
	    	console.log("fileCount: "+ fileCount);	
	    	console.log("filesArr.length: "+filesArr.length);
	    	console.log("existfiles.length: "+existfiles.length);
		    if(fileCount + filesArr.length > totalCount - existfiles.length ){
		    	$('#completeModal').modal();
		    	$('#completeContent').html('파일은 최대 '+totalCount+ '개까지 업로드 할 수 있습니다.')
		      return;
		    }else {
		    	 fileCount = fileCount + filesArr.length;
		    }
		 	// 각각의 파일 배열담기 및 기타
		    filesArr.forEach(function (f) {
		      var reader = new FileReader();
		      
		      reader.onload = function (e) {
			        content_files.push(f);
			        $('#file-list-update').append(
			       		'<div id="file' + fileNum + '">'
			       		+ '<font style="font-size:15px">' + f.name + '</font>'  
			       		+ '<a onclick ="fileDelete(\'file' + fileNum + '\')">'+'<i class="fas fa-times ml-1 text-success"></i></a>' 
			       		+ '<div/>'
					);
			        fileNum ++;
		      };
		      
		      reader.readAsDataURL(f);
		    });
		 	
		}
		/***************** 올린 파일 삭제 *****************/
		$('.deletefileButton').click(function(){
			console.log("delete실행");
			var deleteDiv = $(this).parent();
			var fno = $(this).next().val();
			let distinguish = 1;
			
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/noticefiledelete?fno=" + fno,
				dataType: "json",
				data: {
					distinguish : distinguish
				},
				success: function(result){
					deleteDiv.remove();
				}
			});
			
			
		});
		/****** update() '수정'버튼 클릭 ******/
		function update(){
			//선택된 파일 지우기
			var fileInput = $('#fileInputUpdate')[0];
			var fileBuffer = new DataTransfer();
			fileInput.files = fileBuffer.files;
			
			//배열의 항목으로 채우기
			fileBuffer = new DataTransfer();
			for(var i = 0; i < content_files.length; i ++){
				if(!content_files[i].is_delete){
					fileBuffer.items.add(content_files[i]);
				} 
			}
			fileInput.files = fileBuffer.files;
			
			$('#updateForm').submit();
		}
	</script>

</body>

</html>
