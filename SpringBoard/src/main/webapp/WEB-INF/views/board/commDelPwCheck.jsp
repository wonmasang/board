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
		var cmtno = ${cmtno };
		var parentNo = ${parentNo };
		var password = $("#pwCheck").val();
		var con_firm = confirm("삭제를 진행 하시겠습니까?");
		
		if( con_firm == true ) {
			
			$.ajax({
				type:"POST"
				, url: "/board/commentPwCheckProc.do"
				, dataType:"json"
				, data: {
					cmtno: cmtno,
					cmtpw: password
				}
				, success: function(res) {
					if( res.check == true ) {
// 						alert("삭제를 진행 하시겠습니까?");
						window.opener.location.href="/board/commentDelete.do?cmtno=${cmtno }&parentNo=${parentNo }&boardNo=${boardNo}"
						self.close();
					} 
					else if( res.check == false ) {
						alert("비밀번호를 다시 확인해 주시기 바랍니다.");
						$("#pwCheck").val("");
						$("#pwCheck").focus();
					}
				}
				, error: function(res) {
//	 				console.log(res.responseText)
					alert("비번확인 에러!");
				}
			
			});
		
		//if문 끝	
		}else if( con_firm == false ) {
			alert("취소하셨습니다.");
			self.close();
		}
		
		
		
	
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
<h5>댓글 비번체크 페이지</h5>
<hr>

<div id="mentDiv">*댓글의 <span id="mentSpan">"삭제"</span> 를 위해 비밀번호를 입력해 주세요.*</div>
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