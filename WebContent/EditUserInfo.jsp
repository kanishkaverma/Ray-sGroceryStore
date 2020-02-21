<%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/26/2019
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="jdbc.jsp" %>
<%@include file="auth.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<%  session = request.getSession(true);
    String namex = (String) session.getAttribute("authenticatedUser");
    session = request.getSession(true);
    String address = request.getParameter("address");
    String password1 = request.getParameter("password1");
    if (password1 == "") {
        getConnection();
        String sql = "update customer set address = ? where userId = ?";
        PreparedStatement x = con.prepareStatement(sql);
        x.setString(1, address);
        x.setString(2, namex);
        x.executeUpdate();
    } else if (address == "") {
        getConnection();
        String sql = "update customer set password = ? where userId = ?";
        PreparedStatement x = con.prepareStatement(sql);
        x.setString(1, password1);
        x.setString(2, namex);
        x.executeUpdate();
    } else {
        getConnection();
        String sql = "update customer set address= ?, password = ? where userid = ?";
        PreparedStatement x = con.prepareStatement(sql);
        x.setString(1, address);
        x.setString(2, password1);
        x.setString(3, namex);
        x.executeUpdate();
    }
%> <h2>Address/password updated!</h2>


</body>
</html>
