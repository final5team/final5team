<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


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
<div class="container-fluid">

	<div class="card">
		<div class="card-body">
			<!-- form 태그 시작 -->	
			<form name="item">
				<div class="card card-block">
			
					<div class="form-group row">
						<label class="col-sm-2 form-control-label text-xs-right">
							Name:
						</label>
						<div class="col-sm-10">
							<input type="text" class="form-control boxed" placeholder="">
						</div>
					</div>
			
					<div class="form-group row">
						<label class="col-sm-2 form-control-label text-xs-right">
							Content:
						</label>
						<div class="col-sm-10">
			
								Hello World
			
						</div>
					</div>
			
					<div class="form-group row">
						<label class="col-sm-2 form-control-label text-xs-right">
							Category:
						</label>
						<div class="col-sm-10">
							<select class="c-select form-control boxed">
								<option selected>Select Category</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
					</div>
			
			
					<div class="form-group row">
						<div class="col-sm-10 col-sm-offset-2">
							<button type="submit" class="btn btn-secandary">
								Cancle
							</button>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-10 col-sm-offset-2">
							<button type="submit" class="btn btn-primary">
								Submit
							</button>
						</div>
					</div>
			
			
			
			
				</div>
			</form>                
			<!-- form 태그 끝 -->	
		
		
		
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
