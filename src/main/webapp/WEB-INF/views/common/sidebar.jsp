<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<style>
    .navbar-nav .sidebar-brand .sidebar-brand-icon img{
        height: 50px;
    }
	@keyframes keepturningLogo{
		from{
			transform: rotateY(0);
		}
		to {
		 transform: rotateY(360deg);
		}
	}
	#mainlogo{
        animation: keepturningLogo 7s ease-in-out infinite; 
	}
	
	.nav-link .active{
	color: white;
	background-color: #85CE36 !important;
	}
	
	</style>
<body>

	<ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar" style="background-color: #3A4651;">
	
		<!-- Sidebar - Brand -->
		<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/">
			
			<div class="sidebar-brand-icon">
				<img id="mainlogo" src="${pageContext.request.contextPath}/resources/img/logo.png">
			</div>
			<div class="sidebar-brand-text mx-3"> OTI SRM</div>
		</a>

		<!-- Divider -->
		<hr class="sidebar-divider my-0">

		<!-- Nav Item - Dashboard -->
		<li class="nav-item">
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


		<!-- 사이드메뉴 start -->
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/request">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>요청 작성</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/myrequestlist">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>내 요청 목록</span></a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/requestlist">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>담당 요청 목록</span></a>
		</li>

		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/noticelist">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>공지사항</span></a>
		</li>
		<c:if test="${member.mtype == 'pm'}">
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/stats/statistics">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>현황통계</span></a>
			</li>
		</c:if>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/customer/mypage">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>마이페이지</span></a>
		</li>
		<c:if test="${member.mtype == 'pm'}">
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/customer/register">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>사용자 등록</span></a>
			</li>
		</c:if>
		<!-- 사이드메뉴 end(사이드바 작업한다고 말해주세요) -->


	</ul>
	<script type="text/javascript">
		var button = $('nav-link');
		$('nav-link').click(function(event){
			button.each(function() {
				$(this).removeClass("active");
			});
			$(event.target).addClass("active");
		});
		
		
	</script>
</body>

</html>