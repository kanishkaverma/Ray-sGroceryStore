<%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/26/2019
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp" %>
<html>
<head>
</head>
<body>
<div class="header">

    <div class="header-right">
        <a class="active" href="listprod.jsp">products</a>
        <a href="listorder.jsp">Orders</a>
        <a href="showcart.jsp">Cart</a>
        <a href="index.jsp">Home</a>
        <%
            session = request.getSession(true);
            String namex = (String) session.getAttribute("authenticatedUser");
            if (namex != null) {
                out.print("Logged in as:" + namex);
            }
        %>
    </div>
</div>


<%
    session = request.getSession(true);
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String address = request.getParameter("address");
    String contact = request.getParameter("contact");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalcode");
    String Country = request.getParameter("country");
    String email = request.getParameter("email");

    getConnection();
    String sql1 = "Select customerId from customer where userId = ?";
    PreparedStatement y = con.prepareStatement(sql1);
    y.setString(1, username);
    ResultSet rst = y.executeQuery();
    if (rst.next()) {
        out.print("<h2>Username already taken. Try a different username</h2>");
    } else {
        String sql = "INSERT into customer values (?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement x = con.prepareStatement(sql);
        x.setString(1, first_name);
        x.setString(2, last_name);
        x.setString(3, email);
        x.setString(4, contact);
        x.setString(5, address);
        x.setString(6, city);
        x.setString(7, state);
        x.setString(8, postalCode);
        x.setString(9, Country);
        x.setString(10, username);
        x.setString(11, password);
        x.executeUpdate();
        out.print("<h2>new Customer added!</h2>");
    }
%>


</body>
</html>
