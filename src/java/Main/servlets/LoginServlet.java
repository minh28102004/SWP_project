/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main.servlets;

import Page.Services.ProductService;
import Page.Product.ProductDTO;
import Page.registration.RegistrationDAO;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
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
public class LoginServlet extends HttpServlet {

    private final String MENU_PAGE = "Menu.jsp";
    private final String INVALID_PAGE = "Invalid.html";
    private final String US = "US";
    private final String AD = "AD";
    
    private final ProductService productService = new ProductService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = MENU_PAGE;
        try {
            String userName = request.getParameter("txtUserName");
            String password = request.getParameter("txtPassword");
            
            RegistrationDAO dao = new RegistrationDAO();
            RegistrationDTO isValid = dao.authenticate(userName, password);
            
            if (isValid != null) {
                String roleId = isValid.getRoleID();
                
                if (AD.equals(roleId) || US.equals(roleId)) {
                    url = MENU_PAGE;
                }
                
                HttpSession session = request.getSession(true);
                productService.paginateProducts(request, 1);

                Cookie cUserName = new Cookie("USERNAME", userName);
                Cookie cPassword = new Cookie("PASSWORD", password);
                cUserName.setHttpOnly(true);
                cPassword.setHttpOnly(true);
                cUserName.setSecure(true);
                cPassword.setSecure(true);

                response.addCookie(cUserName);
                response.addCookie(cPassword);

                RegistrationDTO user = dao.getUser(userName);
                session.setAttribute("USER", user);
                session.setAttribute("userID", user.getUserID());
            } else {
                url = INVALID_PAGE;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
