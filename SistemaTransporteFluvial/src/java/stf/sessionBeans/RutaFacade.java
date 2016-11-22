/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import stf.entities.Cab;
import stf.entities.Cargo;
import stf.entities.Passenger;
import stf.entities.Puerto;
import stf.entities.Ruta;
import stf.entities.Transporte;

/**
 *
 * @author eliecer
 */
@Stateless
public class RutaFacade extends AbstractFacade<Ruta> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RutaFacade() {
        super(Ruta.class);
    }
    
    public List<String> obtenerUbicacionPuertoSalidaCab(List<Cab> cabs) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           List<Transporte> trans=new ArrayList();
           List<Transporte> transpor;
           List<Ruta> rutas = new ArrayList<>();
           List<String> trayecto = new ArrayList<>();
           List<String> ubicaPuertos = new ArrayList<>();
           List<Puerto> puertos = new ArrayList<>();
           for (int i = 0; i < cabs.size(); i++) {
            
                Query q = em.createQuery("SELECT t FROM Transporte t where t.cabsIdcab=:cabs").setParameter("cabs",cabs.get(i) );
                Transporte t = null;
                try
                {
                      t=(Transporte)q.getSingleResult();
                }catch(NoResultException n)
                {
                    
                }               
                if(t!=null)
                {
                trans.add(t);
                }
            }       
           for (int i = 0; i < trans.size(); i++) {
            Query q = em.createQuery("SELECT r FROM Ruta r where r.transportesIdtransporte=:cabs").setParameter("cabs",trans.get(i) );
            Ruta r=null;
            try
            {
                r=(Ruta)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(r!=null)
            {
            rutas.add(r);
            }
               
        }
           
           for (int i = 0; i < rutas.size(); i++) {
            String[] split = rutas.get(i).getTrayecto().split(";");
                   trayecto.add(split[0]);
        }
           
           for (int i = 0; i < trayecto.size(); i++) {
             Query q = em.createQuery("SELECT p FROM Puerto p where p.idpuerto=:puertos").setParameter("puertos",Integer.parseInt(trayecto.get(i)) );
            Puerto pu=null;
             try
            {
                pu=(Puerto)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(pu!=null)
            {
             puertos.add(pu);
            }
        }
           for (int i = 0; i < puertos.size(); i++) {
            ubicaPuertos.add(""+puertos.get(i).getUbicacionesIdubicacion().getLatitud()+","+
                                puertos.get(i).getUbicacionesIdubicacion().getLongitud());
        }
          
           for (int i = 0; i < ubicaPuertos.size(); i++) {
               System.out.println(ubicaPuertos.get(i));
        }
           
        return ubicaPuertos;
    }
    
    public List<String> obtenerUbicacionPuertoLlegadaCab(List<Cab> cabs) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           List<Transporte> trans=new ArrayList<Transporte>();
           List<Ruta> rutas = new ArrayList<>();
           List<String> trayecto = new ArrayList<>();
           List<String> ubicaPuertos = new ArrayList<>();
           List<Puerto> puertos = new ArrayList<>();
           for (int i = 0; i < cabs.size(); i++) {
            
                Query q = em.createQuery("SELECT t FROM Transporte t where t.cabsIdcab=:cabs").setParameter("cabs",cabs.get(i) );
             
                 Transporte t = null;
                try
                {
                      t=(Transporte)q.getSingleResult();
                }catch(NoResultException n)
                {
                    
                }               
                if(t!=null)
                {
                trans.add(t);
                }
                
            }       
           for (int i = 0; i < trans.size(); i++) {
            Query q = em.createQuery("SELECT r FROM Ruta r where r.transportesIdtransporte=:cabs").setParameter("cabs",trans.get(i) );
               Ruta r=null;
            try
            {
                r=(Ruta)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(r!=null)
            {
            rutas.add(r);
            }
        }
           
           for (int i = 0; i < rutas.size(); i++) {
            String[] split = rutas.get(i).getTrayecto().split(";");
                   trayecto.add(split[1]);
        }
           
           for (int i = 0; i < trayecto.size(); i++) {
             Query q = em.createQuery("SELECT p FROM Puerto p where p.idpuerto=:puertos").setParameter("puertos",Integer.parseInt(trayecto.get(i)) );
            Puerto pu=null;
             try
            {
                pu=(Puerto)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(pu!=null)
            {
             puertos.add(pu);
            }
        }
           for (int i = 0; i < puertos.size(); i++) {
            ubicaPuertos.add(""+puertos.get(i).getUbicacionesIdubicacion().getLatitud()+","+
                                puertos.get(i).getUbicacionesIdubicacion().getLongitud());
        }
          
           for (int i = 0; i < ubicaPuertos.size(); i++) {
               System.out.println(ubicaPuertos.get(i));
        }
           
        return ubicaPuertos;
    }
    
    
    public List<String> obtenerUbicacionPuertoSalidaPass(List<Passenger> passengers) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           List<Transporte> trans=new ArrayList();
           List<Transporte> transpor;
           List<Ruta> rutas = new ArrayList<>();
           List<String> trayecto = new ArrayList<>();
           List<String> ubicaPuertos = new ArrayList<>();
           List<Puerto> puertos = new ArrayList<>();
           for (int i = 0; i < passengers.size(); i++) {
            
                Query q = em.createQuery("SELECT t FROM Transporte t where t.cabsIdcab=:cabs").setParameter("cabs",passengers.get(i) );
                  Transporte t = null;
                try
                {
                      t=(Transporte)q.getSingleResult();
                }catch(NoResultException n)
                {
                    
                }               
                if(t!=null)
                {
                trans.add(t);
                }
            }       
           for (int i = 0; i < trans.size(); i++) {
            Query q = em.createQuery("SELECT r FROM Ruta r where r.transportesIdtransporte=:cabs").setParameter("cabs",trans.get(i) );
                 Ruta r=null;
            try
            {
                r=(Ruta)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(r!=null)
            {
            rutas.add(r);
            }
               
        }
           
           for (int i = 0; i < rutas.size(); i++) {
            String[] split = rutas.get(i).getTrayecto().split(";");
                   trayecto.add(split[0]);
        }
           
           for (int i = 0; i < trayecto.size(); i++) {
             Query q = em.createQuery("SELECT p FROM Puerto p where p.idpuerto=:puertos").setParameter("puertos",Integer.parseInt(trayecto.get(i)) );
             Puerto pu=null;
             try
            {
                pu=(Puerto)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(pu!=null)
            {
             puertos.add(pu);
            }
        }
           for (int i = 0; i < puertos.size(); i++) {
            ubicaPuertos.add(""+puertos.get(i).getUbicacionesIdubicacion().getLatitud()+","+
                                puertos.get(i).getUbicacionesIdubicacion().getLongitud());
        }
          
           for (int i = 0; i < ubicaPuertos.size(); i++) {
               System.out.println(ubicaPuertos.get(i));
        }
           
        return ubicaPuertos;
    }
    
    public List<String> obtenerUbicacionPuertoLlegadaPass(List<Passenger> passengers) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           List<Transporte> trans=new ArrayList<Transporte>();
           List<Ruta> rutas = new ArrayList<>();
           List<String> trayecto = new ArrayList<>();
           List<String> ubicaPuertos = new ArrayList<>();
           List<Puerto> puertos = new ArrayList<>();
           for (int i = 0; i < passengers.size(); i++) {
            
                Query q = em.createQuery("SELECT t FROM Transporte t where t.cabsIdcab=:cabs").setParameter("cabs",passengers.get(i) );
                 Transporte t = null;
                try
                {
                      t=(Transporte)q.getSingleResult();
                }catch(NoResultException n)
                {
                    
                }               
                if(t!=null)
                {
                trans.add(t);
                }
                
            }       
           for (int i = 0; i < trans.size(); i++) {
            Query q = em.createQuery("SELECT r FROM Ruta r where r.transportesIdtransporte=:cabs").setParameter("cabs",trans.get(i) );
   Ruta r=null;
            try
            {
                r=(Ruta)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(r!=null)
            {
            rutas.add(r);
            }             
        }
           
           for (int i = 0; i < rutas.size(); i++) {
            String[] split = rutas.get(i).getTrayecto().split(";");
                   trayecto.add(split[1]);
        }
           
           for (int i = 0; i < trayecto.size(); i++) {
             Query q = em.createQuery("SELECT p FROM Puerto p where p.idpuerto=:puertos").setParameter("puertos",Integer.parseInt(trayecto.get(i)) );
             Puerto pu=null;
             try
            {
                pu=(Puerto)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(pu!=null)
            {
             puertos.add(pu);
            }
        }
           for (int i = 0; i < puertos.size(); i++) {
            ubicaPuertos.add(""+puertos.get(i).getUbicacionesIdubicacion().getLatitud()+","+
                                puertos.get(i).getUbicacionesIdubicacion().getLongitud());
        }
          
           for (int i = 0; i < ubicaPuertos.size(); i++) {
               System.out.println(ubicaPuertos.get(i));
        }
           
        return ubicaPuertos;
    }
    
     public List<String> obtenerUbicacionPuertoSalidaCargo(List<Cargo> cargos) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           List<Transporte> trans=new ArrayList();
           List<Transporte> transpor;
           List<Ruta> rutas = new ArrayList<>();
           List<String> trayecto = new ArrayList<>();
           List<String> ubicaPuertos = new ArrayList<>();
           List<Puerto> puertos = new ArrayList<>();
           for (int i = 0; i < cargos.size(); i++) {
            
                Query q = em.createQuery("SELECT t FROM Transporte t where t.cabsIdcab=:cabs").setParameter("cabs",cargos.get(i) );
                  Transporte t = null;
                try
                {
                      t=(Transporte)q.getSingleResult();
                }catch(NoResultException n)
                {
                    
                }               
                if(t!=null)
                {
                trans.add(t);
                }
            }       
           for (int i = 0; i < trans.size(); i++) {
            Query q = em.createQuery("SELECT r FROM Ruta r where r.transportesIdtransporte=:cabs").setParameter("cabs",trans.get(i) );
   Ruta r=null;
            try
            {
                r=(Ruta)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(r!=null)
            {
            rutas.add(r);
            }             
        }
           
           for (int i = 0; i < rutas.size(); i++) {
            String[] split = rutas.get(i).getTrayecto().split(";");
                   trayecto.add(split[0]);
        }
           
           for (int i = 0; i < trayecto.size(); i++) {
             Query q = em.createQuery("SELECT p FROM Puerto p where p.idpuerto=:puertos").setParameter("puertos",Integer.parseInt(trayecto.get(i)) );
Puerto pu=null;
             try
            {
                pu=(Puerto)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(pu!=null)
            {
             puertos.add(pu);
            }  }
           for (int i = 0; i < puertos.size(); i++) {
            ubicaPuertos.add(""+puertos.get(i).getUbicacionesIdubicacion().getLatitud()+","+
                                puertos.get(i).getUbicacionesIdubicacion().getLongitud());
        }
          
           for (int i = 0; i < ubicaPuertos.size(); i++) {
               System.out.println(ubicaPuertos.get(i));
        }
           
        return ubicaPuertos;
    }
    
    public List<String> obtenerUbicacionPuertoLlegadaCargos(List<Cargo> cargos) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           List<Transporte> trans=new ArrayList<Transporte>();
           List<Ruta> rutas = new ArrayList<>();
           List<String> trayecto = new ArrayList<>();
           List<String> ubicaPuertos = new ArrayList<>();
           List<Puerto> puertos = new ArrayList<>();
           for (int i = 0; i < cargos.size(); i++) {
            
                Query q = em.createQuery("SELECT t FROM Transporte t where t.cabsIdcab=:cabs").setParameter("cabs",cargos.get(i) );
                 Transporte t=(Transporte)q.getSingleResult();
                if(t!=null)
                {
                trans.add(t);
                }
                
            }       
           for (int i = 0; i < trans.size(); i++) {
            Query q = em.createQuery("SELECT r FROM Ruta r where r.transportesIdtransporte=:cabs").setParameter("cabs",trans.get(i) );
   Ruta r=null;
            try
            {
                r=(Ruta)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(r!=null)
            {
            rutas.add(r);
            }               
        }
           
           for (int i = 0; i < rutas.size(); i++) {
            String[] split = rutas.get(i).getTrayecto().split(";");
                   trayecto.add(split[1]);
        }
           
           for (int i = 0; i < trayecto.size(); i++) {
             Query q = em.createQuery("SELECT p FROM Puerto p where p.idpuerto=:puertos").setParameter("puertos",Integer.parseInt(trayecto.get(i)) );
Puerto pu=null;
             try
            {
                pu=(Puerto)q.getSingleResult();
            }catch(NoResultException n)
                {
                    
                } 
            if(pu!=null)
            {
             puertos.add(pu);
            }        }
           for (int i = 0; i < puertos.size(); i++) {
            ubicaPuertos.add(""+puertos.get(i).getUbicacionesIdubicacion().getLatitud()+","+
                                puertos.get(i).getUbicacionesIdubicacion().getLongitud());
        }
          
           for (int i = 0; i < ubicaPuertos.size(); i++) {
               System.out.println(ubicaPuertos.get(i));
        }
           
        return ubicaPuertos;
    }
    
    
  
    public List<Ruta> consultarRutas(){
        
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
        em=emf.createEntityManager();
         
        
        Query rutas=em.createQuery("Select r From Ruta r");
        List<Ruta> rut=rutas.getResultList();
        
        rutas.getResultList().size();
        
        for (int i = 0; i < rut.size(); i++) {
            
            System.out.println(rut.get(i));
        }
        
        return rut;
    }
    
    
    
}
