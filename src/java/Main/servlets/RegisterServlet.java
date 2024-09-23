/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main.servlets;

import Page.error_report.RegisterError;
import Page.registration.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class RegisterServlet extends HttpServlet {

    private final String LOGIN_PAGE = "Login.jsp";
    private final String REGISTER_PAGE = "signup.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = LOGIN_PAGE;
        try  {
            /* TODO output your page here. You may use following sample code. */
            String userName = request.getParameter("txtUserName");
            String fullName = request.getParameter("txtFullName");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("txtConfirm");
            String address = request.getParameter("txtAddress");
            String sex = request.getParameter("txtSex");
            String phoneNumber = request.getParameter("txtPhoneNumber");
            String email = request.getParameter("txtEmail");
            RegisterError error = new RegisterError();
            boolean isValid = error.checkConfirmMatch(password, confirm);
            if(isValid){
                RegistrationDAO dao = new RegistrationDAO();
                boolean isExist = dao.checkAccountExist(userName);
                if(!isExist){
                    boolean isSuccess = dao.createNewAccount(userName, fullName, password, address, sex, phoneNumber, email);
                }else{
                    isValid = false;
                    error.setAccountExist("Account existed");
                }
                if(!isValid){
                    request.setAttribute("ERRORS", error);
                    url = REGISTER_PAGE;
                }
            }
        }catch(SQLException|ClassNotFoundException e){
            e.printStackTrace();
        }
        finally{
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
