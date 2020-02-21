<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
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
<h2><b> Change address/password </b></h2>
<form action="EditUserInfo.jsp" method="GET">
    New address: <input type="text" name="address" size="35" placeholder="same as prev username if no change">
    <br/>
    New Password: <input type="password" name="password1" size="35" placeholder="same as prev password if no change"/>
    <input type="submit" value="Submit"/>
</form>

<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
    getConnection();

// TODO: Print Customer information
    String sql = "SELECT * from customer where userid = ?;";

    PreparedStatement x = con.prepareStatement(sql);
    x.setString(1, userName);
    ResultSet x1 = x.executeQuery();
    while (x1.next()) {
        out.print("<h3>Customer Profile</h3>\n" +
                "<table class=\"table\" border=\"1\">\n" +
                "<tr><th>Id</th><td>" + x1.getInt("customerId") + "</td></tr>\n" +
                "<tr><th>First Name</th><td>" + x1.getString("firstName") + "</td></tr>\n" +
                "<tr><th>Last Name</th><td>" + x1.getString("lastName") + "</td></tr>\n" +
                "<tr><th>Email</th><td>" + x1.getString("email") + "</td></tr>\n" +
                "<tr><th>Phone</th><td>" + x1.getString("phonenum") + "</td></tr>\n" +
                "<tr><th>Address</th><td>" + x1.getString("address") + "</td></tr>\n" +
                "<tr><th>City</th><td>" + x1.getString("city") + "</td></tr>\n" +
                "<tr><th>State</th><td>" + x1.getString("state") + "</td></tr>\n" +
                "<tr><th>Postal Code</th><td>" + x1.getString("postalCode") + "</td></tr>\n" +
                "<tr><th>Country</th><td>" + x1.getString("country") + "</td></tr>\n" +
                "<tr><th>User id</th><td>" + x1.getString("userid") + "</td></tr>\n" +
                "</table>");
    }

    String sql2 = "select orderId, orderDate, totalAmount  from ordersummary, customer where customer.customerId= ordersummary.customerId and userId = ? ;";
    PreparedStatement y = con.prepareStatement(sql2);
    y.setString(1, userName);
    ResultSet x2 = y.executeQuery();
    out.print("<h3>Orders</h3>\n" +
            "<table class=\"table\" border=\"1\">\n");
    out.print("<tr><th>Order ID</th><th>Order Date</th><th>Order Amount</th></tr>");
    while (x2.next()) {
        out.print(
                "<tr><td>" + x2.getInt(1) + "</td>" +
                        "<td>" + x2.getDate(2) + "</td>" +
                        "<td>" + x2.getDouble("totalAmount") + "</td></tr>\n");
    }
    out.print("</table>");
%>

</body>
</html>

