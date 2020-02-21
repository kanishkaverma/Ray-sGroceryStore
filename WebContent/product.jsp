<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Ray's Grocery - Product Information</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
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

    <%@ include file="header.jsp" %>

        <%
// Get product name to search for
// TODO: Retrieve and display info for the product
    String productid = request.getParameter("id");
    try
    {	// Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e)
    {
        out.println("ClassNotFoundException: " +e);
    }
    String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
    String uid = "kverma";
    String pw = "41062175";

    try (



            Connection con = DriverManager.getConnection(url, uid, pw);
    ) {
        String productnamehtml = " ";
        double price = 0;
        String sql = "SELECT productName, productPrice, productImageURL, productImage FROM product WHERE productId = ?";
        PreparedStatement x =  con.prepareStatement(sql);
        x.setString(1, productid);
        ResultSet x1 = x.executeQuery();
        while (x1.next()) {
            String name = x1.getString(1);
             price = x1.getDouble(2
            );
            String URL = x1.getString(3);
            out.print("<h2>" + name + "</h2>");
            out.print("<table><tr>\n" +
                    "<th>Id</th><td>"+ productid + "</td></tr><tr><th>Price</th><td>"+price+"</td></tr>\n" +

                    "<img src=\""+ URL + "\">\n" +
                    "<img src=\"displayImage.jsp?id="+productid+"\">\n" +
                    "</table>");
             productnamehtml = productnamehtml= java.net.URLEncoder.encode(name,StandardCharsets.UTF_8).replace("+","%20");
        }
        out.print("<h3><a href=\"addcart.jsp?id=" + productid + "&name=" + productnamehtml + "&price=" + price+ "\">"+"Add to Cart"+"</a></h3>\n");
         out.print("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>\n");
    }
    getConnection();
    out.print("<a href=\"Review.jsp?id=" + productid+"\">Write Review</a>");
    out.print("<br>");
    out.print("<a href=\"inventory.jsp?id=" + productid+"\">Item Inventory by warehouse</a>");
    String sql1 = "SELECT  reviewId, reviewRating, reviewDate,reviewComment from review where productId = ?;";
    PreparedStatement x1 =  con.prepareStatement(sql1);
    PreparedStatement x2 = con.prepareStatement(sql1);
    x2.setInt(1,Integer.parseInt(productid));
    x1.setInt(1, Integer.parseInt(productid));
    ResultSet x3 = x1.executeQuery();
    ResultSet x4 = x2.executeQuery();
    if (x4.next() == false) {
    }else{out.print("<table border=1><tr><th>review No.</th><th>Rating</th><th>Date</th><th>Review Comment</th></tr>");
    while (x3.next()) {
        out.print("<tr><td>" + x3.getInt(1) + "</td>" + "<td>" + x3.getInt(2) + "</td>" + "<td>" + x3.getDate(3) + "</td>"
                + "<td>" + x3.getString(4) + "</td></tr>");}}
%> <h4 align="right">
</h4>


</body>
</html>

