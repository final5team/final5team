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
			  border-radius:10px;
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
			  height: 10px;
			  width: 1px;
			  align-items: center;
			  justify-content: center;
			  border: 3px solid var(--line-empty);
			  transition: 0.4s ease;
		}
		
		.circle.done {
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
									<h6 class="mr-auto text-primary font-weight-bold">유저테스트 상세보기 ></h6>
									<div class="ml-3">정규<i class="far fa-registered text-secondary"></i></div>
									<div class="ml-3">긴급<i class="fas fa-exclamation-triangle text-secondary"></i></div>
									<div class="ml-5 mr-4">중요도: 
										<span class="fa fa-star checked" style="color: orange;"></span>
										<span class="fa fa-star checked" style="color: orange;"></span>
										<span class="fa fa-star checked" style="color: orange;"></span>
									</div>					
								</div>
								<div class="card-body">
									<div>
										<h3 class="mr-auto font-weight-bold">${request.reqTitle}</h3>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hooni.png" width="20%">
											<span class="font-weight-bold ml-2">${userInfo.mname}</span>
											<span class="ml-3">${userInfo.organ}</span>
											<span class="ml-3">${userInfo.position}</span>
										</div>
										<div class="col-sm-6 ml-auto">
											<div class="d-flex">
												<div class="pl-5">시스템:</div>
												<div class="pl-2 flex-grow-1">${request.systemName}</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청일:</div>
												<div class="pl-2 flex-grow-1">
													<fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
											<div class="d-flex">
												<div class="pl-5">요청 완료 예정일:</div>
												<div class="pl-2 flex-grow-1">
													<fmt:formatDate value="${requestProcess.allExpectDate}" pattern="yyyy-MM-dd"/>
												</div>
											</div>
											<c:if test="${request.statusNo == 8}">
												<div class="d-flex">
													<div class="pl-5">유저테스트 완료 예정일 :</div>
													<div class="pl-2 flex-grow-1">
														<fmt:formatDate value="${requestProcess.userTestExpectDate}" pattern="yyyy-MM-dd"/>
													</div>
												</div>
											</c:if>
										</div>
									</div>
									<div class="mt-2">${request.reqTitle}</div>
									<div class="mt-2">${request.reqContent}</div>
									<div class="mt-3">
										<!-- 요청 첨부 파일 리스트 -->
										<span>파일이름</span>
										<a href="#" role="button">
											<i class="fas fa-cloud-download-alt"></i>
										</a>
									</div>
								</div>
							</div>
							
							<div>
								<!-- 유저테스트 요청 상태(7) -->
								<c:if test="${request.statusNo == 7}">
									<div class="d-flex justify-content-end">
										 <button class="btn btn-gradient-danger btn-gradient btn-lg mt-3 ml-3" onclick="getDatemodal()" type="button">배포 시작</button>
									</div>
								</c:if>
								<!-- 유저테스트 중 상태(8) -->
								<c:if test="${request.statusNo == 8}">
									<div class="d-flex justify-content-end">
										<form action="${pageContext.request.contextPath}/endwork" method="post" class="mt-3">
											<input type="hidden" name="rno" value="${request.rno}"/>
											<input type="hidden" name="mtype" value="${userInfo.mtype}"/>
											<input type="hidden" name="nextStatus" value="9"/>
											<button class="btn btn-gradient-success btn-gradient btn-lg mt-3">배포 완료</button>
										</form>
									</div>
								</c:if>
							</div>
							
							<div class="card mt-3">
								<div class="card-header">
									배포 소스 내용
								</div>
								<c:forEach var="statusHistory" varStatus="index" items="${devToTesterHistories}">
									<div class="card-body row border border-success ml-4 mr-4 mt-3 mb-3">
										<div class="col-sm-2 d-flex align-items-center" style="text-align: center;">
											<div>
												<img class="rounded-circle ml-3" src="${pageContext.request.contextPath}/resources/img/hoon.png" width="60%">
												<div class="ml-3">김레지나</div>
											
											</div>
										</div>
										<div class="col-sm-10">
											<div class="d-flex justify-content-end mr-5">
												<div>${index.count}차 개발</div>
												<div class="ml-auto"><fmt:formatDate value="${statusHistory.changeDate}" pattern="yyyy-MM-dd"/></div>
											</div>
											<div>
												배포소스: ${statusHistory.distSource}
											</div>
											<span>첨부파일: 파일이름</span>
											<a href="#" role="button">
												<i class="fas fa-cloud-download-alt"></i>
											</a>
										</div>
									</div>
								</c:forEach>
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
									<!-- request.statusName(현재 상태)에 따라 다른 단계 화면 표시-->
									<c:if test="${request.statusName != '반려'}">
										<c:if test="${requestProcess.reqType == null || requestProcess.reqType == '정규'}">
											<div class="container">
									           <div class="circle done">요청완료</div>
									           <div class="bar active"></div>
									           <div class="circle 
									           	 <c:if test="${request.statusNo >= 2}">done</c:if>
									           	 <c:if test="${request.statusNo == 1}">now</c:if>">
									           	 <c:if test="${request.statusNo == 1}">접수중</c:if>
									           	 <c:if test="${request.statusNo >= 2}">접수완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 2}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 5}">done</c:if>
									           	 <c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">now</c:if>">
									             <c:if test="${request.statusNo < 2}">개발단계</c:if>
		       	    						     <c:if test="${request.statusNo == 2}">개발요청</c:if>
									           	 <c:if test="${request.statusNo == 3}">개발중</c:if>
									           	 <c:if test="${request.statusNo == 4}">개발재검토</c:if>
									           	 <c:if test="${request.statusNo >= 5}">개발완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 5}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 7}">done</c:if>
									           	 <c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">now</c:if>">
									           	 <c:if test="${request.statusNo < 5}">테스트단계</c:if>
									           	 <c:if test="${request.statusNo == 5}">테스트요청</c:if>
									           	 <c:if test="${request.statusNo == 6}">테스트중</c:if>
									           	 <c:if test="${request.statusNo >= 7}">테스트완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 7}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 9}">done</c:if>
									           	 <c:if test="${request.statusNo >= 7 && request.statusNo <= 8}">now</c:if>">
									           	 <c:if test="${request.statusNo < 7}">유저테스트단계</c:if>
									           	 <c:if test="${request.statusNo == 7}">유저테스트요청</c:if>
									           	 <c:if test="${request.statusNo == 8}">유저테스트중</c:if>
									           	 <c:if test="${request.statusNo >= 9}">유저테스트완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 9}">active</c:if>"></div>
									           <div class="circle
									             <c:if test="${request.statusNo >= 11}">done</c:if>
									           	 <c:if test="${request.statusNo >= 9 && request.statusNo <= 10}">now</c:if>">	
									             <c:if test="${request.statusNo < 9}">배포단계</c:if>
									           	 <c:if test="${request.statusNo == 9}">배포요청</c:if>
									           	 <c:if test="${request.statusNo == 10}">배포중</c:if>
									           	 <c:if test="${request.statusNo >= 11}">배포완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 11}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 13}">done</c:if>
									           	 <c:if test="${request.statusNo == 11}">now</c:if>">	
									             <c:if test="${request.statusNo < 11}">최종승인단계</c:if>
									           	 <c:if test="${request.statusNo == 11}">최종승인요청</c:if>
									           	 <c:if test="${request.statusNo == 13}">완료</c:if>
									           </div>
										    </div>
										</c:if>
										<c:if test="${requestProcess.reqType == '긴급'}">
											<div class="container">
									           <div class="circle done">요청완료</div>
									           <div class="bar active"></div>
									           <div class="circle 
									           	 <c:if test="${request.statusNo >= 2}">done</c:if>
									           	 <c:if test="${request.statusNo == 1}">now</c:if>">
									           	 <c:if test="${request.statusNo == 1}">접수중</c:if>
									           	 <c:if test="${request.statusNo >= 2}">접수완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 2}">active</c:if>"></div>
									           <div class="circle
									             <c:if test="${request.statusNo >= 5}">done</c:if>
									             <c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">now</c:if>">
									             <c:if test="${request.statusNo < 2}">개발단계</c:if>
		       	    						     <c:if test="${request.statusNo == 2}">개발요청</c:if>
									           	 <c:if test="${request.statusNo == 3}">개발중</c:if>
									           	 <c:if test="${request.statusNo == 4}">개발재검토</c:if>
									           	 <c:if test="${request.statusNo >= 5}">개발완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 5}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 7}">done</c:if>
									           	 <c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">now</c:if>">
									           	 <c:if test="${request.statusNo < 5}">테스트단계</c:if>
									           	 <c:if test="${request.statusNo == 5}">테스트요청</c:if>
									           	 <c:if test="${request.statusNo == 6}">테스트중</c:if>
									           	 <c:if test="${request.statusNo >= 7}">테스트완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 7}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 11}">done</c:if>
									           	 <c:if test="${request.statusNo >= 7 && request.statusNo <= 10}">now</c:if>">	
									             <c:if test="${request.statusNo < 7}">배포단계</c:if>
									           	 <c:if test="${request.statusNo == 7}">배포요청</c:if>
									           	 <c:if test="${request.statusNo == 10}">배포중</c:if>
									           	 <c:if test="${request.statusNo >= 11}">배포완료</c:if>
									           </div>
									           <div class="bar <c:if test="${request.statusNo >= 11}">active</c:if>"></div>
									           <div class="circle
									           	 <c:if test="${request.statusNo >= 13}">done</c:if>
									           	 <c:if test="${request.statusNo == 11}">now</c:if>">	
									             <c:if test="${request.statusNo < 11}">최종승인단계</c:if>
									           	 <c:if test="${request.statusNo == 11}">최종승인요청</c:if>
									           	 <c:if test="${request.statusNo == 13}">완료</c:if>
									           </div>
										    </div>
										</c:if>
									</c:if>
									<c:if test="${request.statusName == '반려'}">
										<div class="container">
									           <div class="circle done">요청완료</div>
									           <div class="bar active"></div>
									           <div class="circle done">
													접수완료
									           </div>
									           <div class="bar active"></div>   
									           <div class="circle now">	
									           		반려
									           </div>
										    </div>
									</c:if>
									
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
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="developDueDate">배포 완료 예정일 입력</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex justify-content-center">
					<form action="" method="post" name="startWork" class="mt-3">
						<label class="mt-1" style="color: #343a40;" for="expectDate">배포 완료 예정일</label>
						<input type="date" id= "expectDate" name="expectDate" class="form-control ml-2" style="width: 200px; display: inline;"/>
						<input type="hidden" name="rno" value="${request.rno}"/>
						<input type="hidden" name="mtype" value="${userInfo.mtype}"/>
						<input type="hidden" name="nextStatus" value="8"/>
					</form>
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
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<i class="fa-solid fa-message-exclamation"></i>
					<h5>경고</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>입력 시간이 완료 예정일 대비 50% 이상 차지합니다. 확인을 누르시면 수정이 불가능합니다.</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" onclick="startWork()" type="button">확인</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 경고 모달창 -->
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
		function closedatemodal(){
			$('#datemodal').modal('hide');
			$('#alartDateTooMuch').modal('show');
		}
		function getcofirm(){
			$('#alartDateTooMuch').modal('hide');
			$('#completeDueDate').modal('show');
		}
		
		function startWork(){
			var queryString = $("form[name=startWork]").serialize() ;

			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/startwork',
				data : queryString,
				dataType : 'json',
				error: function(xhr, status, error){
					alert(error);
				},
				success : function(json){
					alert(json)
				}
			});
		}
	</script>
</body>

</html>
