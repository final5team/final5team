<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
     #noticeDetail{
     	margin-top : 50px;
     	padding : 40px;
     	width : 90%;
     	background-color : white;
     }
     .checkboxIcon{
     	width : 20px;
     	height : 20px;
     }
     .lookaheadicon{
     	width : 20px;
     	height : 20px;
     }
    </style>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
		
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
                <!-- End of Topbar -->

                <!-- 여기에 내용 담기 start -->
                <div id="noticeDetail" class="container">
                	<h1>공지사항 조회</h1>
               		<h6>작성일 : <fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></h6>
                	<h6>작성자 : ${notice.mid}</h6>
               		<hr/>
 
                	<div class="row p-2">
				    	<div class="col-2">시스템</div>
				    	<input type="text" class="form-control col-10" value="${notice.systemName}" readonly/>
				  	</div>
				  	<div class="row p-2">
				    	<div class="col-2">공개 설정</div>
				    	<div class="col-10">
				    	<c:if test="${notice.userShow == 'Y'}">
				    		<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">고객</span>
				    	</c:if>
				    	<c:if test="${notice.devShow == 'Y'}">
				    		<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">개발자</span>
				    	</c:if>
				    	<c:if test="${notice.testerShow == 'Y'}">
				    		<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">테스터</span>
				    	</c:if>
				    	<c:if test="${notice.userTesterShow == 'Y'}">
				    		<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">고객테스터</span>
				    	</c:if>
				    	<c:if test="${notice.distributorShow == 'Y'}">
				    		<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">배포담당자</span>
				    	</c:if>
				    	</div>
				  	</div>
				  	<div class="row p-2">
				    	<div class="col-2">제목</div>
				    	<input type="text" class="form-control col-10" value="${notice.noticeTitle}" readonly/>
				  	</div>
				    <div class="row p-2">
				    	<div class="col-2">내용</div>
				    	<textarea class="form-control col-10" rows="10" readonly>${notice.noticeContent}</textarea>
				    </div>
				  	<div class="row p-2">
				  		<div class="col-2">첨부파일</div>
				  		<div class="col-10">
				    		<c:forEach var="noticeFile" items="${notice.fileList}">
				    			<div>
					    			<a href="${pageContext.request.contextPath}/noticefiledownload?fno=${noticeFile.fno}">${noticeFile.fileName}</a>
				    			</div>
				    		</c:forEach>
			    		</div>
				  	</div>
				  	<a href="${pageContext.request.contextPath}/noticelist" class="btn btn-sm btn-primary">목록</a>
				  	<c:if test="${member.mid == notice.mid}">
				  		<a href="${pageContext.request.contextPath}/noticeupdateform?nno=${notice.nno}" class="btn btn-sm btn-primary">수정</a>
				  		<a href="${pageContext.request.contextPath}/noticedelete?nno=${notice.nno}" class="btn btn-sm btn-primary">삭제</a>
				  	</c:if>
                </div>
                
                <!-- 여기에 내용 담기 end -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

</body>
