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
 * Clase que representa el cliente del sistema
 * @author eliecer
 */
public class Cliente extends Usuario
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * Codigo de la ruta a la cual esta asociado el cliente
     */
    private int codigoRuta;
    /**
     * cantidad de servicios pedidos
     */
    private int cantidadUso;
    private int codigoCargo;
    private int codigoCab;
    private int codigoPassenger;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
     public Cliente(int codigo, String contraseña, String usuario, String nombres,
             String apellidos, String identificacion, String telefono,int codigoRuta,int codigoCab,
             int codigoCargo,int codigoPassenger,int cantidadUso) {
        super(codigo, contraseña, usuario, nombres, apellidos, identificacion, telefono);
        this.codigoRuta=codigoRuta;
        this.cantidadUso=cantidadUso;
        this.codigoCab=codigoCab;
        this.codigoCargo=codigoCargo;
        this.codigoPassenger=codigoPassenger;
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * metodo que da la cantidad de uso del servicio por el cliente
     * @return cantidad uso del servicio
     */
    public int darCantidadUsoServicios()
    {
        return cantidadUso;
    }
    /**
     * Incrementa la cantidad de uso del sistema
     * @param cantidad , cantidad a la cual se le aumentara al actual
     */
    public void aumentarCantidadServicio(int cantidad)
    {
        cantidadUso+=cantidad;
    }
     /**
     * da el codigo de la ruta del cliente
     * @return codigo de la ruta
     */
    public int darCodigoRuta()
    {
        return codigoRuta;
    }
}
