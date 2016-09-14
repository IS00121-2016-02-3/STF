
package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *                                  Universidad Piloto de Colombia
 *                                      Ingeniería de Software
 *                                             2016-III
 * @authors     INGMARK
 * @PROYECTO                             SISTEMA DE TRANSPORTE 
 *                                              FLUVIAL
 */
 
                    //---------------------------CONTROL DE CAMBIOS---------------------------//
                    //------------------------------------------------------------------------//
                    // Fecha actualización                    |                               //
                    // Nombre del líder que realizó el cambio |                               //
                    // Líneas de código actualizadas          |                               //
                    //------------------------------------------------------------------------//


/**
 * Clase que realiza la conexion con la base de datos
 * @author eliecer
 */
public class Conexion 
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    /**
     * conexion con la base de datos
     */
    private Connection conexion;    
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    
    /**
    * Método utilizado para recuperar el valor del atributo conexion
    * @return conexion contiene el estado de la conexión
    */
    public Connection getConexion()
    {
      return conexion;
    }
 
    /**
    * Método utilizado para establecer la conexión con la base de datos
    * @return estado regresa el estado de la conexión, true si se estableció la conexión,
    * falso en caso contrario
    */
    public boolean crearConexion()
    {
       try 
       {
          Class.forName("com.mysql.jdbc.Driver");
          conexion = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/basededatos stf","root","root");
       } 
       catch (SQLException ex) 
       {
          ex.printStackTrace();
          return false;
       } 
       catch (ClassNotFoundException ex) 
       {
          ex.printStackTrace();
          return false;
       }
       return true;
    }
 
    /**
    *
    *Método utilizado para realizar las instrucciones: INSERT, DELETE y UPDATE
    *@param sql Cadena que contiene la instrucción SQL a ejecutar
    *@return estado regresa el estado de la ejecución, true(éxito) o false(error)
    *
    */
    public boolean ejecutarSQL(String sql)
    {
       try 
       {
          Statement sentencia = conexion.createStatement();
          sentencia.executeUpdate(sql);
       } 
       catch (SQLException ex) 
       {
          ex.printStackTrace();
          return false;
       }
       return true;
    }

    /**
    *
    *Método utilizado para realizar la instrucción SELECT
    *@param sql Cadena que contiene la instrucción SQL a ejecutar
    *@return resultado regresa los registros generados por la consulta
    *
    */
    public ResultSet ejecutarSQLSelect(String sql)
    {
       ResultSet resultado;
       try 
       {
          Statement sentencia = conexion.createStatement();
          resultado = sentencia.executeQuery(sql);
       } 
       catch (SQLException ex) 
       {
          ex.printStackTrace();
          return null;
       }
       return resultado;
    }    
}

