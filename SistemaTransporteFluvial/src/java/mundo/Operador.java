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
 * Clase que representa un operador del sistema
 * @author eliecer
 */
public class Operador extends Usuario
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
   /**
    * puerto de trabajo asignado al operador
    */
    private int codigoPuerto;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Operador(int codigo, String contraseña, String usuario, String nombres, String apellidos,
            String identificacion, String telefono,int codigoPuerto) 
    {
        super(codigo, contraseña, usuario, nombres, apellidos, identificacion, telefono);
        this.codigoPuerto=codigoPuerto;
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
   /**
    * da el puerto asignado al operador
    */
    public int darCodigoPuerto()
    {
        return codigoPuerto;
    }
    /**
     * asigna un nuevo puerto al operador
     */
    public void cambiarPuertoTraabajo(int nuevo)
    {
        codigoPuerto=nuevo;
    }
}
