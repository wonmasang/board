<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

<div class="paging text-center">
		<%-- 첫 페이지 버튼 --%>
		<%-- 첫 페이지가 아니면 버튼 노출 --%>
		<c:if test="${paging.curPage ne 1 }">
			<a href="/board/list.do?curPage=1&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }">
				<span style="margin-right: 10px; font-size: 14px;">&larr;처음</span>
			</a>
		</c:if>
		
		
		<%-- 이전 블럭으로 이동하는 버튼 --%>
		<%-- 현재페이지가 1(즉 첫번째 블럭 과 같으면 버튼 노출 안함 --%>
		<c:if test="${paging.curBlock > 1 }">
			<a href="/board/list.do?curPage=${paging.prevBlock }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }">
				<span style="margin-right: 5px; font-size: 14px;">◀이전</span>
			</a>
		</c:if>
		
		<%-- 이전 페이지 버튼 --%>
		<%-- 첫 페이지면 금지 표시 --%>
<%-- 		<c:if test="${paging.curPage eq 1 }"> --%>
<%-- 			<a href="/board/list.do?curPage=${paging.curPage }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" > --%>
<!-- 				<span style="margin-right: 5px; font-size: 18px;">&lt;</span> -->
<!-- 			</a> -->
<%-- 		</c:if> --%>
<%-- 		<c:if test="${paging.curPage ne 1 }"> --%>
<%-- 			<a href="/board/list.do?curPage=${paging.curPage-1 }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" > --%>
<!-- 				<span style="margin-right: 5px; font-size: 18px;">&lt;</span> -->
<!-- 			</a> -->
<%-- 		</c:if> --%>
		
		<%-- 페이징 번호 버튼 --%>
		<c:forEach begin="${paging.startPage }"
			end="${paging.endPage }"
			var="page">
			
			<%-- 페이지 번호가 현재페이지면 빨간색으로 보이기 --%>
			<c:if test="${paging.curPage eq page }">
			<a href="/board/list.do?curPage=${page }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" style="color:red; margin-right: 5px; margin-left: 5px;">${page }</a>
			</c:if>
			<c:if test="${paging.curPage ne page }">
			<a href="/board/list.do?curPage=${page }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" style="margin-right: 5px; margin-left: 5px;">${page }</a>
			</c:if>
			
		</c:forEach>
		
		<%-- 다음 페이지 버튼 --%>
		<%-- 마지막 페이지면 금지 표시 --%>
<%-- 		<c:if test="${paging.curPage eq paging.totalPage }"> --%>
<%-- 			<a href="/board/list.do?curPage=${paging.curPage }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" > --%>
<!-- 				<span style="margin-left: 5px; font-size: 18px;" >&gt;</span> -->
<!-- 			</a> -->
<%-- 		</c:if> --%>
<%-- 		<c:if test="${paging.curPage ne paging.totalPage }"> --%>
<%-- 			<a href="/board/list.do?curPage=${paging.curPage+1 }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" > --%>
<!-- 				<span style="margin-left: 5px; font-size: 18px;">&gt;</span> -->
<!-- 			</a> -->
<%-- 		</c:if> --%>
		
		
		<%-- 다음 블럭으로 이동하는 버튼 --%>
		<%-- 현재페이지가 토탈페이지(전체블럭)과 같으면 버튼 노출 안함 --%>
		<c:if test="${paging.curBlock < paging.totalBlock }">
			<a href="/board/list.do?curPage=${paging.nextBlock }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }" >
				<span style="margin-left: 5px; font-size: 14px;">다음▶</span>
			</a>
		</c:if>
		
		<%-- 끝 페이지로 이동하는 버튼 --%>
		<%-- 마지막 페이지 일시 버튼 안나옴 --%>
		<c:if test="${paging.curPage ne paging.totalPage }">
			<a href="/board/list.do?curPage=${paging.totalPage }&searchSelect=${paging.searchSelect }&keyword=${paging.keyword }">
				<span style="margin-left: 10px; font-size: 14px;">끝&rarr;</span>
			</a>
		</c:if>
</div>