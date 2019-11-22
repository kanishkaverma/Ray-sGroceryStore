<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<!DOCTYPE html>
<html>
<head>
    <title>kanishka's Grocery</title>
</head>
<body>
<div class="header">

    <div class="header-right">
        <a class="active" href="listprod.jsp">products</a>
        <a href="listorder.jsp">Orders</a>
        <a href="showcart.jsp">Cart</a>
        <a href="shop.html">Home</a>
    </div>
</div>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
    <input type="text" name="productName" size="50">
    <input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
    String name = request.getParameter("productName");

//Note: Forces loading of SQL Server driver
    String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
    String uid = "kverma";
    String pw = "41062175";
    if (name == null) {


        try {    // Load driver class
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (java.lang.ClassNotFoundException e) {
            out.println("ClassNotFoundException: " + e);
        }


        try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt2 = con.createStatement();) {
            String y = "SELECT productName, productPrice, productId FROM product";

            PreparedStatement stmt = con.prepareStatement(y);
            //stmt.setString(1,name);
            ResultSet rst2 = stmt.executeQuery();
            // int orderid;
            out.print("<b>ALL ORDERS</b>");
            //out.print("<table border=1>");
            //out.print("<tr>" + "<th></th> "  +"<th>" + "Product Name" + "</th>" + "<th>" + "Price" + "</th></tr>");
            out.print("<table><tr><th></th><th>Product Name</th><th>price</th></tr>");
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            while (rst2.next()) {

                String productname = rst2.getString(1);
                String productnamehtml = productnamehtml= java.net.URLEncoder.encode(productname,"UTF-8").replace("+","%20");
                double price = rst2.getDouble(2);

                int id = rst2.getInt(3);
                out.print("<tr>" +  "<td>" +"<a href="+"addcart.jsp?id="+ id+ "&name="+productnamehtml+"&price="+ price+">" +"Add To Cart" + "</a>" + "</td><td><a href = product.jsp?id="+id+">" + productname + "</a>"+ "</td>" + "<td>" +
                        currFormat.format(price)  + "</td></tr>");
            }
            out.print("</table>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }





    else
    {


    try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt2 = con.createStatement();) {
        String y = "SELECT productName, productPrice, productId FROM product where productName LIKE '%' + ? + '%'";

        PreparedStatement stmt = con.prepareStatement(y);
        stmt.setString(1,name);
        ResultSet rst2 = stmt.executeQuery();
       // int orderid;
        if (name != null) {
            out.print("<b>Products Containing " + '"' + name + '"' + "</b>");
        }

        //out.print("<table border=1>");
        out.print("<table><tr><th></th><th>Product Name</th><th>price</th></tr>");
        //out.print("<tr>" +"<th>"  + "</th>"+ "<th>" + "Product Name" + "</th>" + "<th>" + "Price" + "</th></tr>");
        while (rst2.next()) {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            String productname = rst2.getString(1);
            String productnamehtml = productnamehtml= java.net.URLEncoder.encode(productname,"UTF-8").replace("+","%20");
            double price = rst2.getDouble(2);
            int id = rst2.getInt(3);

            out.print("<tr>" +  "<td>" +"<a href="+"addcart.jsp?id="+ id+ "&name="+productnamehtml+"&price="+ price+">" +"Add To Cart" + "</a>" + "</td><td>" + productname + "</td>" + "<td>" +
                    currFormat.format(price)  + "</td></tr>"); }
        out.print("</table>");
    } catch (SQLException e) {
        e.printStackTrace();
    }}
// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>