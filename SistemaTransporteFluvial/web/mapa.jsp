<%-- 
    Document   : index
    Created on : 17/10/2016, 03:32:30 PM
    Author     : JuanDiego
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="stf.sessionBeans.RutaFacade"%>
<%@page import="stf.entities.Cargo"%>
<%@page import="stf.sessionBeans.CargoFacade"%>
<%@page import="stf.entities.Cab"%>
<%@page import="stf.sessionBeans.CabFacade"%>
<%@page import="stf.entities.Passenger"%>
<%@page import="stf.sessionBeans.PassengerFacade"%>
<%@page import="stf.entities.Embarcacion"%>
<%@page import="stf.entities.Puerto"%>
<%@page import="java.util.List"%>
<%@page import="stf.sessionBeans.PuertoFacade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

  <head>
      <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
   

 <script data-require="jquery@2.2.0" data-semver="1.11.3" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script data-require="bootstrap.js@3.3.6" data-semver="3.3.6" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    
    <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
    <link data-require="font-awesome@4.5.0" data-semver="4.5.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.css" />
    <link rel="stylesheet" href="style.css" />

<style>
html{height:100%;}
body{height:100%;margin:0px;font-family: Helvetica,Arial;}
</style>


<% 
    PuertoFacade pf = new PuertoFacade();
    List<Puerto> puertos = pf.getPuertos();
    List<Cab> cabs = new ArrayList();
    List<Cargo> cargos = new ArrayList();
    List<Passenger> passengers = new ArrayList();
    
    PassengerFacade psf = new PassengerFacade();
    if(psf.consultarPassenger() != null){
    passengers = psf.consultarPassenger();    
    }
    CabFacade cf = new CabFacade();
    if(cf.consultarCab() != null){
        cabs = cf.consultarCab();
    }
    CargoFacade cgf = new CargoFacade();
    if(cgf.consultarCargo() != null) {
    cargos = cgf.consultarCargo();
    }
    RutaFacade rf = new RutaFacade();
    List<String> puertosSalidaCab = rf.obtenerUbicacionPuertoSalidaCab(cabs);
    List<String> puertosLlegadaCab = rf.obtenerUbicacionPuertoLlegadaCab(cabs);
    List<String> puertosSalidaPass = rf.obtenerUbicacionPuertoSalidaPass(passengers);
    List<String> puertosLlegadaPass = rf.obtenerUbicacionPuertoLlegadaPass(passengers);
    List<String> puertosSalidaCarg = rf.obtenerUbicacionPuertoSalidaCargo(cargos);
    List<String> puertosLlegadaCarg = rf.obtenerUbicacionPuertoLlegadaCargos(cargos);
%>



<script type="text/javascript">
  var map;
  var directionDisplay;
  var directionsService;
  var stepDisplay;
  var travelMode;
  var position;
  var marker = [];
  var polyline = [];
  var poly2 = [];
  var poly = null;
  var startLocation = [];
  var endLocation = [];
  var timerHandle = [];
  var distance = [];
  var valorDistancia = {};
  var x=1;
  var speed = 0.000005, wait = 1;
  var infowindow = null;
  
  var myPano;   
  var panoClient;
  var nextPanoId;
  var puertosM = new Array();
  var puertosSCab = new Array();
  var puertosLCab = new Array();
  var puertosSPass = new Array();
  var puertosLPass = new Array();
  var puertosSCargo = new Array();
  var puertosLCargo = new Array();
  
  
  <% for( int i = 0;i < puertos.size(); i++) {%>
  <% String latitud = ""+puertos.get(i).getUbicacionesIdubicacion().getLatitud();
     String longitud = ""+puertos.get(i).getUbicacionesIdubicacion().getLongitud(); %>
        var p = <%= latitud %>+","+<%= longitud %>;
        puertosM[<%=i%>] = p;   
  <%}%>
 <% for( int i = 0;i < puertosSalidaCab.size(); i++) {%>
     
      <% String [] a = puertosSalidaCab.get(i).split(","); %>
           
           var sc = <%= a[0] %> +","+<%= a[1] %>
           window.alert(sc);
    puertosSCab[<%=i%>] = sc;
  <%}%>
      
      <% for( int i = 0;i < puertosLlegadaCab.size(); i++) {%>
       
      <% String [] a = puertosLlegadaCab.get(i).split(","); %>
           
           var lc= <%= a[0] %> +","+<%= a[1] %>
        puertosLCab[<%=i%>] = lc;  
  <%}%>
      
       <% for( int i = 0;i < puertosLlegadaPass.size(); i++) {%>
       
      <% String [] a = puertosLlegadaPass.get(i).split(","); %>
           
           var lp= <%= a[0] %> +","+<%= a[1] %>
        puertosLPass[<%=i%>] = lp;  
  <%}%>
      
      <% for( int i = 0;i < puertosSalidaPass.size(); i++) {%>
       
      <% String [] a = puertosSalidaPass.get(i).split(","); %>
           
           var sp= <%= a[0] %> +","+<%= a[1] %>
        puertosSPass[<%=i%>] = sp;  
  <%}%>
      
       <% for( int i = 0;i < puertosLlegadaCarg.size(); i++) {%>
       
      <% String [] a = puertosLlegadaCarg.get(i).split(","); %>
           
           var lcg= <%= a[0] %> +","+<%= a[1] %>
        puertosLCargo[<%=i%>] = lcg;  
  <%}%>
      
       <%
  for( int i = 0;i < puertosSalidaCarg.size(); i++) {%>
       
      <% String [] a = puertosSalidaCarg.get(i).split(","); %>
           
           var scg= <%= a[0] %> +","+<%= a[1] %>
        puertosSCargo[<%=i%>] = scg;  
  <%}%>

  var Colors = ["#FF0000", "#00FF00", "#0000FF"];


function initialize() {  

  infowindow = new google.maps.InfoWindow(
    { 
      size: new google.maps.Size(150,50)
    });

    var myOptions = {
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.SATELLITE
    }
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    address = 'Colombia'
    geocoder = new google.maps.Geocoder();
    geocoder.geocode( { 'address': address}, function(results, status) {
     map.fitBounds(results[0].geometry.viewport);


    }); 
  // setRoutes();
  } 


function createMarker(latlng, label, html) {
// alert("createMarker("+latlng+","+label+","+html+","+color+")");
    var contentString = '<b>'+label+'</b><br>'+html;
    var marker = new google.maps.Marker({
        position: latlng,

        map: map,
        title: label,
        zIndex: Math.round(latlng.lat()*-100000)<<5
        });
        marker.myname = label;


    google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(contentString); 
        infowindow.open(map,marker);
        });
    return marker;
}  



function setRoutes(){   

    var directionsDisplay = new Array();
    
    for (var i=0; i< puertosSCab.length; i++){

    window.alert("Entra en "+i);
    var rendererOptions = {
        map: map,
        suppressMarkers : true,
        preserveViewport: true
    }
    directionsService = new google.maps.DirectionsService();

    travelMode = google.maps.DirectionsTravelMode.DRIVING;  
    window.alert(puertosSCab[i]);
    var request = {
        origin: puertosSCab[i],
        destination: puertosLCab[i],
        travelMode: travelMode
    };  
    
        //distance = [startLoc[i], endLoc[i]];
          //  valorDistancia = hallarDistancia(startLoc[i], endLoc[i]);
            directionsService.route(request,makeRouteCallback(i,directionsDisplay[i]));
            
    }  

    
   /* function hallarDistancia(start, end){
        var valorDistancia = {};
        valorDistancia.metres = google.maps.geometry.spherical.computeDistanceBetween(start, end);
        valorDistancia.km = Math.round(valorDistancia.metres / 1000 * 10) / 10;
        valorDistancia.miles = Math.round(valorDistancia.metres / 1000 * 0.6214 * 10) / 10;
        return valorDistancia;
    }*/

    function makeRouteCallback(routeNum,disp){
        if (polyline[routeNum] && (polyline[routeNum].getMap() != null)) {
         startAnimation(routeNum);
         return;
        }
        return function(response, status){
          window.alert("Status: "+status);
          if (status == google.maps.DirectionsStatus.OK){

            var bounds = new google.maps.LatLngBounds();
            var route = response.routes[0];
            
            puertosLCab[routeNum] = new Object();
            puertosSCab[routeNum] = new Object();

            polyline[routeNum] = new google.maps.Polyline({
            path: [],
            strokeColor: '#FFFF00',
            strokeWeight: 3
            });

            poly2[routeNum] = new google.maps.Polyline({
            path: [],
            strokeColor: '#FFFF00',
            strokeWeight: 3
            });     
            
            


            // For each route, display summary information.
            var path = response.routes[0].overview_path;
            var legs = response.routes[0].legs;
            disp = new google.maps.DirectionsRenderer(rendererOptions);     
            disp.setMap(map);
            disp.setDirections(response);

            //Markers               
            for (i=0;i<legs.length;i++) {
                
                
        
              if (i == 0) { 
                  
                puertosSCab[routeNum].latlng = legs[i].start_location;
                puertosSCab[routeNum].address = legs[i].start_address;
                //marker = google.maps.Marker({map:map,position: startLocation.latlng});
                window.alert(legs[i].start_location+" ------ "+legs[i].start_address);
                marker[routeNum] = createMarker(legs[i].start_location,"start",legs[i].start_address,"green");
                  
                   
                }
                     puertosLCab[routeNum].latlng = legs[i].end_location;
                     puertosLCab[routeNum].address = legs[i].end_address;
               
          
               
              var steps = legs[i].steps;

              for (j=0;j<steps.length;j++) {
                var nextSegment = steps[j].path;                
                var nextSegment = steps[j].path;

                for (k=0;k<nextSegment.length;k++) {
                    polyline[routeNum].getPath().push(nextSegment[k]);
                    //bounds.extend(nextSegment[k]);
                }

              }
            }

         }       

         polyline[routeNum].setMap(map);
         //map.fitBounds(bounds);
         startAnimation(routeNum);  

    } // else alert("Directions request failed: "+status);

  }

}

    var lastVertex = 1;
    var stepnum=0;
    var step = 50; // 5; // metres
    var tick = 100; // milliseconds
    var eol= [];
//----------------------------------------------------------------------                
 function updatePoly(i,d) {
 // Spawn a new polyline every 20 vertices, because updating a 100-vertex poly is too slow
    if (poly2[i].getPath().getLength() > 20) {
          poly2[i]=new google.maps.Polyline([polyline[i].getPath().getAt(lastVertex-1)]);
          // map.addOverlay(poly2)
        }

    if (polyline[i].GetIndexAtDistance(d) < lastVertex+2) {
        if (poly2[i].getPath().getLength()>1) {
            poly2[i].getPath().removeAt(poly2[i].getPath().getLength()-1)
        }
            poly2[i].getPath().insertAt(poly2[i].getPath().getLength(),polyline[i].GetPointAtDistance(d));
    } else {
        poly2[i].getPath().insertAt(poly2[i].getPath().getLength(),puertosLCab[i].latlng);
    }
 }
//----------------------------------------------------------------------------

function animate(index,d) {
   if (d>eol[index]) {

      marker[index].setPosition(puertosLCab[index].latlng);
      return;
   }
    var p = polyline[index].GetPointAtDistance(d);

    //map.panTo(p);
    marker[index].setPosition(p);
    updatePoly(index,d);
    timerHandle[index] = setTimeout("animate("+index+","+(d+step)+")", tick);
}

//-------------------------------------------------------------------------

function startAnimation(index) {
        if (timerHandle[index]) clearTimeout(timerHandle[index]);
        eol[index]=polyline[index].Distance();
        map.setCenter(polyline[index].getPath().getAt(0));

        poly2[index] = new google.maps.Polyline({path: [polyline[index].getPath().getAt(0)], strokeColor:"#FFFF00", strokeWeight:3});

        timerHandle[index] = setTimeout("animate("+index+",50)",2000);  // Allow time for the initial map display


}
//----------------------------------------------------------------------------    



</script>

  </head>

  <body>
    
     
      
    <!-- All the files that are required -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
<link href='http://www.cssscript.com/demo/pure-css-switches-for-checkbox-and-radio-inputs/dist/rb-switcher.min.css' rel='stylesheet' type='text/css'>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

<!-- Static navbar -->
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          
          <a class="navbar-brand" href="home.jsp"><b>STF</b></a>
          
        </div>
          
        <div id="navBar" class="navbar-collapse collapse">
          
          <ul class="nav navbar-nav">
            <li class="active">
              <a href="home.jsp">Home</a>
            </li>
            <li>
              <a href="prueba-mapa.jsp">Mapa</a>
            </li>
        
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                Embarcaciones
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li>
                 <form id="formCab" action="SolicitarFluvial.jsp" method="POST">
                        <input type="hidden" id="fluvial" name ="fluvial" value="2">
                            <a style="color: black" href="javascript: submitCab()">
                        Solicitar Fluvial Cab</a>
                         <input type ="hidden" name="userHidden" id="prueba1" value="<%= request.getParameter("login") %>" >
                        <input type ="hidden" name="passHidden" id="prueba2" value="<%= request.getParameter("password") %>">
                 </form>
                </li>
                 <li>
                 <form id="formCargo" action="SolicitarFluvial.jsp" method="POST">
                        <input type="hidden" id="fluvial" name ="fluvial" value="1">
                            <a style="color: black" href="javascript: submitCargo()">
                                Solicitar Fluvial Cargo</a>
                        <input type ="hidden" name="userHidden" id="prueba1" value="<%= request.getParameter("login") %>" >
                        <input type ="hidden" name="passHidden" id="prueba2" value="<%= request.getParameter("password") %>">
                 </form>
                </li>
                <li>
                 <form id="formPass" action="SolicitarFluvial.jsp" method="POST">
                        <input type="hidden" id="fluvial" name ="fluvial" value="3">
                            <a style="color: black" href="javascript: submitPass()">
                        Solicitar Fluvial Passenger</a>
                        <input type ="hidden" name="userHidden" id="prueba1" value="<%= request.getParameter("login") %>" >
                        <input type ="hidden" name="passHidden" id="prueba2" value="<%= request.getParameter("password") %>">
                 </form>
                </li>
               
              </ul>
            </li>

      
          </ul>
          
          <ul class="nav navbar-nav navbar-right">
           			
            <li class="active dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                Cerrar Sesion
                <i class="fa fa-border fa-user"></i>
              </a>
             
            </li>
          </ul>
          
        </div>
        <!--/.nav-collapse -->
      </div>
      <!--/.container-fluid -->
    </nav>


<!-- Where all the magic happens -->
<!-- LOGIN FORM -->
<div class="text-center wrapper" style="padding:50px 0">
 
    <div id="tools">

    <button onclick="setRoutes();">Start</button>

</div>

<div id="map_canvas" style="width:100%;height:100%;"></div>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>

<script type="text/javascript">
_uacct = "UA-162157-1";
urchinTracker();
</script>

    
  
	
</div> 
    
    
  </body>

</html>

