/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stf.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import stf.sessionBeans.EmbarcacionFacade;
import stf.sessionBeans.SensorFacade;

/**
 *
 * @author kevin
 */
@WebServlet(name = "RequestServlet", urlPatterns = {"/RequestServlet"})
public class RequestServlet extends HttpServlet {

    @Inject
    private EmbarcacionFacade usuario;
    @Inject
    private SensorFacade sensor;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RequestServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
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
        
        String contraseña = request.getParameter("passService");
        String usua = request.getParameter("userService");
        int puertoSalida = Integer.parseInt(request.getParameter("puertosSalida"));
        int puertoLlegada = Integer.parseInt(request.getParameter("puertosLlegada"));
        int tipo = Integer.parseInt(request.getParameter("idFluvial"));
        int pesoCarga = 0;
        if(request.getParameter("peso")!=null)
        {
            pesoCarga=Integer.parseInt(request.getParameter("peso"));
        }

        usuario.solicitarEmbarcacion(tipo,puertoSalida,puertoLlegada,usua,contraseña,pesoCarga);
      
       Thread hilo = new Thread(new Runnable() 
       {
            @Override
            public void run() 
            {
                while (true) 
                {
                    try 
                    {
                        sensor.ActualizarSensor();
                        usuario.actualizarUbicacion();                    
                        Thread.sleep(30);
                    } 
                    catch (InterruptedException ex) 
                    {
                        Logger.getLogger(Loginservler.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        });
        hilo.start();  
        request.getRequestDispatcher("home.jsp").forward(request, response);
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
