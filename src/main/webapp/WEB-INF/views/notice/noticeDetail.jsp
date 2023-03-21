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
     .label{
		text-align :center;
		padding: 0 20px;
		width: 180px;
		font-weight: 600;
		font-size: 1.0rem;
	   }
	   .form-control[readonly]{
	   background-color: #ffffff;
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
                <div class="container">
                	<!-- main start -->
                	<div id="main">
                		<div class="card card-dark">
                			<div class="card-header">
                			</div>
                			<div class="d-flex">
	                			<h1 class="title ml-4 mt-3">공지사항 조회</h1>
	                			<div class="ml-auto mr-4 mt-2">
				               		<h6>작성일 : <fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></h6>
				                	<h6>작성자 : ${notice.mid}</h6>
	                			</div>
                			</div>
                			<hr>
                			<div class="card-body">
							  	<div class="row p-2">
							    	<div class="col-2 d-flex justify-content-end">
							    		<span style="font-size: 18px;">공개 대상</span>
							    	</div>
							    	<div class="col-9">
						    		<img src="resources/img/multiple-users.png" class="checkboxIcon"/>
							    	<c:if test="${notice.userShow == 'Y'}">
								    	<span class="mr-1">고객</span>
							    	</c:if>
							    	<c:if test="${notice.devShow == 'Y'}">
								    	<span class="mr-1">개발자</span>
							    	</c:if>
							    	<c:if test="${notice.testerShow == 'Y'}">
								    	<span class="mr-1">테스터</span>
							    	</c:if>
							    	<c:if test="${notice.userTesterShow == 'Y'}">
								    	<span class="mr-1">품질검토자</span>
							    	</c:if>
							    	<c:if test="${notice.distributorShow == 'Y'}">
								    	<span class="mr-1">배포담당자</span>
							    	</c:if>
							    	</div>
							  	</div>
							  	<div class="row p-2">
							    	<div class="col-2 d-flex justify-content-end">
							    		<span style="font-size: 18px;">제목</span>
							    	</div>
							    	<input type="text" class="form-control boxed col-9" value="${notice.noticeTitle}" readonly/>
							  	</div>
							    <div class="row p-2">
							    	<div class="col-2 d-flex justify-content-end">
							    		<span style="font-size: 18px;">내용</span>
							    	</div>
							    	<textarea class="form-control boxed col-9" rows="13" readonly>${notice.noticeContent}</textarea>
							    </div>
							  	<div class="row p-2">
							  		<div class="col-2 d-flex justify-content-end">
							    		<span style="font-size: 18px;">첨부파일</span>
							    	</div>
							  		<div class="col-9">
							    		<c:forEach var="noticeFile" items="${notice.fileList}">
							    			<div>
								    			<a href="${pageContext.request.contextPath}/noticefiledownload?fno=${noticeFile.fno}">${noticeFile.fileName}</a>
							    			</div>
							    		</c:forEach>
						    		</div>
							  	</div>
							  	<div class="d-flex justify-content-end">
								  	<a href="${pageContext.request.contextPath}/noticelist" class="btn btn-sm btn-primary">목록</a>
								  	<c:if test="${member.mid == notice.mid}">
								  		<a href="${pageContext.request.contextPath}/noticeupdateform?nno=${notice.nno}" class="btn btn-sm btn-info mx-2">수정</a>
								  		<a href="${pageContext.request.contextPath}/noticedelete?nno=${notice.nno}" class="btn btn-sm btn-danger">삭제</a>
								  	</c:if>
							  	</div>
                			
                			</div> <!-- card-body end -->
                		</div>
	                	
				  	</div>
                	<!-- main end -->
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
