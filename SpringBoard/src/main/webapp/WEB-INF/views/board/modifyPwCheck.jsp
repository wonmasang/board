<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	
	$("#btnPwCheck").click(function() {
		
		var boardNo = ${boardNo };
		var password = $("#pwCheck").val();
		
		$.ajax({
			type:"POST"
			, url: "/board/pwCheckProc.do"
			, dataType:"json"
			, data: {
				boardNo: boardNo,
				pw: password
			}
			, success: function(res) {
				if( res.check == true ) {
					alert("비밀번호 확인이 완료 되었습니다.");
					window.opener.location.href="/board/modify.do?boardNo=${boardNo }"
					self.close();
				} 
				else if( res.check == false ) {
					alert("비밀번호를 다시 확인해 주시기 바랍니다.")
					$("#pwCheck").val("");
					$("#pwCheck").focus();
// 					self.close();
				}
			}
			, error: function(res) {
// 				console.log(res.responseText)
				alert("비번확인 에러!");
			}
		
		
		});
	
	});
	
});


</script>

<style type="text/css">
#mentDiv {
	font-size: 13px;
	color: blue;
	margin-bottom: 6px;
	margin-left: 27px;
}
#mentSpan {
	color: red;
	font-size: 14px;
	font-weight: bold;
}
</style>

<title>Insert title here</title>
</head>
<body>

<div>
<h5>게시판 비번체크 페이지</h5>
<hr>

<div id="mentDiv">*글의 <span id="mentSpan">"수정"</span> 을 위해 비밀번호를 입력해 주세요.*</div>
<label>비밀번호 :</label>
<input type="password" id="pwCheck" name="pwCheck" size="30px" placeholder="비밀번호를 입력해 주세요.">
<button id="btnPwCheck" name="btnPwCheck">확인</button>
<br><br>

<center>
<button onclick="self.close();">닫기</button>
</center>

</div>

</body>
</html>