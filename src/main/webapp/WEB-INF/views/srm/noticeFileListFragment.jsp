<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="noticeFile" items="${noticeFileList}">
  	<a href="${pageContext.request.contextPath}/noticefiledownload?fno=${noticeFile.fno}">${noticeFile.fileName}</a>
  	<button class="btn btn-sm btn-primary" onclick="deleteNoticeFile(${noticeFile.fno}, ${noticeFile.nno})">파일 삭제</button>
</c:forEach>