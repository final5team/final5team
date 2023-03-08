<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/stepperprogress.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/requestdetail.css" rel="stylesheet">
<style>
</style>
</head>
<style>

</style>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/topbar.jsp"%>
				<!-- End of Topbar -->

				<!-- 여기에 내용 담기 start -->
				<div class="container">
					<div id="main">
						<!-- id=main div start -->
						<div class="title-block">
							<h3 class="title">요청 조회</h3>
						</div>
						<!-- 여기에 단계 상태 이력 넣기 -->
						<div>
							<%@ include file="/WEB-INF/views/srm/request/userstepperprogress.jsp" %>
						</div>
						<!-- 여기에 단계 상태 이력 넣기 /-->
						<c:if test="${request.statusNo == 1 && request.rname == member.mname}">
						<section> <!-- 개발내역 입력폼 start -->
							<div class="card border-top-dark mb-3">
								<div class="card-block js">
									<div class="card-title-block">
										<h3 class="title">
											요청 내역 조회 <i class="fas fa-edit"></i>
										</h3>
									</div>
									<div class="card-body">
										<form method="post" action="${pageContext.request.contextPath}/customer/requestupdate" >
											<article class="label js item">
												<h6>작성자</h6>
												<h6>전화번호</h6>
												<h6>직급</h6>
												<h6>시스템</h6>
											</article>
											<article class="inputData">
												<div class="item">
													<input type="text" class="form-control form-control-user" id="clientName" name="clientName" placeholder="${request.rname}" value="${request.rname}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="${request.rphone}" value="${request.rphone}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="position" name="position" placeholder="${request.rposition}" value="${request.rposition}" readonly>
												</div>
												
												<div class="item">
													<div class="select-group">
														<select class="custom-select" id="sno" name="sno" required>
															<option selected value="${request.sno}">${request.systemName}</option>
															<c:forEach var="system" items="${systemList}">
																<option value="${system.sno}">${system.systemName}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</article>
											<article class="label2">
												<h6>소속기관</h6>
												<h6>이메일</h6>
												<h6>완료 희망 일자</h6>
											</article>
											<article class="inputData2">
												<div class="item">
													<input type="text" class="form-control form-control-user" id="organ" name="organ" placeholder="${request.rorgan}" value="${request.rorgan}" readonly>
												</div>
												<div class="item">
													<input type="text" class="form-control form-control-user" id="email" name="email" placeholder="${request.remail}" value="${request.remail}" readonly>
												</div>
												<div class="item">
													<input type="date" class="form-control form-control-user" id="reqExpectDate" name="reqExpectDate" value="<fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd" />">
												</div>
											</article>
											<article class="titleLabel">
												<h6>제목</h6>
											</article>
											<article class="titleInput">
												<div class="item">
													<input type="text" id="reqTitle" name="reqTitle" placeholder="제목" value="${request.reqTitle}">
												</div>
											</article>
											<article class="titleBody">
												<h6>내용</h6>
											</article>
											<article class="bodyInput">
												<div class="item">
													<textarea id="reqContent" cols="30" name="reqContent" placeholder="내용">${request.reqContent}</textarea>
												</div>
											</article>
											<article class="fileTitle">
												<h6>파일첨부</h6>
											</article>
											<article class="fileBody">
												<div class="file-item">
													<div class="upload_name" id="exist_file" >
														<c:forEach var="file" items="${request.fileList}">
											    			<div>
												    			<a href="${pageContext.request.contextPath}/customer/requestdetail/filedownload/${file.fno}">${file.fileName}</a>
											    			</div>
											    		</c:forEach>
													</div>
													<div class="filebox">
														<input multiple="multiple" type="file" id="mfile" name="mfile[]"/>
														<label for="mfile">파일찾기</label> 
													</div>
												</div>
											</article>

											<article class="submit-button">
											<!-- 승인이 아닌경우 수정 가능하도록 변경 c:if 사용 -->
												<button class="btn btn-dark btn-sm" type="submit">수정</button>
												
											</article>
											<article class="return-button">
												<button class="btn btn-dark btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath}/customer/requestlist'">취소</button>
											</article>
											<input type="hidden" value="${request.rno}" id="rno" name ="rno">
										</form> 
									</div>
								</div>
							</div>
						</section> <!-- 개발내역 입력폼 end -->
						</c:if>
						<c:if test="${request.statusNo != 1}">
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
											<div class="col-2">${request.rname}</div>
											<div class="col-3 label">소속 기관</div>
											<div class="col-2">${request.rorgan}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">직급</div>
											<div class="col-2">${request.rposition}</div>
											<div class="col-3 label">전화번호</div>
											<div class="col-2">${request.rphone}</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-3 label">이메일</div>
											<div class="col-8">${request.remail}</div>
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
												<c:forEach var="statusHistoryFile" items="${request.fileList}">
													<div>
														<span>${statusHistoryFile.fileName}</span>
														<a href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button">
															<i class="fas fa-cloud-download-alt"></i>
														</a>
													</div>
												</c:forEach>
											</div>
										</div>										
	                	 			</div>
								</div> <!-- card-block / -->
							</div>				
						</section><!-- 게시글 상세보기 end -->
						</c:if>
						<c:if test="${request.statusNo == 12 && request.rname == member.mname}">
						<section><!-- 접수결과 반려 start -->
						  <div class="card border-top-danger my-3">
		                       <div class="card-block">
		                          <div class="card-title-block">
	                                   <h3 class="title">
	                                     	 반려 처리 내역 <i class="fas fa-scroll"></i>
	                                   </h3>
	                              </div>
	                              <div class="card-body">
		                              <div class="form-group row">
		                                 <div class="col-3 label">반려 사유</div>
		                                 <textarea rows="2" class="form-control boxed" name="reply" readonly>${rejectHistory.reply}</textarea>
		                              </div> 
		                                                              
	                                 <div class="mt-3 row">
		                                <div class="col-3 label">첨부 파일</div>
	                                    <div class="col-7">
				                            <c:if test="${request.files != null}">
			                                       <c:forEach var="file" items="${rejectHistory.fileList}">
			                                          <div>
			                                             <span>${file.fileName}</span>
			                                             <a href="${pageContext.request.contextPath}/filedouwnload/${file.fno}" role="button">
			                                                <i class="fas fa-cloud-download-alt text-info"></i>
			                                             </a>
			                                          </div>
			                                       </c:forEach>
				                            </c:if>
				                            <c:if test="${request.files == null}">
				                            	<div class="text-gray">첨부된 파일이 없습니다.</div>
				                            </c:if>
	                                    </div>   
	                                 </div>                                                                                          
		                              
	                              </div>
		                        </div>
		                     </div>
						</section><!-- 접수결과 반려 end -->
						</c:if>
						<%-- <c:if test="${request.statusNo != 1 && request.statusNo != 12 && request.rname == member.mname}">
						<section> <!-- 접수결과 승인 start -->
							<div class="card border-top-primary my-3">
								<div class="card-block">
									<div class="card-title-block">
	                                   <h3 class="title">
	                                     	 진행 내역 <i class="fas fa-scroll"></i>
	                                   </h3>
	                            	</div>
	                            	<table class="table table-striped" style="text-align: center;">
	                            		<thead>
	                            			<tr>
	                            				<th>단계</th>
	                            				<th>완료일</th>
	                            			</tr>
	                            		</thead>
	                            		<tbody>
	                            			<tr>
	                            				<td>개발</td>
	                            				<td><fmt:formatDate value="${requestProcess.devCompDate}" pattern="yyyy-MM-dd"/></td>
	                            			</tr>
	                            			<tr>
	                            				<td>테스트</td>
	                            				<td><fmt:formatDate value="${requestProcess.testCompDate}" pattern="yyyy-MM-dd"/></td>
	                            			</tr>
	                            			<tr>
	                            				<td>품질테스트</td>
	                            				<td><fmt:formatDate value="${requestProcess.userTestCompDate}" pattern="yyyy-MM-dd"/></td>
	                            			</tr>
	                            			<tr>
	                            				<td>배포</td>
	                            				<td><fmt:formatDate value="${requestProcess.distCompDate}" pattern="yyyy-MM-dd"/></td>
	                            			</tr>
	                            			<tr>
	                            				<td>최종 승인</td>
	                            				<td><fmt:formatDate value="${requestProcess.allCompDate}" pattern="yyyy-MM-dd"/></td>
	                            			</tr>
	                            		</tbody>
	                            	</table>
								</div>
							</div>
						</section> <!-- 접수결과 승인 start -->
						</c:if> --%>
						
					</div><!-- id=main div / -->
				</div>
				<!-- 여기에 내용 담기 end -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>
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
		/* 파일 버튼 변경*/
		$(document).ready(function() {
			$(".file-delete").on("click", function(e) {
				e.preventDefault();
				deleteFile($(this));
			});
		})
		//파일 업로드 제약 자바스크립트
		let mfile = document.querySelector('#mfile');
		mfile.addEventListener('change', function() {
			// 파일 업로드 개수 제한 (3) 
			if(mfile.files.length >3 ){
				alert("파일 업로드 개수는 최대 3개입니다.");
				mfile.value='';
				return false;
			} else {
				// 파일 이름 출력 
				let fileList ='';
				for(i=0; i< mfile.files.length; i++){
					fileList += mfile.files[i].name + '<br>'
					console.log(fileList);
				}
				let inputtag = document.querySelector('#exist_file');
				inputtag.innerHTML = fileList;
			}
		});
		
	</script>
</body>

</html>