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
 * @author eliecer
 */
@Entity
@Table(name = "ruta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ruta.findAll", query = "SELECT r FROM Ruta r"),
    @NamedQuery(name = "Ruta.findByIdruta", query = "SELECT r FROM Ruta r WHERE r.idruta = :idruta"),
    @NamedQuery(name = "Ruta.findByNombre", query = "SELECT r FROM Ruta r WHERE r.nombre = :nombre"),
    @NamedQuery(name = "Ruta.findByTrayecto", query = "SELECT r FROM Ruta r WHERE r.trayecto = :trayecto"),
    @NamedQuery(name = "Ruta.findByTiempoInvertido", query = "SELECT r FROM Ruta r WHERE r.tiempoInvertido = :tiempoInvertido")})
public class Ruta implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idruta")
    private Integer idruta;
    @Size(max = 45)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 500)
    @Column(name = "trayecto")
    private String trayecto;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "tiempo_invertido")
    private String tiempoInvertido;
    @JoinColumn(name = "horas_idhora", referencedColumnName = "idhora")
    @ManyToOne(optional = true)
    private Hora horasIdhora;
    @JoinColumn(name = "puertos_idpuerto", referencedColumnName = "idpuerto")
    @ManyToOne(optional = true)
    private Puerto puertosIdpuerto;
    @JoinColumn(name = "transportes_idtransporte", referencedColumnName = "idtransporte")
    @ManyToOne(optional = true)
    private Transporte transportesIdtransporte;

    public Ruta() {
    }

    public Ruta(Integer idruta) {
        this.idruta = idruta;
    }

    public Ruta(Integer idruta, String trayecto, String tiempoInvertido) {
        this.idruta = idruta;
        this.trayecto = trayecto;
        this.tiempoInvertido = tiempoInvertido;
    }

    public Integer getIdruta() {
        return idruta;
    }

    public void setIdruta(Integer idruta) {
        this.idruta = idruta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTrayecto() {
        return trayecto;
    }

    public void setTrayecto(String trayecto) {
        this.trayecto = trayecto;
    }

    public String getTiempoInvertido() {
        return tiempoInvertido;
    }

    public void setTiempoInvertido(String tiempoInvertido) {
        this.tiempoInvertido = tiempoInvertido;
    }

    public Hora getHorasIdhora() {
        return horasIdhora;
    }

    public void setHorasIdhora(Hora horasIdhora) {
        this.horasIdhora = horasIdhora;
    }

    public Puerto getPuertosIdpuerto() {
        return puertosIdpuerto;
    }

    public void setPuertosIdpuerto(Puerto puertosIdpuerto) {
        this.puertosIdpuerto = puertosIdpuerto;
    }

    public Transporte getTransportesIdtransporte() {
        return transportesIdtransporte;
    }

    public void setTransportesIdtransporte(Transporte transportesIdtransporte) {
        this.transportesIdtransporte = transportesIdtransporte;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idruta != null ? idruta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ruta)) {
            return false;
        }
        Ruta other = (Ruta) object;
        if ((this.idruta == null && other.idruta != null) || (this.idruta != null && !this.idruta.equals(other.idruta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "stf.entities.Ruta[ idruta=" + idruta + " ]";
    }
    
    public boolean estaDisponible(){
    
        return transportesIdtransporte.cualEs().getDisponibilidad();        
    }
    public boolean estaEnPuerto(double longitud)
    {
        return transportesIdtransporte.cualEs().getUbicacionesIdubicacion().getLongitud()==longitud;
    }

    
}
