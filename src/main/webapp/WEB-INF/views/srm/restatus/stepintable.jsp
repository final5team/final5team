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
--color-green: #53a318; 
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
													color: var(--gray-dark);
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
													border-bottom: 2px solid var(--gray-dark);
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
													background-color: var(--gray-dark);
												}
												
												.progress_bar .is_active:before, .progress_bar li:hover:before,
													.progress_bar .is-hovered:before {
													background-color: var(--color-white);
													border-color: var(--gray-dark);
												}
												
												.progress_bar li:hover:before, .progress_bar .is-hovered:before {
													transform: scale(1.33);
												}
												
												.progress_bar li:hover span, .progress_bar li.is-hovered span {
													opacity: 1;
												}
												
												.progress_bar:hover li:not (:hover) span {
													opacity: 0;
												}
												.progress_bar .has-changes {
													opacity: 1 !important;
												}


</style> 

<ol class="progress_bar">
	<c:if test="${request.statusNo != 12}">
		<c:if test="${request.reqType == null || request.reqType == '정규'}">
			<li class="is_complete"><a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}"><span>요청완료</span></a></li>
			<li class="<c:if test="${request.statusNo >= 2}">is_complete</c:if>
						 <c:if test="${request.statusNo == 1}">is_active</c:if>">
					<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
						<span>
							<c:if test="${request.statusNo == 1}">접수중</c:if>
							<c:if test="${request.statusNo >= 2}">접수완료</c:if>
						</span>
					</a>
				</li>
			<li class="<c:if test="${request.statusNo >= 5}">is_complete</c:if>
							<c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">now</c:if>">
				<a href="${pageContext.request.contextPath}/developerdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 2}">개발단계</c:if>
						<c:if test="${request.statusNo == 2}">개발요청</c:if>
						<c:if test="${request.statusNo == 4}">개발중</c:if>
						<c:if test="${request.statusNo == 3}">개발재검토</c:if>
						<c:if test="${request.statusNo >= 5}">개발완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 7}">is_complete</c:if><c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/testerdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 5}">테스트단계</c:if>
						<c:if test="${request.statusNo == 5}">테스트요청</c:if>
						<c:if test="${request.statusNo == 6}">테스트중</c:if>
						<c:if test="${request.statusNo >= 7}">테스트완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 9}">is_complete</c:if><c:if test="${request.statusNo >= 7 && request.statusNo <= 8}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/usertestdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 7}">유저테스트단계</c:if>
						<c:if test="${request.statusNo == 7}">유저테스트요청</c:if>
						<c:if test="${request.statusNo == 8}">유저테스트중</c:if>
						<c:if test="${request.statusNo >= 9}">유저테스트완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 11}">is_complete</c:if><c:if test="${request.statusNo >= 9 && request.statusNo <= 10}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}//distributedetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 9}">배포단계</c:if>
						<c:if test="${request.statusNo == 9}">배포요청</c:if>
						<c:if test="${request.statusNo == 10}">배포중</c:if>
						<c:if test="${request.statusNo >= 11}">배포완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 13}">is_complete</c:if><c:if test="${request.statusNo == 11}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/pm/completedetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 11}">최종승인단계</c:if>
						<c:if test="${request.statusNo == 11}">최종승인요청</c:if>
					</span>
				</a>
				<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
						<c:if test="${request.statusNo == 13}">완료</c:if>
				</a>
			</li>
		</c:if>
		<c:if test="${request.reqType == '긴급'}">
			<li class="is_complete">
				<span>요청완료</span>
			</li>
			<li class="<c:if test="${request.statusNo >= 2}">is_complete</c:if><c:if test="${request.statusNo == 1}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/pm/receiptdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo == 1}">접수중</c:if>
						<c:if test="${request.statusNo >= 2}">접수완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 5}">is_complete</c:if><c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/developerdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 2}">개발단계</c:if>
						<c:if test="${request.statusNo == 2}">개발요청</c:if>
						<c:if test="${request.statusNo == 4}">개발중</c:if>
						<c:if test="${request.statusNo == 3}">개발재검토</c:if>
						<c:if test="${request.statusNo >= 5}">개발완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 7}">is_complete</c:if><c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/testerdetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 5}">테스트단계</c:if>
						<c:if test="${request.statusNo == 5}">테스트요청</c:if>
						<c:if test="${request.statusNo == 6}">테스트중</c:if>
						<c:if test="${request.statusNo >= 7}">테스트완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 11}">is_complete</c:if><c:if test="${request.statusNo >= 7 && request.statusNo <= 10}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}//distributedetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 7}">배포단계</c:if>
						<c:if test="${request.statusNo == 7}">배포요청</c:if>
						<c:if test="${request.statusNo == 10}">배포중</c:if>
						<c:if test="${request.statusNo >= 11}">배포완료</c:if>
					</span>
				</a>
			</li>
			<li class="<c:if test="${request.statusNo >= 13}">is_active</c:if><c:if test="${request.statusNo == 11}">is_active</c:if>">
				<a href="${pageContext.request.contextPath}/pm/completedetail?rno=${request.rno}">
					<span>
						<c:if test="${request.statusNo < 11}">최종승인단계</c:if>
						<c:if test="${request.statusNo == 11}">최종승인요청</c:if>
					</span>
				</a>
				<a href="${pageContext.request.contextPath}/pm/enddetail?rno=${request.rno}">
						<c:if test="${request.statusNo == 13}">완료</c:if>
				</a>
			</li>
		</c:if>
	</c:if>
	<c:if test="${request.statusNo == 12}">
		<li class="is_complete">
			<a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}">
				<span>
					요청
				</span>
			</a>
		</li>
		<li class=""><span>접수</span></li>
		<li class=""><span>개발</span></li>
		<li class=""><span>테스트</span></li>
		<li class=""><span>유저테스트</span></li>
		<li class=""><span>배포</span></li>
		<li class="is_complete"><a href="${pageContext.request.contextPath}/customer/requestdetail?rno=${request.rno}"><span>반려</span></a></li>
	</c:if>
</ol>






<!-- <ol class="progress_bar"> -->
<!-- <li class="is_complete"><span>요청</span></li> -->
<!-- 	<li class="is_complete"><span>접수</span></li> -->
<!-- 	<li class="is_complete"><span>개발</span></li> -->
<!-- 	<li class="is_complete"><span>테스트</span></li> -->
<!-- 	<li class="is_complete"><span>유저테스트</span></li> -->
<!-- 	<li class="is_complete"><span>배포</span></li> -->
<!-- 	<li class="is_active"><span>완료</span></li> -->
<!-- </ol>                                              -->





