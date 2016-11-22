/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.servlets;


import java.io.IOException;
import java.io.PrintWriter;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import stf.entities.Persona;
import stf.entities.Usuario;
import stf.sessionBeans.PersonaFacade;
import stf.sessionBeans.UsuarioFacade;


/**
 *
 * @author kevin
 */
@WebServlet(name = "RegistrarServlet", urlPatterns = {"/RegistrarServlet"})
public class RegistrarServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Inject
    private UsuarioFacade usuariofacade;
    
    @Inject
    private PersonaFacade personafacade;
    
    private Persona persona;
    
    private Usuario usuario;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegistrarServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" + response.getContentType() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
      
        
        String nombre=request.getParameter("nombre");
        String apellido=request.getParameter("apellido");
        String telefono=request.getParameter("telefono");
        String identificacion=request.getParameter("identificacion");
        
        persona= new Persona();
        persona.setNombres(nombre);
        persona.setApellidos(apellido);
        persona.setIdentificacion(identificacion);
        persona.setTelefono(telefono);
        
       personafacade.guardar(persona);
        
        String usua=request.getParameter("usuario");
        String contraseña="bogota";        
        String email=request.getParameter("email");
        int tipo=Integer.parseInt(request.getParameter("tipo"));        
      
        usuario = new Usuario();
        
        usuario.setUsuario(usua);
        usuario.setPassword(contraseña);
        usuario.setEmail(email);
        usuario.setTipoU(tipo);
        usuario.setPersonasIdpersona(persona);
        
       usuariofacade.guardarusuario(usuario);
        request.getRequestDispatcher("redireccionarRegistro.jsp").forward(request, response);
        
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
