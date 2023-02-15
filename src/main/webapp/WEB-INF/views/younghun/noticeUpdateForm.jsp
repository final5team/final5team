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
										게시물 수정하기
									</div>
									<div class="card-body">	
										<input type="hidden" class="form-control" id="bno" name="bno" value="${notice.nno}"> 							
										<div>
											<input type="text" class="form-control" id="btitle" name="btitle" value="${board.btitle}"> 
										</div>
										<div>
											<textarea rows="5" cols="50" id="bcontent" name="bcontent" class="form-control">${board.bcontent}</textarea>
										</div>
										<div>
											<input type="text" class="form-control" id="bwriter" name="mid" value="${board.mid}" readonly> 
										</div>
										<div>
											<label for="battach">Attach</label> 
											<input type="file" class="form-control" id="battach" name="battach"> 
										</div>
										<button type="submit" class="btn btn-info btn-sm">게시물 수정</button>
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
