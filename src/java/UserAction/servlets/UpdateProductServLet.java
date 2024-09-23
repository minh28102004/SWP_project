/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UserAction.servlets;

import Page.Product.ProductDTO;
import Page.registration.RegistrationDAO;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class UpdateProductServLet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "";
        try {
            int productId = Integer.parseInt(request.getParameter("txtProductId"));
            String productName = request.getParameter("txtProductName");
            String company = request.getParameter("txtCompany");
            int price = Integer.parseInt(request.getParameter("txtPrice"));
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
            String lastSearchValue = request.getParameter("txtLastSearchValue");
            RegistrationDAO dao = new RegistrationDAO();
            dao.updateProduct(productId, productName, company, price, quantity);
            url = "MainController?btAction=Search Product&txtSearchValue=" + lastSearchValue;
            // Cập nhật lại cả sessionScope.PRODUCTS và sessionScope.SEARCHED_PRODUCTS
            List<ProductDTO> allProducts = dao.getAllProduct();
            request.getSession().setAttribute("PRODUCTS1", allProducts);
            // Nếu có lastSearchValue, cập nhật sessionScope.SEARCHED_PRODUCTS
            if (lastSearchValue != null && !lastSearchValue.trim().isEmpty()) { // Trim để loại bỏ khoảng trắng
                List<ProductDTO> searchedProducts = dao.search(lastSearchValue);
                request.getSession().setAttribute("SEARCHED_PRODUCTS", searchedProducts);
                url = "MainController?btAction=Search Product&txtSearchValue=" + lastSearchValue;
            } else {
                // Cập nhật lại sessionScope.PRODUCTS khi không có tìm kiếm hoặc tìm kiếm rỗng
                request.getSession().setAttribute("PRODUCTS1", dao.getAllProduct());
                url = "UpdateProduct.jsp";
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
