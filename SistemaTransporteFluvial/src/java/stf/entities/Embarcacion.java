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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author eliecer
 */
@Entity
@Table(name = "embarcacion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Embarcacion.findAll", query = "SELECT e FROM Embarcacion e"),
    @NamedQuery(name = "Embarcacion.findByIdembarcacion", query = "SELECT e FROM Embarcacion e WHERE e.idembarcacion = :idembarcacion"),
    @NamedQuery(name = "Embarcacion.findByDisponibilidad", query = "SELECT e FROM Embarcacion e WHERE e.disponibilidad = :disponibilidad"),
    @NamedQuery(name = "Embarcacion.findByCalado", query = "SELECT e FROM Embarcacion e WHERE e.calado = :calado"),
    @NamedQuery(name = "Embarcacion.findByDescripcion", query = "SELECT e FROM Embarcacion e WHERE e.descripcion = :descripcion"),
    @NamedQuery(name = "Embarcacion.findByBotonPanico", query = "SELECT e FROM Embarcacion e WHERE e.botonPanico = :botonPanico")})
public class Embarcacion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idembarcacion")
    private Integer idembarcacion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "disponibilidad")
    private boolean disponibilidad;
    @Basic(optional = false)
    @NotNull
    @Column(name = "calado")
    private int calado;
    @Size(max = 45)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "boton_panico")
    private Character botonPanico;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "embarcacionesIdembarcacion")
    private Collection<Cab> cabCollection;
    @JoinColumn(name = "ubicaciones_idubicacion", referencedColumnName = "idubicacion")
    @ManyToOne(optional = false)
    private Ubicacion ubicacionesIdubicacion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "embarcacionesIdembarcacion")
    private Collection<Passenger> passengerCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "embarcacionesIdembarcacion")
    private Collection<Cargo> cargoCollection;

    public Embarcacion() {
    }

    public Embarcacion(Integer idembarcacion) {
        this.idembarcacion = idembarcacion;
    }

    public Embarcacion(Integer idembarcacion, boolean disponibilidad, int calado, Character botonPanico) {
        this.idembarcacion = idembarcacion;
        this.disponibilidad = disponibilidad;
        this.calado = calado;
        this.botonPanico = botonPanico;
    }

    public Integer getIdembarcacion() {
        return idembarcacion;
    }

    public void setIdembarcacion(Integer idembarcacion) {
        this.idembarcacion = idembarcacion;
    }

    public boolean getDisponibilidad() {
        return disponibilidad;
    }

    public void setDisponibilidad(boolean disponibilidad) {
        this.disponibilidad = disponibilidad;
    }

    public int getCalado() {
        return calado;
    }

    public void setCalado(int calado) {
        this.calado = calado;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Character getBotonPanico() {
        return botonPanico;
    }

    public void setBotonPanico(Character botonPanico) {
        this.botonPanico = botonPanico;
    }

    @XmlTransient
    public Collection<Cab> getCabCollection() {
        return cabCollection;
    }

    public void setCabCollection(Collection<Cab> cabCollection) {
        this.cabCollection = cabCollection;
    }

    public Ubicacion getUbicacionesIdubicacion() {
        return ubicacionesIdubicacion;
    }

    public void setUbicacionesIdubicacion(Ubicacion ubicacionesIdubicacion) {
        this.ubicacionesIdubicacion = ubicacionesIdubicacion;
    }

    @XmlTransient
    public Collection<Passenger> getPassengerCollection() {
        return passengerCollection;
    }

    public void setPassengerCollection(Collection<Passenger> passengerCollection) {
        this.passengerCollection = passengerCollection;
    }

    @XmlTransient
    public Collection<Cargo> getCargoCollection() {
        return cargoCollection;
    }

    public void setCargoCollection(Collection<Cargo> cargoCollection) {
        this.cargoCollection = cargoCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idembarcacion != null ? idembarcacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Embarcacion)) {
            return false;
        }
        Embarcacion other = (Embarcacion) object;
        if ((this.idembarcacion == null && other.idembarcacion != null) || (this.idembarcacion != null && !this.idembarcacion.equals(other.idembarcacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Embarcacion[ idembarcacion=" + idembarcacion + " ]";
    }
    
}
