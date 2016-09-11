package mundo;


import javax.swing.JOptionPane;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
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
 * Clase que maneja los sensores del sistema
 * @author eliecer
 */
public class Sensor 
{
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Atributos----------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    /**
     * id del sensor
     */   
    private int idSensor;
    /**
     * altura del rio
     */
    private double alturaRio;
    /**
     * fecha en la que envia la informacion el sensor
     */
    private Date fecha;
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Constructor--------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//
    public Sensor(int idSensor, double alturaRio,Date fecha) 
    {
     this.idSensor=idSensor;
     this.fecha=fecha;
     this.alturaRio=alturaRio;        
    }
    //---------------------------------------------------------------------------------------------------------------------//
    //--------------------------------------------Métodos------------------------------------------------------------------//
    //---------------------------------------------------------------------------------------------------------------------//

    /**
     * metodo que da el id del sensor
     * @return id del sensor
     */
    public int getIdSensor() 
    {
        return idSensor;
    }
    /**
     * metodo que da la altura del rio leida por el sensor
     * @return altura del rio
     */
    public double getAlturaRio() 
    {
        return alturaRio;
    }
    /**
     * metodo que actualiza la altura actual del rio
     * @param alturaRio  nueva altura a poner
     */
    public void setAlturaRio(double alturaRio) 
    {
        this.alturaRio = alturaRio;
    }
    /**
     * da la fecha y la hora de la informacion enviada
     * @return  fecha actual
     */
    public Date getFecha() 
    {
        return fecha;
    }
    /**
     * cambia la fecha por una nueva
     * @param fecha , nueva fecha
     */
    public void setFecha(Date fecha)
    {
        this.fecha = fecha;
    }   
}
