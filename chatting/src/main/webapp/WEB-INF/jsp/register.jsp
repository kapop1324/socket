<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>Chating</title>
<link rel="stylesheet" href="${root }/css/register.css">	
</head>


<body>

	<div class="container">
		<div class="body">
		<h1>Register</h1>
		<div class="form">
			<form action="/register" method="post">
				<input type="text" name="id" placeholder="ID"><br>
				<input style="margin-top:50px;" type="password" name="pw" placeholder="PASSWORD"><br>
				<button type="submit">submit</button>
			</form>
		</div>
			
	
		<div>			
		</div>
		</div>
		
	</div>
</body>
</html>