/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main.servlets;

import Page.registration.RegistrationDAO;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class UpdateServlet extends HttpServlet {

    private final String LOGIN_PAGE = "Login.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = LOGIN_PAGE;
        try {
            /* TODO output your page here. You may use following sample code. */
            String fullName = request.getParameter("txtFullName");
            String password = request.getParameter("txtPassword");
            String address = request.getParameter("txtAddress");
            String sex = request.getParameter("txtSex");
            String phoneNumber = request.getParameter("txtPhoneNumber");
            String email = request.getParameter("txtEmail");

            Cookie[] cookies = request.getCookies();
            String userName = "";

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    String key = cookie.getName();
                    String val = cookie.getValue();
                    if (key.equals("USERNAME")) {
                        userName = val;
                    }

                }
                //
                RegistrationDAO dao = new RegistrationDAO();
                dao.update(fullName, password, address, sex, phoneNumber, email, userName);
                HttpSession session = request.getSession(true);
                // Retrieve user object from session
                RegistrationDTO user = (RegistrationDTO) session.getAttribute("USER");
                // Update user information from request parameters

                // Handle password update separately (if provided)
                // Update user object in session
                session.setAttribute("USER", user);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect(url);
            out.close();
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
