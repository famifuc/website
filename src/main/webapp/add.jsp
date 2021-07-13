<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body style="background-color: #CCFF99">
	<script type="text/javascript" src ="js/jquery.js"></script>
	<h1 style="color: red; width: 20%, height:200px"><a href="http://localhost:8080/WebDemo2/">Shop New</a></h1>
	

	<h2>Add Product</h2>

	<form action="${pageContext.request.contextPath}/Add" method="POST" enctype="multipart/form-data" >
		<table>
			<tr>
				<td>ID</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>Price</td>
				<td><input type="text" name="price"></td>
			</tr>
			
			<tr>
			
				<td><input type = "file" name = "file" /></td>
				
			</tr>

			<tr>
				<td><input type="submit" value="Submit"></td>
				<td><input type="reset" value="Reset"></td>
			</tr>
			</table>
			
		</form>
</body>
</html>