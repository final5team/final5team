<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
	<html lang="ko">
	
		<head>
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
		                <div class="container-fluid">
						<!-- 담당자 / 소속 / 직급 / 배포 대상 소스 / 배포예정일 -->			
								<div><span>담당자</span><span>${userInfo.mname}</span></div>
								<div><span>소속</span><span>${userInfo.organ}</span></div>
								<div><span>직급</span><span>${userInfo.position}</span></div>	
								<div><span>배포 대상</span><span>${statusHistory.distSource}</span></div>
								<c:if test="상태가 고객테스트 완료(정규) or 테스트 완료(긴급)일 때">
									<form action="" method="post">
										<input type="text" placeholder="배포 예정일 입력" name="distributeexpectdate"/>
										<button type="submit">배포 작업 시작</button>
									</form>
								</c:if>		
								<c:if test="상태가 배포중일 때">
									<form action="" method="post">
										<input type="hidden" name="rno" value="${request.rno}"/>
										<button type="submit">배포 완료</button>
									</form>
								</c:if>
								<button type="button">취소</button>
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
		
		    <!-- Logout Modal-->
		    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		        aria-hidden="true">
		        <div class="modal-dialog" role="document">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
		                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
		                        <span aria-hidden="true">×</span>
		                    </button>
		                </div>
		                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
		                <div class="modal-footer">
		                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
		                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Logout</a>
		                </div>
		            </div>
		        </div>
		    </div>
		
		
		
		</body>

</html>