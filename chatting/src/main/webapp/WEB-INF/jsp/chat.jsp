<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="${root }/css/chatting.css">
<meta charset="UTF-8">
	<title>Chating</title>
</head>

<script type="text/javascript">
	var ws;
	var roomnum;
	var randomnum;
	function getParameterByName(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	
	
	
	window.onload = function(){
	
		
		roomnum = getParameterByName('roomNumber');
		
		if(roomnum === '0'){
			
			
			$.ajax({
				url: '/rest/searchrandomroom',
				data: {
					id : $("#loginid").val()
				},
				async: false,
				type: 'get',
				contentType:'application/x-www-form-urlencoded; charset=UTF-8',
				success: function (res) {
					randomnum = res;
					
				},
				error : function(err){
					$.ajax({
						url: '/rest/makerandomroom',
						data: {
							id : $("#loginid").val()
						},
						async: false,
						type: 'post',
						contentType:'application/x-www-form-urlencoded; charset=UTF-8',
						success: function (res) {
							randomnum = res;
							
						},
						error : function(err){
							
							
						}
					});
					
				}
			});
			
			roomnum = randomnum;
		}else{
			commonAjax('/rest/getmsg', roomnum, 'get', function(result){
				msgappend(result);
			});
		}
		document.getElementById("roomNumber").value = roomnum;
		document.getElementById("head").innerHTML=roomnum;


		wsOpen();
	}
	
	window.onbeforeunload = function() {

		var loginid = {	loginid : $('#loginid').val()};
		commonAjax('/rest/deleterandomroom', loginid, 'post', function(result){
			
		});
		
		 return "나가시겠습니까?";

	}
	
	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		
			ws = new WebSocket("ws://" + location.host + "/chating/"+roomnum);
		
		
		
		wsEvt();
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
		<h1 id="head">${roomNumber}</h1>
		
			<div id="chating" class="chating">
		
			</div>
			<div id="yourMsg">
			
					<input id="chatting" placeholder="write message">
					<button onclick="send()" id="sendBtn">send</button>
				
			
		</div>
		<div>			
		</div>
		</div>
		
	</div>
</body>
</html>