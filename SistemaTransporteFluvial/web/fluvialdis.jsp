<%-- 
    Document   : fluvialdisjsp
    Created on : 21/11/2016, 12:21:18 PM
    Author     : kevin
--%>

<%@page import="stf.entities.Cab"%>
<%@page import="stf.sessionBeans.CabFacade"%>
<%@page import="stf.sessionBeans.CargoFacade"%>
<%@page import="stf.entities.Cargo"%>
<%-- 
    Document   : SolicitarFluvial
    Created on : 17/10/2016, 06:19:57 PM
    Author     : JuanDiego
--%>

<%@page import="stf.sessionBeans.PassengerFacade"%>
<%@page import="stf.entities.Passenger"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="stf.entities.Ruta"%>
<%@page import="stf.sessionBeans.RutaFacade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>STF - Actualizar Embarcación</title>
        <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />


        <script data-require="jquery@2.2.0" data-semver="1.11.3" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script data-require="bootstrap.js@3.3.6" data-semver="3.3.6" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

        <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
        <link data-require="font-awesome@4.5.0" data-semver="4.5.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.css" />
        <link rel="stylesheet" href="stylesheedadmincss.css" />

        <% List<Passenger> passengers;
            PassengerFacade pf = new PassengerFacade();
            CargoFacade cf = new CargoFacade();
            CabFacade cbf = new CabFacade();
            boolean isDisponible = false;
            boolean isnoDisponible = false;
        %>

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

        <script>


            function disponible() {

                checkDis = document.getElementById("disponible");
                elementUno = document.getElementById("nada");
                elementDos = document.getElementById("disp");
                elementTres = document.getElementById("noDips");
                if (checkDis.checked) {


                    elementUno.style.display = "none";
                    elementDos.style.display = "block";
                    elementTres.style.display = "none";
                } 


            }



        </script>

        <script>


            function nodisponible() {
                checkNoDisp = document.getElementById("nodisponible");
                elementU = document.getElementById("nada");
                elementD = document.getElementById("disp");
                elementT = document.getElementById("noDips");

                if (checkNoDisp.checked) {


                    elementU.style.display = "none";
                    elementD.style.display = "none";
                    elementT.style.display = "block";
                } 
            }

        </script>



    </head>
    <body>     


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

                    <a class="navbar-brand" href="actualizar.jsp"><b>STF</b></a>

                </div>


                <div id="navBar" class="navbar-collapse collapse">

                    <ul class="nav navbar-nav">

                        <li class="active">
                            <a href="homeadmin.jsp">Home</a>
                        </li>

                        <li>
                            <a href="prueba-mapa.jsp">Mapa</a>
                        </li>

                        <li>
                            <a href="consultasensores.jsp">Sensores</a>
                        </li>
                        <li>
                            <a href="consultarutas.jsp">Ruta</a>
                        </li>

                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                Consulta Embarcaciones
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <form id="formCab" action="fluvialdis.jsp" method="POST">
                                        <input type="hidden" id="fluvial" name ="fluvial" value="2">
                                        <a style="color: black" href="javascript: submitCab()">
                                            Consultar Fluvial Cab</a>

                                    </form>
                                </li>
                                <li>
                                    <form id="formCargo" action="fluvialdis.jsp" method="POST">
                                        <input type="hidden" id="fluvial" name ="fluvial" value="1">
                                        <a style="color: black" href="javascript: submitCargo()">
                                            Consultar Fluvial Cargo</a>
                                    </form>
                                </li>
                                <li>
                                    <form id="formPass" action="fluvialdis.jsp" method="POST">
                                        <input type="hidden" id="fluvial" name ="fluvial" value="3">
                                        <a style="color: black" href="javascript: submitPass()">
                                            Consultar Fluvial Passenger</a>

                                    </form>
                                </li>

                            </ul>
                        </li>


                    </ul>

                    <ul class="nav navbar-nav navbar-right">

                        <li class="active dropdown">
                            <a href="index.jsp" >
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


                                <% if (Integer.parseInt(request.getParameter("fluvial")) == 3) { %>
                                <div class="row">
                                    <div class="col-lg-12">

                                        <h3 style="font-size: 30px"> Consultar Fluvial</h3>
                                        <div class="form-group" id="nada" style="display: block;">
                                            <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>




                                            <tbody>

                                            <table >

                                                <tr>
                                                    <th>ID</th>
                                                    <th>Cantidad Pasajeros</th>
                                                    <th>Disponibilidad</th>
                                                    <th>Calado</th>
                                                    <th>Descripcion</th>
                                                </tr>



                                            </table>
                                            </tbody>



                                        </div>

                                        <%-- Si no estan disponibles --%>
                                        <div class="form-group" id="noDisp" style="display: none;">
                                            <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>

                                            <%
                                                List<Passenger> passNo = pf.consultarPassengerDisponibles(false);

                                            %>

                                            <tbody>

                                            <table >

                                                <tr>
                                                    <th>id</th>
                                                    <th>cantidad pasajeros</th>
                                                    <th>disponibilidad</th>
                                                    <th>calado</th>
                                                    <th>Descripcion</th>
                                                </tr>
                                                <tr>
                                                    <%     for (int i = 0; i < passNo.size(); i++) {

                                                            Passenger p = passNo.get(i);
                                                            int id = p.getIdpassengers();
                                                            int cantidad = p.getCantidadPasageros();
                                                            boolean dispo = p.getEmbarcacionesIdembarcacion().getDisponibilidad();
                                                            int calado = p.getEmbarcacionesIdembarcacion().getCalado();
                                                            String descrip = p.getEmbarcacionesIdembarcacion().getDescripcion();
                                                    %>
                                                </tr>   

                                                <tr style="text-align: center;">
                                                    <td> <%= id%> </td>


                                                    <td> <%= cantidad%></td>
                                                    <td> <%= dispo%></td>
                                                    <td>  <%= calado%></td>
                                                    <td> <%= descrip%></td>


                                                </tr>


                                                <%
                                                    }


                                                %>


                                            </table>
                                            </tbody>




                                        </div>


                                        <%-- SI estan disponibles --%>

                                        <div class="form-group" id="disp" style="display: none" >
                                            <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>


                                            <%                                                List<Passenger> pass = pf.consultarPassengerDisponibles(true);
                                            %>



                                            <tbody>

                                            <table >

                                                <tr>
                                                    <th>id</th>
                                                    <th>cantidad pasajeros</th>
                                                    <th>disponibilidad</th>
                                                    <th>calado</th>
                                                    <th>Descripcion</th>
                                                </tr>
                                                <tr>
                                                    <%
                                                        for (int i = 0; i < pass.size(); i++) {

                                                            Passenger p = pass.get(i);
                                                            int id = p.getIdpassengers();
                                                            int cantidad = p.getCantidadPasageros();
                                                            boolean dispo = p.getEmbarcacionesIdembarcacion().getDisponibilidad();
                                                            int calado = p.getEmbarcacionesIdembarcacion().getCalado();
                                                            String descrip = p.getEmbarcacionesIdembarcacion().getDescripcion();
                                                    %>
                                                </tr>   

                                                <tr style="text-align: center;">
                                                    <td> <%= id%> </td>


                                                    <td> <%= cantidad%></td>
                                                    <td> <%= dispo%></td>
                                                    <td>  <%= calado%></td>
                                                    <td> <%= descrip%></td>


                                                </tr>
                                                <%
                                                    }

                                                %>


                                            </table>
                                            </tbody>
                                            <%       }

                                            %>


                                            <% if (Integer.parseInt(request.getParameter("fluvial")) == 1) { %>
                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <h3 style="font-size: 30px"> Consultar Fluvial</h3>
                                                    <div class="form-group" id="nada" style="display: block;">
                                                        <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>




                                                        <tbody>

                                                        <table >

                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Cantidad Carga</th>
                                                                <th>Disponibilidad</th>
                                                                <th>Calado</th>
                                                                <th>Descripcion</th>
                                                            </tr>



                                                        </table>
                                                        </tbody>



                                                    </div>

                                                    <%-- Si no estan disponibles --%>
                                                    <div class="form-group" id="noDisp" style="display: none;">
                                                        <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>

                                                        <%
                                                            List<Cargo> cargoNo = cf.consultarCargosDisponibles(false);

                                                        %>

                                                        <tbody>

                                                        <table >

                                                            <tr>
                                                                <th>id</th>
                                                                <th>cantidad carga</th>
                                                                <th>disponibilidad</th>
                                                                <th>calado</th>
                                                                <th>Descripcion</th>
                                                            </tr>
                                                            <tr>
                                                                <%     for (int i = 0; i < cargoNo.size(); i++) {

                                                                        Cargo c = cargoNo.get(i);
                                                                        int id = c.getIdcargo();
                                                                        int cantidad = c.getPesoCarga();
                                                                        boolean dispo = c.getEmbarcacionesIdembarcacion().getDisponibilidad();
                                                                        int calado = c.getEmbarcacionesIdembarcacion().getCalado();
                                                                        String descrip = c.getEmbarcacionesIdembarcacion().getDescripcion();
                                                                %>
                                                            </tr>   

                                                            <tr>
                                                            <center>
                                                                <td style="text-align: center;"> <%= id%> </td>
                                                                <td style="text-align: center;"> <%= cantidad%></td>
                                                                <td style="text-align: center;"> <%= dispo%></td>
                                                                <td style="text-align: center;">  <%= calado%></td>
                                                                <td style="text-align: center;"> <%= descrip%></td>
                                                            </center>
                                                                
                                                            </tr>


                                                            <%
                                                                }


                                                            %>


                                                        </table>
                                                        </tbody>




                                                    </div>


                                                    <%-- SI estan disponibles --%>

                                                    <div class="form-group" id="disp" style="display: none" >
                                                        <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>


                                                        <% 
                                                          List<Cargo> cargo = cf.consultarCargosDisponibles(true);
                                                        %>



                                                        <tbody>

                                                        <table >

                                                            <tr>
                                                                <th>id</th>
                                                                <th>cantidad carga</th>
                                                                <th>disponibilidad</th>
                                                                <th>calado</th>
                                                                <th>Descripcion</th>
                                                            </tr>
                                                            <tr>
                                                                <%
                                                                    for (int i = 0; i < cargo.size(); i++) {

                                                                        Cargo c = cargo.get(i);
                                                                        int id = c.getIdcargo();
                                                                        int cantidad = c.getPesoCarga();
                                                                        boolean dispo = c.getEmbarcacionesIdembarcacion().getDisponibilidad();
                                                                        int calado = c.getEmbarcacionesIdembarcacion().getCalado();
                                                                        String descrip = c.getEmbarcacionesIdembarcacion().getDescripcion();
                                                                %>
                                                            </tr>   

                                                            <tr>
                                                            
                                                                <td style="text-align: center;"> <%= id%> </td>


                                                                <td style="text-align: center;"> <%= cantidad%></td>
                                                                <td style="text-align: center;"> <%= dispo%></td>
                                                                <td style="text-align: center;">  <%= calado%></td>
                                                                <td style="text-align: center;"> <%= descrip%></td>

                                                            
                                                            </tr>
                                                            <%
                                                                }

                                                            %>


                                                        </table>
                                                        </tbody>
                                                        <%       }

                                                        %>

              <% if (Integer.parseInt(request.getParameter("fluvial")) == 2) { %>
                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <h3 style="font-size: 30px"> Consultar Fluvial</h3>
                                                    <div class="form-group" id="nada" style="display: block;">
                                                        <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>




                                                        <tbody>

                                                        <table >

                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Cantidad Carga</th>
                                                                <th>Disponibilidad</th>
                                                                <th>Calado</th>
                                                                <th>Descripcion</th>
                                                            </tr>



                                                        </table>
                                                        </tbody>



                                                    </div>

                                                    <%-- Si no estan disponibles --%>
                                                    <div class="form-group" id="noDisp" style="display: none;">
                                                        <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>

                                                        <%
                                                            List<Cab> cabNo = cbf.consultarCabDisponible(false);

                                                        %>

                                                        <tbody>

                                                        <table >

                                                            <tr>
                                                                <th>id</th>
                                                                <th>cantidad pasajeros</th>
                                                                <th>disponibilidad</th>
                                                                <th>calado</th>
                                                                <th>Descripcion</th>
                                                            </tr>
                                                            <tr>
                                                                <%     for (int i = 0; i < cabNo.size(); i++) {

                                                                        Cab cb = cabNo.get(i);
                                                                        int id = cb.getIdcab();
                                                                        int cantidad = 1;
                                                                        boolean dispo = cb.getEmbarcacionesIdembarcacion().getDisponibilidad();
                                                                        int calado = cb.getEmbarcacionesIdembarcacion().getCalado();
                                                                        String descrip = cb.getEmbarcacionesIdembarcacion().getDescripcion();
                                                                %>
                                                            </tr>   

                                                            <tr>
                                                            <center>
                                                                <td style="text-align: center;"> <%= id%> </td>
                                                                <td style="text-align: center;"> <%= cantidad%></td>
                                                                <td style="text-align: center;"> <%= dispo%></td>
                                                                <td style="text-align: center;">  <%= calado%></td>
                                                                <td style="text-align: center;"> <%= descrip%></td>
                                                            </center>
                                                                
                                                            </tr>


                                                            <%
                                                                }


                                                            %>


                                                        </table>
                                                        </tbody>




                                                    </div>


                                                    <%-- SI estan disponibles --%>

                                                    <div class="form-group" id="disp" style="display: none" >
                                                        <label style="font-size: 20px" for = "Salida" class="control-label">Disponibilidad</label>


                                                        <% 
                                                          List<Cab> cab = cbf.consultarCabDisponible(true);
                                                        %>



                                                        <tbody>

                                                        <table >

                                                            <tr>
                                                                <th>id</th>
                                                                <th>cantidad pasajeros</th>
                                                                <th>disponibilidad</th>
                                                                <th>calado</th>
                                                                <th>Descripcion</th>
                                                            </tr>
                                                            <tr>
                                                                <%
                                                                    for (int i = 0; i < cab.size(); i++) {

                                                                        Cab cb = cab.get(i);
                                                                        int id = cb.getIdcab();
                                                                        int cantidad = 0;
                                                                        boolean dispo = cb.getEmbarcacionesIdembarcacion().getDisponibilidad();
                                                                        int calado = cb.getEmbarcacionesIdembarcacion().getCalado();
                                                                        String descrip = cb.getEmbarcacionesIdembarcacion().getDescripcion();
                                                                %>
                                                            </tr>   

                                                            <tr>
                                                            
                                                                <td style="text-align: center;"> <%= id%> </td>


                                                                <td style="text-align: center;"> <%= cantidad%></td>
                                                                <td style="text-align: center;"> <%= dispo%></td>
                                                                <td style="text-align: center;">  <%= calado%></td>
                                                                <td style="text-align: center;"> <%= descrip%></td>

                                                            
                                                            </tr>
                                                            <%
                                                                }

                                                            %>


                                                        </table>
                                                        </tbody>
                                                        <%       }

                                                        %>

                                                    </div>                                                

                                                    <div >
                                                        <INPUT  id="disponible" TYPE="checkbox" NAME="nivel" onClick="disponible()" > Consultar <BR>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">

                                    </html>