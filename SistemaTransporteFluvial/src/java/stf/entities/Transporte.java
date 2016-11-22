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
@Table(name = "transporte")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Transporte.findAll", query = "SELECT t FROM Transporte t"),
    @NamedQuery(name = "Transporte.findByIdtransporte", query = "SELECT t FROM Transporte t WHERE t.idtransporte = :idtransporte"),
    @NamedQuery(name = "Transporte.findByTipo", query = "SELECT t FROM Transporte t WHERE t.tipo = :tipo"),
    @NamedQuery(name = "Transporte.findByDescripcion", query = "SELECT t FROM Transporte t WHERE t.descripcion = :descripcion")})
public class Transporte implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idtransporte")
    private Integer idtransporte;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "tipo")
    private String tipo;
    @Size(max = 45)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "transportesIdtransporte")
    private Collection<Servicio> servicioCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "transportesIdtransporte")
    private Collection<Ruta> rutaCollection;
    @JoinColumn(name = "cabs_idcab", referencedColumnName = "idcab")
    @ManyToOne(optional = false)
    private Cab cabsIdcab;
    @JoinColumn(name = "cargos_idcargo", referencedColumnName = "idcargo")
    @ManyToOne(optional = false)
    private Cargo cargosIdcargo;
    @JoinColumn(name = "passengers_idpassengers", referencedColumnName = "idpassengers")
    @ManyToOne(optional = false)
    private Passenger passengersIdpassengers;

    public Transporte() {
    }

    public Transporte(Integer idtransporte) {
        this.idtransporte = idtransporte;
    }

    public Transporte(Integer idtransporte, String tipo) {
        this.idtransporte = idtransporte;
        this.tipo = tipo;
    }

    public Integer getIdtransporte() {
        return idtransporte;
    }

    public void setIdtransporte(Integer idtransporte) {
        this.idtransporte = idtransporte;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public Collection<Servicio> getServicioCollection() {
        return servicioCollection;
    }

    public void setServicioCollection(Collection<Servicio> servicioCollection) {
        this.servicioCollection = servicioCollection;
    }

    @XmlTransient
    public Collection<Ruta> getRutaCollection() {
        return rutaCollection;
    }

    public void setRutaCollection(Collection<Ruta> rutaCollection) {
        this.rutaCollection = rutaCollection;
    }

    public Cab getCabsIdcab() {
        return cabsIdcab;
    }

    public void setCabsIdcab(Cab cabsIdcab) {
        this.cabsIdcab = cabsIdcab;
    }

    public Cargo getCargosIdcargo() {
        return cargosIdcargo;
    }

    public void setCargosIdcargo(Cargo cargosIdcargo) {
        this.cargosIdcargo = cargosIdcargo;
    }

    public Passenger getPassengersIdpassengers() {
        return passengersIdpassengers;
    }

    public void setPassengersIdpassengers(Passenger passengersIdpassengers) {
        this.passengersIdpassengers = passengersIdpassengers;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtransporte != null ? idtransporte.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Transporte)) {
            return false;
        }
        Transporte other = (Transporte) object;
        if ((this.idtransporte == null && other.idtransporte != null) || (this.idtransporte != null && !this.idtransporte.equals(other.idtransporte))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Transporte[ idtransporte=" + idtransporte + " ]";
    }
    
    public Embarcacion cualEs()
    {
        Embarcacion e=null;
        if(cabsIdcab!=null)
        {
            e=cabsIdcab.getEmbarcacionesIdembarcacion();
        }
        else if(cargosIdcargo!=null)
        {
            e=cargosIdcargo.getEmbarcacionesIdembarcacion();
        }
        else
        {
            e=passengersIdpassengers.getEmbarcacionesIdembarcacion();
        }
        return e;
    }
    public Cargo esCargo(){
        Cargo car=null;
        if (cargosIdcargo != null) {
            car= cargosIdcargo;
        }
        return car;
    }
    public Passenger esPassenger(){
        Passenger pas=null;
        if (passengersIdpassengers != null) {
            pas= passengersIdpassengers;
        }
        return pas;
    }
    
}
