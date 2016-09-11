package mundo;

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
 * Clase que representa las rutas del sistema
 * @author eliecer
 */
public class Ruta 
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
   
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * codigo de la ruta
     */
    private int codigoRuta;
    /**
     * codigo de la embarcacion
     */
    private int codigoEmbarcacion;
    /**
     * codigo puerto de salida
     */
    private int codigoPuertoSalida;
    /**
     * codigo puerto de entrada
     */
    private int codigoPuertoEntrada;
    /**
     * orden de la ruta
     */
    private int orden;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Ruta(int codigoRuta,int codigoEmbarcacion,int codigoPuertoSalida,int codigoPuertoEntrada,int orden)
    {
        this.codigoRuta=codigoRuta;
        this.codigoEmbarcacion=codigoEmbarcacion;
        this.codigoPuertoEntrada=codigoPuertoEntrada;
        this.codigoPuertoSalida=codigoPuertoSalida;
        this.orden=orden;            
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//

    /**
     * da el codigo de la ruta
     * @return el codigoRuta
     */
    public int darCodigoRuta() {
        return codigoRuta;
    }

    /**
     * da el codigo de la embarcacion
     * @return el codigoEmbarcacion
     */
    public int darCodigoEmbarcacion() {
        return codigoEmbarcacion;
    }

    /**
     * da el codigo del puerto de salida
     * @return el codigoPuertoSalida
     */
    public int darCodigoPuertoSalida() {
        return codigoPuertoSalida;
    }

    /**
     * da el codigo del puerto de entrada
     * @return el codigoPuertoEntrada
     */
    public int darCodigoPuertoEntrada() {
        return codigoPuertoEntrada;
    }

    /**
     * da el orden que debe seguirse para cumplir la ruta
     * @return el orden
     */
    public int darOrden() {
        return orden;
    }
   
    
}
