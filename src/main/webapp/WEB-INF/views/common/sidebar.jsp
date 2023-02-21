<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<style>
    .navbar-nav .sidebar-brand .sidebar-brand-icon img{
        height: 50px;
    }

</style>
<body>

	<ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar" style="background-color: #3A4651;">
	
		<!-- Sidebar - Brand -->
		<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/">
			
			<div class="sidebar-brand-icon">
				<img src="${pageContext.request.contextPath}/resources/img/logo.png">
			</div>
			<div class="sidebar-brand-text mx-3"> OTI SRM</div>
		</a>

		<!-- Divider -->
		<hr class="sidebar-divider my-0">

		<!-- Nav Item - Dashboard -->
		<li class="nav-item active">
			<a class="nav-link" href="${pageContext.request.contextPath}/">
				<i class="fas fa-fw fa-tachometer-alt"></i>
				<span>Dashboard</span></a>
		</li>


		<!-- Divider -->
		<hr class="sidebar-divider">

		<!-- Heading -->
		<div class="sidebar-heading">
			MENU
		</div>


		<!-- 사이드메뉴 start(사이드바 작업한다고 말해주세요) -->
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/request">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>나의 서비스 요청</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/requestlist">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>내 담당 요청 관리</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/developerdetail?rno=41">
				<i class="fas fa-file-code"></i>
				<span>개발자의 담당요청 상세보기</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/tester?rno=41">
				<i class="fas fa-vial"></i>
				<span>테스터의 담당요청 상세보기</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/main">
				<i class="fas fa-vial"></i>
				<span>현이 메인페이지</span></a>
		</li>

		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/noticelist">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>공지사항</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/stats/statistics">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>현황통계</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/register">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>마이페이지</span></a>
		</li>
		<!-- 사이드메뉴 end(사이드바 작업한다고 말해주세요) -->


	</ul>

</body>

</html>