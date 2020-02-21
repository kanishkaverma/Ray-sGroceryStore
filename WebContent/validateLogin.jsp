<%@ page language="java" import="java.io.IOException,java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="jdbc.jsp" %>
<%
    String authenticatedUser = null;
    session = request.getSession(true);

    try {
        authenticatedUser = validateLogin(out, request, session);
    } catch (IOException e) {
        System.err.println(e);
    }

    if (authenticatedUser != null)
        response.sendRedirect("index.jsp");        // Successful login
    else
        response.sendRedirect("login.jsp");        // Failed login - redirect back to login page with a message
%>


<%!
    String validateLogin(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String retStr = null;

        if (username == null || password == null)
            return null;
        if ((username.length() == 0) || (password.length() == 0))
            return null;

        try {
            getConnection();

            String Sql = "SELECT * from customer where userid = ? and password = ?;";
            PreparedStatement x = con.prepareStatement(Sql);
            x.setString(1, username);
            x.setString(2, password);
            ResultSet x1 = x.executeQuery();
            if (x1.next()) {
                retStr = username;
            }
        } catch (SQLException ex) {
            out.println(ex);
        } finally {
            closeConnection();
        }

        if (retStr != null) {
            session.removeAttribute("loginMessage");
            session.setAttribute("authenticatedUser", username);
        } else
            session.setAttribute("loginMessage", "Could not connect to the system using that username/password.");

        return retStr;
    }
%>

