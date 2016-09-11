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
 *  Clase que maneja los puertos
 * @author eliecer
 */
public class Puerto {	

    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    //---------------------------------------------------------------------------------------------------------------------//
    //---------------------------------------------Atributos---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * id del puerto
     */
    private int idPuerto;
    /**
     * longitud en la cual esta el puerto
     */
    private double longitud;
    /**
     * latitud en la cual esta el puerto
     */
    private double latitud;
     
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Puerto(int idPuerto,double longitud,double latitud) 
    {
        this.idPuerto=idPuerto;
        this.latitud=latitud;
        this.longitud=longitud;          
    }    
    //---------------------------------------------------------------------------------------------------------------------//
    //----------------------------------------------Métodos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//

    /**
     * metodo que da el id del puerto
     * @return el id del puerto
     */
    public int getIdPuerto() 
    {
        return idPuerto;
    }

    /**
     * Metodo que da la longitud en la que esta el puerto
     * @return  longitud
     */
    public double darLongitud() 
    {
        return longitud;
    }

    /**
     * metodo que da la latitud en la que esta la embarcacion
     * @return  latitud
     */
    public double darLatitud() 
    {
        return latitud;
    }
}
