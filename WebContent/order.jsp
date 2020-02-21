<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<!DOCTYPE html>
<html>
<head>
    <title>YOUR NAME Grocery Order Processing</title>
</head>
<body>
<div class="header">

    <div class="header-right">
        <a class="active" href="listprod.jsp">products</a>
        <a href="listorder.jsp">Orders</a>
        <a href="showcart.jsp">Cart</a>
        <a href="shop.html">home </a>
    </div>
</div>

<%
    // Get customer id
    String custId = request.getParameter("customerId");
    String password = request.getParameter("password");


    Integer customeridint = 0;
    try {
        customeridint = Integer.valueOf(custId);
    } catch (NumberFormatException e) {
        out.print("CustomerID needs to be a number");
    }
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
    String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
    String uid = "kverma";
    String pw = "41062175";
    boolean isnumber = true;
    boolean isCustomer = false;
    boolean passwordtruw = false;
    boolean onlyhas0qty = true;
    try {    // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " + e);

    }


    try (Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt2 = con.createStatement();) {
        if (password != null) {
            String pass = "SELECT password from customer where customerId = ?";
            PreparedStatement stmt = con.prepareStatement(pass);
            stmt.setInt(1, customeridint);
            ResultSet x = stmt.executeQuery();
            x.next();
            String actualpassword = x.getString("password");

            if (password.equals(actualpassword)) {
                passwordtruw = true;
            }
        }
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator1 = null;
        try {
            iterator1 = productList.entrySet().iterator();
        } catch (NullPointerException e) {
            out.print("Empty cart");
        }
        while (iterator1.hasNext()) {
            Map.Entry<String, ArrayList<Object>> entry1 = iterator1.next();
            ArrayList<Object> product = entry1.getValue();
            int qty1 = ((Integer) product.get(3)).intValue();
            if (qty1 != 0) {
                onlyhas0qty = false;
            }
        }

        String y = "SELECT * FROM customer WHERE customerId = ?";
        PreparedStatement stmt = con.prepareStatement(y);
        stmt.setInt(1, customeridint);
        ResultSet rst2 = stmt.executeQuery();
        while (rst2.next()) {
            isCustomer = true;
        }
        for (int i = 0; i < custId.length(); i++) {
            if (Character.isDigit(custId.charAt(i)) == false) {
                isnumber = false;
                break;
            }
        }
        if (isCustomer == false | isnumber == false | passwordtruw == false) {

            out.print("Invalid Customer ID Or password. Try again. ");

        } else if (productList == null | onlyhas0qty == true) {
            out.print("No items in your order. Go back and get some orders in your cart to checkout.");
        } else {
            String sql = "INSERT INTO ordersummary (customerId, orderDate) values (?,?) ;";
            PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, custId);
            pstmt.setString(2, (new java.util.Date()).toLocaleString());
            int insert = pstmt.executeUpdate();
            ResultSet rst_keys = pstmt.getGeneratedKeys();
            rst_keys.next();
            int orderId = rst_keys.getInt(1);
            Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
            onlyhas0qty = false;
            double totalA = 0;
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            out.println("<h1>Your Order Summary</h1>");
            out.println("<table> <tr> <th>Product Id</th>  <th>Quantity</th> <th>Price</th>  <th>Subtotal</th> </tr>");
            while (iterator.hasNext()) {
                Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = entry.getValue();
                String productId = (String) product.get(0);
                String price = (String) product.get(2);
                double pr = Double.parseDouble(price);
                int pid = Integer.parseInt(productId);
                int qty = ((Integer) product.get(3)).intValue();

                totalA += pr * qty;
                if (qty > 0) {
                    onlyhas0qty = false;
                    out.print("<tr><td>" + productId + "</td> <td>" + qty + "</td><td>" + currFormat.format(pr) + "</td>" + "<td>" + currFormat.format(pr * qty) + "</td></tr>");
                    String sql2 = "INSERT INTO orderproduct (orderId, productId, quantity, price) values (?,?,?,?) ;"; //orderId, 0, 2, 3
                    PreparedStatement pstmt2 = con.prepareStatement(sql2);
                    pstmt2.setInt(1, orderId);
                    pstmt2.setString(2, productId);
                    pstmt2.setInt(3, qty);
                    pstmt2.setDouble(4, pr);
                    int insert2 = pstmt2.executeUpdate();
                }
            }
            String sql2 = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
            PreparedStatement pstUpdateTotal = con.prepareStatement(sql2);
            pstUpdateTotal.setDouble(1, totalA);
            pstUpdateTotal.setInt(2, orderId);
            pstUpdateTotal.executeUpdate();
            out.print("<tr><td colspan=\"4\" align=\"right\"><strong>Total:</strong></td><td class=\"currency\">" + currFormat.format(totalA) + "</td></tr></tbody></table>");
            out.println(" </table>");
            out.println("<h1>Order completed.  Will be shipped soon...</h1>");
            out.println("<h1>Your order reference number is: " + orderId + "</h1>");
            String sql3 = "SELECT firstName from  customer where customerID = ?";
            PreparedStatement customername = con.prepareStatement(sql3);
            customername.setInt(1, customeridint);
            ResultSet customernamerst = customername.executeQuery();
            customernamerst.next();
            String cusname = customernamerst.getString("firstName");
            out.println("<h1>Shipping to customer:" + customeridint + " Name:" + cusname + "</h1>");
            out.println("<h2><a href=\"shop.html\">Return to shopping</a></h2>");
            productList.clear();
            session.invalidate();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
</BODY>
</HTML>

