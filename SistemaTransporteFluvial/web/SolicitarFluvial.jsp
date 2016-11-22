<%-- 
    Document   : SolicitarFluvial
    Created on : 17/10/2016, 06:19:57 PM
    Author     : JuanDiego
--%>

<%@page import="stf.sessionBeans.PuertoFacade"%>
<%@page import="stf.entities.Puerto"%>
<%@page import="java.util.List"%>
<%@page import="stf.entities.Ruta"%>
<%@page import="stf.sessionBeans.RutaFacade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STF - Solicitar Embarcación</title>
        <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
       

        <script data-require="jquery@2.2.0" data-semver="1.11.3" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script data-require="bootstrap.js@3.3.6" data-semver="3.3.6" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

        <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
        <link data-require="font-awesome@4.5.0" data-semver="4.5.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.css" />
        <link rel="stylesheet" href="style.css" />

        <script src="script-solicitar.js"></script>
        
<script type="text/javascript">
            function submitCab()
            {
                document.forms["formCab"].submit();
            }
            function submitCargo()
            {
                document.forms["formCargo"].submit();
            }
            function submitPass()
            {
                document.forms["formPass"].submit();
            }
        </script>

    </head>
    <body>

        <% PuertoFacade pf = new PuertoFacade();
            List<Puerto> puertos = pf.getPuertos();
        %>
        
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
                        <li >
                            <a href="home.jsp">Home</a>
                        </li>
                        <li>
                            <a href="#">Mapa</a>
                        </li>


                        <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                Embarcaciones
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li>
                 <form id="formCab" action="SolicitarFluvial.jsp" method="POST">
                        <input type="hidden" id="fluvial" name ="fluvial" value="0">
                            <a style="color: black" href="javascript: submitCab()">
                        Solicitar Fluvial Cab</a>
                 </form>
                </li>
                 <li>
                 <form id="formCargo" action="SolicitarFluvial.jsp" method="POST">
                        <input type="hidden" id="fluvial" name ="fluvial" value="1">
                            <a style="color: black" href="javascript: submitCargo()">
                                Solicitar Fluvial Cargo</a>
                 </form>
                </li>
                <li>
                 <form id="formPass" action="SolicitarFluvial.jsp" method="POST">
                        <input type="hidden" id="fluvial" name ="fluvial" value="0">
                            <a style="color: black" href="javascript: submitPass()">
                        Solicitar Fluvial Passenger</a>
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


        <div class="container">
            <br />

            <div class="container">

                <div class="row">
                    <div class="col-md-6 col-md-offset-3">

                        <div class ="login-group" style="color: white;">
                            <div class=" panel-login">

                                <hr />


                                <div class="row">
                                    <div class="col-lg-12">
                                        <form class = "formularioRegistro" name ="solicitudForm" id="register-form" action="RequestServlet" method="post" role="form" style="display: block;">
                                            <h3 style="font-size: 30px"> Solicitar Fluvial</h3>
                                            <div class="form-group">
                                                <label style="font-size: 20px" for = "Salida" class="control-label">Puerto de salida</label>
                                                
                                                
                                                <input type ="hidden" id="userService" name="userService" value="<%= request.getParameter("userHidden") %>" />
                                                <input type ="hidden" id="passService" name="passService" value="<%= request.getParameter("passHidden") %>" />
                                                <input type ="hidden" id="idFluvial" name="idFluvial" value="<%= request.getParameter("fluvial") %>" />
                                                <%-- Size debe reemplazarse por <%! "nombre consulta BD".length %> --%>
                                                <select size="<%= puertos.size() %>" tabindex="1" class="form-control" name ="puertosSalida" id ="puertosSalida" required  style="color:black">
                                                    <%
                                                        // Recorre el tamaño de la lista
                                                        for(int i=0; i< puertos.size(); i++){
                                                            %>
                                                            <%
                                                                Puerto ps = (Puerto) puertos.get(i);
                                                                int puertoS = ps.getIdpuerto(); %>
                                                            <option value="<%= puertoS %>"> Puerto  <%= puertoS %> </option>
                                                            <%}
                                                        %>
                                                    
                                                </select>

                                                        
                                                <label style="font-size: 20px" for = "Llegada" class="control-label">Puerto de llegada</label>
                                                 
                                                <%-- Size debe reemplazarse por <%! "nombre consulta BD".length %> --%>
                                                <select size="<%= puertos.size() %>"tabindex="1" class="form-control" name ="puertosLlegada" id ="puertosLlegada" required  style="color:black">
                                                    <%
                                                        // Recorre el tamaño de la lista
                                                        for(int i=0; i< puertos.size(); i++){
                                                    %><%
                                                        Puerto p = (Puerto) puertos.get(i);
                                                        int puertoL = p.getIdpuerto(); %>
                                                    <option value="<%= puertoL %>"> Puerto <%= puertoL %> </option>
                                                            <%}
                                                        %>
                                                    
                                                </select>
                                                
                                                  <% 
                                                      String hidden = request.getParameter("fluvial");
                                                      if(hidden.equalsIgnoreCase("1")){%>
                                                      <label style="font-size: 20px" for = "Llegada" class="control-label">Peso a enviar (En Kg)</label>
                                                      <br>
                                                      <input style="color: black"type="number" min="0" max="5000" size="40" id="peso" name="peso" require value="0">
                                                      <%}
                                                        %>
                                                        
                                            </div>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-6 col-sm-offset-3">
                                                        <input type="submit" name="register-submit" id="register-submit" 
                                                               onclick="return validarSiNumero()" tabindex="4" class="form-control btn btn-register" value="Solicitar Servicio" />
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="list-arrows col-md-4 text-center">

                </div>





            </div>
        </div>
    </div>


</body>
</html>
