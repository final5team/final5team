<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
     #writeform{
     	margin-top : 50px;
     	padding : 40px;
     	width : 90%;
     	background-color : white;
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
                <div id="writeform" class="container">
                	<h1 class="">공지사항 작성</h1>
               		<hr/>
	                <form action="" method="post" enctype="multipart/form-data">
	                	<div class="form-group row">
					    	<label for="systems" class="col-2">시스템</label>
					    	<select class="form-control col-10" id="sno" name="sno">
					      		<option value="1">가족관계정보</option>
					      		<option value="2">전자조달</option>
					      		<option value="3">국민취업지원제도</option>
					      		<option value="4">나라장터</option>
					      		<option value="5">전파관리</option>
					    	</select>
					  	</div>
					  	<div class="form-group row">
					    	<div class="col-2">공개 설정</div>
					    	<div class="form-group col-10">
						    	<div class="form-check form-check-inline">
						    		<input type="checkbox" class="form-check-input" id="userShow" name="userShow" value="Y">
							    	<label class="form-check-label mr-4" for="userShow">시스템 사용자(고객)</label>
						    	</div>
						    	<div class="form-check form-check-inline">
						    		<input type="checkbox" class="form-check-input" id="devShow" name="devShow" value="Y">
							    	<label class="form-check-label mr-4" for="devShow">개발자</label>
						    	</div>
						    	<div class="form-check form-check-inline">
						    		<input type="checkbox" class="form-check-input" id="testerShow" name="testerShow" value="Y">
							    	<label class="form-check-label mr-4" for="testerShow">테스터</label>
						    	</div>
						    	<div class="form-check form-check-inline">
						    		<input type="checkbox" class="form-check-input" id="distributorShow" name="distributorShow" value="Y"> 
							    	<label class="form-check-label mr-4" for="distributorShow">배포담당자</label>
						    	</div>
						    	<div class="form-check form-check-inline">
						    		<input type="checkbox" class="form-check-input" id="userTesterShow" name="userTesterShow" value="Y">
							    	<label class="form-check-label" for="userTesterShow">유저테스터</label>
						    	</div>
						  	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="noticeTitle" class="col-2">제목</label>
					    	<input type="text" class="form-control col-10" id="noticeTitle" name="noticeTitle">
					    	<small id="" class="form-text text-muted"></small>
					  	</div>
					    <div class="form-group row">
					    	<label for="noticeContent" class="col-2">내용</label>
					    	<textarea class="form-control col-10" rows="10" id="noticeContent" name="noticeContent"></textarea>
					    </div>
					  	<div class="form-group row">
					    	<label for="files" class="col-2">첨부파일</label>
					    	<input type="file" multiple class="form-control-file col-10" id="files">
					  	</div>
					  	<div class="form-group row">
					    	<a href="#" class="btn btn-danger" style="margin-left : 87%">취소</a>
				    		<button type="submit" class="btn btn-primary ml-3">등록</button>
					  	</div>  	
					</form>
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

