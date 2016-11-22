/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author BrianUser
 */
@Entity
@Table(name = "servicio")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicio.findAll", query = "SELECT s FROM Servicio s")
    , @NamedQuery(name = "Servicio.findByIdservicio", query = "SELECT s FROM Servicio s WHERE s.idservicio = :idservicio")
    , @NamedQuery(name = "Servicio.findByDescripcion", query = "SELECT s FROM Servicio s WHERE s.descripcion = :descripcion")
    , @NamedQuery(name = "Servicio.findByPuertollegada", query = "SELECT s FROM Servicio s WHERE s.puertollegada = :puertollegada")
    , @NamedQuery(name = "Servicio.findByPesocarga", query = "SELECT s FROM Servicio s WHERE s.pesocarga = :pesocarga")})
public class Servicio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idservicio")
    private Integer idservicio;
    @Size(max = 100)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "puertollegada")
    private int puertollegada;
    @Column(name = "pesocarga")
    private Integer pesocarga;
    @JoinColumn(name = "transportes_idtransporte", referencedColumnName = "idtransporte")
    @ManyToOne(optional = false)
    private Transporte transportesIdtransporte;
    @JoinColumn(name = "usuarios_idusuario", referencedColumnName = "idusuario")
    @ManyToOne(optional = false)
    private Usuario usuariosIdusuario;

    public Servicio() {
    }

    public Servicio(Integer idservicio) {
        this.idservicio = idservicio;
    }

    public Servicio(Integer idservicio, int puertollegada) {
        this.idservicio = idservicio;
        this.puertollegada = puertollegada;
    }

    public Integer getIdservicio() {
        return idservicio;
    }

    public void setIdservicio(Integer idservicio) {
        this.idservicio = idservicio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPuertollegada() {
        return puertollegada;
    }

    public void setPuertollegada(int puertollegada) {
        this.puertollegada = puertollegada;
    }

    public Integer getPesocarga() {
        return pesocarga;
    }

    public void setPesocarga(Integer pesocarga) {
        this.pesocarga = pesocarga;
    }

    public Transporte getTransportesIdtransporte() {
        return transportesIdtransporte;
    }

    public void setTransportesIdtransporte(Transporte transportesIdtransporte) {
        this.transportesIdtransporte = transportesIdtransporte;
    }

    public Usuario getUsuariosIdusuario() {
        return usuariosIdusuario;
    }

    public void setUsuariosIdusuario(Usuario usuariosIdusuario) {
        this.usuariosIdusuario = usuariosIdusuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idservicio != null ? idservicio.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Servicio)) {
            return false;
        }
        Servicio other = (Servicio) object;
        if ((this.idservicio == null && other.idservicio != null) || (this.idservicio != null && !this.idservicio.equals(other.idservicio))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Servicio[ idservicio=" + idservicio + " ]";
    }
    
}
