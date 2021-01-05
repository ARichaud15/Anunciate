var coords = {};    //coordenadas obtenidas con la geolocalización

//Funcion principal
initMap = function () 
{
    if( navigator.geolocation)
    {
        //usamos la API para geolocalizar el usuario
        navigator.geolocation.getCurrentPosition(
        function (position){
            coords =  {
                lng: position.coords.longitude,
                lat: position.coords.latitude
            };
            setMapa(coords);  //pasamos las coordenadas al metodo para crear el mapa
            setAddress(coords);
        },function(error){console.log(error);});
    }
}

function setMapa (coords)
{
    var coord = new google.maps.LatLng(coords.lat, coords.lng);
    var infowindow = new google.maps.InfoWindow;
    
    //Se crea una nueva instancia del objeto mapa
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 17,
        center:new google.maps.LatLng(coords.lat,coords.lng),
    });

    var marker = new google.maps.Marker({
        map: map,
        draggable: true,
        position: new google.maps.LatLng(coords.lat, coords.lng),
    });
    
    google.maps.event.addListener(marker,'dragend',function(event) 
    {
        var coords_aux = this.getPosition().toString();
        
        var coords_1 = coords_aux,
        caracter_1 = "(",
        nuevoValor = "",
        nuevaCadena = coords_1.replace(caracter_1, nuevoValor);

        var coords_2 = nuevaCadena,
        caracter_2 = ")",
        nuevoValor = "",
        coords = coords_2.replace(caracter_2, nuevoValor);

        setAddress_marker(coords);
        
    });
    
    infowindow.setContent('<p>Instrucciones:</p> <p>Haz click y arrastra este marcador sobre el mapa hasta conocer la ubicación exacta de tu negocio.</p> ');
    infowindow.open(map, marker);
}

function setAddress (coords)
{
    var geocoder = new google.maps.Geocoder;
    var input = coords.lat + ',' + coords.lng;
    geocodeLatLng(geocoder, input);
}

function setAddress_marker (coords)
{
    var geocoder = new google.maps.Geocoder;
    var input = coords;
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
                document.getElementById('Coordenadas').value = input;
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


          