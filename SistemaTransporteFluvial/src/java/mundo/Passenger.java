package mundo;


import java.util.ArrayList;
import java.util.Date;

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
 * Clase que maneja las embarcaciones PASSENGER
 * @author eliecer
 */
public class Passenger extends Fluvial
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * calado de la embarcacion fluvial passenger en metros
     */
    private static final double CALADO_PASSENGER=1.25;
    /**
     * constante de cantidad maxima de pasajeros en la embarcacion
     */
    private static final int CANTIDAD_MAX_PASAJEROS=30;    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
   
    /**
     * boolean que maneja el estado del boton de panico
     */
    private boolean panico;

    /**
     * cantidad de pasajeros en el fluvial
     */
    private int cantidadClientes;
    
    //---------------------------------------------------------------------------------------------------------------------//
    //-------------------------------------------Constructor---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Passenger(int cod,boolean libre,double latitud,double longitud,int codRuta,int tiempoRecorrido,int codigoPuerto,
            boolean panico,int cantidadClientes,Date horaSalida,Date horaLlegada)
    {
        super(cod,libre,latitud,longitud,tiempoRecorrido,codigoPuerto,horaSalida,horaLlegada);
        this.panico=panico;
        this.cantidadClientes=cantidadClientes;
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    public int consultarCantidadPasajeros()
    {
        return cantidadClientes;
    }
    
    public void actualizarCantidadPasajeros(int cantidadNueva) throws Exception
    {
        if(cantidadClientes+cantidadNueva>CANTIDAD_MAX_PASAJEROS)
        {
            throw new Exception("No es posible agregar mas clientes a esta embarcacion");
        }
        else
        {
            cantidadClientes+=cantidadNueva;
        }
    }
    
    /**
     * Metodo para consultar el estado del boton de panico
     * @return boolean que retorna true si el boton fue usado o false en caso contrario
     */
    public boolean consultarBotonPanico()
    {
        return panico;
    }    
    
    /**
     * Metodo para usar el boton de panico en la embarcacion
     * @param panico , boolean que activa o desactiva el boton
     */
    public void cambiarBotonPanico(boolean panico)
    {
        this.panico=panico;
    }    
}
