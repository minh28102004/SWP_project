/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main.servlets;

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
public class MainController extends HttpServlet {

    private static final String ACTION_LOGIN = "Login";
    private static final String LOGIN_SERVLET = "LoginServlet";
    private static final String ACTION_REGISTER = "Register";
    private static final String REGISTER_SERVLET = "RegisterServlet";
    private static final String COOKIE_SERVLET = "CookieServlet";
    private static final String ACTION_SEARCH = "Search";
    private static final String SEARCH_SERVLET = "SearchServlet";
    private static final String ACTION_UPDATE = "Update";
    private static final String UPDATE_SERVLET = "UpdateServlet";
    private static final String ACTION_ADD_TO_CART = "Add To Cart";
    private static final String ADD_TO_CART_SERVLET = "AddToCartServlet";
    private static final String MENU_PAGE = "Menu.jsp";
    private static final String ACTION_REMOVE_FROM_CART = "Remove_From_Cart";
    private static final String REMOVE_CART_SERVLET = "RemoveCartItemServlet";
    private static final String ACTION_UPDATE_CART = "Update_Cart";
    private static final String UPDATE_CART_SERVLET = "UpdateCartServlet";
    private static final String ACTION_SEARCH_PRODUCT = "Search Product";
    private static final String SEARCH_PRODUCT_SERVLET = "SearchProductServlet";
    private static final String ACTION_DELETE = "Delete";
    private static final String DELETE_SERVLET = "DeleteServlet";
    private static final String ACTION_UPDATE_PRODUCT = "Update Product";
    private static final String UPDATE_PRODUCT_SERVLET = "UpdateProductServlet";
    private static final String ACTION_SEARCH_USER = "Search Name";
    private static final String SEARCH_USER_SERVLET = "SearchUserServlet";
    private static final String ACTION_DELETE_USER = "Delete User";
    private static final String DELETE_USER_SERVLET = "DeleteUserServlet";
    private static final String ACTION_UPDATE_USER = "Update User";
    private static final String UPDATE_USER_SERVLET = "UpdateAdminServlet";
    private static final String ACTION_ADD_TO_CART_LOGIN = "ADD TO CART";
    private static final String ACTION_LOGOUT = "Log Out";
    private static final String LOG_OUT_SERVLET = "LogoutServlet";
    private static final String LOGIN_PAGE = "Login.jsp";
    private static final String ACTION_ADD_PRODUCT = "Add Product";
    private static final String ADD_NEW_PRODUCT_SERVLET = "AddProductServlet";
    private static final String ACTION_BUY = "BUY";
    private static final String BUY_CART_SERVLET = "BuyCartServlet";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = MENU_PAGE;
        try  {
            String action  = request.getParameter("btAction");
            if (action == null) {
                url = COOKIE_SERVLET;
            } else if (ACTION_LOGIN.equals(action)) {
                url = LOGIN_SERVLET;
            } else if (ACTION_REGISTER.equals(action)) {
                url = REGISTER_SERVLET;
            } else if (ACTION_SEARCH.equals(action)) {
                url = SEARCH_SERVLET;
            } else if (ACTION_UPDATE.equals(action)) {
                url = UPDATE_SERVLET;
            } else if (ACTION_ADD_TO_CART.equals(action)) {
                url = ADD_TO_CART_SERVLET;
            } else if (ACTION_UPDATE_CART.equals(action)) {
                url = UPDATE_CART_SERVLET;
            } else if (ACTION_REMOVE_FROM_CART.equals(action)) {
                url = REMOVE_CART_SERVLET;
            } else if (ACTION_SEARCH_PRODUCT.equals(action)) {
                url = SEARCH_PRODUCT_SERVLET;
            } else if (ACTION_DELETE.equals(action)) {
                url = DELETE_SERVLET;
            } else if (ACTION_UPDATE_PRODUCT.equals(action)) {
                url = UPDATE_PRODUCT_SERVLET;
            } else if (ACTION_SEARCH_USER.equals(action)) {
                url = SEARCH_USER_SERVLET;
            } else if (ACTION_DELETE_USER.equals(action)) {
                url = DELETE_USER_SERVLET;
            } else if (ACTION_UPDATE_USER.equals(action)) {
                url = UPDATE_USER_SERVLET;
            } else if (ACTION_ADD_TO_CART_LOGIN.equals(action)) {
                url = LOGIN_PAGE;
            } else if (ACTION_LOGOUT.equals(action)) {
                url = LOG_OUT_SERVLET;
            } else if (ACTION_ADD_PRODUCT.equals(action)) {
                url = ADD_NEW_PRODUCT_SERVLET;
            } else if (ACTION_BUY.equals(action)) {
                url = BUY_CART_SERVLET;
            }
        }catch (Exception e) {
            log("Error at MainController: " + e.toString());
        }finally{
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
