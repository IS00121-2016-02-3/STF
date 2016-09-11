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
 * Clase que maneja los usuarios del sistema
 * @author eliecer
 */
public class Usuario 
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constantes---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
      
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * codigo del usuario en el sistema
     */
    private int codigo;
    /**
     * contraseña del usuario
     */
    private String contraseña;
    /**
     * usuario de acceso
     */
    private String usuario;
    /**
     * nombres del usuario
     */
    private String nombres;
    /**
     * appellidos del usuario
     */
    private String apellidos;
    /**
     * identificacion del usuario (cedula)
     */
    private String identificacion;
    /**
     * telefono del usuario
     */
    private String telefono;    
    
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Usuario(int codigo,String contraseña,String usuario,String nombres,String apellidos,String identificacion,
            String telefono)
    {
        this.codigo=codigo;
        this.contraseña=contraseña;
        this.usuario=usuario;
        this.nombres=nombres;
        this.apellidos=apellidos;
        this.identificacion=identificacion;
        this.telefono=telefono;
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//

    /**
     * metodo que da el codigo del usuario
     * @return the codigo
     */
    public int darCodigo() {
        return codigo;
    }

    /**
     * metodo que da la contraseña
     * @return the contraseña
     */
    public String darContraseña() {
        return contraseña;
    }

    /**
     * metodo que cambia la contraseña
     * @param contraseña the contraseña to cambiar
     */
    public void cambiarContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    /**
     * metodo que da el nombre de usuario
     * @return the usuario
     */
    public String darUsuario() {
        return usuario;
    }

    /**
     * metodo que cambia el nombre de usuario
     * @param usuario the usuario to cambiar
     */
    public void cambiarUsuario(String usuario) {
        this.usuario = usuario;
    }

    /**
     * metodo que da los nombres
     * @return the nombres
     */
    public String darNombres() {
        return nombres;
    }

    /**
     * metodo que cambia los nombres
     * @param nombres the nombres to cambiar
     */
    public void cambiarNombres(String nombres) {
        this.nombres = nombres;
    }

    /**
     * metodo que da los apellidos
     * @return the apellidos
     */
    public String darApellidos() {
        return apellidos;
    }

    /**metodo que cambia los apellidos
     * @param apellidos the apellidos to cambiar
     */
    public void cambiarApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    /**
     * metodo que da la identificacion del usuario
     * @return the identificacion
     */
    public String darIdentificacion() {
        return identificacion;
    }

    /**
     * metodo que actualiza la identificacion del usuario
     * @param identificacion the identificacion to cambiar
     */
    public void cambiarIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    /**
     * metodo que da el telefono del usuario
     * @return the telefono
     */
    public String darTelefono() {
        return telefono;
    }

    /**
     * cambia el telefono del usuario
     * @param telefono el telefono a cambiar
     */
    public void cambiarTelefono(String telefono) {
        this.telefono = telefono;
    }    
}
