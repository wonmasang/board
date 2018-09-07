<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<style type="text/css">
#listDiv {
	width: 800px;
}
#listTable {
	width: 100%;
	text-align: center;
	border: 1px solid;
	border-collapse: collapse;
}
th, td {
	border: 1px solid;
	height: 30px;
}

</style>

<title>Insert title here</title>
</head>
<body>

<div>

<h1>게시글 검색 리스트 페이지</h1>
<hr>

<div id="listDiv">
	<table id="listTable">
		<colgroup>
			<col width="10%">
			<col width="40%">
			<col width="20%">
			<col width="20%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${search }" var="searchList">
				<tr>
					<td>${searchList.boardNo }</td>
					<td><a href="/board/listView.do?boardNo=${searchList.boardNo }"> ${searchList.title }</a></td>
					<td>${searchList.writer }</td>
					<td><fmt:formatDate value="${searchList.reg_date }" pattern="yyyy-MM-dd"/></td>
					<td>${searchList.hit }</td>
				</tr>
			</c:forEach>
		</tbody>
				
	</table>
	
	<center>
	<form action="/board/search.do" method="POST">
		<select id="searchSelect" name="searchSelect">
			<option selected="selected">제목</option>
			<option>내용</option>
			<option>작성자</option>
		</select>
		<input type="text" id="keyword" name="keyword" />
		<button>검색</button>
	</form>	
	</center>
	
	
	<br><br>
	<a href="/board/write.do"><button>글쓰기</button></a>
	<a href="/board/list.do"><button>목록</button></a>
	
</div>

</div>

</body>
</html>