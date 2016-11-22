<%-- 
    Document   : register
    Created on : 19/10/2016, 03:53:28 PM
    Author     : JuanDiego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

  <head>
   <script data-require="jquery@*" data-semver="3.0.0" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.js"></script>
        <script src="jquery-3.1.1.min.js"></script>
        <link data-require="bootstrap@3.3.0" data-semver="3.3.0" rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" />
        <script data-require="bootstrap@3.3.0" data-semver="3.3.0" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="style-register.css" />
        <script src="script-register.js"></script>
        <link rel="stylesheet" href="style-index.css" />

        
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
          
          <a class="navbar-brand" href="index.jsp"><b>STF</b></a>
          
        </div>
          
        <div id="navBar" class="navbar-collapse collapse">
          
          <ul class="nav navbar-nav">
            <li>
              <a href="index.jsp">Home</a>
            </li>
            <li>
              <a href="#">Mapa</a>
            </li>
       

            
                   
            
      
          </ul>
          
        
          
        </div>
        <!--/.nav-collapse -->
      </div>
      <!--/.container-fluid -->
    </nav>
        
        <div class="container">

            <div class="row">
                <div class="col-md-6 col-md-offset-3">

                    <div class ="login-group" style="color: white;">
                        <div class=" panel-login">
                            <div class="panel-heading">
                                <div class="row">
                                    <% 
                                        String hidden = request.getParameter("login");
                                    if(hidden.equalsIgnoreCase("1")){ %>
                                    
                                    <div class="col-xs-6">
                                        <a href="#"  class="active"id="login-form-link" >Ingresar</a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="#"  id="register-form-link" >Registrarse</a>
                                    </div>
                                    <%
                                    }else{ %>
                                    <div class="col-xs-6">
                                        <a href="#"  id="login-form-link" >Ingresar</a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="#" class="active" id="register-form-link" >Registrarse</a>
                                    </div>
                                    <%}
                                    %>
                                    
                                    
                                </div>
                            </div>
                            <hr />


                            <div class="row">
                                <div class="col-lg-12">
                                    <form id="login-form" action="Loginservler" method="post" role="form" style="<%
                                                            if(request.getParameter("login").equalsIgnoreCase("1")){%> 
                                                            display: block;
                                                            <%} else {%>
                                                            display: none;
                                                            <%}
                                                            %>">
                                        <div class="form-group">
                                            <input type="text" name="login" id="login" tabindex="1" class="form-control" placeholder="Usuario" value="" />
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Contraseña" />
                                        </div>
                                        <div class="form-group text-center">
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <input type="submit" name="ingresar" id="ingresar" tabindex="4" class="form-control btn btn-login" value="Ingresar" onclick="igualar()"/>
                                                </div>
                                            </div>
                                        </div>

                                    </form>
                                        <form class = "formularioRegistro" name ="registerform" id="register-form" action="RegistrarServlet" method="post" role="form" style="
                                                            <%
                                                            if(request.getParameter("login").equalsIgnoreCase("0")){%> 
                                                            display: block;
                                                            <%} else {%>
                                                            display: none;
                                                            <%}
                                                            %>">
                                        <h3> Datos Personales</h3>
                                        <div class="form-group">
                                            <label for = "Nombre" class="control-label">Nombre</label>
                                            <input type="text" name="nombre" id="nombre" required
                                                   tabindex="1" class="form-control" placeholder="Nombre" value="" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Apellido</label>
                                            <input type="text" name="apellido" 
                                                   required id="apellido" tabindex="1" class="form-control" placeholder="Apellido" value="" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Teléfono</label>
                                            <input type="text" name="telefono" id="telefono" tabindex="1" class="form-control" placeholder="Teléfono" value="" />
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="control-label">Identificación (C.C)</label>
                                            <input type="text" name="identificacion" id="identificacion" required
                                                   tabindex="1" class="form-control" placeholder="Identificación (Cedula de ciudadania)" value="" />
                                        </div>
                                        
                                        <hr/>
                                        <h3> Datos de Cuenta </h3>
                                        <div class="form-group">
                                            <label class="control-label">Usuario</label>
                                            <input type="text" name="usuario" id="usuario" 
                                                   required tabindex="1" class="form-control" placeholder="Usuario" value="" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Contraseña</label>
                                            <input type="password" name="contra" id="contra" 
                                                   required tabindex="2" class="form-control" placeholder="Contraseña" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Confirmar Contraseña</label>
                                            <input type="password" name="confirm-password" id="confirm-password" 
                                                   required tabindex="2" class="form-control" placeholder="Confirmar Contraseña" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Email</label>
                                            <input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Email" value="" />
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <input type="submit" name="register-submit" id="register-submit" 
                                                           onclick="return validarSiNumero()" tabindex="4" class="form-control btn btn-register" value="Registrarse" />
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
    </body>

</html>

