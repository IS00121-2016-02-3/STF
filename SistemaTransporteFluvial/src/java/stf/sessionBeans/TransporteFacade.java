/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import stf.entities.Transporte;

/**
 *
 * @author eliecer
 */
@Stateless
public class TransporteFacade extends AbstractFacade<Transporte> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TransporteFacade() {
        super(Transporte.class);
    }
    
}
