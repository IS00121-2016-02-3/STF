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
 *  Clase que maneja las embarcaciones CAB
 * @author eliecer
 */
public class Cab extends Fluvial
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * calado de la embarcacion fluvial en metros
     */
    public static final double CALADO_CAB=0.03;
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
   /**
    * boolean que maneja el estado del boton de panico
    */
   private boolean panico;   
   /**
    * codigo del puerto en el cual esta en espera o disponible
    */
   private int codigoPuerto;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Cab(int cod,boolean libre,double latitud,double longitud,int tiempoRecorrido,int codigoPuerto,boolean panico
    ,Date horaSalida,Date horaLlegada)
    {
        super(cod,libre,latitud,longitud,tiempoRecorrido,codigoPuerto,horaSalida,horaLlegada);
        this.panico=panico;       
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
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
