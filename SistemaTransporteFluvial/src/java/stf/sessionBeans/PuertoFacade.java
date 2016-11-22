/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import stf.entities.Puerto;

/**
 *
 * @author eliecer
 */
@Stateless
public class PuertoFacade extends AbstractFacade<Puerto> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PuertoFacade() {
        super(Puerto.class);
    }
    public List<Puerto> getPuertos() {
        
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("stfPU");

        em = emf.createEntityManager();

        Query q = em.createQuery("SELECT p FROM Puerto p");
        List<Puerto> resultado = q.getResultList();

        return resultado;
    }
    
}
