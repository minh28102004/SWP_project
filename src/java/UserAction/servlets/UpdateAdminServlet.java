/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UserAction.servlets;

import Page.registration.RegistrationDAO;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class UpdateAdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "";
        try {
            /* TODO output your page here. You may use following sample code. */
            String userName = request.getParameter("txtUserName");
            String roleId = request.getParameter("txtRoleId");
            String lastSearchValue = request.getParameter("txtLastSearchValue");
            RegistrationDAO dao = new RegistrationDAO();
            dao.updateUser(userName, roleId);

            List<RegistrationDTO> allUsers = dao.getAllUser();
            request.getSession().setAttribute("USER_LIST", allUsers);

            // Nếu trước đó có tìm kiếm thì cập nhật lại SEARCHED_USER_LIST
            if (lastSearchValue != null && !lastSearchValue.trim().isEmpty()) {
                List<RegistrationDTO> searchedUsers = dao.searchUser(lastSearchValue);
                request.getSession().setAttribute("SEARCHED_USER_LIST", searchedUsers);
                url = "MainController?btAction=Search Name&txtSearchValue=" + lastSearchValue;
            } else {
                request.getSession().setAttribute("USER_LIST", dao.getAllUser());
                url = "UpdateUser.jsp";
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
