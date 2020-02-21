<!DOCTYPE html>
<html lang="en">

<head>
    <title>Locations</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
    <style>
        #map {
            height: 400px;
            width: 100%;
        }
    </style>
</head>

<body>


<div class="container text-center">
    <div class="row content">
        <div class="col-sm-2">
        </div>
        <div class="col-sm-8 text-left" style="text-align:center">
            <h1 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Locations</h1>
            <p>&nbsp;</p>

            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Vancouver, BC</h3>
            <p>&nbsp;</p>

            <hr>

            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Kelowna, BC</h3>
            <p>&nbsp;</p>
            <hr>

            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Toronto, ON</h3>
            <p>&nbsp;</p>
            <hr>

            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">New Delhi, India</h3>
            <p>&nbsp;</p>
            <hr>

            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Manila, Philippines</h3>
            <p>&nbsp;</p>
            <hr>


            <h2 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Address</h2>
            <p>&nbsp;</p>
            <div id="map"></div>
            <script>
                function initMap() {
                    var kelowna = {lat: 49.882114, lng: -119.477829};
                    var Vancouver = {lat: 49.246292, lng: -119.477829};
                    var Toronto = {lat: 43.761539, lng: -79.411079};
                    var New_Delhi = {lat: 28.644800, lng: 77.216721};
                    var Philippines = {lat: 14.599512, lng: 120.984222};
                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 2,
                        center: kelowna
                    });
                    var marker = new google.maps.Marker({
                        position: kelowna,
                        map: map
                    });
                    var marker = new google.maps.Marker({
                        position: Vancouver,
                        map: map
                    });
                    var marker = new google.maps.Marker({
                        position: Toronto,
                        map: map
                    });
                    var marker = new google.maps.Marker({
                        position: New_Delhi,
                        map: map
                    });
                    var marker = new google.maps.Marker({
                        position: Philippines,
                        map: map
                    });
                }
            </script>
            <script async defer
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD155hbzvlPXhucZkvWMypkBcpASr0OevM&callback=initMap">
            </script>


            <hr>

        </div>
        <div class="col-sm-2">
        </div>
    </div>
</div>


</body>

</html>