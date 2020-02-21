<%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/26/2019
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.io.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file="jdbc.jsp" %>
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<title>Register New Customer</title>
</head>
<body>
<h1> Register Product Form</h1>
<form method="post" action="imageuploadservelet" enctype="multipart/form-data">
    <table style="with: 50%">
        <tr>
            <td>Product Name</td>
            <td><input type="text" name="productName" required="required"/></td>
        </tr>
        <tr>
            <td>Price</td>
            <td><input type="number" name="price" required="required"/></td>
        </tr>
        <tr>
            <td>Image URL</td>
            <td><input type="text" name="URL"/></td>
        </tr>
        <tr>
            <td>Image Upload</td>
            <td><input type="file" name="image" required="required"/></td>
        </tr>
        <tr>
            <td>Category ID</td>
            <td><input type="text" name="category" required="required"/></td>
        </tr>
        <tr>
            <td>Description</td>
            <td><input type="text" name="desc" required="required"/></td>
        </tr>
    </table>
    <input type="submit" value="Submit"/></form>


</body>
</html>
