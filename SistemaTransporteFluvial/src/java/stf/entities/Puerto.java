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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "puerto")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Puerto.findAll", query = "SELECT p FROM Puerto p"),
    @NamedQuery(name = "Puerto.findByIdpuerto", query = "SELECT p FROM Puerto p WHERE p.idpuerto = :idpuerto"),
    @NamedQuery(name = "Puerto.findByCapacidad", query = "SELECT p FROM Puerto p WHERE p.capacidad = :capacidad")})
public class Puerto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idpuerto")
    private Integer idpuerto;
    @Column(name = "capacidad")
    private Integer capacidad;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "puertosIdpuerto")
    private Collection<Ruta> rutaCollection;
    @JoinColumn(name = "ubicaciones_idubicacion", referencedColumnName = "idubicacion")
    @ManyToOne(optional = false)
    private Ubicacion ubicacionesIdubicacion;

    public Puerto() {
    }

    public Puerto(Integer idpuerto) {
        this.idpuerto = idpuerto;
    }

    public Integer getIdpuerto() {
        return idpuerto;
    }

    public void setIdpuerto(Integer idpuerto) {
        this.idpuerto = idpuerto;
    }

    public Integer getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(Integer capacidad) {
        this.capacidad = capacidad;
    }

    @XmlTransient
    public Collection<Ruta> getRutaCollection() {
        return rutaCollection;
    }

    public void setRutaCollection(Collection<Ruta> rutaCollection) {
        this.rutaCollection = rutaCollection;
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
        hash += (idpuerto != null ? idpuerto.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Puerto)) {
            return false;
        }
        Puerto other = (Puerto) object;
        if ((this.idpuerto == null && other.idpuerto != null) || (this.idpuerto != null && !this.idpuerto.equals(other.idpuerto))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Puerto[ idpuerto=" + idpuerto + " ]";
    }
    
    public boolean estaEnPosicion(double longitud,double latitud)
    {
        return ubicacionesIdubicacion.getLongitud()==longitud && ubicacionesIdubicacion.getLatitud()==latitud;
    }
    
}
