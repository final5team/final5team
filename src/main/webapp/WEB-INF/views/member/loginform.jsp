<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
<meta charset="UTF-8">
<title>Login to start</title>
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.css" rel="stylesheet">
=======
>>>>>>> branch 'master' of https://github.com/final5team/final5team.git
	<%@ include file="/WEB-INF/views/common/head.jsp"%>
</head>
<body>
	<div class="auth">
		<div class="auth-container">
			<div class="card mb-3">
				<header class="auth-header">
					<h1 class="auth-title">
						<img src="${pageContext.request.contextPath}/resources/img/logo.png" width="18%" class="mr-2">
						OTI SRM
					</h1>
				</header>
				<div class="auth-content">
					<p class="text-center">LOGIN TO CONTINUE</p>
					<form id="login-form"  action="${pageContext.request.contextPath}/login" method="POST" novalidate>
						<div class="form-group">
							<label for="mid" >UserId</label>
							<input type="email" class="form-control underlined" name="mid" id="mid" value="${member.mid}" placeholder="Your email address" required>
						</div>
						<div class="form-group">
							<label for="password" >Password</label>
							<input type="password" class="form-control underlined" name="password" id="password" value="${member.password}" placeholder="Your password" required>
						</div>
						<div class="form-group">
							<label for="remember">
								<input class="checkbox" id="remember" type="checkbox">
								<span>Remember me</span>
							</label>
						</div>
						<c:if test="${loginResult != null}">
							<div class="text-warning">${loginResult}</div>
						</c:if>
						<div class="form-group">
							<button type="submit" class="btn btn-block btn-primary">Login</button>
						</div>
						<div class="form-group">
							<p class="text-muted text-center">Do not have an account? <a href="#">Sign Up</a></p>
						</div>
					</form>
				</div>
			</div>
			<div class="text-center">
				<a href="${pageContext.request.contextPath}" class="btn btn-sm" style="border-color:#d7dde4; background-color: #fff;">
					<i class="fa fa-arrow-left"></i> Back to dashboard
				</a>
			</div>
		</div>
	</div>
</body>
</html>