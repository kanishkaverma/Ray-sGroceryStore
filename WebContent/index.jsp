<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>
    <link href="bootstrap.min.css" rel="stylesheet">
</head>
<body>
<h1 align="center">Welcome to Ray's Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>


<%  session = request.getSession(true);
   String name = (String) session.getAttribute("authenticatedUser");
        if (name != null) {
                out.print("<h3 align=\"center\">Signed in as:" + name + " </h3>");
        }

%>
</body>
</head>
</html>


