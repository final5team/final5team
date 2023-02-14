<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<nav class="navbar navbar-dark bg-dark text-white font-weight-bold">
	<a class="navbar-brand" href="${pageContext.request.contextPath}"> 
		<img src="${pageContext.request.contextPath}/resources/images/logo-spring.png" width="30" height="30" class="d-inline-block align-top">
		Spring
	</a>
	<div>
		<div>
			<c:if test="${loginMember == null}">
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/member/login">로그인</a>
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/member/join">회원가입</a>
			</c:if>
			<c:if test="${loginMember != null}">
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
			</c:if>
		</div>
	</div>
</nav>
	
		