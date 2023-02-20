<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="inner_step">
												<td class="circle">요청완료</td>
												<td class="bar"></td>
												<td class="circle">접수완료</td>
												<td class="bar"></td>
												<td class="circle">개발완료</td>
												<td class="bar"></td>
												<td class="circle">테스트완료</td>
												<td class="bar"></td>
												<td class="circle">유저테스트</td>
												<td class="bar"></td>
												<td class="circle">배포단계</td>
												<td class="bar"></td>
												<td class="circle">최종승인</td>
											</table>

<c:if test="${request.statusName != '반려'}">
	<c:if test="${requestProcess.reqType == null || requestProcess.reqType == '정규'}">
		<table class="inner_step">
           <td class="circle done">요청완료</td>
           <td class="bar active"></td>
           <td class="circle 
           	 <c:if test="${request.statusNo >= 2}">done</c:if>
           	 <c:if test="${request.statusNo == 1}">now</c:if>">
           	 <c:if test="${request.statusNo == 1}">접수중</c:if>
           	 <c:if test="${request.statusNo >= 2}">접수완료</c:if>
		</td>
           <td class="bar <c:if test="${request.statusNo >= 2}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 5}">done</c:if>
           	 <c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">now</c:if>">
             <c:if test="${request.statusNo < 2}">개발단계</c:if>
	    						     <c:if test="${request.statusNo == 2}">개발요청</c:if>
           	 <c:if test="${request.statusNo == 3}">개발중</c:if>
           	 <c:if test="${request.statusNo == 4}">개발재검토</c:if>
           	 <c:if test="${request.statusNo >= 5}">개발완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 5}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 7}">done</c:if>
           	 <c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">now</c:if>">
           	 <c:if test="${request.statusNo < 5}">테스트단계</c:if>
           	 <c:if test="${request.statusNo == 5}">테스트요청</c:if>
           	 <c:if test="${request.statusNo == 6}">테스트중</c:if>
           	 <c:if test="${request.statusNo >= 7}">테스트완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 7}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 9}">done</c:if>
           	 <c:if test="${request.statusNo >= 7 && request.statusNo <= 8}">now</c:if>">
           	 <c:if test="${request.statusNo < 7}">유저테스트단계</c:if>
           	 <c:if test="${request.statusNo == 7}">유저테스트요청</c:if>
           	 <c:if test="${request.statusNo == 8}">유저테스트중</c:if>
           	 <c:if test="${request.statusNo >= 9}">유저테스트완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 9}">active</c:if>"></td>
           <td class="circle
             <c:if test="${request.statusNo >= 11}">done</c:if>
           	 <c:if test="${request.statusNo >= 9 && request.statusNo <= 10}">now</c:if>">	
             <c:if test="${request.statusNo < 9}">배포단계</c:if>
           	 <c:if test="${request.statusNo == 9}">배포요청</c:if>
           	 <c:if test="${request.statusNo == 10}">배포중</c:if>
           	 <c:if test="${request.statusNo >= 11}">배포완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 11}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 13}">done</c:if>
           	 <c:if test="${request.statusNo == 11}">now</c:if>">	
             <c:if test="${request.statusNo < 11}">최종승인단계</c:if>
           	 <c:if test="${request.statusNo == 11}">최종승인요청</c:if>
           	 <c:if test="${request.statusNo == 13}">완료</c:if>
           </td>
	    </table>
	</c:if>
	<c:if test="${requestProcess.reqType == '긴급'}">
		<table class="inner_step">
           <td class="circle done">요청완료</td>
           <td class="bar active"></td>
           <td class="circle 
           	 <c:if test="${request.statusNo >= 2}">done</c:if>
           	 <c:if test="${request.statusNo == 1}">now</c:if>">
           	 <c:if test="${request.statusNo == 1}">접수중</c:if>
           	 <c:if test="${request.statusNo >= 2}">접수완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 2}">active</c:if>"></td>
           <td class="circle
             <c:if test="${request.statusNo >= 5}">done</c:if>
             <c:if test="${request.statusNo >= 2 && request.statusNo <= 4}">now</c:if>">
             <c:if test="${request.statusNo < 2}">개발단계</c:if>
	    						     <c:if test="${request.statusNo == 2}">개발요청</c:if>
           	 <c:if test="${request.statusNo == 3}">개발중</c:if>
           	 <c:if test="${request.statusNo == 4}">개발재검토</c:if>
           	 <c:if test="${request.statusNo >= 5}">개발완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 5}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 7}">done</c:if>
           	 <c:if test="${request.statusNo >= 5 && request.statusNo <= 6}">now</c:if>">
           	 <c:if test="${request.statusNo < 5}">테스트단계</c:if>
           	 <c:if test="${request.statusNo == 5}">테스트요청</c:if>
           	 <c:if test="${request.statusNo == 6}">테스트중</c:if>
           	 <c:if test="${request.statusNo >= 7}">테스트완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 7}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 11}">done</c:if>
           	 <c:if test="${request.statusNo >= 7 && request.statusNo <= 10}">now</c:if>">	
             <c:if test="${request.statusNo < 7}">배포단계</c:if>
           	 <c:if test="${request.statusNo == 7}">배포요청</c:if>
           	 <c:if test="${request.statusNo == 10}">배포중</c:if>
           	 <c:if test="${request.statusNo >= 11}">배포완료</c:if>
           </td>
           <td class="bar <c:if test="${request.statusNo >= 11}">active</c:if>"></td>
           <td class="circle
           	 <c:if test="${request.statusNo >= 13}">done</c:if>
           	 <c:if test="${request.statusNo == 11}">now</c:if>">	
             <c:if test="${request.statusNo < 11}">최종승인단계</c:if>
           	 <c:if test="${request.statusNo == 11}">최종승인요청</c:if>
           	 <c:if test="${request.statusNo == 13}">완료</c:if>
           </td>
	    </table>
	</c:if>
</c:if>
<c:if test="${request.statusName == '반려'}">
	<table class="inner_step">
           <td class="circle done">요청완료</td>
           <td class="bar active"></td>
           <td class="circle done">
				접수완료
           </td>
           <td class="bar active"></td>   
           <td class="circle now">	
           		반려
           </td>
	    </table>
</c:if>
