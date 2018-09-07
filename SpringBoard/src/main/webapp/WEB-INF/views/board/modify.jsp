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

function modifyFrom() {
	var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,16}$/;
	var blank_patten = /[\s]/g;
	
	var writer = $("#writer").val();
	var title = $("#title").val();
	var password = $("#pw").val();
	var content = $("#content").val();
	
	if( blank_patten.exec(writer) ) {
		alert("작성자에 띄어쓰기가 포함되어 있습니다.");
		$("#writer").focus();
		return false;
	}else if( blank_patten.exec(password) ) {
		alert("비밀번호에 띄어쓰기가 포함되어 있습니다.");
		$("#pw").focus();
		return false;
	}else if( writer == "" || writer == null ) {
		alert("작성자에 값을 입력 해 주세요.");
		$("#writer").focus();
		return false;
	}else if( title == "" || title == null ) {
		alert("제목에 값을 입력 해 주세요.");
		$("#title").focus();
		return false;
	}else if( title.length == 0 || !title.trim() ) {
		alert("제목에 띄어쓰기만 입력 되었습니다.\n제목에 값을 입력 해 주세요.");
		$("#title").focus();
		return false;
	}else if( password == "" || password == null ) {
		alert("비밀번호에 값을 입력 해 주세요.");
		$("#pw").focus();
		return false;
	}else if( content == "" || content == null ) {
		alert("내용에 글을 입력 해 주세요.");
		$("#content").focus();
		return false;
	}else if( content.length == 0 || !content.trim() ) {
		alert("내용에 띄어쓰기만 입력 되었습니다.\n내용에 글을 입력 해 주세요.");
		$("#content").focus();
		return false;
	}else if( !check.exec(password) ) {
		alert("비밀번호를 양식에 맞게 다시 작성해 주세요.");
		$("#pw").focus();
		return false;
	}else {
		alert("작성을 완료 하시겠습니까?")
		return true;
	}
	
};

$(function() {
    $("#content").keyup(function (e){
        var content = $(this).val();
//         $(this).height(((content.split('\n').length + 1) * 9) + 'em');
        $("#counter").html("("+content.length + "/300"+")");
    });
    $("#content").keyup();
});

$(function(){
	
	$("#pw").keyup(function(){
		  
		var pw = $("#pw").val();
		var blank_patten = /[\s]/g;
		  
		if(blank_patten.exec(pw)) {
			$("#coment").text("");
			$("#coment").html("띄어쓰기는 사용 할 수 없습니다.");
			return;
		}
		  
		if(pw.length<6||pw.length>16) {
			$("#coment").text("");
			$("#coment").html("6~16 자리로 만들어 주세요.");
			return;
		}
			  
		var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,16}$/;
		if(!check.test(pw)) {
			$("#coment").text("");
			$("#coment").html("영문,숫자,특수문자의 조합으로 입력해 주세요.");
			return;
		} else if(check.test(pw)) {
			$("#coment").text("");
			$("#coment").html("비밀번호가 입력되었습니다.");
			return;
		}
		  
	});  
	
// 	blur - 포커스아웃 되었을때 
	$("#pw").blur(function() {
		$("#coment").text("");
	});
});	  

function fileDelBtn(b_fileno) {
	
// 		e.preventDefault();
		
// 		var b_fileno = $("#b_fileno").val();

		
		var con_firm = confirm("파일삭제는 복구가 불가능합니다.\n삭제를 진행 하시겠습니까?");
		
		if( con_firm == true ) {
			
			$.ajax({
				type:"POST"
				, url: "/board/fileDelete.do"
				, dataType:"json"
				, data: {
					b_fileno: b_fileno
				}
				, success: function(res) {
					if( res.check == true ) {
						alert("삭제 성공");
						location.reload();
					} 
					else if( res.check == false ) {
						alert("삭제 실패");
					}
				}
				, error: function(res) {
					alert("삭제 에러!");
				}
			
			});
		
		}else if( con_firm == false ) {
			alert("취소하셨습니다.");
			self.close();
		}
		
	
	
}



$(document).ready(function(){
	
	$("#addFileBtn").on("click", function(e){
		e.preventDefault();
		fn_addFile();
	});
	
	$("#delFileBtn").on("click", function(e){
		e.preventDefault();
		fn_delFile($(this));
	});
	
	
	
});

var gfv_count = 1;
function fn_addFile() {
	var str = "<span><input type='file' id='files_"+(gfv_count++)+"' name='files' style='margin-top: 5px; margin-bottom: 5px;' /><a href='#' name='delFile'>X</a></span>";
	$("#fileDiv").append(str);
	$("a[name='delFile']").on("click", function(e) {
		e.preventDefault();
		fn_delFile($(this));
	});
}

function fn_delFile(obj) {
	obj.parent().remove();
}




</script>

<style type="text/css">
#mDiv {
	border:1px solid;
	width: 450px;
	margin-left: 70px;
}
#modifyDiv {
	width: 400px;
	margin: 0 auto;
	padding: 10px;
}
#boardNo {
	margin-left: 30px;
}
#writer {
	margin-left: 30px;
}
#title {
	margin-left: 45px;
}
#pw {
	margin-left: 13px;
}
#coment {
	font-size: 12px;
	color: red;
	text-align: center;
}
#comentDiv {
	height: 30px;
}
#counterDiv {
	width: 373px;
	height: 40px;
}
#counter {
	float: right;
}
#content {
	word-break:break-all;
}
textarea {
	resize: none;
}

</style>

<title>Insert title here</title>
</head>
<body>

<div>

<h1>게시글 수정 페이지</h1>
<hr>

	<div id="mDiv">
		<div id="modifyDiv">
			<form action="/board/modifyProc.do" method="post" enctype="multipart/form-data" onsubmit="return modifyFrom();">
			
<!-- 				<label for="boardNo">글번호 :</label> -->
				<input type="hidden" id="boardNo" name="boardNo" size="30px" value="${modify.boardNo }" readonly="readonly" >
				
				<label for="writer">작성자 :</label>
				<input type="text" id="writer" name="writer" size="30px" maxlength="10" autocomplete="off" value="<c:out value="${modify.writer }"></c:out>"><br><br>
				
				<label for="title">제목 :</label>
				<input type="text" id="title" name="title" size="30px" maxlength="40" autocomplete="off" value="<c:out value="${modify.title }"></c:out>"><br><br>
				
				<label for="pw">비밀번호 :</label>
				<input type="password" id="pw" name="pw" size="30px" maxlength="16" value="<c:out value="${modify.pw }"></c:out>" placeholder="비밀번호를 입력해 주세요."><br>
				<p style="font-size: 10px; color: blue;">(비밀번호는 숫자+문자+특수문자 조합으로 6~16자 이내로 작성하시기 바랍니다.)</p>
				
				<div id="comentDiv">
					<p id="coment" name="coment"></p><br>
				</div>
				
				<label for="content">내용</label><br>
				<textarea id="content" name="content" maxlength="300" rows="15px" cols="55px"><c:out value="${modify.content }"></c:out></textarea>
				
				<div id="counterDiv">
				<span id="counter"></span>
				</div>
				
				
				<label for="file">첨부파일</label><br>
<!-- 				<input multiple="multiple" type="file" id="files" name="files"> -->
				<button id="addFileBtn">파일추가</button>
				<div id="fileDiv" style="width: 373px;"></div>
				<br><br>
				
				<div id="fileList" style="width: 373px;">
					<c:forEach items="${fileList }" var="fileList">
						<input type="hidden" id="b_fileno" name="b_fileno" value="${fileList.b_fileno }">
						<span style="margin-left: 30px;">
								<c:out value="${fileList.b_original_filename }" />
						</span>
						<c:out value="( ${fileList.file_size_kb } )kb" />
						<a href="#" id="fileDelBtn${fileList.b_fileno }" name="fileDelBtn" onclick="fileDelBtn(${fileList.b_fileno });">삭제</a><br>
					</c:forEach>
				</div>
				
				<br><br>
				
				<center><button>작성</button></center>
				
			</form>
				<a href="/board/list.do"><button>목록</button></a>
		</div>
	</div>
	
</div>

</body>
</html>