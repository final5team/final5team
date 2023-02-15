<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
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
                <div class="d-flex flex-column vh-100">
					<div class="flex-grow-1 container-fluid">
						<div class="row h-100">
							<div class="col-md-4 bg-dark text-white p-3"><%@ include file="/WEB-INF/views/common/menu.jsp" %></div>
							<div class="col-md-8 p-2">
								<div class="card m-2">
									<div class="card-header">
										공지사항 목록
									</div>
									<div class="card-body">
										<table class="table table-sm table-bordered">
											<tr>
												<th style="width:30px">공지사항 번호</th>
												<th style="width:300px">제목</th>
												<th style="width:70px">작성자</th>
												<th style="width:70px">작성일</th>
											</tr>
											
<%-- 											<c:forEach var="board" items="${boards}">
												<tr>
													<td></td>
													<td></td>
													<td></td>
													
												</tr>
												</c:forEach> --%>
											
											<%-- <tr>
												<td colspan="4" class="text-center">
													<div>
														<a class="btn btn-outline-primary btn-sm" href="list?pageNo=1">처음</a>
														<c:if test="${pager.groupNo>1}">
															<a class="btn btn-outline-info btn-sm" href="list?pageNo=${pager.startPageNo-1}">이전</a>
														</c:if>
														
														<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
															<c:if test="${pager.pageNo != i}">
																<a class="btn btn-outline-success btn-sm" href="list?pageNo=${i}">${i}</a>
															</c:if>
															<c:if test="${pager.pageNo == i}">
																<a class="btn btn-danger btn-sm" href="list?pageNo=${i}">${i}</a>
															</c:if>
														</c:forEach>
														
														<c:if test="${pager.groupNo<pager.totalGroupNo}">
															<a class="btn btn-outline-info btn-sm" href="list?pageNo=${pager.endPageNo+1}">다음</a>
														</c:if>
														<a class="btn btn-outline-primary btn-sm" href="list?pageNo=${pager.totalPageNo}">맨끝</a>
													</div>
												</td>
											</tr> --%>
										</table>

										<!-- PM일 때만 출력 -->
										<div class="mt-2">
											<a href="#" class="btn btn-sm btn-info">공지사항 작성</a>
										</div>
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

</html>



