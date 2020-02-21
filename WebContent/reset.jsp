<%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/26/2019
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.io.File,java.io.FileInputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.Scanner" %>
<%@include file="jdbc.jsp" %>
<html>
<head>
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


<%
    getConnection();
    Statement stmt = con.createStatement();
    URL url = new URL("https://cosc304.ok.ubc.ca/41062175/tomcat/lab_8/orderdb_sql.ddl");
    Scanner scanner = new Scanner(url.openStream());//.useDelimiter("\\A").next();
    scanner.useDelimiter(";");
    while (scanner.hasNext()) {
        String command = scanner.next();
        if (command.trim().equals(""))
            continue;
        System.out.println(command);
        try {
            stmt.execute(command);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    scanner.close();

    System.out.println("Database loaded.");
    for (int i = 1; i < 30; i++) {
        File imgfile = new File("./img/" + i + "_a" + ".jpg");
        URL x = new URL("\"./img/\" + i + \"_a\" + \".jpg\"");
        FileInputStream fin = new FileInputStream(x);
        PreparedStatement pre = con.prepareStatement("UPDATE Product SET productImage = ? WHERE ProductId = ?;");
        System.out.println(fin);;
        pre.setBinaryStream(1, fin, (int) imgfile.length());
        pre.setInt(2, i);
        pre.executeUpdate();
    }
%> <h2>Database reseted!</h2>


</body>
</html>
