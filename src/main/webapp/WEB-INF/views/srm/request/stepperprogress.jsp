<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${request.statusNo != 12}">
	<c:if test="${request.reqType == null || request.reqType == '정규'}">
		<div class="stepper-wrapper">
			<div class="stepper-item">
			  <div class="step-counter btn">
			  	<i class="fas fa-file-word"></i>
			  </div>
			  <div class="step-name">등록</div>
			</div>
			<div class="stepper-item ">
			  <div class="step-counter btn">
			  	<i class="fas fa-inbox"></i>
			  </div>
			  <div class="step-name">접수</div>
			</div>
			<div class="stepper-item ">
			  <div class="step-counter btn">
			  	<i class="fas fa-laptop-code"></i>
			  </div>
			  <div class="step-name">개발</div>
			</div>
			<div class="stepper-item">
			  <div class="step-counter btn">
			  	<i class="fas fa-vial"></i>
			  </div>
			  <div class="step-name">테스트</div>
			</div>
			<div class="stepper-item">
			  <div class="step-counter btn">
			  	<i class="fas fa-equals"></i>
			  </div>
			  <div class="step-name">품질테스트</div>
			</div>
			<div class="stepper-item">
			  <div class="step-counter btn">
			  	<i class="fas fa-project-diagram"></i>
			  </div>
			  <div class="step-name">배포</div>
			</div>
			<div class="stepper-item">
			  <div class="step-counter btn">
			  	<i class="fas fa-check-double"></i>
			  </div>
			  <div class="step-name">완료</div>
			</div>
		</div>
	</c:if>
</c:if>