<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>Chating</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating .me{
			color: #F6F6F6;
			text-align: right;
		}
		.chating .others{
			color: #FFE400;
			text-align: left;
		}
		input{
			width: 330px;
			height: 25px;
		}
		
	</style>
</head>

<script type="text/javascript">
	var ws;

	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
		wsEvt();
	}
	
	window.onload = function(){
		wsOpen();
		var roomnum = {	roomnum : $('#roomNumber').val()	};
		commonAjax('/rest/getmsg', roomnum, 'get', function(result){
			msgappend(result);
		});

	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
		}
		
		

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
				
			}
		});
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var roomnum = {	roomnum : $('#roomNumber').val()	};
			commonAjax('/rest/getmsg', roomnum, 'get', function(result){
				msgappend(result);
			});
		}
	}

	function send() {
		
		var option ={
			type: "message",
			roomNumber: $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : $("#loginid").val(),
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option))
		$('#chatting').val("");
	}
	
	

	function msgappend(res){
		
		$("#chating").empty();
		
		for(var i =0; i < res.length; i++){
		
			if($("#loginid").val() == res[i]["user"]){
				$("#chating").append("<p class='me'>나 :" + res[i]["msg"] + "</p>");	
			}else{
				$("#chating").append("<p class='others'>" + res[i]["user"] + " :" + res[i]["msg"] + "</p>");
			}

			
		}

	}
	
	
	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
</script>
<body>
	<div id="container" class="container">
		<h1>${roomName}의 채팅방</h1>
		<input type="hidden" id="loginid" value="${loginuser.id }">
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
		<div id="chating" class="chating">
		
		</div>
		
		
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>