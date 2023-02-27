<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<body>
		
		<nav class="navbar navbar-expand topbar mb-3 static-top" style="background-color: #d7dde4;">

			<!-- Topbar Navbar -->
			<ul class="navbar-nav ml-auto">

				<!-- Nav Item - Alerts -->
				<c:if test="${member.mid == null}">
				
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/login" role="button" style="color: #5C6B7A;">
						<i class="fas fa-sign-in-alt"></i>
						Login
					</a>
				</li>
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/customer/register" role="button" style="color: #5C6B7A;">
						<i class="fas fa-user-plus"></i>
						SignUp
					</a>
					
				</li>
				</c:if>
				<c:if test="${member.mid != null}">
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" data-toggle="modal" data-target="#logoutModal" role="button" style="color: #5C6B7A;">
						<i class="fas fa-sign-out-alt"></i>
						Logout
					</a>
					
				</li>
				</c:if>
				

				<div class="topbar-divider d-none d-sm-block"></div>

				<!-- Nav Item - User Information -->
				<li class="nav-item dropdown no-arrow">
					<div class="nav-link dropdown-toggle" id="userDropdown">
						<img class="img-profile rounded-circle" src="${pageContext.request.contextPath}/customer/mypage/${member.mid}" >
						<a href="${pageContext.request.contextPath}/customer/mypage">
							<span class="ml-3 mr-3 d-lg-inline font-weight-bold " style="color: #5C6B7A;">${member.mname} 님</span>
						</a>
					</div>
				</li>

			</ul>

		</nav>
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
	                <div class="modal-body">로그아웃을 원하시면 버튼을 눌러주세요.</div>
	                <div class="modal-footer">
	                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
	                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/logout">Logout</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>
</html>


