<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
	getConnection();

// TODO: Print Customer information
	String sql = "SELECT * from customer where userid = ?;";

	PreparedStatement x = con.prepareStatement(sql);
	x.setString(1,userName);
	ResultSet x1 = x.executeQuery();
	while (x1.next()) {
		out.print("<h3>Customer Profile</h3>\n" +
				"<table class=\"table\" border=\"1\">\n" +
				"<tr><th>Id</th><td>" + x1.getInt("customerId")+ "</td></tr>\n" +
				"<tr><th>First Name</th><td>" + x1.getString("firstName")+ "</td></tr>\n" +
				"<tr><th>Last Name</th><td>"+x1.getString("lastName")+"</td></tr>\n" +
				"<tr><th>Email</th><td>"+x1.getString("email")+"</td></tr>\n" +
				"<tr><th>Phone</th><td>"+x1.getString("phonenum")+"</td></tr>\n" +
				"<tr><th>Address</th><td>" + x1.getString("address")+"</td></tr>\n" +
				"<tr><th>City</th><td>"+x1.getString("city")+"</td></tr>\n" +
				"<tr><th>State</th><td>"+ x1.getString("state")+"</td></tr>\n" +
				"<tr><th>Postal Code</th><td>"+x1.getString("postalCode")+"</td></tr>\n" +
				"<tr><th>Country</th><td>"+x1.getString("country")+"</td></tr>\n" +
				"<tr><th>User id</th><td>"+x1.getString("userid")+"</td></tr>\n" +
				"</table>");
	}

// Make sure to close connection
%>

</body>
</html>

