<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>kanishka's Grocery</title>
    <link href="bootstrap.min.css" rel="stylesheet">
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

<h1>Browse Products By Category and Search by Product Name:</h1>

<form method="get" action="listprod.jsp">
    <input type="text" name="productName" size="50">
    <input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
    <select size="1" name="categoryName">
        <option value="All">All</option>

        <% getConnection();
            String sql = "Select  categoryName from category";
            PreparedStatement x = con.prepareStatement(sql);
            ResultSet zy = x.executeQuery();
            while (zy.next()) {
                String category = zy.getString(1);
        %>

        <option value="<%=category%>"><%=category%>
        </option>
        <%}%>

    </select>
</form>


<%
    String name = request.getParameter("productName");
    String categoryname = request.getParameter("categoryName");

//Note: Forces loading of SQL Server driver
    String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
    String uid = "kverma";
    String pw = "41062175";
    if ((name == null | name == "") & (categoryname == null || categoryname.equals("All"))) {


        try {    // Load driver class
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (java.lang.ClassNotFoundException e) {
            out.println("ClassNotFoundException: " + e);
        }


        try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt2 = con.createStatement();) {
            String y = "SELECT productName, productPrice, productId, productImageURL FROM product";
            PreparedStatement stmt = con.prepareStatement(y);
            ResultSet rst2 = stmt.executeQuery();
            out.print("<b>ALL ORDERS</b>");
            out.print("<table><tr><th></th><th>Product Name</th><th>price</th></tr>");
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            while (rst2.next()) {

                String productname = rst2.getString(1);
                String productnamehtml = productnamehtml = java.net.URLEncoder.encode(productname, StandardCharsets.UTF_8).replace("+", "%20");
                double price = rst2.getDouble(2);
                String img = rst2.getString(4);

                int id = rst2.getInt(3);
                out.print("<tr>" + "<td>" + "<a href=" + "addcart.jsp?id=" + id + "&name=" + productnamehtml + "&price=" + price + ">" + "Add To Cart " + "</a>" + " " + "</td><td align=\"center\"><a href = product.jsp?id=" + id + ">" + productname + "</a>" + "</td>" + "<td>" +
                        currFormat.format(price) + "</td><td><img src = \"" + img + "\"" + "style=\"width:100px; height:100px; \"><td> </tr>");
            }
            out.print("</table>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else if (categoryname != null & name == "") {
        getConnection();
        String sql1 = "select productName, productPrice, productID, productImageURL from product,category where product.categoryId = category.categoryId and categoryName = ?";

        PreparedStatement x1 = con.prepareStatement(sql1);
        x1.setString(1, categoryname);
        ResultSet z = x1.executeQuery();

        out.print("<b>Products in " + '"' + categoryname + '"' + " category" + "</b>");
        out.print("<table><tr><th></th><th>Product Name</th><th>price</th></tr>");

        while (z.next()) {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            String productname = z.getString(1);
            String productnamehtml = productnamehtml = java.net.URLEncoder.encode(productname, StandardCharsets.UTF_8).replace("+", "%20");
            double price = z.getDouble(2);
            String img = z.getString(4);

            int id = z.getInt(3);
            out.print("<tr>" + "<td>" + "<a href=" + "addcart.jsp?id=" + id + "&name=" + productnamehtml + "&price=" + price + ">" + "Add To Cart " + "</a>" + " " + "</td><td align=\"center\"><a href = product.jsp?id=" + id + ">" + productname + "</a>" + "</td>" + "<td>" +
                    currFormat.format(price) + "</td><td><img src = \"" + img + "\"" + "style=\"width:100px; height:100px; \"><td> </tr>");
        }
        out.print("</table>");


    } else if (name != "" & categoryname.equals("All") == false) {
        out.print(categoryname);
        getConnection();
        String sql1 = "select productName, productPrice, productID, productImageURL from product,category where product.categoryId = category.categoryId and categoryName = ? and productName like '%' + ? + '%'";

        PreparedStatement x1 = con.prepareStatement(sql1);
        x1.setString(1, categoryname);
        x1.setString(2, name);
        ResultSet z = x1.executeQuery();

        out.print("<b>Products in " + '"' + categoryname + '"' + " category" + " containing " + '"' + name + '"' + "</b>");
        out.print("<table><tr><th></th><th>Product Name</th><th>price</th></tr>");

        while (z.next()) {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            String productname = z.getString(1);
            String productnamehtml = productnamehtml = java.net.URLEncoder.encode(productname, StandardCharsets.UTF_8).replace("+", "%20");
            double price = z.getDouble(2);
            String img = z.getString(4);

            int id = z.getInt(3);
            out.print("<tr>" + "<td>" + "<a href=" + "addcart.jsp?id=" + id + "&name=" + productnamehtml + "&price=" + price + ">" + "Add To Cart " + "</a>" + " " + "</td><td align=\"center\"><a href = product.jsp?id=" + id + ">" + productname + "</a>" + "</td>" + "<td>" +
                    currFormat.format(price) + "</td><td><img src = \"" + img + "\"" + "style=\"width:100px; height:100px; \"><td> </tr>");
            ;
        }
        out.print("</table>");

    } else {


        try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt2 = con.createStatement();) {
            String y = "SELECT productName, productPrice, productId, productImageURL FROM product where productName LIKE '%' + ? + '%'";

            PreparedStatement stmt = con.prepareStatement(y);
            stmt.setString(1, name);
            ResultSet rst2 = stmt.executeQuery();
            // int orderid;
            if (name != null) {
                out.print("<b>Products Containing " + '"' + name + '"' + "</b>");
            }
            out.print("<table><tr><th></th><th>Product Name</th><th>price</th></tr>");
            while (rst2.next()) {
                NumberFormat currFormat = NumberFormat.getCurrencyInstance();
                String productname = rst2.getString(1);
                String productnamehtml = productnamehtml = java.net.URLEncoder.encode(productname, StandardCharsets.UTF_8).replace("+", "%20");
                double price = rst2.getDouble(2);
                String img = rst2.getString(4);

                int id = rst2.getInt(3);
                out.print("<tr>" + "<td>" + "<a href=" + "addcart.jsp?id=" + id + "&name=" + productnamehtml + "&price=" + price + ">" + "Add To Cart " + "</a>" + " " + "</td><td align=\"center\"><a href = product.jsp?id=" + id + ">" + productname + "</a>" + "</td>" + "<td>" +
                        currFormat.format(price) + "</td><td><img src = \"" + img + "\"" + "style=\"width:100px; height:100px; \"><td> </tr>");
            }
            out.print("</table>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

%>

</body>
</html>