<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

function modifyWindowOpen() {
	
	var url = "/board/modifyPwCheck.do?boardNo=${listView.boardNo}";
	var settings = "width=450px, height=200px, top=100px, left=100px, toolbar=no, menubar=no, scrollbars=no, fullscreen=no";
	var windowObj = window.open(url, '비밀번호 확인', settings);
	
};

function deleteWindowOpen() {
	
	var url = "/board/deletePwCheck.do?boardNo=${listView.boardNo}&parentNo=${listView.parentNo}";
	var settings = "width=450px, height=200px, top=100px, left=100px, toolbar=no, menubar=no, scrollbars=no, fullscreen=no";
	var windowObj = window.open(url, '비밀번호 확인', settings);
	
};

function back() {
	
// 	window.history.go(-1);
	location.href = document.referrer;
	
}

$(function(){
	$("#cmtRpw").keyup(function(){
		
		var pw = $("#cmtRpw").val();
		var blank_patten = /[\s]/g;
		  
		console.log("view"+pw);
		
		if(blank_patten.exec(pw)) {
			$("#comentR").text("");
			$("#comentR").html("( 띄어쓰기는 사용 할 수 없습니다. )");
			return;
		}
		  
		if(pw.length<6||pw.length>16) {
			$("#comentR").text("");
			$("#comentR").html("( 6~16 자리로 만들어 주세요. )");
			return;
		}
			  
		var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,16}$/;
		if(!check.test(pw)) {
			$("#comentR").text("");
			$("#comentR").html("( 영문,숫자,특수문자의 조합으로 입력해 주세요. )");
			return;
		} else if(check.test(pw)) {
			$("#comentR").text("");
			$("#comentR").html("( 비밀번호가 입력되었습니다. )");
			return;
		}
		  
	});  

	//	blur - 포커스아웃 되었을때 
	$("#cmtRpw").blur(function() {
		$("#comentR").text("");
		  
	});
});
// $(document).ready(function() {
	
// 	var content = $("#viewContent").text();
// // 	alert(content);
	
// 	var content2 = content.replace(/&amp;/g,"&");
// // 	alert(content2);
// 	$("#viewContent").text(content2);
	
// });
function gfn_isNull(str) {
    if (str == null) return true;
    if (str == "NaN") return true;
    if (new String(str).valueOf() == "undefined") return true;   
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;   
    if (chkStr.toString().length == 0 ) return true;  
    return false;
}


function downloadFile(b_fileno) {
// 	alert("다운로드시작");
// 	var b_fileno = $("#b_fileno").val();
	console.log("dd"+b_fileno);
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/board/downloadFile.do' />");
	comSubmit.addParam("b_fileno", b_fileno);
	comSubmit.submit();
}

function ComSubmit(opt_formId) {
    this.formId = gfn_isNull(opt_formId) == true ? "formFream" : opt_formId;
    this.url = "";
     
    if(this.formId == "formFream"){
        $("#formFream")[0].reset();
    }
     
    this.setUrl = function setUrl(url){
        this.url = url;
    };
     
    this.addParam = function addParam(key, value){
        $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
        console.log("hh"+value);
    };
     
    this.submit = function submit(){
        var frm = $("#"+this.formId)[0];
        frm.action = this.url;
        frm.method = "post";
        frm.submit();  
    };
}



	

</script>
<style type="text/css">

#viewDiv {
	width: 800px;
	word-break:break-all;
	font-family: '맑은고딕';
}
#viewTable {
	width: 100%;
 	text-align: center;
	border: 1px solid;
	border-collapse: collapse;
	table-layout: fixed;
}
#btnDelete {
	float: right;
}
#btnModify {
	float: right;
	margin-right: 5px;
}
#contentPre {
	font-size: 15px;
 	white-space: pre-wrap;
 	margin-left: 25px;
 	margin-right: 25px;
}
#viewContent {
 	text-align: left;
}
#viewTitle {
	text-align: left;
	padding-left: 6px;
	padding-right: 5px;
}
#preTitle {
	font-size: 20px;
	white-space: pre-wrap;
	margin-top: 0px;
	margin-bottom: 0px;
}
#preWriter {
	font-size: 19px;
	white-space: pre-wrap;
	margin-top: 0px;
	margin-bottom: 0px;
}
pre {
	font-family: '맑은고딕';
}
th, td {
	border: 1px solid;
}
th {
	text-align: center;
	height: 30px;
}
td {
	height: 60px;
}

</style>

<title>Insert title here</title>
</head>
<body>

<div>

<h1>게시글 상세 페이지</h1>
<hr>


<div id="viewDiv">
	<div>
		<a href="/board/reply.do?grp=${listView.grp }&grpord=${listView.grpord }&depth=${listView.depth }&boardNo=${listView.boardNo}">
		<button style="float: right; margin-bottom: 5px;">답글쓰기</button></a>
	</div>
	<table id="viewTable">
		<colgroup>
			<col width="8%">
			<col width="*">
			<col width="15%">
			<col width="12%">
			<col width="8%">
		</colgroup>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tr>
			<td>${rank }</td>
			<td id="viewTitle"><pre id="preTitle"><c:out value="${listView.title }"></c:out></pre></td>
			<td><pre id="preWriter"><c:out value="${listView.writer }"></c:out></pre></td>
			<td><fmt:formatDate value="${listView.reg_date }" pattern="yyyy-MM-dd"/></td>
			<td>${listView.hit }</td>
		</tr>
		<tr>
			<th colspan="5">내용</th>
		</tr>
		<tr>
			<td id="viewContent" colspan="5"><pre id="contentPre"><c:out value="${listView.content }"></c:out></pre></td>
		</tr>
		<tr>
			<th colspan="5" style="text-align: left; padding-left: 20px; background-color: aliceblue">첨부파일</th>
		</tr>
		<tr>
			<td colspan="5" style="text-align: left;">
				<c:forEach items="${fileList }" var="fileList" varStatus="status">
					<input type="hidden" id="b_fileno" name="b_fileno" value="${fileList.b_fileno }">
					
					<p style="margin-left: 30px; margin-top: 8px; margin-bottom: 8px;">
						${status.count }.&nbsp;
						<a href="#" id="fileView" name="fileView" onclick="downloadFile(${fileList.b_fileno });" >
							<c:out value="${fileList.b_original_filename }" />
						</a>
					<c:out value="( ${fileList.file_size_kb } )kb" />
					</p>
				</c:forEach>	
			</td>
		</tr>
	</table>
<%-- 	<c:out value="${listView.content }"></c:out> --%>


	
	<br><br>
	
<!-- 	<button onclick="back();">목록으로</button> -->
	<a href="/board/list.do"><button>목록으로</button></a>
	
	<button id="btnDelete" onclick="deleteWindowOpen();">삭제</button>
	<button id="btnModify" onclick="modifyWindowOpen();">수정</button>
	
	<br><br>
	
	<div style="margin-left: 5px;">
		<jsp:include page="/WEB-INF/views/board/comment.jsp" />	
	</div>
	
	<br><br><br><br><br><br>
	
	
	<form id="formFream" name="formFream"></form>
<%-- 	<a href="/board/delete.do?boardNo=${listView.boardNo }"><button>삭제</button></a> --%>
	
</div>

</div>

</body>
</html>