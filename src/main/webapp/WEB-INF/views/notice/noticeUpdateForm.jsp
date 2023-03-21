<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
     <script src="${pageContext.request.contextPath}/resources/vendor/tinymce/tinymce.min.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/js/tinymceinit.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/vendor/tinymce/themes/silver/theme.min.js"></script>    
    
    <style>
	.label{
		text-align :center;
		padding: 0 20px;
		width: 180px;
		font-weight: 600;
		font-size: 1.0rem;
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
                	<div id="main">
                		<div class="title-block">
                	 		<h3 class="title">공지사항 수정</h3>
                	 	</div>
                		<div class="card border-top-primary mb-4">
                			<div class="card-block">
				                <form action="${pageContext.request.contextPath}/noticeupdate" method="post" enctype="multipart/form-data">
				                	<input type="hidden" name="nno" value="${notice.nno}"/>
								  	<div class="form-group row">
								    	<div class="col-2 label">공개 대상</div>
								    	<div class="form-group col-8">
									    	<div class="form-check form-check-inline">
									    		<span class="mr-2">시스템 사용자(고객)</span>
									    		<input type="checkbox" class="form-check-input" id="userShow" name="userShow" value="Y"
									    			<c:if test="${notice.userShow == 'Y'}">checked</c:if>>
										    	<label class="form-check-label mr-4" for="userShow"></label>
									    	</div>
									    	<div class="form-check form-check-inline">
									    		<span class="mr-2">개발자</span>
									    		<input type="checkbox" class="form-check-input" id="devShow" name="devShow" value="Y"
									    			<c:if test="${notice.devShow == 'Y'}">checked</c:if>>
										    	<label class="form-check-label mr-4" for="devShow"></label>
									    	</div>
									    	<div class="form-check form-check-inline">
									    		<span class="mr-2">테스터</span>
									    		<input type="checkbox" class="form-check-input" id="testerShow" name="testerShow" value="Y"
									    			<c:if test="${notice.testerShow == 'Y'}">checked</c:if>>
										    	<label class="form-check-label mr-4" for="testerShow"></label>
									    	</div>
									    	<div class="form-check form-check-inline">
									    		<span class="mr-2">배포담당자</span>
									    		<input type="checkbox" class="form-check-input" id="distributorShow" name="distributorShow" value="Y"
									    			<c:if test="${notice.distributorShow == 'Y'}">checked</c:if>> 
										    	<label class="form-check-label mr-4" for="distributorShow"></label>
									    	</div>
									    	<div class="form-check form-check-inline">
									    		<span class="mr-2">품질검토자</span>
									    		<input type="checkbox" class="form-check-input" id="userTesterShow" name="userTesterShow" value="Y"
									    			<c:if test="${notice.userTesterShow == 'Y'}">checked</c:if>>
										    	<label class="form-check-label" for="userTesterShow"></label>
									    	</div>
									  	</div>
								  	</div>
								  	<div class="form-group row">
								    	<label for="noticeTitle" class="col-2 label">제목</label>
								    	<input type="text" class="form-control col-8" id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}">
								    	<small id="" class="form-text text-muted"></small>
								  	</div>
								    <div class="form-group row">
								    	<label for="noticeContent" class="col-2 label">내용</label>
								    	<textarea class="form-control col-8 noticeContent" name="noticeContent">${notice.noticeContent}</textarea>
								    </div>
								    <div class="row p-2">
								    	<div class="col-2 label">기존 첨부파일</div>
								    	<div class="col-8" id="fileContainer">
								    		<c:forEach var="noticeFile" items="${notice.fileList}">
								    			<div>
								    				<a href="${pageContext.request.contextPath}/noticefiledownload?fno=${noticeFile.fno}">${noticeFile.fileName}</a>
								    				<input type="hidden" value="${noticeFile.fno}"/>
								    				<button type="button" class="btn btn-sm btn-white deletefilebutton">
								    					<img src="${pageContext.request.contextPath}/resources/img/deleteicon.png"
								    					style="width:25px; height:25px"/>
								    				</button>
							    				</div>
							    			</c:forEach>
								    	</div>
								    </div>
								    
								  	<div class="form-group row p-2">
								    	<label for="files" class="col-2 label">첨부파일 등록</label>
								    	<input type="file" multiple class="form-control-file col-10" id="files" name="files">
								  	</div>
								  	<div class="form-group row">
								    	<a href="${pageContext.request.contextPath}/noticedetail?nno=${notice.nno}" class="btn btn-dark" style="margin-left : 87%">취소</a>
							    		<button type="submit" class="btn btn-primary ml-3">
							    			등록
							    		</button>
								  	</div>  	
								</form>
							</div>
                		</div>
                	</div>
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
    
    <script>
    	$('.deletefilebutton').click(function(){
    		var fno = $(this).prev().val();
    		var deleteDiv = $(this).parent();
    		$.ajax({
    			type: "POST", //요청 메소드 방식
    			url:"${pageContext.request.contextPath}/noticefiledelete?fno=" + fno,
    			dataType:"json", 
    			success : function(result){
    				deleteDiv.remove();
    			}
    		})
    	}
    );
    </script>

</body>


