/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import stf.entities.Sensor;

/**
 *
 * @author eliecer
 */
@Stateless
public class SensorFacade extends AbstractFacade<Sensor> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;
    private int Id;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SensorFacade() {
        super(Sensor.class);
    }
    
    public void ActualizarSensor() 
    {
        Query q = em.createQuery("select count(s) from Sensor s");
        long id = (long) q.getSingleResult();
        Id = (int) id;

        for (int i = 1; i <= Id; i++) 
        {
            Sensor s = em.find(Sensor.class, i);
            if (s.getNivelAgua() >= 20 && s.getNivelAgua() < 500) 
            {                
                s.setNivelAgua(s.getNivelAgua()+10);
            }

            if (s.getNivelAgua() >= 500) 
            {
                while (s.getNivelAgua() > 30) 
                {
                    s.setNivelAgua(s.getNivelAgua() - 20);
                }
            }
            s.setFecha(new Date());
        }
    }       
    
    public List<Sensor> consultarMediaSensor(){
    
    
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");
    em=emf.createEntityManager();
         
    
    Query nivel = em.createQuery("select s from Sensor s");
    List<Sensor> sensor=nivel.getResultList();
    
    return sensor;
    
    }
}
