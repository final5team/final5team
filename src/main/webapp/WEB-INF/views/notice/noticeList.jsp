<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style>
     #noticelist{
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
                <div id="noticelist" class="container">
                	<h1>공지사항 목록</h1>
                	<a href="${pageContext.request.contextPath}/noticewriteform" class="btn btn-sm btn-primary">공지사항 작성</a>
               		<hr/>
                	<table class="table">
					  <thead class="thead-light">
					    <tr>
					      <th scope="col">글번호</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성일</th>
					      <th scope="col">작성자</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">1</th>
					      <td>가족관계시스템 전체 담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">2</th>
					      <td>전자조달시스템 개발자/배포담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">3</th>
					      <td>전파관리시스템 테스터 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">4</th>
					      <td>가족관계시스템 전체 담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">5</th>
					      <td>전자조달시스템 개발자/배포담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">6</th>
					      <td>가족관계시스템 전체 담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">7</th>
					      <td>전자조달시스템 개발자/배포담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">8</th>
					      <td>전파관리시스템 테스터 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">9</th>
					      <td>가족관계시스템 전체 담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					    <tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail"'>
					      <th scope="row">10</th>
					      <td>전자조달시스템 개발자/배포담당자 필독</td>
					      <td>2023-02-16</td>
					      <td>송영훈</td>
					    </tr>
					  </tbody>
					</table>
					<nav class="nav justify-content-center" aria-label="Page navigation example">
					  <ul class="pagination">
					    <li class="page-item"><a class="page-link" href="#">처음</a></li>
					    <li class="page-item"><a class="page-link" href="#">이전</a></li>
					    <li class="page-item"><a class="page-link" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item"><a class="page-link" href="#">4</a></li>
					    <li class="page-item"><a class="page-link" href="#">5</a></li>
					    <li class="page-item"><a class="page-link" href="#">다음</a></li>
					    <li class="page-item"><a class="page-link" href="#">끝</a></li>
					  </ul>
					</nav>
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


