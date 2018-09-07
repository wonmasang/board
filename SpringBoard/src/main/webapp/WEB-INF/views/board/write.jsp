<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

function writeFrom() {
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
		//content 내용물 중에 &이 있으면 &amp;로 바꾸는 로직
// 		alert("1 -"+content);
// 		content = content.replace(/&/g, "&amp;");
// 		$("#content").val(content);
// 		alert("2 -"+content);
		alert("작성을 완료 하시겠습니까?")
		return true;
	}
};

$(function() {
    $("#content").keyup(function (e){
        var content = $(this).val();
//         $(this).height(((content.split("\n").length + 1) * 7) + "em");
        $("#counter").html("("+ content.length + "/300"+")");
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
	
// 	$("#btnWrite").click(function() {
// 		var content = $("#content").val();
// 		alert("1 -"+content);
// 		content = content.replace(/&/g, "&amp;");
// 		$("#content").val(content);
// 		alert("2 -"+content);
		
// 		$("#formWrite").submit();
		
// 	});
	  
});	  

$(document).ready(function(){
	
	$("#addFileBtn").on("click", function(e){
		e.preventDefault();
		fn_addFile();
	});
	
	$("#delFileBtn").on("click", function(e){
		e.preventDefault();
		fn_delFile($(this));
	});
	
// 	function handleFileSelect(evt) {
// 		var files = evt.target.files; // FileList object
		
// 		var div = [];
// 		for (var i = 0, f; f = files[i]; i++) {
// 		div.push('<li>', f.name, ' <br> - type: ', f.type, '<br> - size: ', f.size, ' bytes','</li>');
// 		}
// 		document.getElementById('list').innerHTML = '<span>' + div.join('') + '</span>';
// 	}
	
// 	document.getElementById('files').addEventListener('change', handleFileSelect, false);

});

var gfv_count = 1;
function fn_addFile() {
	var str = "<span><input type='file' id='files_"+(gfv_count++)+"' name='files' style='margin-top: 5px; margin-bottom: 5px;' /><a href='#' name='delFile'>X</a></span>";
	$("#fileDiv").append(str);
// 	$("#files").focus(function(){
// 		$("#files").click();
// 	});
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
#wDiv {
	border:1px solid;
	width: 450px;
	margin-left: 70px;
}
#writeDiv {
	width: 400px;
	margin: 0 auto;
	padding: 10px;
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

<h1>게시판 글쓰기 페이지</h1>
<hr>
	<div id="wDiv">
		<div id="writeDiv">
			<form id="formWrite" action="/board/write.do" method="post" enctype="multipart/form-data" onsubmit="return writeFrom();" >
				
				<label for="writer">작성자 :</label>
				<input type="text" id="writer" name="writer" maxlength="10" size="30px" placeholder="작성자를 입력해 주세요." autocomplete="off"><br><br>
				
				<label for="title">제목 :</label>
				<input type="text" id="title" name="title" maxlength="40" size="30px" placeholder="제목을 입력해 주세요." autocomplete="off"><br><br>
				
				<label for="pw">비밀번호 :</label>
				<input type="password" id="pw" name="pw" size="30px" maxlength="16" placeholder="비밀번호를 입력해 주세요."><br>
				<p style="font-size: 10px; color: blue;">(비밀번호는 숫자+문자+특수문자 조합으로 6~16자 이내로 작성하시기 바랍니다.)</p>
				
				<div id="comentDiv">
					<p id="coment" name="coment"></p>
				</div>
				
				<label for="content">내용</label><br>
				<textarea id="content" name="content" maxlength="300" rows="15px" cols="55px" placeholder="내용을 입력해 주세요."></textarea>
				
				<div id="counterDiv">
					<span id="counter"></span>
				</div>
				
				<label for="file">첨부파일</label><br>
<!-- 				<input multiple="multiple" type="file" id="files" name="files"> -->
				<button id="addFileBtn">파일추가</button>
				<div id="fileDiv" style="width: 373px;"></div>
				<div id="list" style="width: 373px;"></div>
				<br><br>
				
				<center><button id="btnWrite">작성</button></center>
			</form>
				<a href="/board/list.do"><button>목록</button></a>
		</div>
	</div>

</div>

</body>
</html>