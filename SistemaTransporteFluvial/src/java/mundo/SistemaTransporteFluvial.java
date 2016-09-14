package mundo;


import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

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
 * Clase que maneja todo el sistema de transporte fluvial
 * @author eliecer
 */
public class SistemaTransporteFluvial 
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
   /**
    *lista de clientes en el sistema
    */
    private ArrayList<Cliente> clientes;
    /**
    *lista de operadores en el sistema
    */
    private ArrayList<Operador> operadores;
    /**
    *lista de usuarios en el sistema
    */
    private ArrayList<Administrador> administradores;
    /**
     * lista de embarcaciones cab en el sistema
     */
    private ArrayList<Cab> embarcacionesCab;
    /**
     * lista de embarcaciones cargo en el sistema
     */
    private ArrayList<Cargo> embarcacionesCargo;
    /**
     * lista de embarcaciones passenger en el sistema
     */
    private ArrayList<Passenger> embarcacionesPassenger;
    /**
     * lista de sensores en el rio
     */
    private ArrayList<Sensor> sensores;
    /**
     * lista de puertos en el sistema
     */
    private ArrayList<Puerto> puertos;
    
    //-------------------------------------------Atributos BD--------------------------------------------------------------//
        
        
        private Conexion conexion;
        
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public SistemaTransporteFluvial()
    {
       
        embarcacionesCab=new ArrayList<>();
        embarcacionesCargo=new ArrayList<>();
        embarcacionesPassenger=new ArrayList<>();
        sensores=new ArrayList<>();
        puertos=new ArrayList<>();
        clientes=new ArrayList<>();
        administradores=new ArrayList<>();
        operadores=new ArrayList<>();
        
        cargarCabs();
        cargarCargos();
        cargarPassengers();
        cargarClientes();
        cargarOperadores();
        cargarAdministradores();
        cargarSensores();
        cargarPuertos();        	
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
        
    public void cargarClientes()
    {
        try 
        {
            ResultSet cursor = conexion.ejecutarSQLSelect("SELECT * FROM CLIENTE");
		
            while (cursor.next()) 
            {		
                Cliente nuevo=new Cliente(cursor.getInt(1), cursor.getString(2),cursor.getString(3),
                        cursor.getString(4),cursor.getString(5),cursor.getString(6),cursor.getString(7),
                        cursor.getInt(8),cursor.getInt(9),cursor.getInt(10),cursor.getInt(11),
                        cursor.getInt(12));
                clientes.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    public void cargarOperadores()
    {
        try 
        {
            ResultSet resultado = conexion.ejecutarSQLSelect("SELECT * FROM OPERADOR");
		
            while (resultado.next()) 
            {		
                Operador nuevo=new Operador(resultado.getInt(1), resultado.getString(2),resultado.getString(3),
                        resultado.getString(4),resultado.getString(5),resultado.getString(6),resultado.getString(7),
                        resultado.getInt(8));
                operadores.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    public void cargarAdministradores()
    {
        try 
        {
            ResultSet resultado = conexion.ejecutarSQLSelect("SELECT * FROM ADMINISTRADOR");
		
            while (resultado.next()) 
            {		
                Administrador nuevo=new Administrador(resultado.getInt(1), resultado.getString(2),resultado.getString(3),
                        resultado.getString(4),resultado.getString(5),resultado.getString(6),resultado.getString(7));
                administradores.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    public void cargarSensores()
    {
        try 
        {
            ResultSet resultado = conexion.ejecutarSQLSelect("SELECT * FROM SENSOR");
		
            while (resultado.next()) 
            {		
                Sensor nuevo=new Sensor(resultado.getInt(1),resultado.getDouble(2),resultado.getDate(3));
                sensores.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    public void cargarPuertos()
    {
        try 
        {
            ResultSet resultado = conexion.ejecutarSQLSelect("SELECT * FROM SENSOR");
		
            while (resultado.next()) 
            {		
                Sensor nuevo=new Sensor(resultado.getInt(1),resultado.getDouble(2),resultado.getDate(3));
                sensores.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    private void cargarCabs()
    {
        try 
        {
            ResultSet resultado = conexion.ejecutarSQLSelect("SELECT * FROM PUERTO");
		
            while (resultado.next()) 
            {		
                Puerto nuevo=new Puerto(resultado.getInt(1), resultado.getDouble(2), resultado.getDouble(3));
                puertos.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    public void cargarCargos()
    {
        try 
        {
            ResultSet cursor=conexion.ejecutarSQLSelect("SELECT * FROM CARGO");
            while (cursor.next()) 
            {
                Cargo temp=new Cargo(cursor.getInt(1), cursor.getBoolean(2), cursor.getDouble(3), 
                        cursor.getDouble(4), cursor.getInt(5),cursor.getInt(6),cursor.getInt(7),
                cursor.getDate(8),cursor.getDate(9));
                embarcacionesCargo.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }
    public void cargarPassengers()
    {
        try 
        {
            ResultSet cursor=conexion.ejecutarSQLSelect("SELECT * FROM PASSENGER");
            while (cursor.next()) 
            {
                Passenger temp=new Passenger(cursor.getInt(1), cursor.getBoolean(2), cursor.getDouble(3), 
                        cursor.getDouble(4), cursor.getInt(5),cursor.getInt(6),cursor.getInt(7),cursor.getBoolean(8)
                ,cursor.getInt(9),cursor.getDate(10),cursor.getDate(11));
                embarcacionesPassenger.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }
    
    /**
     * envia una embarcacion cab a un usuario en un puerto
     * @param solicitante 
     */
    public void enviarEmbarcacionCabDisponible(Cliente solicitante)
    {
        
    }
    /**
     * metodo que consulta el posicionamiento global satelital de una embarcacion especifica
     * @param codigoEmbarcacion , codigo de la embarcacion a consultar
     */
    public void consultarGPS(int codigoEmbarcacion)
    {
        
    }
    /**
     * metodo que dada una alarma de panico activada, envia una embarcacion disponible a las
     * coordenadas de latitud y longitud pasadas por parametro
     * @param longitud, longitud de la embarcacion en panico
     * @param latitud , latitud de la embarcacion en panico
     */
    public void enviarEmbarcacionReemplazo(double longitud, double latitud)
    {
        
    }    

    public ArrayList<Cab> buscarCabDisponibles(int idPuerto ) 
    {
        ArrayList<Cab> cabsDisponibles=new ArrayList<Cab>();        
        try 
        {
            ResultSet cursor=conexion.ejecutarSQLSelect("SELECT * FROM CAB WHERE ID_PUERTO="+idPuerto+" AND DISPONIBLE=TRUE");
            while (cursor.next()) 
            {
                Cab temp=new Cab(cursor.getInt(1), cursor.getBoolean(2), cursor.getDouble(3), 
                        cursor.getDouble(4), cursor.getInt(5),cursor.getInt(6),cursor.getBoolean(7),
                cursor.getDate(8),cursor.getDate(9));
                cabsDisponibles.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return cabsDisponibles;
    }
    public ArrayList<Cargo> buscarCargoDisponibles(int idPuerto ) 
    {
        ArrayList<Cargo> cargoDisponibles=null;
        
        try 
        {
            ResultSet cursor=conexion.ejecutarSQLSelect("SELECT * FROM CARGO WHERE ID_PUERTO="+idPuerto+" AND DISPONIBLE=TRUE");
            while (cursor.next()) 
            {
                Cargo temp=new Cargo(cursor.getInt(1), cursor.getBoolean(2), cursor.getDouble(3), 
                        cursor.getDouble(4), cursor.getInt(5),cursor.getInt(6),cursor.getInt(7)
                ,cursor.getDate(8),cursor.getDate(9));
                cargoDisponibles.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return cargoDisponibles;
    }
    public ArrayList<Passenger> buscarPassengerDisponibles(int idPuerto ) 
    {
        ArrayList<Passenger> passDisponibles=null;
        
        try 
        {
            ResultSet cursor=conexion.ejecutarSQLSelect("SELECT * FROM PASSENGER WHERE ID_PUERTO="+idPuerto+" AND DISPONIBLE=TRUE");
            while (cursor.next()) 
            {
                Passenger temp=new Passenger(cursor.getInt(1), cursor.getBoolean(2), cursor.getDouble(3), 
                        cursor.getDouble(4), cursor.getInt(5),cursor.getInt(6),cursor.getInt(7),cursor.getBoolean(8)
                ,cursor.getInt(9),cursor.getDate(10),cursor.getDate(11));
                passDisponibles.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return passDisponibles;
    }   
}
