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
@Table(name = "passenger")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Passenger.findAll", query = "SELECT p FROM Passenger p"),
    @NamedQuery(name = "Passenger.findByIdpassengers", query = "SELECT p FROM Passenger p WHERE p.idpassengers = :idpassengers"),
    @NamedQuery(name = "Passenger.findByCantidadPasageros", query = "SELECT p FROM Passenger p WHERE p.cantidadPasageros = :cantidadPasageros")})
public class Passenger implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idpassengers")
    private Integer idpassengers;
    @Basic(optional = false)
    @NotNull
    @Column(name = "cantidad_pasageros")
    private int cantidadPasageros;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "passengersIdpassengers")
    private Collection<Transporte> transporteCollection;
    @JoinColumn(name = "embarcaciones_idembarcacion", referencedColumnName = "idembarcacion")
    @ManyToOne(optional = false)
    private Embarcacion embarcacionesIdembarcacion;

    public Passenger() {
    }

    public Passenger(Integer idpassengers) {
        this.idpassengers = idpassengers;
    }

    public Passenger(Integer idpassengers, int cantidadPasageros) {
        this.idpassengers = idpassengers;
        this.cantidadPasageros = cantidadPasageros;
    }

    public Integer getIdpassengers() {
        return idpassengers;
    }

    public void setIdpassengers(Integer idpassengers) {
        this.idpassengers = idpassengers;
    }

    public int getCantidadPasageros() {
        return cantidadPasageros;
    }

    public void setCantidadPasageros(int cantidadPasageros) {
        this.cantidadPasageros = cantidadPasageros;
    }

    @XmlTransient
    public Collection<Transporte> getTransporteCollection() {
        return transporteCollection;
    }

    public void setTransporteCollection(Collection<Transporte> transporteCollection) {
        this.transporteCollection = transporteCollection;
    }

    public Embarcacion getEmbarcacionesIdembarcacion() {
        return embarcacionesIdembarcacion;
    }

    public void setEmbarcacionesIdembarcacion(Embarcacion embarcacionesIdembarcacion) {
        this.embarcacionesIdembarcacion = embarcacionesIdembarcacion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idpassengers != null ? idpassengers.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Passenger)) {
            return false;
        }
        Passenger other = (Passenger) object;
        if ((this.idpassengers == null && other.idpassengers != null) || (this.idpassengers != null && !this.idpassengers.equals(other.idpassengers))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Passenger[ idpassengers=" + idpassengers + " ]";
    }
    public boolean estaEnPosicion(double longitud,double latitud)
    {
       return embarcacionesIdembarcacion.getUbicacionesIdubicacion().getLongitud()==longitud
               &&embarcacionesIdembarcacion.getUbicacionesIdubicacion().getLatitud()==latitud;
    }
}
