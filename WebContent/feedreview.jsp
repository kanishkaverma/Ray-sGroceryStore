<%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/26/2019
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.PreparedStatement,java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
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
    String rating = request.getParameter("rating");
    String date = request.getParameter("date");
    Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(date);

    String comment = request.getParameter("comment");
    String CustId = request.getParameter("custId");
    String prodid = request.getParameter("prodid");
    getConnection();
    String sql = "INSERT into review values  (?,?,?,?,?)";
    PreparedStatement x = con.prepareStatement(sql);
    x.setInt(1, Integer.parseInt(rating));
    x.setDate(2, new java.sql.Date(date1.getTime()));
    x.setInt(3, Integer.parseInt(CustId));
    x.setInt(4, Integer.parseInt(prodid));
    x.setString(5, comment);
    x.executeUpdate();
%> <h2>Review Added!</h2>


</body>
</html>
