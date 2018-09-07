<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">


function searchFrom() {
	var blank_patten = /[\s]/g;
	var key = $("#keyword").val();
	
		if( blank_patten.exec(key) ) {
			alert("검색어를 다시 입력 해 주세요.");
			$("#keyword").focus();
			return false;
		}else if( key == "" || key == null ){
			alert("검색어를 입력 해 주세요.");
			$("#keyword").focus();
			
			return false;
		}else {
			return true;
		}
	
};


function listExcelDown() {
	location.href="/board/excelTransform.do?target=List";
};

function searchListExcelDown() {
	var search = "${searchSelected }";
	var key = "${searchKeyword }";
	alert(search);
	alert(key);
	location.href="/board/excelTransform.do?target=searchList&searchSelect="+search+"&keyword="+key;
};


</script>

<style type="text/css">
#listDiv {
	width: 800px;
	height: 600px;
	word-break:break-all;
	font-family: '맑은고딕';
}
#listTable {
	width: 100%;
	text-align: center;
	border: 1px solid;
	border-collapse: collapse;
	table-layout: fixed;
}
#searchDiv {
	margin-top: 10px;
}
#searchSelect, #keyword, #btnSearch {
	vertical-align: middle;
}
#searchSelect {
	height: 21px;
}
#listTitle {
	text-align: left;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
#listWriter {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
#titleAtag {
	margin-left: 15px;
	white-space: pre;
}
#listExcelDown {
	margin-bottom: 10px;
	float: right;
}
#searchListExcelDown {
	margin-bottom: 10px;
}

/* pre { */
/* 	overflow: hidden; */
/* 	text-overflow: ellipsis; */
/* 	margin-top: 0px; */
/* 	margin-bottom: 0px; */
/* 	font-family: '맑은고딕'; */
/* } */
th {
	border: 1px solid;
	padding: 0;
 	height: 30px;
}
td {
	border: 1px solid;
	padding: 0;
 	height: 40px;
}
p {
	margin: 0;
}
a {
	text-decoration: none;
}

</style>

<title>Insert title here</title>
</head>
<body>

<div>

<h1>게시글 리스트 페이지</h1>
<hr>

<div id="listDiv">
	<div>
		<c:if test="${ empty searchKeyword }">
			<button id="listExcelDown" name="listExcelDown" onclick="listExcelDown();">엑셀다운로드</button>
		</c:if>
		<c:if test="${ searchKeyword ne null and searchKeyword ne ''  }">
			<button id="searchListExcelDown" name="searchListExcelDown" onclick="searchListExcelDown();">엑셀다운로드</button>
		</c:if>
	</div>
	
	<table id="listTable">
		<colgroup>
			<col width="8%">
			<col width="*">
			<col width="15%">
			<col width="15%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
<%-- 		<c:if test="${empty list }"> --%>
<!-- 			<tr> -->
<!-- 				<td colspan="5">데이타가 없습니다	</td> -->
<!-- 			</tr> -->
<%-- 		</c:if>	 --%>
<%-- 		<c:if test="${!empty list }"> --%>
			<c:forEach items="${list }" var="list">
				<tr>
					<td>
					<c:choose>
						<c:when test="${searchKeyword ne null and searchKeyword ne '' }">
							${list.pnum }
						</c:when>
						<c:otherwise>
							<c:if test="${list.depth == 0 }">
								${list.rank }
							</c:if>
						</c:otherwise>
					</c:choose>	
					</td>
					<td id="listTitle">
					<c:choose>
						<c:when test="${list.del == 0}">
							<c:if test="${list.depth > 0 }">
								<c:forEach begin="1" end="${list.depth }">
									&nbsp;&nbsp;
								</c:forEach>
								<span style="color: fuchsia;">└ RE :</span>
							</c:if>
								
								<c:choose>
									<c:when test="${fn:length(list.title) > 25 }">
										<a id="titleAtag" href="/board/listView.do?boardNo=${list.boardNo }&rank=${list.rank }&commentCount=${list.commentCount }"><c:out value="${fn:substring(list.title,0,24) }"></c:out>....</a>
									</c:when>
									<c:otherwise>
										<span><a id="titleAtag" href="/board/listView.do?boardNo=${list.boardNo }&rank=${list.rank }&commentCount=${list.commentCount }"><c:out value="${list.title }"></c:out></a></span>
									</c:otherwise>
								</c:choose>
								
							<c:if test="${list.commentCount > 0 }">
								<span style="color: red;">(${list.commentCount })</span>
							</c:if>
							<c:if test="${list.fileCount > 0 }">
								<img src="/resources/img/fileimg.png" style="width: 15px; vertical-align: middle;">
							</c:if>
						</c:when>
						<c:when test="${list.del == 1}">
							<c:if test="${list.depth > 0 }">
								<c:forEach begin="1" end="${list.depth }">
										&nbsp;&nbsp;
								</c:forEach>
							<span style="color: fuchsia;">└ RE :</span>
							</c:if>
							<span style="margin-left: 15px; color: red; text-decoration: line-through; font-size: 13px;">삭제된 글 입니다.</span>
						</c:when>
						
					</c:choose>
					</td>
					<td id="listWriter"><c:out value="${list.writer }"></c:out></td>
					<td><fmt:formatDate value="${list.reg_date }" pattern="yyyy-MM-dd"/></td>
					<td>${list.hit }</td>
				</tr>
			</c:forEach>
<%-- 		</c:if> --%>
		</tbody>
				
	</table>
	
	<div id="searchDiv">
		<center>
			<form action="/board/list.do" method="POST" onsubmit="return searchFrom();">
				<select id="searchSelect" name="searchSelect">
					<option value="title" selected="selected">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
				<input type="text" id="keyword" name="keyword" autocomplete="off" />
				<button id="btnSearch">검색</button>
			</form>	
		</center>
	</div>
	
<%-- 	<c:if test="${!empty list }"> --%>
		<center>
			<div>
				<jsp:include page="/WEB-INF/views/util/paging.jsp" />
			</div>
		</center>
<%-- 	</c:if> --%>
	
	<br><br>
	<c:if test="${searchKeyword ne null and searchKeyword ne '' }">
		<a href="/board/list.do"><button>목록</button></a>
	</c:if>
	<a href="/board/write.do"><button style="float: right;">글쓰기</button></a>
	
	
</div>

</div>

</body>
</html>