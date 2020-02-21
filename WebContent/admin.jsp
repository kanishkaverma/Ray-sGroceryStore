<%@ page import="java.util.Date" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>

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


<%@include file="jdbc.jsp" %>
<%@include file="auth.jsp" %>


<%

    // TODO: Write SQL query that prints out total order amount by day
    getConnection();
    String sql = "SELECT CAST(orderDate as DATE) as dateField , sum(totalAmount) as TotalAmount from ordersummary group by CAST(orderDate AS DATE);";
    PreparedStatement x = con.prepareStatement(sql
    );
    ResultSet x1 = x.executeQuery();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    out.print("<table class=\"table\" border=\"1\">\n" + "<tr><th>Order Date</th><th>Total Order Amount</th>");
    while (x1.next()) {

        Date orderdate = x1.getDate(1);
        Double totalAmount = x1.getDouble(2);

        out.print("<tr><td>" + orderdate + "</td><td>" + currFormat.format(totalAmount) + " </td></tr>");
    }
    out.print("<a href = \"visualization.jsp\">" + "Visualize" + "</a>");


%>

</body>
</html>

