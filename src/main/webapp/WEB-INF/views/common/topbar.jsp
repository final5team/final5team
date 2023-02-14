<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<body>
		<nav class="navbar navbar-expand topbar mb-3 static-top" style="background-color: #d7dde4;">

			<!-- Topbar Navbar -->
			<ul class="navbar-nav ml-auto">

				<!-- Nav Item - Alerts -->
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/login" role="button" style="color: #5C6B7A;">
						<i class="fas fa-sign-in-alt"></i>
						Login
					</a>
				</li>
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/logout" role="button" style="color: #5C6B7A;">
						<i class="fas fa-sign-out-alt"></i>
						Logout
					</a>
					
				</li>
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" href="#" role="button" style="color: #5C6B7A;">
						<i class="fas fa-user-plus"></i>
						SignUp
					</a>
					
				</li>
				

				<div class="topbar-divider d-none d-sm-block"></div>

				<!-- Nav Item - User Information -->
				<li class="nav-item dropdown no-arrow">
					<div class="nav-link dropdown-toggle" id="userDropdown">
						<span class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas McGee</span>
						<img class="img-profile rounded-circle" src="resources/img/hooni.png">
					</div>
				</li>

			</ul>

		</nav>
		
	</body>
</html>


