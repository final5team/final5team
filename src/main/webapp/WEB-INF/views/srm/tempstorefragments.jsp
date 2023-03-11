<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row mt-3">
	<div class="col-2 label">첨부파일</div>
	<div class="col-8 p-2">
		<c:forEach var="statusHistoryFile" items="${devTemp.fileList}">
			<div>
				<span>${statusHistoryFile.fileName}</span> 
				<a class="existfiles" href="${pageContext.request.contextPath}/filedouwnload/${statusHistoryFile.fno}" role="button"> <i class="fas fa-cloud-download-alt text-info"></i></a>
				<a class="deletefileButton"><i class="fas fa-times ml-1"></i></a> 
				<input type="hidden" name="fno" value="${statusHistoryFile.fno}">
			</div>
		</c:forEach>
	</div>
</div>
<div class="row mb-3 mt-1">
	<div class="col-2 label label-write">
		<div class="btn btn-sm btn-info" id="btn-upload-update">파일 수정</div>
		<input type="file" name="files" id="fileInputUpdate" multiple
			style="display: none;">
	</div>
	<div class="border flex-grow-1 col-8" id="file-list-update"></div>
</div>


