<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: kanishka
  Date: 11/27/2019
  Time: 12:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" %>
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
<lb></lb>
<h1> Review Form</h1>
<% session = request.getSession(true);
    String idx = request.getParameter("id"); %>
<%     final java.util.Date todayDate = new Date();

    System.out.println(todayDate);
String x = new SimpleDateFormat("yyyy-MM-dd").format(todayDate);



    System.out.println(todayDate);%>
<form action="feedreview.jsp" method="post" id="z">

    Rating(0-5): <input type="number" min="0" max="5" name="rating" size="35" required="required">
    <br/>
    Date: <input type="date" name="date" size="35" required="required" max = "<%=x%>">
    <br/>

    Customer ID <input type="text" name="custId" size="35" required="required">
    <input type="submit" value="Submit"/>
    <input type="hidden" id="prodId" name="prodid" value="<%= idx         %>">

</form>
<br>
<textarea rows="4" cols="50" name="comment" form="z"  placeholder="Enter your comment here">
</textarea>

</body>
</html>
