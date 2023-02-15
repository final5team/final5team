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
							<div><span>담당자</span><span>${userInfo.mname}</span></div>
							<div><span>소속</span><span>${userInfo.organ}</span></div>
							<div><span>직급</span><span>${userInfo.position}</span></div>	
							<div><span>개발 내용</span><span>${statusHistory.reply}</span></div>
							<c:if test="상태가 테스트완료일 때">
								<form action="" method="post">
									<input type="text" placeholder="유저테스트 예정일 입력" name="distributeexpectdate"/>
									<button type="submit">유저테스트 시작</button>
								</form>
							</c:if>		
							<c:if test="상태가 고객테스트 중일 때">
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
		</body>

</html>