<%-- 
    Document   : cunsultafluvialjsp
    Created on : 19/11/2016, 06:21:02 PM
    Author     : kevin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <form action="Fluvialservler" method="post">
        
  <select name="fluvial">
  <option value="passenger">Fluvial Passenger</option>
  <option value="cargo">Fluvial cargo</option>
  <option value="cab">Fluvial cab</option>
  
  </select>
  
  <input type="radio" name="disponibilidad" value="true" checked>disponible</input>
  <input type="radio" name="disponibilidad"value="false">No disponible</input>
        
  <input type="submit" value="Aceptar">
  
  </form>
</select>
    </body>
</html>
