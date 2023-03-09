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
                <div class="container">
               		 <div id="main">
               		 	<div class="card border-left-dark" style="height:700px;">
               		 		<div class="title-block d-flex">
               		 			<h2 class="font-weight-bold"  style="display: inline-block">공지사항 목록</h2>
               		 		</div>
               		 		<div class="d-flex px-4 justify-content-end">
               		 			<form class="form-group form-inline mt-2 " action="${pageContext.request.contextPath}/noticelist" method="get">
								    <label for="searchType"></label>
								    <select class="form-control boxed p-0" id="searchType" name="searchType">
								        <option value="제목" <c:if test="${searchType == '제목'}">selected</c:if>>제목</option>
								        <option value="작성자" <c:if test="${searchType == '작성자'}">selected</c:if>>작성자</option>
								    </select>
								    <input type="text" class="form-control boxed ml-2 p-0" name="searchWord" value="${searchWord}"/>
								    <button type="submit" class="btn btn-md btn-primary ml-2">검색</button>
								</form>
	               		 		<c:if test="${member.mtype == 'pm'}">
	               		 			<div class="pt-2 mx-3">
				                		<a href="${pageContext.request.contextPath}/noticewriteform" class="btn btn-md btn-primary">글작성</a>
	               		 			</div>
			                	</c:if>
               		 		</div>
               		 		<div class="card-body">
               		 			<div style="height: 470px;">
               		 				<table class="table table-hover table-striped">
									  <thead class="thead" style="background-color:#3A4651; color:white">
									    <tr style="text-align: center;">
									      <th scope="col">글번호</th>
									      <th scope="col">제목</th>
									      <th scope="col">작성일</th>
									      <th scope="col">작성자</th>
									    </tr>
									  </thead>
									  <tbody>
									  	<c:forEach var="notice" items="${noticeList}">
										  	<tr style="text-align: center;" class="classHover colored" onclick='location.href="${pageContext.request.contextPath}/noticedetail?nno=${notice.nno}"'>
										       <th scope="row">${notice.nno}</th>
										       <td>${notice.noticeTitle}</td>
										       <td><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></td>
										       <td>${notice.mid}</td>
										    </tr>
									  	</c:forEach>
									  </tbody>
									</table>
               		 			</div>	
								<div class="pager default mt-2">
									<div class="pagingButtonSet d-flex justify-content-center">
										<a href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=1" class="btn btn-muted shadow">처음</a>
										<c:if test="${pager.groupNo > 1}">
											<a href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${pager.startPageNo-1}" class="btn btn-muted shadow">이전</a>
						
										</c:if>
						
										<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
											<c:if test="${pager.pageNo != i}">
												<a href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${i}" type="button" class="btn btn-white shadow">${i}</a>
											</c:if>
											<c:if test="${pager.pageNo == i}">
												<a href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${i}" type="button" class="btn btn-dark shadow">${i}</a>
											</c:if>
										</c:forEach>
						
										<c:if test="${pager.groupNo < pager.totalGroupNo }">
											<a href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${pager.endPageNo+1}" type="button" class="btn btn-muted shadow">다음</a>
						
										</c:if>
										<a href="${pageContext.request.contextPath}/noticelist?searchType=${searchType}&searchWord=${searchWord}&pageNo=${pager.totalPageNo}" type="button" class="btn btn-muted shadow">맨끝</a>
									</div>
								</div>	
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

</body>


