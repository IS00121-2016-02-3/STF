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
import stf.entities.Cargo;
import stf.entities.Embarcacion;

/**
 *
 * @author eliecer
 */
@Stateless
public class CargoFacade extends AbstractFacade<Cargo> {

    private List<Cargo> prueba;
    
    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CargoFacade() {
        super(Cargo.class);
        prueba = new ArrayList();
    }
    
   public List<Cargo> consultarCargo(){
    
       
           EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           
        Query q=em.createQuery("select e from Embarcacion e where e.disponibilidad="+false);
        
        if (q == null) {
           return null;
       }
        List<Embarcacion> embarcacion = q.getResultList();
        List<Cargo> prueba = new ArrayList<>();
        for (int i = 0; i < embarcacion.size(); i++) {
            
            
            Query q2=em.createQuery("select c from Cargo c where c.embarcacionesIdembarcacion=:emb").setParameter("emb",  embarcacion.get(i));
            List<Cargo> cab=q2.getResultList();
            
            if (cab.size()>0) {
                
                prueba.add(cab.get(0));
                
            } 
        }
        
        for (int i = 0; i < prueba.size(); i++) {
            
            System.out.println(prueba.get(i));
            
        }
        
       return prueba;
           
    }
   
   public List<Cargo> consultarCargosDisponibles(boolean disponibilidad){
    
       EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
       
        Query q=em.createQuery("select e from Embarcacion e where e.disponibilidad="+disponibilidad);
        List<Embarcacion> embarcacion=q.getResultList();
        List<Cargo> carg;
        for (int i = 0; i < embarcacion.size(); i++) {
            
            
            Query q2=em.createQuery("select c from Cargo c where c.embarcacionesIdembarcacion=:emb").setParameter("emb",  embarcacion.get(i));
           carg=q2.getResultList();
            
            if (carg.size()>0) {
                
                prueba.add(carg.get(0));
                
            } 
        }
        
        for (int i = 0; i < getPrueba().size(); i++) {
            
            System.out.println(getPrueba().get(i));
            
        }
        
       return prueba;
           
    }
   
    
   public void setPrueba( List<Cargo> prueba) {
       this.prueba = prueba;
   }
   
   public List<Cargo> getPrueba() {
       return this.prueba;
   }
    
}
