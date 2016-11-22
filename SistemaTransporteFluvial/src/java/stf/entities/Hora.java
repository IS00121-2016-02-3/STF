/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author eliecer
 */
@Entity
@Table(name = "hora")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Hora.findAll", query = "SELECT h FROM Hora h"),
    @NamedQuery(name = "Hora.findByIdhora", query = "SELECT h FROM Hora h WHERE h.idhora = :idhora"),
    @NamedQuery(name = "Hora.findByHoraSalida", query = "SELECT h FROM Hora h WHERE h.horaSalida = :horaSalida"),
    @NamedQuery(name = "Hora.findByHoraLlegada", query = "SELECT h FROM Hora h WHERE h.horaLlegada = :horaLlegada")})
public class Hora implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idhora")
    private Integer idhora;
    @Column(name = "hora_salida")
    @Temporal(TemporalType.TIME)
    private Date horaSalida;
    @Column(name = "hora_llegada")
    @Temporal(TemporalType.TIME)
    private Date horaLlegada;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "horasIdhora")
    private Collection<Ruta> rutaCollection;

    public Hora() {
    }

    public Hora(Integer idhora) {
        this.idhora = idhora;
    }

    public Integer getIdhora() {
        return idhora;
    }

    public void setIdhora(Integer idhora) {
        this.idhora = idhora;
    }

    public Date getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(Date horaSalida) {
        this.horaSalida = horaSalida;
    }

    public Date getHoraLlegada() {
        return horaLlegada;
    }

    public void setHoraLlegada(Date horaLlegada) {
        this.horaLlegada = horaLlegada;
    }

    @XmlTransient
    public Collection<Ruta> getRutaCollection() {
        return rutaCollection;
    }

    public void setRutaCollection(Collection<Ruta> rutaCollection) {
        this.rutaCollection = rutaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idhora != null ? idhora.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Hora)) {
            return false;
        }
        Hora other = (Hora) object;
        if ((this.idhora == null && other.idhora != null) || (this.idhora != null && !this.idhora.equals(other.idhora))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Hora[ idhora=" + idhora + " ]";
    }
    
}
