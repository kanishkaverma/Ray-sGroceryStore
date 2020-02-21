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
<%@include file="auth.jsp" %>
<html>
<head>
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

        </head>
<body>


<%
    session = request.getSession(true);
    String prodid = request.getParameter("id");
    getConnection();
    String sql = "\n" +
            "SELECT productinventory.warehouseid,  warehousename, quantity, price from productinventory,warehouse where productId = ? and warehouse.warehouseId = productinventory.warehouseid order by productinventory.warehouseId,warehousename";
    PreparedStatement x = con.prepareStatement(sql);
    x.setInt(1, Integer.parseInt(prodid));
    ResultSet z = x.executeQuery();
    if (z.next() == false) {
        out.print("<h2>Currently no supplier.</h2>");
    } else {
        out.print("<table border = \"1\"><tr><th>WarehouseID</th><th>WarehouseName</th><th>Quantity</th><th>price/$</th>");
        do {
            out.print("<tr><td>" + z.getInt(1) + "</td><td>" + z.getString(2) + "</td><td>" + z.getInt(3) + "</td><td>" + z.getDouble(4) + "</td></tr>");
        } while (z.next());
    }
%>


</body>
</html>
