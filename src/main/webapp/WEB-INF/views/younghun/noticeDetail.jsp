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
               		<h6>작성일 : 2023-02-16</h6>
                	<h6>작성자 : 송영훈</h6>
               		<hr/>
 
                	<div class="row p-2">
				    	<div class="col-2">시스템</div>
				    	<input type="text" class="form-control col-10" value="가족관계정보시스템" readonly/>
				  	</div>
				  	<div class="row p-2">
				    	<div class="col-2">공개 설정</div>
				    	<div class="col-10">
					    	<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">개발자</span>
					    	<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">테스터</span>
					    	<img src="resources/img/checkbox.png" class="checkboxIcon"/>
					    	<span class="mr-1">배포담당자</span>
				    	</div>
				  	</div>
				  	<div class="row p-2">
				    	<div class="col-2">제목</div>
				    	<input type="text" class="form-control col-10" value="가족관계정보시스템 관련 개발/배포담당자 업무 시 참고사항" readonly/>
				  	</div>
				    <div class="row p-2">
				    	<div class="col-2">내용</div>
				    	<textarea class="form-control col-10" rows="10" readonly>참고사항</textarea>
				    </div>
				  	<div class="row p-2">
				    	<div class="col-2">첨부파일 등록</div>
				    	<!-- 다운로드 파일 리스트 -->
				    	<div class="col-10">
				    		<div>
					    		<a href="">songyounghun.jpg</a>
					    		<a href="" class="ml-2">
					    			<img src="resources/img/lookahead.png" class="lookaheadicon"/>
					    		</a>
				    		</div>
				    		<div>
					    		<a href="">janghyun.pptx</a>
					    		<a href="" class="ml-2">
					    		</a>
				    		</div>
				    		<div>
					    		<a href="">jisung.mpg</a>
					    		<a href="" class="ml-2">
					    		</a>
				    		</div>
				    		<div>
					    		<a href="">jiyoung.hwp</a>
					    		<a href="" class="ml-2">
					    		</a>
				    		</div>
				    	</div>
				  	</div>
				  	<a href="" class="btn btn-sm btn-primary">공지사항 목록</a>
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
