<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<body>
		<script type="text/javascript">
			function checkLogout(){
				confirm('로그아웃하니?')
			}
		</script>
		
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
					<a class="nav-link dropdown-toggle" data-toggle="modal" data-target="#logoutModal" role="button" style="color: #5C6B7A;">
						<i class="fas fa-sign-out-alt"></i>
						Logout
					</a>
					
				</li>
				<li class="nav-item dropdown no-arrow mx-1">
					<a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/customer/register" role="button" style="color: #5C6B7A;">
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
	                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Logout</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>
</html>


