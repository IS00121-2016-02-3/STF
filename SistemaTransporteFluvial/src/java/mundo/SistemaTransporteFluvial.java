package mundo;


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
        /*
         * permite interactuar con la base de datos por medio de consultas
         */
        private PreparedStatement preInsertar;
        /**
         * maneja las consultas
         */
        private ResultSet resultado;
        /**
         * maneja las conexiones
         */
        private Statement statement;
    
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public SistemaTransporteFluvial(Connection conexion)
    {
        embarcacionesCab=new ArrayList<>();
        embarcacionesCargo=new ArrayList<>();
        embarcacionesPassenger=new ArrayList<>();
        sensores=new ArrayList<>();
        puertos=new ArrayList<>();
        clientes=new ArrayList<>();
        administradores=new ArrayList<>();
        operadores=new ArrayList<>();
        try 
        {                  
            statement= conexion.createStatement();
            
            cargarCabs(conexion);
            cargarCargos(conexion);
            cargarPassengers(conexion);
            cargarClientes(conexion);
            cargarOperadores(conexion);
            cargarAdministradores(conexion);
            cargarSensores(conexion);
            cargarPuertos(conexion);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }	
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    
    public void cargarClientes(Connection conexion)
    {
        try 
        {
            ResultSet resultado = statement.executeQuery("SELECT * FROM CLIENTE");
		
            while (resultado.next()) 
            {		
                Cliente nuevo=new Cliente(resultado.getInt(1), resultado.getString(2),resultado.getString(3),
                        resultado.getString(4),resultado.getString(5),resultado.getString(6),resultado.getString(7),
                        resultado.getInt(8),resultado.getInt(9),resultado.getInt(10),resultado.getInt(11),
                        resultado.getInt(12));
                clientes.add(nuevo);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    public void cargarOperadores(Connection conexion)
    {
        try 
        {
            ResultSet resultado = statement.executeQuery("SELECT * FROM OPERADOR");
		
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
    public void cargarAdministradores(Connection conexion)
    {
        try 
        {
            ResultSet resultado = statement.executeQuery("SELECT * FROM ADMINISTRADOR");
		
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
    public void cargarSensores(Connection conexion)
    {
        try 
        {
            ResultSet resultado = statement.executeQuery("SELECT * FROM SENSOR");
		
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
    public void cargarPuertos(Connection conexion)
    {
        try 
        {
            ResultSet resultado = statement.executeQuery("SELECT * FROM SENSOR");
		
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
    private void cargarCabs(Connection conexion)
    {
        try 
        {
            ResultSet resultado = statement.executeQuery("SELECT * FROM PUERTO");
		
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
    public void cargarCargos(Connection conexion)
    {
        try 
        {
            ResultSet cursor=statement.executeQuery("SELECT * FROM CARGO");
            while (cursor.next()) 
            {
                Cargo temp=new Cargo(resultado.getInt(1), resultado.getBoolean(2), resultado.getDouble(3), 
                        resultado.getDouble(4), resultado.getInt(5),resultado.getInt(6),resultado.getInt(7));
                embarcacionesCargo.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }
    public void cargarPassengers(Connection conexion)
    {
        try 
        {
            ResultSet cursor=statement.executeQuery("SELECT * FROM PASSENGER");
            while (cursor.next()) 
            {
                Passenger temp=new Passenger(resultado.getInt(1), resultado.getBoolean(2), resultado.getDouble(3), 
                        resultado.getDouble(4), resultado.getInt(5),resultado.getInt(6),resultado.getInt(7),resultado.getBoolean(8)
                ,resultado.getInt(9));
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

    public ArrayList<Cab> buscarCabDisponibles(int idPuerto, Connection conexion) 
    {
        ArrayList<Cab> cabsDisponibles=null;
        
        try 
        {
            ResultSet cursor=statement.executeQuery("SELECT * FROM CAB WHERE ID_PUERTO="+idPuerto+" AND DISPONIBLE=TRUE");
            while (cursor.next()) 
            {
                Cab temp=new Cab(resultado.getInt(1), resultado.getBoolean(2), resultado.getDouble(3), 
                        resultado.getDouble(4), resultado.getInt(5),resultado.getInt(6),resultado.getBoolean(7));
                cabsDisponibles.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return cabsDisponibles;
    }
    public ArrayList<Cargo> buscarCargoDisponibles(int idPuerto, Connection conexion) 
    {
        ArrayList<Cargo> cargoDisponibles=null;
        
        try 
        {
            ResultSet cursor=statement.executeQuery("SELECT * FROM CARGO WHERE ID_PUERTO="+idPuerto+" AND DISPONIBLE=TRUE");
            while (cursor.next()) 
            {
                Cargo temp=new Cargo(resultado.getInt(1), resultado.getBoolean(2), resultado.getDouble(3), 
                        resultado.getDouble(4), resultado.getInt(5),resultado.getInt(6),resultado.getInt(7));
                cargoDisponibles.add(temp);
            } 
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SistemaTransporteFluvial.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return cargoDisponibles;
    }
    public ArrayList<Passenger> buscarPassengerDisponibles(int idPuerto, Connection conexion) 
    {
        ArrayList<Passenger> passDisponibles=null;
        
        try 
        {
            ResultSet cursor=statement.executeQuery("SELECT * FROM PASSENGER WHERE ID_PUERTO="+idPuerto+" AND DISPONIBLE=TRUE");
            while (cursor.next()) 
            {
                Passenger temp=new Passenger(resultado.getInt(1), resultado.getBoolean(2), resultado.getDouble(3), 
                        resultado.getDouble(4), resultado.getInt(5),resultado.getInt(6),resultado.getInt(7),resultado.getBoolean(8)
                ,resultado.getInt(9));
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
