/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author eliecer
 */
@Entity
@Table(name = "sensor")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Sensor.findAll", query = "SELECT s FROM Sensor s"),
    @NamedQuery(name = "Sensor.findByIdsensor", query = "SELECT s FROM Sensor s WHERE s.idsensor = :idsensor"),
    @NamedQuery(name = "Sensor.findByNivelAgua", query = "SELECT s FROM Sensor s WHERE s.nivelAgua = :nivelAgua"),
    @NamedQuery(name = "Sensor.findByFecha", query = "SELECT s FROM Sensor s WHERE s.fecha = :fecha")})
public class Sensor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idsensor")
    private Integer idsensor;
    @Basic(optional = false)
    @NotNull
    @Column(name = "nivel_agua")
    private int nivelAgua;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @JoinColumn(name = "ubicaciones_idubicacion", referencedColumnName = "idubicacion")
    @ManyToOne(optional = false)
    private Ubicacion ubicacionesIdubicacion;

    public Sensor() {
    }

    public Sensor(Integer idsensor) {
        this.idsensor = idsensor;
    }

    public Sensor(Integer idsensor, int nivelAgua, Date fecha) {
        this.idsensor = idsensor;
        this.nivelAgua = nivelAgua;
        this.fecha = fecha;
    }

    public Integer getIdsensor() {
        return idsensor;
    }

    public void setIdsensor(Integer idsensor) {
        this.idsensor = idsensor;
    }

    public int getNivelAgua() {
        return nivelAgua;
    }

    public void setNivelAgua(int nivelAgua) {
        this.nivelAgua = nivelAgua;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Ubicacion getUbicacionesIdubicacion() {
        return ubicacionesIdubicacion;
    }

    public void setUbicacionesIdubicacion(Ubicacion ubicacionesIdubicacion) {
        this.ubicacionesIdubicacion = ubicacionesIdubicacion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idsensor != null ? idsensor.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sensor)) {
            return false;
        }
        Sensor other = (Sensor) object;
        if ((this.idsensor == null && other.idsensor != null) || (this.idsensor != null && !this.idsensor.equals(other.idsensor))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Sensor[ idsensor=" + idsensor + " ]";
    }
    
     public boolean estaEnUbicacion(double longitud, double latitud)
    {
        return ubicacionesIdubicacion.getLongitud()==longitud && ubicacionesIdubicacion.getLatitud()==latitud;
    }
    
}
