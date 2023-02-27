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
                	<c:if test="${member.mtype == 'pm'}">
                		<a href="${pageContext.request.contextPath}/noticewriteform" class="btn btn-sm btn-dark">공지사항 작성</a>
                	</c:if>
                	<form class="form-group form-inline mt-2" action="${pageContext.request.contextPath}/noticelist" method="get">
					    <label for="searchType"></label>
					    <select class="form-control" id="searchType" name="searchType">
					        <option value="제목" <c:if test="${searchType == '제목'}">selected</c:if>>제목</option>
					        <option value="작성자" <c:if test="${searchType == '작성자'}">selected</c:if>>작성자</option>
					    </select>
					    <input type="text" class="form-control ml-2" name="searchWord" value="${searchWord}"/>
					    <button type="submit" class="btn btn-dark btn-sm ml-2">검색</button>
					</form>
               		<hr/>
                	<table class="table">
					  <thead class="thead" style="background-color:white; color:black">
					    <tr>
					      <th scope="col">글번호</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성일</th>
					      <th scope="col">작성자</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach var="notice" items="${noticeList}">
						  	<tr class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail?nno=${notice.nno}"'>
						       <th scope="row">${notice.nno}</th>
						       <td>${notice.noticeTitle}</td>
						       <td><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></td>
						       <td>${notice.mid}</td>
						    </tr>
					  	</c:forEach>
					  </tbody>
					</table>
					<nav class="nav justify-content-center" aria-label="Page navigation example">
					  <div class="pagination">
					    <a class="btn btn-outline-primary btn-sm" 
					    	href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=1">처음</a>
						<c:if test="${pager.groupNo > 1}">
							<a class="btn btn-outline-info btn-sm" 
							href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${pager.startPageNo-1}">이전</a>
						</c:if>
						
						<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
							<c:if test="${pager.pageNo != i}">
								<a class="btn btn-outline-success btn-sm" 
								href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${i}">${i}</a>
							</c:if>
							<c:if test="${pager.pageNo == i}">
								<a class="btn btn-danger btn-sm" 
								href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${i}">${i}</a>
							</c:if>
						</c:forEach>
						
						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<a class="btn btn-outline-info btn-sm" 
							href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${pager.endPageNo+1}">다음</a>
						</c:if>
						<a class="btn btn-outline-primary btn-sm" 
						href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${pager.totalPageNo}">맨끝</a>
					  </div>
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


