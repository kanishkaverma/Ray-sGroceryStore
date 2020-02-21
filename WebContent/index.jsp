<!DOCTYPE html>
<html>
<head>
    <style>
        .container {
            position: relative;
        }

        .topright {
            position: absolute;
            top: 8px;
            right: 16px;
            font-size: 18px;
        }
    </style>
    <title>Ray's Grocery Main Page</title>
    <link href="bootstrap.min.css" rel="stylesheet">
    <div class="header">

        <div class="header-right">
            <a href="https://www.facebook.com/sharer/sharer.php?u=example.org" target="_blank">
                Share on Facebook
            </a>
        </div>
        </head>
<body>

<div class="topright"><a href="About.jsp">About</a></div>

<% session = request.getSession(true);
    String name = (String) session.getAttribute("authenticatedUser");%>
<h1 align="center">Welcome to Ray's Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="location.jsp">Find us</a></h2>

<% if (name == null) {
    out.print("<h2 align=\"center\"><a href=\"Register.jsp\">Register New Customer</a></h2>");
}
    ;%>

<% if (name != null) {
    out.print("<h2 align=\"center\"><a href=\"logout.jsp\">Log out</a></h2>");
}
    ; %>


<%
    if (name != null) {
        out.print("<h3 align=\"center\">Signed in as:" + name + " </h3>");
    }

%>
</body>
</head>
</html>


