<%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/26/2019
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp" %>
<html>
<head>
</head>
<title>Register New Customer</title>

</head>
<body>
<h1> Register Form</h1>
<form action="Registration.jsp" method="post">
    <table style="with: 50%">
        <tr>
            <td>First Name</td>
            <td><input type="text" name="first_name" required="required"/></td>
        </tr>
        <tr>
            <td>Last Name</td>
            <td><input type="text" name="last_name" required="required"/></td>
        </tr>
        <tr>
            <td>UserName</td>
            <td><input type="text" name="username" required="required"/></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="password" name="password" required="required"/></td>
        </tr>
        <tr>
            <td>Address</td>
            <td><input type="text" name="address" required="required"/></td>
        </tr>
        <tr>
            <td>Contact No</td>
            <td><input type="text" name="contact" required="required"/></td>
        </tr>
        <tr>
            <td>City</td>
            <td><input type="text" name="city" required="required"/></td>
        </tr>

        <tr>
            <td>State</td>
            <td><input type="text" name="state" required="required"/></td>
        </tr>


        <tr>
            <td>postalCode</td>
            <td><input type="text" name="postalcode" required="required"></td>
        </tr>
        <tr>
            <td>Country</td>
            <td><input type="text" name="country" required="required"/></td>
        </tr>
        <tr>
            <td>email</td>
            <td><input type="email" name="email" required="required"/></td>
        </tr>
    </table>
    <input type="submit" value="Submit"/></form>


</body>
</html>
