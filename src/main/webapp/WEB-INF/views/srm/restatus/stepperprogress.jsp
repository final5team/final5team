<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<c:if test="${request.statusName != '반려'}">

	<c:if test="${requestProcess.reqType == null || requestProcess.reqType == '정규'}">
		<div class="stepper-wrapper">
			<div class="stepper-item completed">
			  <div class="step-counter btn" onclick="openRegister()">
			  	<i class="fas fa-file-word"></i>
			  </div>
			  <div class="step-name">등록</div>
			</div>
			<div class="stepper-item
				 <c:if test="${request.statusNo >= 2}">completed</c:if>
		         <c:if test="${request.statusNo == 1}">active</c:if>">
			  <a class="step-counter btn" href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
			  	<i class="fas fa-inbox"></i>
			  </a>
			  <div class="step-name">
			  	 <c:if test="${request.statusNo == 1}">접수중</c:if>
		         <c:if test="${request.statusNo >= 2}">접수완료</c:if>
			  </div>
			</div>
			<div class="stepper-item
			   <c:if test="${request.statusNo >= 5}">completed</c:if>
		       <c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">active</c:if>">
		       <c:if test="${requestProcess.allExpectDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-laptop-code"></i>
			  	 </a>
			   </c:if>
			   <c:if test="${requestProcess.allExpectDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/developerdetail?rno=${request.rno}">
			  		<i class="fas fa-laptop-code"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 2}">개발단계</c:if>
			    <c:if test="${request.statusNo == 2}">개발요청</c:if>
		    	<c:if test="${request.statusNo == 3}">개발재검토</c:if>
		        <c:if test="${request.statusNo == 4}">개발중</c:if>
		        <c:if test="${request.statusNo >= 5}">개발완료</c:if>
			  </div>
			</div>
			<div class="stepper-item 
			  <c:if test="${request.statusNo >= 7}">completed</c:if>
		      <c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">active</c:if>
		      <c:if test="${request.statusNo == 3}">warning</c:if>">
		      <c:if test="${requestProcess.devCompDate == null && testRejectExist == 0}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-vial""></i>
			  	 </a>
			   </c:if>
			  <c:if test="${requestProcess.devCompDate != null || testRejectExist == 1}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/testerdetail?rno=${request.rno}">
			  		<i class="fas fa-vial""></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 5}">테스트단계</c:if>
		        <c:if test="${request.statusNo == 5}">테스트요청</c:if>
		        <c:if test="${request.statusNo == 6}">테스트중</c:if>
		        <c:if test="${request.statusNo >= 7}">테스트완료</c:if>
			  </div>
			</div>
			<div class="stepper-item 
			  <c:if test="${request.statusNo >= 9}">completed</c:if>
		      <c:if test="${request.statusNo >= 7 && request.statusNo <= 8}">active</c:if>">
		      <c:if test="${requestProcess.testCompDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-equals"></i>
			  	 </a>
			   </c:if>
			  <c:if test="${requestProcess.testCompDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/usertestdetail?rno=${request.rno}">
			  		<i class="fas fa-equals"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 7}">품질검사단계</c:if>
		        <c:if test="${request.statusNo == 7}">품질검사요청</c:if>
		        <c:if test="${request.statusNo == 8}">품질검사중</c:if>
		        <c:if test="${request.statusNo >= 9}">품질검사완료</c:if>
			  </div>
			</div>
			<div class="stepper-item
			  <c:if test="${request.statusNo >= 11}">completed</c:if>
		      <c:if test="${request.statusNo >= 9 && request.statusNo <= 10}">active</c:if>">
			  <c:if test="${requestProcess.userTestCompDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-project-diagram"></i>
			  	 </a>
			  </c:if>
			  <c:if test="${requestProcess.userTestCompDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/distributedetail?rno=${request.rno}">
			  		<i class="fas fa-project-diagram"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 9}">배포단계</c:if>
		        <c:if test="${request.statusNo == 9}">배포요청</c:if>
		        <c:if test="${request.statusNo == 10}">배포중</c:if>
		        <c:if test="${request.statusNo >= 11}">배포완료</c:if>
			  </div>
			</div>
			<div class="stepper-item
		      <c:if test="${request.statusNo >= 13}">completed</c:if>
		      <c:if test="${request.statusNo == 11}">active</c:if>">
		      <c:if test="${requestProcess.distCompDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-check-double"></i>
			  	 </a>
			  </c:if>
			  <c:if test="${requestProcess.distCompDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
			  		<i class="fas fa-check-double"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 11}">최종승인단계</c:if>
		        <c:if test="${request.statusNo == 11}">최종승인요청</c:if>
		        <c:if test="${request.statusNo == 13}">완료</c:if>
			  </div>
			</div>
		</div>
	</c:if>
	<c:if test="${requestProcess.reqType == '긴급'}">
		<div class="stepper-wrapper">
			<div class="stepper-item completed">
			  <div class="step-counter btn" onclick="openRegister()">
			  	<i class="fas fa-file-word"></i>
			  </div>
			  <div class="step-name">등록</div>
			</div>
			<div class="stepper-item
				 <c:if test="${request.statusNo >= 2}">completed</c:if>
		         <c:if test="${request.statusNo == 1}">active</c:if>">
			  <a class="step-counter btn" href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
			  	<i class="fas fa-inbox"></i>
			  </a>
			  <div class="step-name">
			  	 <c:if test="${request.statusNo == 1}">접수중</c:if>
		         <c:if test="${request.statusNo >= 2}">접수완료</c:if>
			  </div>
			</div>
			<div class="stepper-item
				<c:if test="${request.statusNo >= 5}">completed</c:if>
		        <c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">active</c:if>">
			  <c:if test="${requestProcess.allExpectDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-laptop-code"></i>
			  	 </a>
			   </c:if>
			   <c:if test="${requestProcess.allExpectDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/developerdetail?rno=${request.rno}">
			  		<i class="fas fa-laptop-code"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 2}">개발단계</c:if>
			    <c:if test="${request.statusNo == 2}">개발요청</c:if>
		    	<c:if test="${request.statusNo == 3}">개발재검토</c:if>
		        <c:if test="${request.statusNo == 4}">개발중</c:if>
		        <c:if test="${request.statusNo >= 5}">개발완료</c:if>
			  </div>
			</div>
			<div class="stepper-item 
				<c:if test="${request.statusNo >= 7}">completed</c:if>
		        <c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">active</c:if>">
			  <c:if test="${requestProcess.devCompDate == null && testRejectExist == 0}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-vial""></i>
			  	 </a>
			   </c:if>
			  <c:if test="${requestProcess.devCompDate != null || testRejectExist == 1}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/testerdetail?rno=${request.rno}">
			  		<i class="fas fa-vial""></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 5}">테스트단계</c:if>
		        <c:if test="${request.statusNo == 5}">테스트요청</c:if>
		        <c:if test="${request.statusNo == 6}">테스트중</c:if>
		        <c:if test="${request.statusNo >= 7}">테스트완료</c:if>
			  </div>
			</div>
			<div class="stepper-item
				<c:if test="${request.statusNo >= 11}">completed</c:if>
		           	 <c:if test="${request.statusNo >= 9 && request.statusNo <= 10}">active</c:if>">
			  <c:if test="${requestProcess.userTestCompDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-project-diagram"></i>
			  	 </a>
			  </c:if>
			  <c:if test="${requestProcess.userTestCompDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/distributedetail?rno=${request.rno}">
			  		<i class="fas fa-project-diagram"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 9}">배포단계</c:if>
		        <c:if test="${request.statusNo == 9}">배포요청</c:if>
		        <c:if test="${request.statusNo == 10}">배포중</c:if>
		        <c:if test="${request.statusNo >= 11}">배포완료</c:if>
			  </div>
			</div>
			<div class="stepper-item
				<c:if test="${request.statusNo >= 13}">completed</c:if>
		        <c:if test="${request.statusNo == 11}">active</c:if>">
			  <c:if test="${requestProcess.distCompDate == null}">
			  	 <a class="step-counter btn" href="#">
			  		<i class="fas fa-check-double"></i>
			  	 </a>
			  </c:if>
			  <c:if test="${requestProcess.distCompDate != null}">
			  	<a class="step-counter btn" href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
			  		<i class="fas fa-check-double"></i>
			  	</a>
			  </c:if>
			  <div class="step-name">
			  	<c:if test="${request.statusNo < 11}">최종승인단계</c:if>
		        <c:if test="${request.statusNo == 11}">최종승인요청</c:if>
		        <c:if test="${request.statusNo == 13}">완료</c:if>
			  </div>
			</div>
		</div>
	</c:if>
</c:if>	
<c:if test="${request.statusName == '반려'}">
	<div class="stepper-wrapper">
		<div class="stepper-item completed">
			<div class="step-counter btn">
			  	<i class="fas fa-file-word"></i>
			</div>
			<div class="step-name">등록</div>
		</div>
		<div class="stepper-item completed">
			<a class="step-counter btn" href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
			  <i class="fas fa-inbox"></i>
			</a>
			<div class="step-name">접수 완료</div>
		</div>
		<div class="stepper-item completed">
			<a class="step-counter btn" href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
		  		<i class="fas fa-check-double"></i>
		  	</a>
			<div class="step-name">반려</div>
		</div>	
	</div>
</c:if>
	