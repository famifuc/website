<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="dao.DAO"%>
<%@ page import="entity.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Product</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body style="background-color: #CCFFCC">
	<h1 style="color: red; width: 20%, height:200px">
		<a href="http://localhost:8080/WebDemo2/">Shop New</a>
	</h1>

	<div>Search</div>
	<form action="Search" method="POST">
		<input class="searchBox" type="text" name="txtSearch" size="15"
			required> <input class="searchButton" type="submit"
			name="btnGo" value="Search">
	</form>




	<%
	int first = 0, last = 0, pages = 1;
	String txtSearch = request.getParameter("txtSearch");
	if (request.getParameter("pages") != null) {
		pages = (int) Integer.parseInt(request.getParameter("pages"));
	}
	int total = new DAO().count(txtSearch);

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
		List<Product> list = new DAO().searchProduct(txtSearch);
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

			<td><img src="<%=request.getContextPath()%>/images/<%=p.getImage()%>" width="200px"
				height="300px"></td>

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
		<li><a href="search.jsp?pages=<%=back%>"><i></i></a></li>
		<%
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

		<li><span><a href="search.jsp?pages=<%=i%>"><%=i%></a></span></li>
		<%
		} else {
		%>
		<li class="arrow"><a href="search.jsp?pages=<%=i%>"><%=i%></a></li>

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
			next = pages;
				} else {
			next = pages + 1;
				}
			} else {

				if (pages == (total / 3)) {
			next = pages;
				} else {
			next = pages + 1;
				}
			}
		}
		%>
		<li><a href="search.jsp?pages=<%=next%>"><i class="next"></i></a></li>
</body>
</html>