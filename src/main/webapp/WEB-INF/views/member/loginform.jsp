<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login to start</title>
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.css" rel="stylesheet">
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
							<input type="email" class="form-control underlined" name="mid" id="mid" value="pm1" placeholder="Your email address" required>
						</div>
						<div class="form-group">
							<label for="password" >Password</label>
							<input type="password" class="form-control underlined" name="password" id="password" value="1234" placeholder="Your password" required>
						</div>
						<div class="form-group">
						<input class="checkbox" id=pwd type="checkbox" onclick="showPwd()">
							<label for="pwd">								
								<span>Password Check</span>
							</label>
						</div>
						<div id="loginInfo" class="text-warning">${loginResult}</div>
					</form>
					<div>
						<button type="button" class="btn btn-block btn-primary" onclick="login()">Login</button>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script>
		function login(){
			var id = $('#mid').val();
			var password = $('#password').val();
			if(id == "" || id == null){
				console.log('id없음');
				$('#loginInfo').text('아이디를 입력하세요.');
				return;
			}
			if(password == "" || password == null){
				console.log('password없음');
				$('#loginInfo').text('비밀번호를 입력하세요.');
				return;
			}
			$('#login-form').submit();
		}
		function showPwd() {
		  var x = document.getElementById("password");
		  if (x.type === "password") {
		    x.type = "text";
		  } else {
		    x.type = "password";
		  }
		}
	</script>
</body>
</html>