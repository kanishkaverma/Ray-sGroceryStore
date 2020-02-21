<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Date" %>
<html>
<%@include file="jdbc.jsp" %>

<head>
    <title> chart </title>
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages': ['corechart']});
        google.charts.setOnLoadCallback(drawChart);


        <%

        // TODO: Write SQL query that prints out total order amount by day
            getConnection();
        String sql = "SELECT CAST(orderDate as DATE) as dateField , sum(totalAmount) as TotalAmount from ordersummary group by CAST(orderDate AS DATE);";
            PreparedStatement x = con.prepareStatement(sql
            );
            ResultSet x1 = x.executeQuery();
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
%>

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Date', 'Sales']<%   while (x1.next()) {

    Date orderdate = x1.getDate(1);
    String dateString = orderdate + "";
        String[] str = dateString.split("-");
int year = Integer.parseInt(str[0]);
int date = Integer.parseInt(str[1]);
int month = Integer.parseInt(str[2]);
    Double totalAmount = x1.getDouble(2);

  out.print(",");  out.print("[" + "new Date(" + (year) + "," + (date-1) +","+(month) + ")"+ ',' +totalAmount+"]");

}
%>
            ]);

            var options = {
                title: 'Company Performance',
                curveType: 'function',
                legend: {position: 'bottom'}
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

            chart.draw(data, options);
        }
    </script>
</head>
<body>
<div id="curve_chart" style="width: 900px; height: 500px"></div>
</body>
</html>