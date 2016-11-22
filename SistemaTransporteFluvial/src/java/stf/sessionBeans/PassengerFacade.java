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
import stf.entities.Embarcacion;
import stf.entities.Passenger;

/**
 *
 * @author eliecer
 */
@Stateless
public class PassengerFacade extends AbstractFacade<Passenger> {

    private List<Passenger> prueba;
    
    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PassengerFacade() {
        super(Passenger.class);
        prueba = new ArrayList();
    }
    
    public List<Passenger> consultarPassenger(){
    
        
           EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
           
        
        Query q=em.createQuery("select e from Embarcacion e where e.disponibilidad="+false);
        
        if (q ==  null) {
            return null;
        }
        List<Embarcacion> embarcacion = q.getResultList();
        List<Passenger> prueba = new ArrayList<>();
        for (int i = 0; i < embarcacion.size(); i++) {
            
            
            Query q2=em.createQuery("select p from Passenger p where p.embarcacionesIdembarcacion=:emb").setParameter("emb",  embarcacion.get(i));
            List<Passenger> cab=q2.getResultList();
            
            if (cab.size()>0) {
                
                prueba.add(cab.get(0));
                
            } 
        }
        
        for (int i = 0; i < prueba.size(); i++) {
            
            System.out.println(prueba.get(i));
            
        }
        
       return prueba;
           
    }
    
    
    public List<Passenger> consultarPassengerDisponibles(boolean disponibilidad){
    
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
           
           em = emf.createEntityManager();
        
        Query q=em.createQuery("select e from Embarcacion e where e.disponibilidad="+disponibilidad);
        List<Embarcacion> embarcacion = q.getResultList();
        List<Passenger> passengers;
        List<Passenger> prueba = new ArrayList();
        for (int i = 0; i < embarcacion.size(); i++) {
            
            
            Query q2=em.createQuery("select p from Passenger p where p.embarcacionesIdembarcacion=:emb").setParameter("emb",  embarcacion.get(i));
           passengers=q2.getResultList();
            
            if (passengers.size()>0) {
                
                prueba.add(passengers.get(0));
                
            } 
        }

        
        return prueba;

    }
    
    public void setPrueba(List<Passenger> prueba){
        this.prueba = prueba;
    }
    
    public List<Passenger> getPrueba() {
        return this.prueba;
    }
}
