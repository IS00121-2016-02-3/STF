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
@Table(name = "cargo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cargo.findAll", query = "SELECT c FROM Cargo c"),
    @NamedQuery(name = "Cargo.findByIdcargo", query = "SELECT c FROM Cargo c WHERE c.idcargo = :idcargo"),
    @NamedQuery(name = "Cargo.findByPesoCarga", query = "SELECT c FROM Cargo c WHERE c.pesoCarga = :pesoCarga")})
public class Cargo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idcargo")
    private Integer idcargo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "peso_carga")
    private int pesoCarga;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cargosIdcargo")
    private Collection<Transporte> transporteCollection;
    @JoinColumn(name = "embarcaciones_idembarcacion", referencedColumnName = "idembarcacion")
    @ManyToOne(optional = false)
    private Embarcacion embarcacionesIdembarcacion;

    public Cargo() {
    }

    public Cargo(Integer idcargo) {
        this.idcargo = idcargo;
    }

    public Cargo(Integer idcargo, int pesoCarga) {
        this.idcargo = idcargo;
        this.pesoCarga = pesoCarga;
    }

    public Integer getIdcargo() {
        return idcargo;
    }

    public void setIdcargo(Integer idcargo) {
        this.idcargo = idcargo;
    }

    public int getPesoCarga() {
        return pesoCarga;
    }

    public void setPesoCarga(int pesoCarga) {
        this.pesoCarga = pesoCarga;
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
        hash += (idcargo != null ? idcargo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cargo)) {
            return false;
        }
        Cargo other = (Cargo) object;
        if ((this.idcargo == null && other.idcargo != null) || (this.idcargo != null && !this.idcargo.equals(other.idcargo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Cargo[ idcargo=" + idcargo + " ]";
    }
    
    
    public boolean estaEnPosicion(double longitud,double latitud)
    {
       return embarcacionesIdembarcacion.getUbicacionesIdubicacion().getLongitud()==longitud &&
               embarcacionesIdembarcacion.getUbicacionesIdubicacion().getLatitud()==latitud;
    }
}
