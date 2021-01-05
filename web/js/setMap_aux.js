initMap = function () 
{
    var latlngStr = coords.split(',', 2);
    var coord = {lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1])};
    setAddress(coord);
    setMapa(coord);
}

function setMapa (coords)
{
    var coord = new google.maps.LatLng(coords.lat, coords.lng);
    var infowindow = new google.maps.InfoWindow;
    
    //Se crea una nueva instancia del objeto mapa
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 17,
        center:new google.maps.LatLng(coords.lat, coords.lng),
    });

    var marker = new google.maps.Marker({
        map: map,
        draggable: false,
        position: new google.maps.LatLng(coords.lat, coords.lng),
    });
    infowindow.setContent('<p>Aqui esta tu negocio</p>');
    infowindow.open(map, marker);
    console.log(error);
}
function setAddress (coords)
{
    var geocoder = new google.maps.Geocoder;
    var input = coords.lat + ',' + coords.lng;
    geocodeLatLng(geocoder, input);
}

function geocodeLatLng(geocoder, input) 
{
    var latlngStr = input.split(',', 2);
    var latlng = {lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1])};
    
    geocoder.geocode({'location': latlng,}, function(results, status) 
    {
        if (status === 'OK') 
        {
            if (results[0]) 
            {
                document.getElementById('Calle').value = results[0].address_components[1].long_name;
                document.getElementById('Numero_exterior').value = results[0].address_components[0].long_name;
                document.getElementById('Codigo_postal').value = results[0].address_components[7].long_name;
                document.getElementById('Colonia').value = results[0].address_components[2].long_name;
                document.getElementById('Ciudad').value = results[0].address_components[3].long_name;
                document.getElementById('Municipio').value = results[0].address_components[4].long_name;
                document.getElementById('Estado').value = results[0].address_components[5].long_name;
            } 
            else 
            {
                window.alert('No results found');
            }
        } 
        else 
        {
            window.alert('Geocoder failed due to: ' + status);
        }
    });
}
