/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main.servlets;

import Page.Product.ProductDAO;
import Page.Product.ProductDTO;
import Page.Services.ProductService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nhat Hung
 */
public class ListBrandProduct extends HttpServlet {

    private final String MENU = "displayProduct.jsp";
    
    private final ProductService productService = new ProductService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = MENU;
        try {
            String brandAction = request.getParameter("brandAction");
            String productLineAction = request.getParameter("productLineAction");

            HttpSession session = request.getSession(true);
            ProductDAO dao = new ProductDAO();

            List<String> brandKeys = Arrays.asList("Onitsuka", "Nike", "Adidas", "Vans", "New Balance", "MLB", "Converse");
            List<String> NikeproductLineKeys = Arrays.asList("Zoom", "Air Force 1", "Air Max", "Jordan", "Running", "Cortez", "Flyknit");

            int index = 1;
            String pageIndex = request.getParameter("index");      
            int currentPage = (pageIndex != null) ? Integer.parseInt(pageIndex) : 1;
            productService.paginateProducts(request, currentPage);
            request.setAttribute("currentPage", currentPage); 

            List<ProductDTO> productList = new ArrayList<>();
            int count = 0;

            if (brandKeys.contains(brandAction)) {
                if (brandAction.equals("Nike") && NikeproductLineKeys.contains(productLineAction)) {
                    count = dao.getTotalProductsWith2Keywords(brandAction, productLineAction);
                    productList = dao.getProductWith2KeyWordPagination(brandAction, productLineAction, index);
                } else {
                    count = dao.getTotalProductsWith2Keywords(brandAction, "");
                    productList = dao.getProductWith2KeyWordPagination(brandAction, "", index);
                }
            }

            int endPage = (int) Math.ceil(count / 12.0);

            session.setAttribute("PRODUCT_PAGING", productList);
            request.setAttribute("endP", endPage);
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
