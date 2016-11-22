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
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import stf.entities.Cab;
import stf.entities.Embarcacion;

/**
 *
 * @author eliecer
 */
@Stateless
public class CabFacade extends AbstractFacade<Cab> {

  private List<Cab> prueba;
    
    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CabFacade() {
        super(Cab.class);
        prueba = new ArrayList();
    }
 
    public List<Cab> consultarCab(){
    
        
           EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           
        
        Query q=em.createQuery("select e from Embarcacion e where e.disponibilidad="+false);
        if (q == null) {
            return null;
        }
        List<Embarcacion> embarcacion = q.getResultList();
        List<Cab> prueba = new ArrayList<>();
        for (int i = 0; i < embarcacion.size(); i++) {
            
            
            Query q2=em.createQuery("select c from Cab c where c.embarcacionesIdembarcacion=:emb").setParameter("emb",  embarcacion.get(i));
            List<Cab> cab=q2.getResultList();
            
            if (cab.size()>0) {
                
                prueba.add(cab.get(0));
                
                System.out.println("entre)");
            } 
        }
        
       
        
       return prueba;
           
    }
    
    public List<Cab> consultarCabDisponible(boolean disponibilidad){
    
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
        
        Query q=em.createQuery("select e from Embarcacion e where e.disponibilidad="+disponibilidad);
        List<Embarcacion> embarcacion = q.getResultList();
        List<Cab> cab;
        for (int i = 0; i < embarcacion.size(); i++) {
            
            
            Query q2=em.createQuery("select c from Cab c where c.embarcacionesIdembarcacion=:emb").setParameter("emb",  embarcacion.get(i));
            cab=q2.getResultList();
            
            if (cab.size()>0) {
                
                prueba.add(cab.get(0));
                
            } 
        }
        
   
        
       return prueba;
           
    }
    
    
    public void setPrueba( List<Cab> prueba ) {
        this.prueba = prueba;
    }
    
    public List<Cab> getPrueba() {
        return this.prueba;
    }
    
    
}
