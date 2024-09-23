/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Cart.servlets;

import Page.Cart.CartDAO;
import static Page.Cart.CartDAO.getAvailableQuantity;
import Page.Cart.CartDTO;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import static java.lang.Integer.parseInt;
import static java.lang.System.out;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Luong Xuan Tien
 */
public class UpdateCartServlet extends HttpServlet {

    private final String VIEW_CART_PAGE = "ViewCart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = VIEW_CART_PAGE;
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));

            HttpSession session = request.getSession();

            List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("CART");

            for (CartDTO item : cartList) {
                if (item.getProductId() == productID) {
                    item.setQuantity(quantity);
                    item.setSubTotal(quantity * item.getPrice());
                    break;
                }
            }

            int userID = parseInt(((RegistrationDTO) session.getAttribute("USER")).getUserID());
            CartDAO cartDAO = new CartDAO();
            boolean updateSuccess = cartDAO.updateCartItem(userID, productID, quantity);

            session.setAttribute("CART", cartList);

        } catch (NumberFormatException|SQLException | ClassNotFoundException e) {
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
