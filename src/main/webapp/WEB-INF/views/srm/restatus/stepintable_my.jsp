<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
:root {
--color-white: #fff; 
--color-black: #333; 
--color-gray: #75787b; 
--color-gray-light: #bbb; 
--color-gray-disabled: #e8e8e8; 
--color-green: #72B22B;
--color-green-dark: #383; 
--font-size-small: .75rem; 
--font-size-default: .875rem;
}

.progress_bar {
display: flex;
justify-content: space-between;
list-style: none;
padding: 0;
margin: 0 0 1rem 0;
}
												
.progress_bar li {
	flex: 2;
	position: relative;
	padding: 0 0 14px 0;
	font-size: var(--font-size-default);
	line-height: 1.5;
	color: var(--color-green);
	font-weight: 600;
	white-space: nowrap;
	overflow: visible;
	min-width: 0;
	text-align: center;
	border-bottom: 2px solid var(--color-gray-disabled);
}

.progress_bar li:first-child, .progress_bar li:last-child {
	flex: 1;
}

.progress_bar li:last-child {
	text-align: right;
}

.progress_bar li:before {
	content: "";
	display: block;
	width: 8px;
	height: 8px;
	background-color: var(--color-gray-disabled);
	border-radius: 50%;
	border: 2px solid var(--color-white);
	position: absolute;
	left: calc(50% - 6px);
	bottom: -7px;
	z-index: 3;
	transition: all .2s ease-in-out;
}

.progress_bar li:first-child:before {
	left: 0;
}

.progress_bar li:last-child:before {
	right: 0;
	left: auto;
}

.progress_bar span {
	transition: opacity .3s ease-in-out;
}


.progress_bar li:not(.is_active) span {
	opacity: 0;
}

.progress_bar .is_complete:not(:first-child):after,
.progress_bar .is_active:not(:first-child):after {
	content: "";
	display: block;
	width: 100%;
	position: absolute;
	bottom: -2px;
	left: -50%;
	z-index: 2;
	border-bottom: 2px solid var(--color-green);
}
.progress_bar li:last-child span {
	width: 200%;
	display: inline-block;
	position: absolute;
	left: -100%;
}

.progress_bar .is_complete:last-child:after, 
.progress_bar .is_active:last-child:after{
	width: 200%;
	left: -100%;
}

.progress_bar .is_complete:before {
	background-color: var(--color-green);
}

.progress_bar .is_active:before, .pli:hover:before,
	.progress_bar .is-hovered:before {
	background-color: var(--color-white);
	border-color: var(--color-green);
}

.progress_bar li:hover:before, .pris-hovered:before {
	transform: scale(1.33);
}

.progress_bar li:hover span, .progress_bar lispan {
	opacity: 1;
}

.progress_bar:hover li:not(:hover) span {
	opacity: 0;
}
.progress_bar .has-changes {
	opacity: 1 !important;
}
.progress_bar a{
	text-decoration: none;
}
.progress-bar .has-changes {
    opacity: 1 !important;
}
.progress-bar .has-changes:before {
    content: "";
    display: block;
    width: 8px;
    height: 8px;
    position: absolute;
    left: 22px;
    bottom: -20px;
}

</style> 
<script>
	// li click??? url ?????? ?????? ??????
	// 1. ?????? ?????? : ????????? ?????? ????????????
	function register(i){
		let rno = i;
		console.log(i);
		location.href ="${pageContext.request.contextPath}/customer/requestdetail?rno="+rno;
	}
	// 2. ????????????
	function receipt(i){
		let rno = i;
		location.href ="${pageContext.request.contextPath}/pm/receiptdetail?rno="+rno;
	}
	// 3. ????????????
	function developer(i){
		let rno = i;
		location.href ="${pageContext.request.contextPath}/developerdetail?rno="+rno;
	}
	// 4.???????????????
	function test(i){
		let rno = i;
		location.href ="${pageContext.request.contextPath}/testerdetail?rno="+rno;
	}
	// 5. ?????? ????????? ??????
	function quality(i){
		let rno = i;
		location.href ="${pageContext.request.contextPath}/usertestdetail?rno="+rno;
	}
	// 6. ????????????
	function distribute(i){
		let rno = i;
		location.href ="${pageContext.request.contextPath}/distributedetail?rno="+rno;
	}
	// 7. ????????????
	function enddetail(i){
		let rno = i;
		location.href ="${pageContext.request.contextPath}/pm/enddetail?rno="+rno;
	}
	
	
	
</script>
<ol class="progress_bar">
<!-- ?????????????????? ????????? -->
	<c:if test="${request.statusNo != 12}">
		<c:if test="${request.reqType == null || request.reqType == '??????'}">
		<!-- ?????? : ??????  -->
			<li class="is_complete" onclick="register(${request.rno});" style="cursor: pointer;">
				<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
					<span>??????</span>
				</a>
			</li>
			
		<!-- ?????? : ??????  -->	
			<li class="<c:if test="${request.statusNo >= 2}">is_complete</c:if>
					 <c:if test="${request.statusNo == 1}">is_active</c:if>" onclick="receipt(${request.rno})" style="cursor: pointer;">
				<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo == 1}">??????</c:if>
						<c:if test="${request.statusNo >= 2}">????????????</c:if>
					</span>
				</a>
			</li>
		<!-- ?????? : ??????  -->
			<li class="<c:if test="${request.statusNo >= 5}">is_complete</c:if>
						<c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">is_active</c:if>" 
				<c:if test="${request.statusNo >= 2}">
					onclick="developer(${request.rno})" style="cursor: pointer;"
				</c:if>
					>
			<c:if test="${request.statusNo >= 2}">	
				<a href="${pageContext.request.contextPath}/developerdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 2}">??????</c:if>
						<c:if test="${request.statusNo == 2}">????????????</c:if>
						<c:if test="${request.statusNo == 4}">?????????</c:if>
						<c:if test="${request.statusNo == 3}">?????????</c:if>
						<c:if test="${request.statusNo >= 5}">????????????</c:if>
					</span>
				</a>
			</c:if>	
				<c:if test="${request.statusNo == 4}">
					<c:if test="${request.devProgress > 0}">
						<div class="percent">${request.devProgress}%</div>
					</c:if>
				</c:if>
			</li>
			
		<!-- ?????? : ?????????  -->	
			<li class="<c:if test="${request.statusNo >= 7}">is_complete</c:if>
				<c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">is_active</c:if>" 
				<c:if test="${request.statusNo >= 5}">
					onclick="test(${request.rno})" style="cursor: pointer;"
				</c:if>
					>
				<c:if test="${request.statusNo >= 5}">
					<a href="${pageContext.request.contextPath}/testerdetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo < 5}">?????????</c:if>
							<c:if test="${request.statusNo == 5}">???????????????</c:if>
							<c:if test="${request.statusNo == 6}">????????????</c:if>
							<c:if test="${request.statusNo >= 7}">???????????????</c:if>
						</span>
					</a>
				</c:if>
			</li>
			
		<!-- ?????? : ?????? ?????????  -->		
			<li class="<c:if test="${request.statusNo >= 9}">is_complete</c:if>
				<c:if test="${request.statusNo >= 7 && request.statusNo <= 8}">is_active</c:if>" 
					<c:if test ="${request.statusNo >= 7}"> 
						onclick="quality(${request.rno})" style="cursor: pointer;"
					</c:if>	
						>
				<c:if test ="${request.statusNo >= 7}">	
					<a href="${pageContext.request.contextPath}/usertestdetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo < 7}">???????????????</c:if>
							<c:if test="${request.statusNo == 7}">?????????????????????</c:if>
							<c:if test="${request.statusNo == 8}">??????????????????</c:if>
							<c:if test="${request.statusNo >= 9}">?????????????????????</c:if>
						</span>
					</a>
				</c:if>	
			</li>
			
		<!-- ?????? : ??????  -->		
			<li class="<c:if test="${request.statusNo >= 11}">is_complete</c:if>
						<c:if test="${request.statusNo >= 9 && request.statusNo <= 10}">is_active</c:if>" 
				<c:if test="${request.statusNo >= 9}">
					onclick="distribute(${request.rno})" style="cursor: pointer;"
				</c:if>	
					>
				<c:if test ="${request.statusNo >= 9}">	
					<a href="${pageContext.request.contextPath}/distributedetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo < 9}">??????</c:if>
							<c:if test="${request.statusNo == 9}">????????????</c:if>
							<c:if test="${request.statusNo == 10}">?????????</c:if>
							<c:if test="${request.statusNo >= 11}">????????????</c:if>
						</span>
					</a>
				</c:if>
			</li>
			
		<!-- ?????? : ?????? ??????  -->	
			<li class="<c:if test="${request.statusNo >= 13}">is_complete</c:if>
				<c:if test="${request.statusNo == 11}">is_active</c:if>" 
				<c:if test ="${request.statusNo >= 11}">
					onclick="enddetail(${request.rno})" style="cursor: pointer;"
				</c:if>
					>
				<c:if test = "${request.statusNo >= 11}">
					<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
						<c:if test="${request.statusNo < 11}">
							<span>
								????????????
							</span>
						</c:if>
						<c:if test="${request.statusNo == 11}">
							<span>
								????????????
							</span>
						</c:if>
						<c:if test="${request.statusNo == 13}">
							<span class="has-changes">
								??????
							</span>
						</c:if>
					</a>
				</c:if>
			</li>
		</c:if>
		
		
		
		<c:if test="${request.reqType == '??????'}">
		<!-- ?????? : ??????  -->	
			<li class="is_complete" onclick="register(${request.rno})" style="cursor: pointer;">
				<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
					<span>??????</span>
				</a>
			</li>
		<!-- ?????? : ??????  -->
			
			<li class="<c:if test="${request.statusNo >= 2}">is_complete</c:if>
					 <c:if test="${request.statusNo == 1}">is_active</c:if>" onclick="receipt(${request.rno})" style="cursor: pointer;">
				<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo == 1}">??????</c:if>
						<c:if test="${request.statusNo >= 2}">????????????</c:if>
					</span>
				</a>
			</li>
		<!-- ?????? : ??????  -->		
			<li class="<c:if test="${request.statusNo >= 5}">is_complete</c:if>
				<c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">is_active</c:if>" 
					<c:if test="${request.statusNo >= 2}">
						onclick="developer(${request.rno})" style="cursor: pointer;"
					</c:if>
						>
				<c:if test="${request.statusNo >= 2}">			
					<a href="${pageContext.request.contextPath}/developerdetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo < 2}">??????</c:if>
							<c:if test="${request.statusNo == 2}">????????????</c:if>
							<c:if test="${request.statusNo == 4}">?????????</c:if>
							<c:if test="${request.statusNo == 3}">?????????</c:if>
							<c:if test="${request.statusNo >= 5}">????????????</c:if>
						</span>
					</a>
				</c:if>
				<c:if test="${request.statusNo == 4}">
					<c:if test="${request.devProgress > 0}">
						<div class="percent">${request.devProgress}%</div>
					</c:if>
				</c:if>
			</li>
			
		<!-- ?????? : ?????????  -->		
			<li class="<c:if test="${request.statusNo >= 7}">is_complete</c:if>
				<c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">is_active</c:if>" 
				<c:if test="${request.statusNo >= 5}">
					onclick="test(${request.rno})" style="cursor: pointer;"
				</c:if>
					>
				<c:if test="${request.statusNo >= 5}">
					<a href="${pageContext.request.contextPath}/testerdetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo < 5}">?????????</c:if>
							<c:if test="${request.statusNo == 5}">???????????????</c:if>
							<c:if test="${request.statusNo == 6}">????????????</c:if>
							<c:if test="${request.statusNo >= 7}">???????????????</c:if>
						</span>
					</a>
				</c:if>
			</li>
			
			
		<!-- ?????? : ??????  -->		
			<li class="<c:if test="${request.statusNo >= 11}">is_complete</c:if>
						<c:if test="${request.statusNo >= 7 && request.statusNo <= 10}">is_active</c:if>" 
				<c:if test="${request.statusNo >= 7}">
					onclick="distribute(${request.rno})" style="cursor: pointer;"
				</c:if>	
					>
				<c:if test ="${request.statusNo >= 7}">	
					<a href="${pageContext.request.contextPath}/distributedetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo < 7}">??????</c:if>
							<c:if test="${request.statusNo == 7}">????????????</c:if>
							<c:if test="${request.statusNo == 10}">?????????</c:if>
							<c:if test="${request.statusNo >= 11}">????????????</c:if>
						</span>
					</a>
				</c:if>
			</li>
			
			<!-- ?????? : ?????? ??????  -->	
			<li class="<c:if test="${request.statusNo >= 13}">is_complete</c:if>
				<c:if test="${request.statusNo == 11}">is_active</c:if>" 
				<c:if test ="${request.statusNo >= 11}">
				onclick="enddetail(${request.rno})" style="cursor: pointer;"
				</c:if>
				>
				<c:if test = "${request.statusNo >= 11}">
					<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
						<c:if test="${request.statusNo < 11}">
							<span>
								????????????
							</span>
						</c:if>
						<c:if test="${request.statusNo == 11}">
							<span>
								????????????
							</span>
						</c:if>
						<c:if test="${request.statusNo == 13}">
							<span class="has-changes">
								??????
							</span>
						</c:if>
					</a>
				</c:if>
			</li>
		</c:if>
	</c:if>
	
	<c:if test="${request.statusNo == 12}">
		<li class="is_reject_first is_reject" onclick="register(${request.rno})" style="cursor: pointer;">
			<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
				<span>
					??????
				</span>
			</a>
		</li>
		<li class="is_reject" style="cursor: pointer;" onclick="receipt(${request.rno})"><span>??????</span></li>
		<li class="is_reject" style="cursor: pointer;" onclick="enddetail(${request.rno})" >
			<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
				<span class="has-changes">??????</span>
			</a>
		</li>
	</c:if>
</ol>

<style>
/* ????????? ????????? ???, not:first-child??? ???*/
/* before ????????? ??? ????????? */
/* after ????????? ??? ????????? */
.progress_bar .is_reject_first span {
      width: 100%;
      display: inline-block;
      position: absolute;
      left: -30%;
    }
.progress_bar .is_reject:not(:first-child):after {
      content: "";
      display: block;
      width: 100%;
      position: absolute;
      bottom: -2px;
      left: -50%;
      z-index: 3;
      border-bottom: 2px solid red;
    }
.progress_bar .is_reject::before {
      content: "";
      display: block;
      width: 5px;
      height: 5px;
      background-color: red;
      border-radius: 50%;
      border: 2px solid red;
      position: absolute;
      left: calc(50% - 6px);
      bottom: -5px;
      z-index: 3;
      transition: all .2s ease-in-out;
    }    
    .progress_bar .is_reject:last-child:after {
      width: 200%;
      left: -100%;
    }
    
</style>

<!-- <ol class="progress_bar"> -->
<!-- <li class="is_complete"><span>??????</span></li> -->
<!-- 	<li class="is_complete"><span>??????</span></li> -->
<!-- 	<li class="is_complete"><span>??????</span></li> -->
<!-- 	<li class="is_complete"><span>?????????</span></li> -->
<!-- 	<li class="is_complete"><span>???????????????</span></li> -->
<!-- 	<li class="is_complete"><span>??????</span></li> -->
<!-- 	<li class="is_active"><span>??????</span></li> -->
<!-- </ol>                                              -->





