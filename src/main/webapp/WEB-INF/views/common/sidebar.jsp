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
	
	.button.active{
	color: white;
	background-color: #85CE36 !important;
	}
	.button.user:hover{
	color: white;
	background-color: #FF6161 !important;
	}
	.button.pm:hover{
	color: white;
	background-color: #52bcd3 !important;
	}
	.button.workers:hover{
	color: white;
	background-color: #85CE36 !important;
	}
	
	</style>
<body>

	<ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar" style="background-color: #3A4651;">
	
		<!-- Sidebar - Brand -->
		<c:if test="${member.mtype eq 'user'}">
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/userhome">
		</c:if>
		<c:if test="${member.mtype eq 'pm'}">
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/pmhome">
		</c:if>
		<c:if test="${member.mtype != 'user' && member.mtype != 'pm'}">
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/">
		</c:if>
			
			<div class="sidebar-brand-icon">
				<img id="mainlogo" src="${pageContext.request.contextPath}/resources/img/logo.png">
			</div>
			<div class="sidebar-brand-text mx-3"> OTI SRM</div>
		</a>

		<!-- Divider -->
		<hr class="sidebar-divider my-0">


		<!-- Nav Item - Dashboard -->
		<c:if test="${member.mtype eq 'user'}">
			<li class="nav-item button user" id="userDashboard">
				<a class="nav-link user" href="${pageContext.request.contextPath}/userhome">
					<i class="fas fa-fw fa-tachometer-alt"></i>
					<span>Dashboard</span>
				</a>
			</li>
		</c:if>
		<c:if test="${member.mtype eq 'pm'}">
			<li class="nav-item button pm" id="pmDashboard">
				<a class="nav-link pm" href="${pageContext.request.contextPath}/pmhome">
					<i class="fas fa-fw fa-tachometer-alt"></i>
					<span>Dashboard</span>
				</a>
			</li>
		</c:if>
		<c:if test="${member.mtype != 'user' && member.mtype != 'pm'}">
			<li class="nav-item button workers" id="workersDashboard">
				<a class="nav-link workers" href="${pageContext.request.contextPath}/">
					<i class="fas fa-fw fa-tachometer-alt"></i>
					<span>Dashboard</span>
				</a>
			</li>
		</c:if>
			


		<!-- Divider -->
		<hr class="sidebar-divider">

		<!-- Heading -->
		<div class="sidebar-heading">
			MENU
		</div>

		<!-- 사이드메뉴 start -->
		<c:if test="${member.mtype == 'user'}">
			<li class="nav-item button user" id="userlist">
				<a class="nav-link" href="${pageContext.request.contextPath}/customer/userrequestlist">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>내 요청 목록</span></a>
			</li>
		</c:if>
		
		<c:if test="${member.mtype == 'pm'}">
			<li class="nav-item button pm" id="pmlist">
				<a class="nav-link" href="${pageContext.request.contextPath}/customer/requestlist">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>담당 요청 목록</span></a>
			</li>
		</c:if>
		<c:if test="${member.mtype != 'user' && member.mtype != 'pm'}">
			<li class="nav-item button workers" id="workerslist">
				<a class="nav-link" href="${pageContext.request.contextPath}/customer/requestlist">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>담당 요청 목록</span></a>
			</li>
		</c:if>
		
		<li class="nav-item button" id="notice">
			<a class="nav-link" href="${pageContext.request.contextPath}/noticelist">
				<i class="fas fa-fw fa-chart-area"></i>
				<span>공지사항</span>
			</a>
		</li>

		<c:if test="${member.mtype == 'pm'}">
			<li class="nav-item button pm" id="pmstats">
				<a class="nav-link" href="${pageContext.request.contextPath}/stats/statistics">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>현황통계</span>
				</a>
			</li>
		</c:if>
		<c:if test="${member.mtype == 'pm'}">
			<li class="nav-item button pm" id="pmregister">
				<a class="nav-link" href="${pageContext.request.contextPath}/customer/register">
					<i class="fas fa-fw fa-chart-area"></i>
					<span>사용자 등록</span></a>
			</li>
		</c:if>
		<!-- 사이드메뉴 end(사이드바 작업한다고 말해주세요) -->


	</ul>
	<script type="text/javascript">
		/* $('.nav-link').click(function(event){
			$('.button').each(function() {
				$(this).removeClass("active");
			});
			$(event.target).parent().addClass("active");
		}); */
		
		//세션에 저장된 where 이 어떤 버튼인지 받아온다. dashboard/list/stats/notice 있을 거임
		//세션에 저장된 member 타입을 받아온다. user, pm, (developer/tester/usertester/distributor)
		//where 과 member 타입에 따라서, id값 부여한 태그에 배경색, 글자색 바꿔준다. 
		//where 이 공지사항일 경우, member에 따른 class까지 넣어주고 배경색, 글자색 바꿔준다.
		
		$(document).ready(function(){
			let where = '${where}';
 			let membertype = '${member.mtype}';
			if(membertype == 'user'){
				$('#notice').addClass('user');
			} else if(membertype == 'pm'){
				$('#notice').addClass('pm');
			}else{
				$('#notice').addClass('workers');
			}
 			
 			
 			
			 if(where == 'dashboard'){
				if(membertype == 'user'){
					$('#userDashboard').css('background-color','#FF6161');
					$('#userDashboard >a').css('color','#FFFFFF');
					
				} else if(membertype == 'pm'){
					
					$('#pmDashboard').css('background-color','#52BCD3');
					$('#pmDashboard >a').css('color','#FFF');
					
				} else {
					$('#workersDashboard').css('background-color','#85CE36');
					$('#workersDashboard >a').css('color','#FFFFFF');
				}
			
			} else if(where == 'notice'){
				if(membertype == 'user'){
					$('#notice').css('background-color','#FF6161');
					$('#notice >a').css('color','#FFFFFF');
					
				} else if(membertype == 'pm'){
					$('#notice').css('background-color','#52BCD3');
					$('#notice >a').css('color','#FFFFFF');
				}else{
					$('#notice').css('background-color','#85CE36');
					$('#notice >a').css('color','#FFFFFF');
				}
			} else if(where == 'list'){
				if(membertype == 'user'){
					$('#userlist').css('background-color','#FF6161');
					$('#userlist >a').css('color','#FFFFFF');
				} else if(membertype == 'pm'){
					$('#pmlist').css('background-color','#52BCD3');
					$('#pmlist >a').css('color','#FFFFFF');
				} else{
					$('#workerslist').css('background-color','#85CE36');
					$('#workerslist >a').css('color','#FFFFFF');
				}
			} else if(where == 'stat'){
				$('#pmstats').css('background-color','#52BCD3');
				$('#pmstats >a').css('color','#FFFFFF');
			} else{
				$('#pmregister').css('background-color','#52BCD3');
				$('#pmregister >a').css('color','#FFFFFF');
			}
			
		});
		
		
		
		
		
	</script>
</body>

</html>