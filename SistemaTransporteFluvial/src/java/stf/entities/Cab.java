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
@Table(name = "cab")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cab.findAll", query = "SELECT c FROM Cab c"),
    @NamedQuery(name = "Cab.findByIdcab", query = "SELECT c FROM Cab c WHERE c.idcab = :idcab")})
public class Cab implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idcab")
    private Integer idcab;
    @JoinColumn(name = "embarcaciones_idembarcacion", referencedColumnName = "idembarcacion")
    @ManyToOne(optional = false)
    private Embarcacion embarcacionesIdembarcacion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cabsIdcab")
    private Collection<Transporte> transporteCollection;

    public Cab() {
    }

    public Cab(Integer idcab) {
        this.idcab = idcab;
    }

    public Integer getIdcab() {
        return idcab;
    }

    public void setIdcab(Integer idcab) {
        this.idcab = idcab;
    }

    public Embarcacion getEmbarcacionesIdembarcacion() {
        return embarcacionesIdembarcacion;
    }

    public void setEmbarcacionesIdembarcacion(Embarcacion embarcacionesIdembarcacion) {
        this.embarcacionesIdembarcacion = embarcacionesIdembarcacion;
    }

    @XmlTransient
    public Collection<Transporte> getTransporteCollection() {
        return transporteCollection;
    }

    public void setTransporteCollection(Collection<Transporte> transporteCollection) {
        this.transporteCollection = transporteCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcab != null ? idcab.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cab)) {
            return false;
        }
        Cab other = (Cab) object;
        if ((this.idcab == null && other.idcab != null) || (this.idcab != null && !this.idcab.equals(other.idcab))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Cab[ idcab=" + idcab + " ]";
    }
    
    public boolean estaEnPosicion(double longitud,double latitud)
    {
       return embarcacionesIdembarcacion.getUbicacionesIdubicacion().getLongitud()==longitud &&
               embarcacionesIdembarcacion.getUbicacionesIdubicacion().getLatitud()==latitud;
    }
    
}
