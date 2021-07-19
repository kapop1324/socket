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
	
	
	var timer;
	
	window.onload = function(){
	
		var loginid = {	loginid : $('#loginid').val()	};
		commonAjax('/rest/enrollwait', loginid, 'post', function(result){
			
		});
		
		var delay = 10;
		var time = 0;
		
		document.getElementById("time").innerHTML = "0";
		  timer = setInterval(function(){
		        time++;

		        document.getElementById("time").innerHTML = time;
		       
		        $.ajax({
					url: '/rest/searchwait',
					data: loginid,
					type: 'get',
					contentType:'application/x-www-form-urlencoded; charset=UTF-8',
					success: function (res) {
						clearInterval(timer);
						document.getElementById("time").remove();
						document.getElementById("result").innerHTML = "Matched!";
						
						setInterval(function() {
							location.href="/moveChating?roomNumber=0";
						}, 5000);
					},
					error : function(err){
						
						
					}
				});
		      }, 1000);

	}
	
	window.onbeforeunload = function() {

		var loginid = {	loginid : $('#loginid').val()};
		commonAjax('/rest/deletewait', loginid, 'post', function(result){
			
		});
		
		 return "매칭을포기하시겠습니까?";

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
			<h1 id="result">Waiting...</h1>
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