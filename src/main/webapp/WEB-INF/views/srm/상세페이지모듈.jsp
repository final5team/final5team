<!-- 요청정보 DIV START -->
<div class="card card-block sameheight-item">
	<h3 class="title-block font-weight-bold">						
		 요청 정보
	</h3>
	<div class="row mt-3">
		<div class="col-3 font-weight-bold">요청자 :</div>
		<div class="col-3">${request.clientName}</div>
		<div class="col-3 font-weight-bold">소속 기관 :</div>
		<div class="col-3">${request.organ}</div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-3 font-weight-bold">요청일 :</div>
		<div class="col-3"><fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/></div>
		<div class="col-3 font-weight-bold">완료 희망일 :</div>
		<div class="col-3"><fmt:formatDate value="${request.reqExpectDate}" pattern="yyyy-MM-dd"/></div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-3 font-weight-bold">시스템 :</div>
		<div class="col-9">${request.systemName}</div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-3 font-weight-bold">요청 유형 :</div>
		<div class="col-3">
			<c:if test="${requestProcess.reqType eq '정규'}">
				<div>정규<i class="far fa-registered text-secondary"></i></div>
			</c:if>
			<c:if test="${requestProcess.reqType eq '긴급'}">
				<div>긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
			</c:if>
		</div>
		<div class="col-3 font-weight-bold">중요도 :</div>
		<div class="col-3">
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
		<div class="col-3 font-weight-bold">제목 :</div>
		<div class="col-9">${request.reqTitle}</div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-3 font-weight-bold">내용 :</div>
		<div class="col-9 border" style="min-height:100px;">${request.reqContent}</div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-3 font-weight-bold">첨부파일 :</div>
		<div class="col-9">
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
	<!-- 단계 처리 버튼 start -->
	<div class="d-flex justify-content-end">
		<c:if test="${member.mtype =='developer' && (request.statusNo == 2 || request.statusNo == 3)}">
		<button class="btn btn-primary btn-lg mt-3 ml-3" onclick="getDatemodal()" type="button">개발시작</button>
		</c:if>
		<c:if test="${member.mtype =='developer' && request.statusNo == 4}">
		<button class="btn btn-info btn-lg mt-3" onclick="devEnd()">개발 완료</button>
		</c:if>
	</div>
	<!-- 단계 처리 버튼 end -->
</div>
<!-- 요청정보 DIV END -->



<!-- PM 검토 정보 start -->	
<div class="card card-block sameheight-item">
	<h3 class="title-block font-weight-bold">						
		 PM 검토 정보
	</h3>
	<c:forEach var="statusHistory" items="${pmToAllHistories}">
		<div class="row">
			<div class="col-3 font-weight-bold">PM :</div>
			<div class="col-3">${requestProcess.pm}</div>
			<div class="col-3 font-weight-bold">접수 일자 :</div>
			<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-3 font-weight-bold">검토 의견 :</div>
			<div class="col-9 border" style="min-height:100px;">${statusHistory.reply}</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-3 font-weight-bold">첨부파일 :</div>
			<div class="col-9">
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
<!-- PM 검토 정보 end -->	




<!-- 개발자의 개발 요청 글 작성 start-->
<c:if test="${member.mtype =='developer' && request.statusNo == 4}">
	<div class="card mt-3 mb-3">
		<div class="card-header">작성하기</div>
		<div class="card-body row">
			<div class="col-3 d-flex align-items-center" style="text-align:center;">
				<div>
					<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hoon.png" width="70%">
					<div class="mt-3">${member.mname}</div>
				</div>
			</div>
			<div class="col-9">
				<form role="form" id="writeform" action="${pageContext.request.contextPath}/devdone" method="POST" enctype="multipart/form-data">
					<input type="hidden" name="rno" value="${request.rno}">
					<div class="col-12 form-group">
						<label class="control-label" >완료예정일</label>
						<input type="text" class="form-control boxed" value="<fmt:formatDate value="${requestProcess.devExpectDate}" pattern="yyyy-MM-dd"/>" readonly>
					</div>
					<div class="col-12 form-group">
						<label class="control-label">개발내용</label>
						<textarea rows="2" class="form-control boxed" name="reply"></textarea>
					</div>
					<div class="col-12 form-group">
						<label class="control-label">배포소스</label>
						<input type="text" class="form-control boxed" name="distSource">
					</div>
					<div class="filebox">
						<label for="files">Choose a file</label>
						<input type="file" id="files" name="files" multiple>
					</div>
				</form>
			</div>
		</div>
	</div>
</c:if>
<!-- 개발자의 개발 요청 글 작성 end-->



<!-- 개발 내역 start -->
<div class="card card-block mt-3">
	<h3 class="font-weight-bold m-0">						
		 개발 히스토리
	</h3>
	<ul class="p-0">
		<hr/>
		<li>
			<div class="row">
				<div class="col-2 font-weight-bold" style="color:#333333">차수</div>
			 	<div class="col-3 font-weight-bold" style="color:#333333">작성자</div>
			 	<div class="col-3 font-weight-bold" style="color:#333333">작성일</div>
			 	<div class="col-4 font-weight-bold" style="color:#333333">
			 		개발 내용
			 	</div>
			</div>
		</li>
		<hr/>
		<c:forEach var="statusHistory" varStatus="index" items="${devToTester}">
			<li>
				<div class="row">
					<div class="col-2">${index.count}차</div>
				 	<div class="col-3">${statusHistory.writer}</div>
				 	<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
				 	<div class="col-4">
				 		<button class="showContentButton btn btn-sm btn-primary">보기</button>
				 	</div>
				</div>
			</li>
			<li style="display:none;">
			<hr/>
				<div class="row">
					<div class="col-4">개발 내용 :</div>
					<div class="col-8 border" style="min-height:100px;">${statusHistory.reply}</div>
				</div>
				<div class="row mt-3">
					<div class="col-4">배포 소스 :</div>
					<div class="col-8 border" style="min-height:100px;">${statusHistory.distSource}</div>
				</div>
				<div class="row mt-3">
					<div class="col-4">첨부파일 : </div>
					<div class="col-8">
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
			</li>
			<hr/>
		</c:forEach>
	</ul>
</div>	
<!-- 개발 내역 end -->


<!-- 재검토 내역 start -->
<div class="card card-block mt-3">
	<h3 class="font-weight-bold m-0">						
		 재검토 요청 히스토리
	</h3>
	<ul class="p-0">
		<hr/>
		<li>
			<div class="row">
				<div class="col-2 font-weight-bold" style="color:#333333">차수</div>
			 	<div class="col-3 font-weight-bold" style="color:#333333">작성자</div>
			 	<div class="col-3 font-weight-bold" style="color:#333333">작성일</div>
			 	<div class="col-4 font-weight-bold" style="color:#333333">
			 		재검토 내용
			 	</div>
			</div>
		</li>
		<hr/>
		<c:forEach var="statusHistory" varStatus="index" items="${testerToDev}">
			<li>
				<div class="row">
					<div class="col-2">${index.count}차</div>
				 	<div class="col-3">${statusHistory.writer}</div>
				 	<div class="col-3"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
				 	<div class="col-4">
				 		<button class="showContentButton btn btn-sm btn-primary">보기</button>
				 	</div>
				</div>
			</li>
			<li style="display:none;">
			<hr/>
				<div class="row">
					<div class="col-4">재검토 내용 :</div>
					<div class="col-8 border" style="min-height:100px;">${statusHistory.reply}</div>
				</div>
				<div class="row mt-3">
					<div class="col-4">첨부파일 : </div>
					<div class="col-8">
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
			</li>
			<hr/>
		</c:forEach>
	</ul>
</div>
<!-- 재검토 내역 end -->