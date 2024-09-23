package Payment.servlet;

import Page.Cart.CartDAO;
import Page.Invoice.InvoiceDTO;
import Page.Product.ProductDAO;
import Page.Product.ProductDTO;
import Page.Services.InvoiceService;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BuyCartServlet extends HttpServlet {

    private final String INVOICE_PAGE = "Invoice.jsp";
    private static final Logger logger = Logger.getLogger(BuyCartServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVOICE_PAGE;
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            RegistrationDTO user = (RegistrationDTO) session.getAttribute("USER");

            if (user != null) {
                int userID = Integer.parseInt(user.getUserID());
                String shippingMethod = request.getParameter("shipping");
                String[] cartIDStrings = request.getParameter("selectedCartIDs").split(",");
                double totalAmount = Double.parseDouble(request.getParameter("totalPrice"));

                List<Integer> cartIDs = new ArrayList<>();
                for (String cartIDStr : cartIDStrings) {
                    cartIDs.add(Integer.parseInt(cartIDStr));
                }

                ProductDAO productDAO = new ProductDAO();
                List<ProductDTO> products = productDAO.getProductsSelectedFromCart(userID, cartIDs);

                InvoiceService invoiceService = new InvoiceService();
                InvoiceDTO createdInvoice = invoiceService.createInvoice(userID, cartIDs, totalAmount, shippingMethod, products);

                // Add the created invoice to purchaseHistory
                List<InvoiceDTO> purchaseHistory = invoiceService.getInvoicesByUserID(userID);

                for (InvoiceDTO invoice : purchaseHistory) {
                    List<ProductDTO> products1 = invoiceService.getProductsByInvoiceID(invoice.getInvoiceID());
                    invoice.setProducts(products1);
                }
                session.setAttribute("purchaseHistory", purchaseHistory);

                request.setAttribute("username", user.getUserName());
                request.setAttribute("fullname", user.getFullName());
                request.setAttribute("address", user.getAddress());
                request.setAttribute("email", user.getEmail());
                request.setAttribute("phoneNumber", user.getPhoneNumber());
                request.setAttribute("invoiceID", createdInvoice.getInvoiceID());
                request.setAttribute("shippingMethod", createdInvoice.getShippingMethod());
                request.setAttribute("totalAmount", createdInvoice.getTotalAmount());
                request.setAttribute("PRODUCTS", products);

                // Calculate invoiceDate2 as 5 days after the current date
                LocalDate invoiceDate2 = LocalDate.now().plusDays(5);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                request.setAttribute("invoiceDate", createdInvoice.getInvoiceDate().format(formatter));
                request.setAttribute("invoiceDate2", invoiceDate2.format(formatter));

            } else {
                url = "Login.jsp";
            }
        } catch (SQLException | ClassNotFoundException e) {
            logger.severe("Error processing request in BuyCartServlet: " + e.getMessage());
            request.setAttribute("message", "An error occurred: " + e.getMessage());
            url = "invalid.jsp";
        } finally {
            request.setAttribute("showMessage", true);
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BuyCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BuyCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
