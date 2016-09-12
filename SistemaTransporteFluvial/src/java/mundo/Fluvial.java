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
 *  Clase que representa un Fluvial en general
 * @author eliecer
 */
public class Fluvial 
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * hora de salida de la embarcacion
     */
    protected Date horaSalida;
    /**
     * hora de llegada de la embarcacion
     */
    protected Date horaLlegada;
    /**
     * mirar si la embarcacion esta libre o no
     */
    protected boolean libre;
    /**
     * tiempo en que tardo hacer el recorrido
     */
    protected int tiempoRecorrido;
    /**
     * latitud de la embarcacion
     */
    protected double latitud;
    /**
     * longitud de la embarcacion
     */
    protected double longitud;
    /**
     * codigo de la embarcacion
     */
    protected int codigo;
    /**
     * id del puerto en el que esta disponible
     */
    protected int codigoPuerto;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Contructor---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Fluvial(int codigo,boolean libre,double lat,double lon,int tiempoRecorrido,int codigoPuerto,Date horaSalida
            ,Date horaLLegada)
    {
        this.codigo=codigo;
        this.latitud=lat;
        this.longitud=lon;
        this.libre=libre;
        this.tiempoRecorrido=tiempoRecorrido;
        this.codigo=codigoPuerto;
        this.horaSalida=horaSalida;
        this.horaLlegada=horaLLegada;
    }
     //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Metodos---------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * da la hora de llegada de la embarcacion
     * @return  hora de llegada
     */
    public Date darHoraLlegada()
    {
        return horaLlegada;
    }
    /**
     * da la hora de salida de la embarcacion
     * @return hora de salida
     */
    public Date darHoraSalida()
    {
        return horaSalida;
    }
    /**
     * da el codigo de la embarcacion
     * @return 
     */
    public int darCodigo()
    {
        return codigo;
    }   
    /**
     * Metodo que mira si la embarcacion se encuentra en estado libre u ocupado
     * @return boolean diciendo si esta libre o ocupado
     */
    public boolean estaLibre()
    {
        return libre;
    }
    /**
     * metodo que da el tiempo del recorrido de la embarcacion desde el puerto
     * de salida hasta el puerto de llegada
     * @return tiempo recorrido total
     */
    public int darTiempoRecorrido()
    {
        return tiempoRecorrido;
    }
    /**
     * da la longitud de la embarcacion
     * @return longitud
     */
    public double darLongitud()
    {
        return longitud;
    }
    /**
     * da la latitud de la embarcacion
     * @return latitud
     */
    public double darLatitud()
    {
        return latitud;
    }
    
    /**
     * cambia la hora de salida de la embarcacion
     * @param hora , hora a cambiar
     */
    public void cambiarHoraSalida(Date hora)
    {
        horaSalida=hora;
    }
    /**
     * cambia la hora de llegada de la embarcacion
     * @param hora , hora a cambiar
     */
    public void cambiarHoraLlegada(Date hora)
    {
        horaLlegada=hora;
    }
    /**
     * asigna el tiempo total del recorrido
     * @param tiempo , tiempo total del recorrido desde el puerto de salida
     *                  hasta el puerto de llegada
     */
    public void asignarTiempoRecorrido(int tiempo)
    {
        tiempoRecorrido=tiempo;
    }
    /**
     * Cambia el estado de la embarcacion a libre=true o ocupado=false
     * @param estado , boolean que refiere al estado
     */
    public void cambiarEstado(boolean estado)
    {
        libre=estado;
    }
     /**
     * Asignar la latitud a la embarcacion
     * @param lat , latitud actual
     */
    public void asignarLatitud(double lat)
    {
        latitud=lat;
    }
    /**
     * Asignar la longitud a la embarcacion
     * @param lon , longitud actual
     */
    public void asignarLongitud(double lon)
    {
        longitud=lon;
    }     
}   