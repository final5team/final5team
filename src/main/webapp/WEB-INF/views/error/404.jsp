<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>404</title>
	</head>
	<body>
		<h3>404 에러 발생</h3>
		<hr/>
		<p>요청 URL이 존재하지 않습니다.</p>
		<p><a href="${pageContext.request.contextPath}">홉페이지 가기</a></p>
		<img src="${pageContext.request.contextPath}/resources/img/hooni.png">
	</body>
</html>