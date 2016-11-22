/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.entities;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author eliecer
 */
@Entity
@Table(name = "ubicacion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ubicacion.findAll", query = "SELECT u FROM Ubicacion u"),
    @NamedQuery(name = "Ubicacion.findByIdubicacion", query = "SELECT u FROM Ubicacion u WHERE u.idubicacion = :idubicacion"),
    @NamedQuery(name = "Ubicacion.findByLatitud", query = "SELECT u FROM Ubicacion u WHERE u.latitud = :latitud"),
    @NamedQuery(name = "Ubicacion.findByLongitud", query = "SELECT u FROM Ubicacion u WHERE u.longitud = :longitud")})
public class Ubicacion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idubicacion")
    private Integer idubicacion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "latitud")
    private double latitud;
    @Basic(optional = false)
    @NotNull
    @Column(name = "longitud")
    private double longitud;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ubicacionesIdubicacion")
    private Collection<Embarcacion> embarcacionCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ubicacionesIdubicacion")
    private Collection<Puerto> puertoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ubicacionesIdubicacion")
    private Collection<Sensor> sensorCollection;

    public Ubicacion() {
    }

    public Ubicacion(Integer idubicacion) {
        this.idubicacion = idubicacion;
    }

    public Ubicacion(Integer idubicacion, int latitud, int longitud) {
        this.idubicacion = idubicacion;
        this.latitud = latitud;
        this.longitud = longitud;
    }

    public Integer getIdubicacion() {
        return idubicacion;
    }

    public void setIdubicacion(Integer idubicacion) {
        this.idubicacion = idubicacion;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    @XmlTransient
    public Collection<Embarcacion> getEmbarcacionCollection() {
        return embarcacionCollection;
    }

    public void setEmbarcacionCollection(Collection<Embarcacion> embarcacionCollection) {
        this.embarcacionCollection = embarcacionCollection;
    }

    @XmlTransient
    public Collection<Puerto> getPuertoCollection() {
        return puertoCollection;
    }

    public void setPuertoCollection(Collection<Puerto> puertoCollection) {
        this.puertoCollection = puertoCollection;
    }

    @XmlTransient
    public Collection<Sensor> getSensorCollection() {
        return sensorCollection;
    }

    public void setSensorCollection(Collection<Sensor> sensorCollection) {
        this.sensorCollection = sensorCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idubicacion != null ? idubicacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ubicacion)) {
            return false;
        }
        Ubicacion other = (Ubicacion) object;
        if ((this.idubicacion == null && other.idubicacion != null) || (this.idubicacion != null && !this.idubicacion.equals(other.idubicacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Ubicacion[ idubicacion=" + idubicacion + " ]";
    }
    
}
