<%-- 
    Document   : index
    Created on : 17/10/2016, 03:32:30 PM
    Author     : JuanDiego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />

        <script data-require="jquery@2.2.0" data-semver="1.11.3" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script data-require="bootstrap.js@3.3.6" data-semver="3.3.6" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

        <link data-require="bootstrap-css@3.3.6" data-semver="3.3.6" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />
        <link data-require="font-awesome@4.5.0" data-semver="4.5.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.css" />
        <link rel="stylesheet" href="style-index.css" />

        <script src="script-index.js"></script>

        <script type="text/javascript">
            function submitRegister()
            {
                document.forms["formRegister"].submit();
            }
            function submitLogin()
            {
                document.forms["formLogin"].submit();
            }
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

                    <ul class="nav navbar-nav navbar-right">
                        <li class="active dropdown">
                            <label style="padding: 15px 0 0 0"> ¿No tienes cuenta?</label>
                        </li>
                        <li class="active dropdown">
                            
                           <form id="formRegister" action="register.jsp" method="POST">
                                <input type="hidden" id="login" name ="login" value="0">
                                <a href="javascript: submitRegister()">
                                    <label style="padding: 15px 0 0 0">  Registrarse</label></a>
                                 <i class="fa fa-border fa-user-plus"></i>
                            </form>
                               
                            

                        </li>

                        <li class="active dropdown">

                            <form id="formLogin" action="register.jsp" method="POST">


                                <input type="hidden" id="login" name="login" value="1">
                                <a href="javascript: submitLogin()">
                                    <label style="padding: 15px 0 0 0">     Ingresar</label></a>
                                </a>   
                                <i class="fa fa-border fa-user"></i>
                            </form>


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
            <div>
                
            </div>
        </div> 


    </body>

</html>
