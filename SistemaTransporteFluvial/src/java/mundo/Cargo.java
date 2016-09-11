package mundo;


import java.util.ArrayList;

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
 * Clase que maneja las embarcaciones CARGO
 * @author eliecer
 */
public class Cargo extends Fluvial
{
   //---------------------------------------------------------------------------------------------------------------------//
   //--------------------------------------------Constantes---------------------------------------------------------------//
   //---------------------------------------------------------------------------------------------------------------------//
    /**
     * calado del fluvial cargo en metros
     */
     private double CALADO_CARGO=1.5;
    /**
     * peso maximo en kilogramos del fluvial cargo
     */
    private int PESO_MAX_CARGA=5000;    
   //---------------------------------------------------------------------------------------------------------------------//
   //--------------------------------------------Atributos----------------------------------------------------------------//
   //---------------------------------------------------------------------------------------------------------------------//
    /**
     * carga actual del fluvial cargo
     */
    private int cargaActual;

  
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Cargo(int cod,boolean libre,double latitud,double longitud,int tiempoRecorrido,int codigoPuerto,int cargaActual)
    {
        super(cod,libre,latitud,longitud,tiempoRecorrido,codigoPuerto);
        this.cargaActual=cargaActual;
    }
    //----------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos-------------------------------------------------------------------//
    //----------------------------------------------------------------------------------------------------------------------//
    
    /**
     * metodo que da la carga actual de la embarcacion
     * @return carga actual
     */
    public int darCargaActual()
    {
        return cargaActual;
    }
    
    /**
     * actualiza la carga de la embarcacion
     * @param carga, carga que se le sumara a la carga actual
     * @throws Exception , bota excepcion si se supera la carga maxima
     */
    public void cambiarTotalCarga(int carga) throws Exception
    {
        if(cargaActual+carga<=PESO_MAX_CARGA)
        {
           cargaActual=carga; 
        }
        else
        {
            throw new Exception("No es posible asignar mas carga");   
        }        
    }
}
