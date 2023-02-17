<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/common/head.jsp"%>
<style>
        *{
            font-size: 14px;
        }
        .body {
            line-height: 1.5em;
            margin: 0px
            font-weight: 300;
            justify-content: center;
            align-items: center;
            
        }

        a {
            text-decoration: none;
        }

        form {
            width: 700px;
            margin-bottom: 10px;
        }

        .card-header {
            margin-left: 20px;
            align-items: center;
        }
        .card-body{
            margin: 10px;
        }

        #reqContent {
            width: inherit;
            height: 200px;
            border-radius: 5px;
        }
        #privacy{
            text-align: center;
            
        }
        #privacy .label{
            width: 80px;
            display: inline-block;
            align-items: center;
            margin-top: 5px;
        }
        #privacy .right{
            margin-left: 30%;
            
        }
        #privacy input {
            width: 150px;
        }
        .write{
            margin: 15px 15px;
        }
        #reqTitle{
            width: 670px;
        }


    </style>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/WEB-INF/views/common/topbar.jsp"%>
				<!-- End of Topbar -->

				<!-- 여기에 내용 담기 start -->
				<div class="container-fluid">
                    <div class="row" style="justify-content: center;">

                        <div class="card shadow h-100 py-2">
                            <div class="card-header">
                                <div>SR 요청 작성</div>
                            </div>
                            <div class="card-body">
                                <form method="post">
                                    <div id="privacy">
                                        <div class="form-group row">
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <div class="row">
                                                    <div class="label">작성자</div>
                                                    <input type="text" class="form-control form-control-user"
                                                        id="clientName" name="clientName" value="default">
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <div class="row">
                                                    <div class="label right">전화번호</div>
                                                    <input type="text" class="form-control form-control-user" id="phone"
                                                        name="phone" value="010-1234-1234">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <div class="row">
                                                    <div class="label">직급</div>
                                                    <input type="text" class="form-control form-control-user"
                                                        id="position" name="position" placeholder="직급" value="직급">
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <div class="row">
                                                    <div class="label right">소속기관</div>
                                                    <input type="text" class="form-control form-control-user" id="organ"
                                                        name="organ" placeholder="소속기관" value="소속기관">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <div class="row">
                                                    <div class="label">이메일</div>
                                                    <input type="text" class="form-control form-control-user" id="email"
                                                        name="email" placeholder="이메일" value="email@oti.com">
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <div class="row">
                                                    <div class="label right">완료 희망일</div>
                                                    <input type="date" class="form-control form-control-user"
                                                        id="reqExpectDate" name="reqExpectDate">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <hr>
                                    <br>
                                    <div class="write">
                                        <div class="header">
                                            <div>요청 제목</div>
                                            <input type="text" id="reqTitle" name="reqTitle" value="제목">
                                        </div>
                                        <br>
                                        <div class="writebody">
                                            <div class="form-group row">
                                                <div class="col mb-3 mb-sm-0">
                                                    <div>요청내역</div>
                                                    <textarea id="reqContent" name="reqContent"></textarea>
                                                </div>
                                                <div class="input-group mb-3">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"
                                                            id="inputGroupFileAddon01">File</span>
                                                    </div>
                                                    <div class="custom-file">
                                                        <input type="file" class="custom-file-input"
                                                            id="inputGroupFile01"
                                                            aria-describedby="inputGroupFileAddon01"> <label
                                                            class="custom-file-label" for="inputGroupFile01">
                                                            첨부파일</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>


</body>

</html>
