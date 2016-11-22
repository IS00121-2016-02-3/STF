/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import stf.entities.Persona;

/**
 *
 * @author eliecer
 */
@Stateless
public class PersonaFacade extends AbstractFacade<Persona> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PersonaFacade() {
        super(Persona.class);
    }
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void guardar(Persona per) {
       
         
        Query q=em.createQuery("select count(u) from Usuario u");
        long id=(long)q.getSingleResult();
        
        int Id=(int) id;
        
        per.setIdpersona(Id+1);
        
        em.persist(per);     
    }
    
}
