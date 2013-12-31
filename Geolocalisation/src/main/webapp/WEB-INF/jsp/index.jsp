
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>

    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

        <title>Marquer une adresse sur Google Maps</title>

        <style type="text/css">
            html { height: 100% }
            body { height: 90%; margin: 5px; padding: 5px }
            h3, form { text-align: center }
            span.centered { 
            	display: block;
     			text-align: center;}
            div.displayed {
    			display: block;
    			margin-left: auto;
   				margin-right: auto }
            #map-canvas { height: 80% ; width:80%;}
        </style>

        <!-- Inclure certaines fonctions javascript externes -->
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false&language=fr"></script>
       
        <!-- Intégration de la javascript API google maps -->
        <script type="text/javascript">
            var geocoder;
            var map;
            var marker;


            /** initialisation de la carte Google Map de départ */
            function initialiserCarte() {
                geocoder = new google.maps.Geocoder();
                // Ici on a mis la latitude et longitude de la ville de Safi, Maroc
                var latlng = new google.maps.LatLng(32.310059, -9.236617000000024);
                var mapOptions = {
                    zoom: 14,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                }
                // map-canvas est le conteneur HTML de la carte Google Map
                map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
            }
            
      
            
            /** Recherche et localisation des adresses */
            function TrouverAdresse() {
                // Récupération de l'adresse tapée dans le formulaire
                var adresse = document.getElementById('adresse').value;
                geocoder.geocode({'address': adresse}, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                    	placeMarker(results[0].geometry.location);
                        // Récupération des coordonnées GPS du lieu tapé dans le formulaire
                        var strposition = results[0].geometry.location + "";
                        strposition = strposition.replace('(', '');
                        strposition = strposition.replace(')', '');
                        // Affichage des coordonnées dans le <span>
                        document.getElementById('text_latlng').innerHTML = 'Coordonnées : ' + strposition;
                        
                        // Création du marqueur du lieu (Maison)
                        var image = {
                            url: 'http://icons.iconarchive.com/icons/deleket/sleek-xp-basic/24/Home-icon.png'
                        };
						
                        /*
                        // Définition d'un marqueur d'adresses
                        var marker = new google.maps.Marker({
                            map: map,
                            position: results[0].geometry.location,
                            icon: image
                        });
                        */
                    } else {
                    	
                        alert('Adresse introuvable: ' + status);
                    }
                });
            }

            /** Fonction pour supprimer l'ancien marqueur et garder que celui de l'emplacement recherché dans le gecoding */
			function placeMarker(location) {
            	
				// Personnaliser l'icon du marqueur (sous forme Maison)
            	var image = {
                        url: 'http://icons.iconarchive.com/icons/deleket/sleek-xp-basic/24/Home-icon.png'
                    };
            	
                if (marker) {
                	
                    // Si le marqueur existe déja, changer sa position
                    marker.setPosition(location);
                    
                    // Recharger la map et la centrer en l'adresse de location
                    map.setCenter(location);
                } else {
                	
                    //créer un marqueur
                    marker = new google.maps.Marker({
                        position: location,
                        map: map,
                        icon: image
                    });
                    
                 	// Recharger la map
                    map.setCenter(location);
                }
            }
		
            // Lancement de la construction de la carte google map
            google.maps.event.addDomListener(window, 'load', initialiserCarte);

        </script>

    </head>

    <body onload="initialiserCarte();">
        <h3> ${message} </h3>
        <form>
            <div>Tapez une adresse :</div>
            <input type="text" id="adresse"/>
            <input type="button"  value="Localiser sur Google Maps" onclick="TrouverAdresse();"/>
        </form>
        <span class="centered" id="text_latlng"></span><br>
        <div class="displayed" id="map-canvas" ></div>
    </body>

</html>