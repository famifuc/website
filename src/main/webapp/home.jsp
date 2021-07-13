<%@ page import="java.sql.SQLException"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="dao.DAO"%>
<%@ page import="entity.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.ResultSet, java.sql.SQLException"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Home Shop</title>
<link rel="stylesheet" href="home.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<title>Home</title>
</head>
<body style="background-color: #CCFFCC">
			
	<h1 style="color: red; font-size: 70px "><a href="home.jsp">Shop New</a></h1>
	<div>
		<h2 style="color: red;text-align: left"><a href ="add.jsp">Add Product</a></h2>
		<h3 style="color: red;text-align: right"><a href="cart.jsp">Cart</a></h2>
	
	</div>
	
	<div>
 
     Search 
     
 
  </div>
  <form action= "Search" method = "POST">
  	<input class = "searchBox" type = "text" name = "txtSearch" size = "15" required>
  	<input class = "searchButton" type = "submit" name = "btnGo" value = "Search">
  </form> 
  
  
  
	<%
         	int first = 0, last = 0, pages = 1;

         	if (request.getParameter("pages") != null) {
         		pages = (int) Integer.parseInt(request.getParameter("pages"));
         	}
         	int total = new DAO().getCount();

         	if (total <= 3) {
         		first = 0;
         		last = total;
         	} else {
         		first = (pages - 1) * 3;
         		last = 3;
         	}
         	%>
	
		<table border="1" style="width: 100%">
		<tr>
			<th style="width: 5%; color: red">ID</th>
			<th style="width: 25%; color: red">Name</th>
			<th style="width: 10%; color: red">Price</th>
			<th style="width: 50%; color: red">Photo</th>
			
			<th style="width: 10%; color: red"></th>
		</tr>
		<%
		List<Product> list = new DAO().getAllProduct(first, last);
		
		for (Product p : list) {
			String buyURL = "Cart?id=" + p.getId();
		%>
		
		<tr>
			<td>

				<h1 style="color: DodgerBlue"><%=p.getId()%></h1>
			</td>
			<td><h1 style="color: DodgerBlue"><%=p.getName()%></h1></td>
			<td>
				<h1 style="color: DodgerBlue"><%=p.getPrice()%></h1>
			</td>
			 
			<td><img src=" <%=request.getContextPath()%>/images/<%=p.getImage()%>" width="200px" height="300px"> </td>
			
			<td><a href="<%=buyURL%>">Add to Cart</a></td>
		</tr>
		<%
		}
		%>
	</table>
	<ul class="start">
		<%
		int back = 0;
		if (pages == 0 || pages == 1) {
			back = 1;
		} else {
			back = pages - 1;
		}
		%>
		<li><a href="home.jsp?pages=<%=back%>"><i></i></a></li>
		<%
		//Button Number pages
		int loop = 0, num = 0;
		if ((total / 3) % 2 == 0) {
			num = total / 3;
		} else {
			num = (total + 1) / 3;
		}

		if (total % 2 != 0) {
			loop = (total / 3) + 1;

		} else {

			if (total < (num * 3) + 3 && total != num * 3) {
				loop = (total / 3) + 1;
			} else {

				loop = (total / 3);
			}
		}
		for (int i = 1; i <= loop; i++) {
		%>
		<%
		if (pages == i) {
		%>

		<li><span><a href="home.jsp?pages=<%=i%>"><%=i%></a></span></li>
		<%
		} else {
		%>
		<li class="arrow"><a href="home.jsp?pages=<%=i%>"><%=i%></a></li>

		<%
		}
		}
		%>
		<%
		int next = 0;
		if (total % 2 != 0) {
			if (pages == (total / 3) + 1) {
				next = pages;
			} else {
				next = pages + 1;
			}
		} else {

			if (total < (num * 3) + 3 && total != num * 3) {
				if (pages == (total / 3) + 1) {
			next = pages;//Khong next
				} else {
			next = pages + 1;//Co next
				}
			} else {
				//Nếu fullPage đến trang cuối dừng
				//Chưa tới trang cuối thì được next
				if (pages == (total / 3)) {
			next = pages;//Khong next
				} else {
			next = pages + 1;//Co next
				}
			}
		}
		%>
		<li><a href="home.jsp?pages=<%=next%>"><i class="next"></i></a></li> 
</body>
</html>