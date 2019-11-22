<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

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
          //  Statement stmt2 = con.createStatement();
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
            //int binary = x1.getBinaryStream(4
          //  );
            out.print("<h2>" + name + "</h2>");
            out.print("<table><tr>\n" +
                    "<th>Id</th><td>"+ productid + "</td></tr><tr><th>Price</th><td>"+price+"</td></tr>\n" +

                    "<img src=\""+ URL + "\">\n" +
                    "<img src=\"displayImage.jsp?id="+productid+"\">\n" +
                    "</table>");
             productnamehtml = productnamehtml= java.net.URLEncoder.encode(name,"UTF-8").replace("+","%20");
        }
        out.print("<h3><a href=\"addcart.jsp?id=" + productid + "&name=" + productnamehtml + "&price=" + price+ "\">"+"Add to Cart"+"</a></h3>\n");
       // out.print"<h3><a href=\"addcart.jsp?id=1&name=Pure Apple Juice&price=18.0\">Add to Cart</a></h3>"
         out.print("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>\n");



    }



// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

