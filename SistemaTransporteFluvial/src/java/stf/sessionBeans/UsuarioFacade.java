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
import stf.entities.Usuario;

/**
 *
 * @author eliecer
 */
@Stateless
public class UsuarioFacade extends AbstractFacade<Usuario> {

    @PersistenceContext(unitName = "stfPU")
    private EntityManager em;
    private String usua;
    private String pass;  

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }
    public Boolean loguearUsuario(String usuario, String contraseña){
                
        Query u = em.createQuery("select u.usuario from Usuario u where u.usuario='"+usuario+"'");
        Query p =em.createQuery("select u.password from Usuario u where u.password='"+contraseña+"' and u.usuario='"+usuario+"'");
       
        try {
            usua = (String)u.getSingleResult();
            pass = (String)p.getSingleResult();
         
            
        } catch (Exception e) {
            System.out.println(""+e.getLocalizedMessage());
            
        }
       
        if (usuario.equals(usua) && contraseña.equals(pass)) {
            
            buscarTipoUsuario();
            return true;
        }else{
        
        return false;    
        
        
        }}
       
        
    public String buscarTipoUsuario(){
    
         Query u = em.createQuery("select u.tipoU from Usuario u where u.usuario='"+usua+"' and u.password='"+pass+"'");
         int estado=(int)u.getSingleResult();
         
         if (estado==1) {
            
             return "administrador";
        }else{
         
             return "cliente";
             
         }
        
    
    }
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void guardarusuario(Usuario usua) {
            
        
        Query q=em.createQuery("select count(u) from Usuario u");
        long id=(long)q.getSingleResult();
        
        int Id=(int) id;
        
        usua.setIdusuario(Id);
        
        em.persist(usua);
        
    }
}
