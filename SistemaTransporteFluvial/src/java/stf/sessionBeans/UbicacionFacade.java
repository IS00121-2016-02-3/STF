/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.sessionBeans;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import stf.entities.Ubicacion;

/**
 *
 * @author eliecer
 */
@Stateless
public class UbicacionFacade extends AbstractFacade<Ubicacion> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UbicacionFacade() {
        super(Ubicacion.class);
    }
    
}
