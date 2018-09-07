<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

// $(function(){
	
// 	$("#cmtpw").keyup(function(){
		  
// 		var cmtpw = $("#cmtpw").val();
// 		var blank_patten = /[\s]/g;
		  
// 		if(blank_patten.exec(cmtpw)) {
// 			$("#coment").text("");
// 			$("#coment").html("( 띄어쓰기는 사용 할 수 없습니다. )");
// 			return;
// 		}
		  
// 		if(cmtpw.length<6||cmtpw.length>16) {
// 			$("#coment").text("");
// 			$("#coment").html("( 6~16 자리로 만들어 주세요. )");
// 			return;
// 		}
			  
// 		var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,16}$/;
// 		if(!check.test(cmtpw)) {
// 			$("#coment").text("");
// 			$("#coment").html("( 영문,숫자,특수문자의 조합으로 입력해 주세요. )");
// 			return;
// 		} else if(check.test(cmtpw)) {
// 			$("#coment").text("");
// 			$("#coment").html("( 비밀번호가 입력되었습니다. )");
// 			return;
// 		}
		  
// 	});  
	
// // 	blur - 포커스아웃 되었을때 
// 	$("#cmtpw").blur(function() {
// 		$("#coment").text("");
		  
// 	});

// });




function commentList() {
	var boardNo = ${listView.boardNo};
	console.log("gg"+boardNo);
	$.ajax ({
		type:"GET"
		, url: "/board/commentList.do"
		, data: {
			boardNo: boardNo,
		}
		, success: function(res) {
			var a="";
			$.each(res, function(key, value){ 
                a += '<div style="border-bottom:1px solid darkgray; margin-top: 8px; margin-bottom: 10px; white-space: pre-wrap;">';
                a += '<div id="commentInfo'+value.cmtno+'" style=" margin-bottom: 10px;">';
				if( value.del == 0 ) {
					
                
	                if( value.depth > 0 ) {
						for(var i=0; i<value.depth; i++){
							a += '&nbsp;&nbsp;&nbsp;';
						}
						a += '<span>└ RE</span>&nbsp;';
					}
	                
	                a += '작성자 : '+value.cmtwriter+'  / 작성일: '+value.reg_date;
	                a += '<button style="margin-left: 30px;" onclick="commDelWindowOpen('+value.cmtno+','+value.parentNo+');">삭제</button>';
	                a += '<button style="margin-left: 10px;" onclick="commentReplyFrom('+value.cmtno+','+value.grp+','+value.grpord+','+value.depth+');">댓글</button> </div>';
	                a += '<div id="commentContent'+value.cmtno+'" style="margin-top: 10px; margin-bottom: 10px;">';
	                
	                if( value.depth > 0 ) {
						for(var i=0; i<value.depth; i++){
							a += '&nbsp;&nbsp;&nbsp';
						}
						a += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
					}
	                
	                a += '<span>내용 : '+value.cmtcontent +'</span>';
	                a += '</div>';
	                a += '<div><div id="commentReply'+value.cmtno+'" name="commentReply'+value.cmtno+'"></div></div></div>';
				
				}else {
					if( value.depth > 0 ) {
						for(var i=0; i<value.depth; i++){
							a += '&nbsp;&nbsp;&nbsp';
						}
						a += '<span>└ RE</span>&nbsp;';
					}
					a += '<span style="margin-left: 15px; color: red; text-decoration: line-through; font-size: 14px;">댓글이 삭제 되었습니다.</span></div></div>';
				}
					
            });
				
			$("#commentList").html(a);

		}
		, error: function(res) {
			alert("댓글리스트 에러남!!!!");
		}
	});
};
	
function commentInsert(){
	var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,16}$/;
	var blank_patten = /[\s]/g;
	
	var boardNo = ${listView.boardNo};
	var cmtwriter = $("#cmtwriter").val();
	var cmtcontent = $("#cmtcontent").val();
	var cmtpw = $("#cmtpw").val();
	
	
	if( blank_patten.exec(cmtwriter) ) {
		alert("작성자에 띄어쓰기가 포함되어 있습니다.");
		$("#cmtwriter").focus();
		return false;
	}else if( blank_patten.exec(cmtpw) ) {
		alert("비밀번호에 띄어쓰기가 포함되어 있습니다.");
		$("#cmtpw").focus();
		return false;
	}else if( cmtwriter == "" || cmtwriter == null ) {
		alert("작성자에 값을 입력 해 주세요.");
		$("#cmtwriter").focus();
		return false;
	}else if( cmtpw == "" || cmtpw == null ) {
		alert("비밀번호에 값을 입력 해 주세요.");
		$("#cmtpw").focus();
		return false;
	}else if( cmtcontent == "" || cmtcontent == null ) {
		alert("내용에 글을 입력 해 주세요.");
		$("#cmtcontent").focus();
		return false;
	}else if( cmtcontent.length == 0 || !cmtcontent.trim() ) {
		alert("내용에 띄어쓰기만 입력 되었습니다.\n내용에 글을 입력 해 주세요.");
		$("#cmtcontent").focus();
		return false;
	}else if( !check.exec(cmtpw) ) {
		alert("비밀번호를 양식에 맞게 다시 작성해 주세요.");
		$("#cmtpw").focus();
		return false;
	}else {
		var con_firm = confirm("댓글을 등록 하시겠습니까?");	
		if(con_firm == true) {
	
			$.ajax({
				type:"POST"
				, url: "/board/commentInsert.do"
				, data: {
					cmtboardno: boardNo
					, cmtwriter: cmtwriter
					, cmtcontent: cmtcontent
					, cmtpw: cmtpw
				}
				, success: function() {
						alert("댓글이 등록되었습니다.");
						$("#cmtwriter").val("");
						$("#cmtcontent").val("");
						$("#cmtpw").val("");
						commentList(); //댓글 작성 후 댓글 목록 reload
					}
		
			});
		}else if(con_firm == false){
			alert("취소");
		}
		return true;
	}	
		
};


function commentReplyFrom(cmtno,grp,grpord,depth){
	
	var cmtReplyFrom = "";
	cmtReplyFrom += '<div style="margin-bottom: 10px;">';
	cmtReplyFrom += '<label for="cmtRwriter">commentReply</label>';
	cmtReplyFrom += '<div>';
	cmtReplyFrom += '<label for="cmtRwriter">작성자 :</label>';
	cmtReplyFrom += '<input type="text" id="cmtRwriter" name="cmtRwriter" maxlength="10" size="30px" placeholder="작성자를 입력하세요." style="margin-left: 21px;"><br>';
	cmtReplyFrom += '<label for="cmtRcontent">내용 :</label>';
	cmtReplyFrom += '<input type="text" id="cmtRcontent" name="cmtRcontent" maxlength="40" size="85px" placeholder="내용을 입력하세요." style="margin-left: 37px; margin-top: 5px;">';
	cmtReplyFrom += '<span><button type="button" id="commentReplyBtn" onclick="commentReplyInsert('+cmtno+','+grp+','+grpord+','+depth+');" style="margin-left: 60px;">댓글등록</button></span><br>';
	cmtReplyFrom += '<label for="cmtRpw">비밀번호 :</label>';
	cmtReplyFrom += '<input type="password" id="cmtRpw" name="cmtRpw" size="30px" maxlength="16" placeholder="비밀번호를 입력해 주세요." style="margin-top: 5px; margin-left: 5px;">';
	cmtReplyFrom += '<span style="font-size: 10px; color: blue;">(비밀번호는 숫자+문자+특수문자 조합으로 6~16자 이내로 작성하시기 바랍니다.)</span>';
// 	cmtReplyFrom += '<div id="comentRDiv" style="height: 40px;"><p id="comentR" name="comentR" style="color: red; margin-left: 77px; margin-top: 5px; margin-bottom: 0px;"></p></div>';
	cmtReplyFrom += '</div></div>';

	$("#commentReply"+cmtno+"").html(cmtReplyFrom);
	
}


function commentReplyInsert(cmtno,grp,grpord,depth){
	var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,16}$/;
	var blank_patten = /[\s]/g;
	
	var boardNo = ${listView.boardNo};
	var cmtno = cmtno;
	var cmtRwriter = $("#cmtRwriter").val();
	var cmtRcontent = $("#cmtRcontent").val();
	var cmtRpw = $("#cmtRpw").val();
	
	if( blank_patten.exec(cmtRwriter) ) {
		alert("작성자에 띄어쓰기가 포함되어 있습니다.");
		$("#cmtRwriter").focus();
		return false;
	}else if( blank_patten.exec(cmtRpw) ) {
		alert("비밀번호에 띄어쓰기가 포함되어 있습니다.");
		$("#cmtRpw").focus();
		return false;
	}else if( cmtRwriter == "" || cmtRwriter == null ) {
		alert("작성자에 값을 입력 해 주세요.");
		$("#cmtRwriter").focus();
		return false;
	}else if( cmtRpw == "" || cmtRpw == null ) {
		alert("비밀번호에 값을 입력 해 주세요.");
		$("#cmtRpw").focus();
		return false;
	}else if( cmtRcontent == "" || cmtRcontent == null ) {
		alert("내용에 글을 입력 해 주세요.");
		$("#cmtRcontent").focus();
		return false;
	}else if( cmtRcontent.length == 0 || !cmtRcontent.trim() ) {
		alert("내용에 띄어쓰기만 입력 되었습니다.\n내용에 글을 입력 해 주세요.");
		$("#cmtRcontent").focus();
		return false;
	}else if( !check.exec(cmtRpw) ) {
		alert("비밀번호를 양식에 맞게 다시 작성해 주세요.");
		$("#cmtRpw").focus();
		return false;
	}else {
	
		var con_firm = confirm("댓글을 등록 하시겠습니까?");
		
		if( con_firm == true ) {
		
			$.ajax({
				type:"POST"
				, url: "/board/commentReply.do"
				, data: {
					cmtboardno: boardNo
					, parentNo: cmtno
					, cmtwriter: cmtRwriter
					, cmtcontent: cmtRcontent
					, cmtpw: cmtRpw
					, grp: grp
					, grpord: grpord
					, depth: depth
				}
				, success: function() {
						alert("댓글이 등록되었습니다.");
						$("#commentReply").html("");
						commentList(); //댓글 작성 후 댓글 목록 reload
					}
			});
			
		}else if( con_firm == false ){
			alert("취소하셨습니다.");
		}	
		return true;
	}
		
};

// function commentDelete(cmtno, parentNo) {
	
	
// 	$.ajax({
// 		type:"POST"
// 		, url: "/board/commentDelete.do"
// 		, data: {
// 			cmtno: cmtno
// 			, parentNo: parentNo
// 		}
// 		, success: function() {
// 				alert("삭제 되었습니다.");
// 				commentList(); //댓글 작성 후 댓글 목록 reload
// 			}

// 	});
	
// };

	
$(document).ready(function(){
	
	commentList();
	
	$("#commentHide").click(function(){
        $("#container").hide(500);
        $("#commentShow").show();
        $("#commentHide").hide();
    });
	$("#commentShow").click(function(){
        $("#container").show(500);
        $("#commentShow").hide();
        $("#commentHide").show();
    });
	
});


function commDelWindowOpen(cmtno, parentNo) {
	var cmtno = cmtno;
	var parentNo = parentNo;
	console.log("하하"+cmtno+parentNo);
	
	var url = "/board/commDelPwCheck.do?cmtno="+cmtno+"&parentNo="+parentNo+"&boardNo=${listView.boardNo }";
	var settings = "width=450px, height=200px, top=100px, left=100px, toolbar=no, menubar=no, scrollbars=no, fullscreen=no";
	var windowObj = window.open(url, '비밀번호 확인', settings);
	
};

</script>



<title>Insert title here</title>
</head>
<body>

<div>
	<label for="cmtwriter">comment</label>
		<div>
			<input type="hidden" name="cmtboardno" value="${listView.boardNo}"/>
			
			<label for="cmtwriter">작성자 :</label>
			<input type="text" id="cmtwriter" name="cmtwriter" maxlength="10" size="30px" placeholder="작성자를 입력하세요." style="margin-left: 17px;"><br>
			
			<label for="cmtcontent">내용 :</label>
			<input type="text" id="cmtcontent" name="cmtcontent" maxlength="40" size="85px" placeholder="내용을 입력하세요." style="margin-left: 32px; margin-top: 5px;">
			
			<span>
			<button type="button" id="commentInsertBtn" onclick="commentInsert();" style="margin-left: 60px;">댓글등록</button>
			</span>
			<br>
			
			<label for="cmtpw">비밀번호 :</label>
			<input type="password" id="cmtpw" name="cmtpw" size="30px" maxlength="16" placeholder="비밀번호를 입력해 주세요." style="margin-top: 5px;">
			<span style="font-size: 10px; color: blue;">(비밀번호는 숫자+문자+특수문자 조합으로 6~16자 이내로 작성하시기 바랍니다.)</span><br>
				
<!-- 			<div id="comentDiv" style="height: 40px;"> -->
<!-- 				<p id="coment" name="coment" style="color: red; margin-left: 77px; margin-top: 5px; margin-bottom: 0px;"></p> -->
<!-- 			</div> -->
			
			
		</div>
</div>
    <hr>
    
    <button id="commentHide" style="float: right; margin-left: 8px;">댓글 숨기기</button>
    <button id="commentShow" style="float: right; display: none;">댓글 보이기(<span style="color: red;">${commentCount }</span>)</button>
    
    <br><br>
    <hr>
    <div id="container">
        <div id="commentList" name="commentList"></div>
    </div>

</body>
</html>