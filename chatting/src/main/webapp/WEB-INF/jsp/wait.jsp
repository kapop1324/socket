<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="${root }/css/wait.css">
<meta charset="UTF-8">
	<title>Chating</title>
</head>

<script type="text/javascript">
	var ws;

	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
		wsEvt();
	}
	
	var timer;
	
	window.onload = function(){
		wsOpen();
		var roomnum = {	roomnum : $('#roomNumber').val()	};
		commonAjax('/rest/getmsg', roomnum, 'get', function(result){
			msgappend(result);
		});
		
		var delay = 10;
		var time = 0;
		
		document.getElementById("time").innerHTML = "0";
		  timer = setInterval(function(){
		        time++;

		       

		        document.getElementById("time").innerHTML = time;
		      }, 1000);

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
				$("#chating").append("<p class='me'>나 : " + res[i]["msg"] + "</p>");	
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

	
	<div class="container">
		<div class="body">
		<input type="hidden" id="loginid" value="${loginuser.id }">
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
		
		<div>
			<h1>Waiting...</h1>
		</div>
		<div>
			<h2 id="time"></h2>
		</div>

		<div>			
		</div>
		</div>
		
	</div>
</body>
</html>