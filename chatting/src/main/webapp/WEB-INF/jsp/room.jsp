<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="${root }/css/room.css">
<meta charset="UTF-8">
	<title>Room</title>
</head>

<script type="text/javascript">
	var ws;
	window.onload = function(){
		getRoom();
		createRoom();
	}

	function getRoom(){
		commonAjax('/rest/getRoom', "", 'get', function(result){
			createChatingRoom(result);
		});
	}
	
	function createRoom(){
		$("#createRoom").click(function(){
			var msg = {	roomName : $('#roomName').val()	};

			commonAjax('/rest/createRoom', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}

	function goRoom(number, name){
		location.href="/moveChating?roomName="+name+"&"+"roomNumber="+number;
	}

	function createChatingRoom(res){
		
		var tag = "";
		for(var i =0; i < res.length; i++){
			
			tag += "<tr>"+
			"<td class='num'>"+res[i]["idx"]+"</td>"+
			"<td class='room'>"+ res[i]["title"] +"</td>"+
			"<td class='go'><button type='button' onclick='goRoom(\""+res[i]["idx"]+"\", \""+res[i]["title"]+"\")'>Go</button></td>" +
			"</tr>";	
			
			
		}
		$("#roombody").empty().append(tag);
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
			<div class="login">
			
			<span>
				<c:if test="${loginuser eq null }">
					<a href="/login">Login</a>
				</c:if>
				<c:if test="${loginuser ne null }">
					<a href="/logout">Logout</a>
				</c:if>
			</span>
			<span style="font-weight:bold;">&nbsp/&nbsp</span>
			<span>
				<a href="/register">Register</a>
			</span>
		</div>
		<h1>Chatting</h1>
		<div class="inputTable">
			<span>Title : </span>
			<input type="text" name="roomName" id="roomName">
			<button id="createRoom">Make</button>
		</div>
		<div id="roomContainer" class="roomContainer">
			<table id="roomList" class="roomList">
			
				<tbody id="roombody">
				
				</tbody>
				
			</table>
		</div>
		<div>			
		</div>
		</div>
		
	</div>
</body>
</html>