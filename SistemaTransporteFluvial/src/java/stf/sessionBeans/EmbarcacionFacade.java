    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import stf.entities.Cab;
import stf.entities.Cargo;
import stf.entities.Embarcacion;
import stf.entities.Hora;
import stf.entities.Passenger;
import stf.entities.Puerto;
import stf.entities.Ruta;
import stf.entities.Sensor;
import stf.entities.Servicio;
import stf.entities.Transporte;
import stf.entities.Usuario;

/**
 *
 * @author eliecer
 */
@Stateless
public class EmbarcacionFacade extends AbstractFacade<Embarcacion> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EmbarcacionFacade() {
        super(Embarcacion.class);
    }
    
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void solicitarEmbarcacion(int tipo,int puertoSalida,int puertoLlegada,String usuario, String contraseña,int pesoCarga)
    {        
        Query u = em.createQuery("SELECT u FROM Usuario u WHERE u.usuario=:user AND u.password=:pass ")
                .setParameter("user", usuario)
                .setParameter("pass", contraseña);
        Usuario user = (Usuario) u.getSingleResult();

        Query query = em.createQuery("SELECT p FROM Puerto p WHERE p.idpuerto=:puer ")
                .setParameter("puer", puertoSalida);
        Puerto p = (Puerto) query.getSingleResult();
        
        //---------------------------------------------------------
        Query query2 = em.createQuery("SELECT r FROM Ruta r WHERE r.puertosIdpuerto=:puer ")
                .setParameter("puer",p);
        List<Ruta> rutas=query2.getResultList();
        if(!rutas.isEmpty() && tipo!=2)
        {
            for (int i = 0; i < rutas.size(); i++) 
            {
                Ruta temp=(Ruta)rutas.get(i);
                Transporte t=temp.getTransportesIdtransporte();
                if(t.getCargosIdcargo()!=null && tipo==1)
                {
                    if(t.getCargosIdcargo().getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                    {
                        int pesoActual=t.getCargosIdcargo().getPesoCarga();
                        int pesoNuevo=pesoActual+pesoCarga;
                        if(pesoActual==5000)
                        {
                            t.getCargosIdcargo().getEmbarcacionesIdembarcacion().setDisponibilidad(false);
                            em.persist(t.getCargosIdcargo());
                            em.persist(t.getCargosIdcargo().getEmbarcacionesIdembarcacion());
                        }
                        else
                        {
                            if (pesoNuevo <= 5000) 
                            {
                                t.getCargosIdcargo().setPesoCarga(pesoActual + pesoCarga);                                
                                crearServicio(t, user,puertoLlegada,pesoCarga);
                                temp.setTrayecto(temp.getTrayecto() + ";" + puertoLlegada);
                                em.persist(t.getCargosIdcargo());
                                em.persist(temp);
                            }
                            else
                            {
                                //crear otra ruta transporte y servicio
                                nuevoServicio(tipo, p, user, puertoSalida, puertoLlegada, pesoCarga);
                            }
                        }
                        break;
                    }
                }
                else
                {//passengers
                    if(t.getPassengersIdpassengers().getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                    {
                       // Query query6 = em.createQuery("SELECT p.cantidadPasageros FROM Passenger p WHERE p.idpassengers= " + t.getPassengersIdpassengers());
                        int cantPasajeros=t.getPassengersIdpassengers().getCantidadPasageros();
                        
                        if(cantPasajeros==1)
                        {
                            t.getPassengersIdpassengers().getEmbarcacionesIdembarcacion().setDisponibilidad(false);
                            em.persist(t.getPassengersIdpassengers());
                            em.persist(t.getPassengersIdpassengers().getEmbarcacionesIdembarcacion());
                        }
                        else
                        {
                            if((cantPasajeros+1)<=1)
                            {
                                t.getPassengersIdpassengers().setCantidadPasageros(cantPasajeros+1);
                                crearServicio(t, user,puertoLlegada,pesoCarga);
                                temp.setTrayecto(temp.getTrayecto()+";"+puertoLlegada);
                                em.persist(temp);
                                em.persist(t.getPassengersIdpassengers());
                            }
                            else
                            {
                                //crear nueva ruta, transporte y servicio
                                nuevoServicio(tipo, p, user, puertoSalida, puertoLlegada, pesoCarga);
                            }
                        }                        
                        break;
                    }
                }                
            }
        }
        else
        {   
            nuevoServicio(tipo, p, user, puertoSalida, puertoLlegada, pesoCarga);
        }
    }    
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void nuevoServicio(int tipo,Puerto p,Usuario user,int puertoSalida,int puertoLlegada, int pesoCarga)
    {
        switch (tipo) 
            {           
                case 1:
                    
                    Query qcargos=em.createQuery("SELECT c FROM Cargo c");
                    List<Cargo> carguitos=qcargos.getResultList();
                    List<Cargo> necesito=new ArrayList<>();
                    
                    for (int i = 0; i < carguitos.size(); i++) 
                    {
                        Cargo c=(Cargo)carguitos.get(i);
                        if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud(),p.getUbicacionesIdubicacion().getLatitud())==true)
                        {
                            necesito.add(c);
                        }
                    }
                    //si la lista necesito esta vacia encontrar un fluvial del mismo tipo para enviarselo al usuario
                    //con carguitos
                    if(necesito.isEmpty())
                    {
                        for (int i = 0; i < carguitos.size(); i++) 
                        {
                            Cargo c=(Cargo)carguitos.get(i);
                            if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()+50,p.getUbicacionesIdubicacion().getLatitud()+50)==true 
                                    && c.getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                            {
                                Transporte tFicti=crearTransporte(null, null, c);
                                crearServicio(tFicti, user,puertoLlegada,pesoCarga);
                                Query consultaPuertoCercano=em.createQuery("SELECT p FROM Puerto p");
                                List<Puerto> puertos=consultaPuertoCercano.getResultList();
                                Puerto buscado=null;
                                for (Puerto puerto : puertos) {
                                    if(puerto.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()+50,p.getUbicacionesIdubicacion().getLatitud()+50))
                                    {
                                        buscado=puerto;
                                        break;
                                    }
                                }
                                //envio el Fluvial
                                crearRuta(buscado.getIdpuerto(), p.getIdpuerto(), tFicti, buscado);
                                crearRuta(p.getIdpuerto(), puertoLlegada, tFicti, p);
                                break;
                            }
                            else if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()-50,p.getUbicacionesIdubicacion().getLatitud()-50)==true 
                                    && c.getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                            {
                                Transporte tFicti=crearTransporte(null, null, c);
                                crearServicio(tFicti, user,puertoLlegada,pesoCarga);
                                Query consultaPuertoCercano=em.createQuery("SELECT p FROM Puerto p");
                                List<Puerto> puertos=consultaPuertoCercano.getResultList();
                                Puerto buscado=null;
                                for (Puerto puerto : puertos) {
                                    if(puerto.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()-50,p.getUbicacionesIdubicacion().getLatitud()-50))
                                    {
                                        buscado=puerto;
                                        break;
                                    }
                                }
                                //envio el Fluvial
                                crearRuta(buscado.getIdpuerto(), p.getIdpuerto(), tFicti, buscado);
                                crearRuta(p.getIdpuerto(), puertoLlegada, tFicti, p);
                                break;
                            }
                        }
                    }      
                    else
                    {
                        //sino recorrer
                        for (Cargo c : necesito) {
                            if (c.getPesoCarga() == 5000) {
                                c.getEmbarcacionesIdembarcacion().setDisponibilidad(false);
                                em.persist(c);
                                break;
                            }
                            if (c.getEmbarcacionesIdembarcacion().getDisponibilidad() == true) {
                                int pesoFinal = c.getPesoCarga() + pesoCarga;
                                if (pesoFinal <= 5000) {
                                    c.setPesoCarga(c.getPesoCarga() + pesoCarga);

                                    Transporte trans = crearTransporte(null, null, c);
                                    crearServicio(trans, user,puertoLlegada,pesoCarga);
                                    crearRuta(puertoSalida, puertoLlegada, trans, p);
                                    em.persist(c);
                                    if (c.getPesoCarga() == 5000) {
                                        c.getEmbarcacionesIdembarcacion().setDisponibilidad(false);
                                        em.persist(c);
                                    }
                                    break;
                                }
                            }
                        } 
                    }
                    break;
                case 2:
                    //para cab
                    Query qcabs=em.createQuery("SELECT c FROM Cab c");
                    List<Cab> cabsitos=qcabs.getResultList();
                    List<Cab> necesito1=new ArrayList<>();
                    
                    for (int i = 0; i < cabsitos.size(); i++) 
                    {
                        Cab c=(Cab)cabsitos.get(i);
                        if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud(),p.getUbicacionesIdubicacion().getLatitud())==true)
                        {
                            necesito1.add(c);
                        }
                    }
                    //si la lista esta vacia encontrar un fluvial del mismo tipo para enviarselo al usuario
                    if(necesito1.isEmpty())
                    {
                        for (int i = 0; i < cabsitos.size(); i++) 
                        {
                            Cab c=(Cab)cabsitos.get(i);
                            if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()+50,p.getUbicacionesIdubicacion().getLatitud()+50)==true 
                                    && c.getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                            {
                                Transporte tFicti=crearTransporte(c, null, null);
                                crearServicio(tFicti, user,puertoLlegada,pesoCarga);
                                Query consultaPuertoCercano=em.createQuery("SELECT p FROM Puerto p");
                                List<Puerto> puertos=consultaPuertoCercano.getResultList();
                                Puerto buscado=null;
                                for (Puerto puerto : puertos) {
                                    if(puerto.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()+50,p.getUbicacionesIdubicacion().getLatitud()+50))
                                    {
                                        buscado=puerto;
                                        break;
                                    }
                                }
                                //envio el Fluvial
                                crearRuta(buscado.getIdpuerto(), p.getIdpuerto(), tFicti, buscado);
                                crearRuta(p.getIdpuerto(), puertoLlegada, tFicti, p);
                                break;
                            }
                            else if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()-50,p.getUbicacionesIdubicacion().getLatitud()-50)==true 
                                    && c.getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                            {
                                Transporte tFicti=crearTransporte(c, null, null);
                                crearServicio(tFicti, user,puertoLlegada,pesoCarga);
                                Query consultaPuertoCercano=em.createQuery("SELECT p FROM Puerto p");
                                List<Puerto> puertos=consultaPuertoCercano.getResultList();
                                Puerto buscado=null;
                                for (Puerto puerto : puertos) {
                                    if(puerto.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()-50,p.getUbicacionesIdubicacion().getLatitud()-50))
                                    {
                                        buscado=puerto;
                                        break;
                                    }
                                }
                                //envio el Fluvial
                                crearRuta(buscado.getIdpuerto(), p.getIdpuerto(), tFicti, buscado);
                                crearRuta(p.getIdpuerto(), puertoLlegada, tFicti, p);
                                break;
                            }
                        }
                    }
                    else
                    {
                        //sino recorrer
                        for (Cab c : necesito1) {
                            if (c.getEmbarcacionesIdembarcacion().getDisponibilidad() == true) {
                                Transporte trans = crearTransporte(c, null, null);
                                crearServicio(trans, user,puertoLlegada,pesoCarga);
                                crearRuta(puertoSalida, puertoLlegada, trans, p);
                                c.getEmbarcacionesIdembarcacion().setDisponibilidad(false);
                                em.persist(c);
                                break;
                            }
                        }
                    }
                    break;
                case 3:
                    //para passengers
                   Query qpass=em.createQuery("SELECT c FROM Passenger c");
                    List<Passenger> passitos=qpass.getResultList();
                    List<Passenger> necesito2=new ArrayList<>();
                    
                    for (int i = 0; i < passitos.size(); i++) 
                    {
                        Passenger c=(Passenger)passitos.get(i);
                        if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud(),p.getUbicacionesIdubicacion().getLatitud())==true)
                        {
                            necesito2.add(c);
                        }
                    }
                    //si la lista esta vacia encontrar un fluvial del mismo tipo para enviarselo al usuario
                    if(necesito2.isEmpty())
                    {
                        for (int i = 0; i < passitos.size(); i++) 
                        {
                            Passenger c=(Passenger)passitos.get(i);
                            if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()+50,p.getUbicacionesIdubicacion().getLatitud()+50)==true 
                                    && c.getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                            {
                                Transporte tFicti=crearTransporte(null, c, null);
                                crearServicio(tFicti, user,puertoLlegada,pesoCarga);
                                Query consultaPuertoCercano=em.createQuery("SELECT p FROM Puerto p");
                                List<Puerto> puertos=consultaPuertoCercano.getResultList();
                                Puerto buscado=null;
                                for (Puerto puerto : puertos) {
                                    if(puerto.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()+50,p.getUbicacionesIdubicacion().getLatitud()+50))
                                    {
                                        buscado=puerto;
                                        break;
                                    }
                                }
                                //envio el Fluvial
                                crearRuta(buscado.getIdpuerto(), p.getIdpuerto(), tFicti, buscado);
                                crearRuta(p.getIdpuerto(), puertoLlegada, tFicti, p);
                                break;
                            }
                            else if(c.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()-50,p.getUbicacionesIdubicacion().getLatitud()-50)==true 
                                    && c.getEmbarcacionesIdembarcacion().getDisponibilidad()==true)
                            {
                                Transporte tFicti=crearTransporte(null, c, null);
                                crearServicio(tFicti, user,puertoLlegada,pesoCarga);
                                Query consultaPuertoCercano=em.createQuery("SELECT p FROM Puerto p");
                                List<Puerto> puertos=consultaPuertoCercano.getResultList();
                                Puerto buscado=null;
                                for (Puerto puerto : puertos) {
                                    if(puerto.estaEnPosicion(p.getUbicacionesIdubicacion().getLongitud()-50,p.getUbicacionesIdubicacion().getLatitud()-50))
                                    {
                                        buscado=puerto;
                                        break;
                                    }
                                }
                                //envio el Fluvial
                                crearRuta(buscado.getIdpuerto(), p.getIdpuerto(), tFicti, buscado);
                                crearRuta(p.getIdpuerto(), puertoLlegada, tFicti, p);
                                break;
                            }
                        }
                    }
                    else
                    {
                        //sino recorrer
                        for (Passenger pas : necesito2) {
                            //Query query6 = em.createQuery("SELECT p FROM Passenger p WHERE p.idpassengers= " + pas);
                            int cantPasajeros = /*(int) query6.getFirstResult();*/pas.getCantidadPasageros();

                            if (pas.getEmbarcacionesIdembarcacion().getDisponibilidad() == true) {
                                int nuevaCant = cantPasajeros + 1;
                                if (nuevaCant <= 1) {
                                    pas.setCantidadPasageros(nuevaCant);
                                    Transporte trans = crearTransporte(null, pas, null);
                                    crearServicio(trans, user,puertoLlegada,pesoCarga);
                                    crearRuta(puertoSalida, puertoLlegada, trans, p);
                                    if (nuevaCant == 1) {
                                        pas.getEmbarcacionesIdembarcacion().setDisponibilidad(false);
                                    }
                                    em.persist(pas);
                                    break;
                                }
                            }
                        } 
                    }
                    break;
                default:
                    break;
        }          
    }
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void crearServicio(Transporte t,Usuario u,int puertoLlegada,int pesoCarga)
    {
        //-----------------------------servicio es unico-------------------------------------------
        Query id = em.createQuery("SELECT COUNT(s) FROM Servicio s");
        long idServ = (long) id.getSingleResult();

        Servicio servicio = new Servicio((int) idServ + 1);
        servicio.setDescripcion("Servicio " + (idServ + 1));
        servicio.setPesocarga(pesoCarga);
        servicio.setPuertollegada(puertoLlegada);
        servicio.setUsuariosIdusuario(u);
        servicio.setTransportesIdtransporte(t);
        em.persist(servicio);
        //-----------------------------------------------------------------------------------------
    }
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Transporte crearTransporte(Cab cb, Passenger ps,Cargo cr)
    {
        Query idt = em.createQuery("SELECT COUNT(t) FROM Transporte t");
        long idtra = (long) idt.getSingleResult();
        Transporte transporte = null;
        if(cb!=null)
        {
            transporte = new Transporte((int) idtra + 1, "Cab");
            transporte.setCabsIdcab(cb);
        }
        else if(ps!=null)
        {
            transporte = new Transporte((int) idtra + 1, "Passenger");
            transporte.setPassengersIdpassengers(ps);
        }
        else
        {
            transporte = new Transporte((int) idtra + 1, "Cargo"); 
            transporte.setCargosIdcargo(cr);
        }
        
        transporte.setDescripcion("Transporte de carga " + (int) idtra + 1);
        em.persist(transporte);
        return transporte;
    }
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void crearRuta(int puertoSalida, int puertoLlegada,Transporte t,Puerto p)
    {
        Query id = em.createQuery("SELECT COUNT(r) FROM Ruta r");
        long idruta = (long) id.getSingleResult();       
        
        Hora nueva=crearHora();
        
        Ruta ruta = new Ruta((int)idruta+1,puertoSalida + ";" + puertoLlegada, "");
        ruta.setNombre("ruta " + (idruta+1));
        ruta.setTransportesIdtransporte(t);
        ruta.setPuertosIdpuerto(p);
        ruta.setHorasIdhora(nueva);
        em.persist(ruta);
    }
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Hora crearHora()
    {
        Query id2 = em.createQuery("SELECT COUNT(h) FROM Hora h");
        long idhora = (long) id2.getSingleResult();
        
        Hora nueva=new Hora((int)idhora+1);
        nueva.setHoraSalida(new Date());
        em.persist(nueva);
        
        return nueva;
    }
    
        public void actualizarUbicacion()
        {

            Puerto p = null;
            Query q2 = em.createQuery("select r from Ruta r");

            List<Ruta> rutas = q2.getResultList();
            List<Embarcacion> embarcaciones = new ArrayList<>();

            if (!rutas.isEmpty()) {

                for (int i = 0; i < rutas.size(); i++) {

                    Ruta r = (Ruta) rutas.get(i);

                    String[] t = r.getTrayecto().split(";");
                    int puertollegada = Integer.parseInt(t[t.length - 1]);

                    Query q = em.createQuery("select p from Puerto p where p.idpuerto =:pu").setParameter("pu", puertollegada);

                    p = (Puerto) q.getSingleResult();
                    int tipo = 0;

                    if (!r.estaDisponible()) {

                        embarcaciones.add(r.getTransportesIdtransporte().cualEs());

                    }
                }

                for (Embarcacion embarcacion : embarcaciones) {
                    
                    double elo=embarcacion.getUbicacionesIdubicacion().getLongitud();
                    double ela=embarcacion.getUbicacionesIdubicacion().getLatitud();
                   
                    if (elo != p.getUbicacionesIdubicacion().getLongitud()) {

                        Query q = em.createQuery("SELECT s FROM Sensor s");
                        List<Sensor> sensores = q.getResultList();
                        for (int i = 0; i < sensores.size(); i++) {
                            Sensor inicio = (Sensor) sensores.get(i);
                            if (i == sensores.size() - 1) {

                            } else {
                                Sensor siguiente = (Sensor) sensores.get(i +1);
                                double silo=siguiente.getUbicacionesIdubicacion().getLongitud();
                                double inlo=inicio.getUbicacionesIdubicacion().getLongitud();
                                double sila=siguiente.getUbicacionesIdubicacion().getLatitud();
                                
                                if (inicio.estaEnUbicacion(elo, ela)) {
                                    if (silo < inlo) {
                                        //reste
                                        if (elo != silo) {
                                            //el calado de la embarcacion + 30cm de mas
                                            int total = embarcacion.getCalado() + 30;
                                            if (inicio.getNivelAgua() < total || inicio.getNivelAgua() > 500) {
                                                //no se puede navegar
                                            } else {
                                                //cambiar latitud y longitud ahora
                                                inlo=restarHastaLlegar(inlo, silo);
                                                embarcacion.getUbicacionesIdubicacion().setLongitud(inlo);
                                                embarcacion.getUbicacionesIdubicacion().setLatitud(sila);
                                                em.persist(embarcacion);
                                            }
                                        }
                                        break;
                                    } else {
                                        //sume
                                        if (elo != silo) {
                                            //el calado de la embarcacion + 30cm de mas
                                            int total = embarcacion.getCalado() + 30;
                                            if (inicio.getNivelAgua() < total || inicio.getNivelAgua() > 500) {
                                                //no se puede navegar
                                            } else {
                                                //cambiar latitud y longitud ahora
                                                inlo=sumarHastaLlegar(inlo, silo);
                                                embarcacion.getUbicacionesIdubicacion().setLongitud(inlo);
                                                embarcacion.getUbicacionesIdubicacion().setLatitud(sila);
                                                em.persist(embarcacion);
                                            }
                                        }
                                        break;
                                    }                                    
                                }
                            }
                        }

                    } else {
                        actualizarCantidad();
                        for (int i = 0; i < rutas.size(); i++) {
                            Ruta r = (Ruta) rutas.get(i);
                            if (r.estaEnPuerto(p.getUbicacionesIdubicacion().getLongitud())) {
                                Date salida = r.getHorasIdhora().getHoraSalida();
                                Date fin = new Date();
                                r.getHorasIdhora().setHoraLlegada(fin);
                                r.setTiempoInvertido("" + (fin.getHours() - salida.getHours()) + ":" + (fin.getMinutes() - salida.getMinutes()) + ":" + (fin.getSeconds() - salida.getSeconds()));
                                embarcacion.setDisponibilidad(true);
                            }

                        }
                    }

                }
            }

    }
    public double  sumarHastaLlegar(double inicio , double fin)
    {
         System.out.println("el inicio fue"+inicio);
        while(inicio<fin)
        {
            inicio+=0.5;
            System.out.println(inicio);
        }
        if(inicio>fin)
        {
            inicio=fin;
        }
        System.out.println("el final fue"+inicio+"--"+fin);
        return inicio;
    }
    
    public double restarHastaLlegar(double inicio , double fin)
    {
        System.out.println("el inicio fue"+inicio);
        while(inicio>fin)
        {
            inicio-=0.5;
            System.out.println(inicio);
        }
        if(inicio<fin)
        {
            inicio=fin;
        }
        System.out.println("el final fue"+inicio+"--"+fin);
        return inicio;
    }
    
    public void actualizarCantidad(){
        
        Query m = em.createQuery("SELECT s from Servicio s");
        List<Servicio> servicios = m.getResultList();

        for (Servicio servicio : servicios) {
            Transporte transporte = servicio.getTransportesIdtransporte();
            Cargo carguito= transporte.esCargo();
            Passenger pass= transporte.esPassenger();
            
            if(pass != null){
                double longitudEmbarcacion = transporte.cualEs().getUbicacionesIdubicacion().getLongitud();

                Query p = em.createQuery("SELECT p from Puerto p ");
                List<Puerto> puertos = p.getResultList();
                Puerto buscado = null;
                for (Puerto puerto : puertos) {
                    if ((int)puerto.getIdpuerto() == servicio.getPuertollegada()) {
                        buscado = puerto;
                        break;
                    }
                }
                if (longitudEmbarcacion == buscado.getUbicacionesIdubicacion().getLongitud()) {
                    pass.setCantidadPasageros(pass.getCantidadPasageros()-1);
                    em.persist(pass);
                }
            }
            else if(carguito != null){
                double longitudEmbarcacion = transporte.cualEs().getUbicacionesIdubicacion().getLongitud();

                Query p = em.createQuery("SELECT p from Puerto p ");
                List<Puerto> puertos = p.getResultList();
                Puerto buscado = null;
                for (Puerto puerto : puertos) {
                    if (puerto.getIdpuerto() == servicio.getPuertollegada()) {
                        buscado = puerto;
                        break;
                    }
                }
                if (longitudEmbarcacion == buscado.getUbicacionesIdubicacion().getLongitud()) {
                    carguito.setPesoCarga(carguito.getPesoCarga()- servicio.getPesocarga());
                    em.persist(carguito);
                }
            }        
        }
        
    }
}
