<!DOCTYPE html>
<html>
<head>
    <title>Ray's Grocery CheckOut Line</title>
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

<h1>Enter your customer id and password to complete the transaction:</h1>

<form method="get" action="order.jsp">
    <input type="text" name="customerId" size="50">Password:<input type="password" name="password"/>
    <input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>

