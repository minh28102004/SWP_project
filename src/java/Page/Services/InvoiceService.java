/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Services;

import Page.Cart.CartDAO;
import Page.Invoice.InvoiceDAO;
import Page.Invoice.InvoiceDTO;
import Page.Product.ProductDAO;
import Page.Product.ProductDTO;
import Page.db.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nhat Hung
 */
public class InvoiceService {

    public InvoiceDTO createInvoice(int userID, List<Integer> cartIDs, double totalAmount, String shippingMethod, List<ProductDTO> products) throws SQLException, ClassNotFoundException {
        InvoiceDTO invoice = new InvoiceDTO();
        invoice.setUserID(userID);
        invoice.setTotalAmount(totalAmount);
        invoice.setShippingMethod(shippingMethod);
        invoice.setInvoiceDate(LocalDateTime.now());
        invoice.setInvoiceID(generateInvoiceID());
        
        invoice.setProducts(products);

        InvoiceDAO invoiceDAO = new InvoiceDAO();
        invoiceDAO.saveInvoice(invoice);

        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();

        for (ProductDTO product : products) {
            int currentQuantity = productDAO.getProductQuantity(product.getProductID());
            int cartQuantity = cartDAO.getCartQuantity(userID, product.getProductID());
            int newQuantity = currentQuantity - cartQuantity;

            productDAO.updateProductQuantity(product.getProductID(), newQuantity);
        }

        for (int cartID : cartIDs) {
            cartDAO.removeCartItem(cartID);
        }

        return invoice;
    }

    private int generateInvoiceID() throws SQLException, ClassNotFoundException {
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        return invoiceDAO.getNextInvoiceIDFromDatabase();
    }
    
    public List<InvoiceDTO> getInvoicesByUserID(int userID) throws SQLException, ClassNotFoundException {
        List<InvoiceDTO> invoiceList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT InvoiceID, InvoiceDate, TotalAmount, ShippingMethod FROM Invoice WHERE UserID = ?";
                stm = con.prepareStatement(query);
                stm.setInt(1, userID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int invoiceID = rs.getInt("InvoiceID");
                    LocalDateTime invoiceDate = rs.getTimestamp("InvoiceDate").toLocalDateTime();
                    double totalAmount = rs.getDouble("TotalAmount");
                    String shippingMethod = rs.getString("ShippingMethod");
                    
                    List<ProductDTO> products = getProductsByInvoiceID(invoiceID);

                    InvoiceDTO invoice = new InvoiceDTO(invoiceID, userID, invoiceDate, totalAmount, shippingMethod, products);
                    invoiceList.add(invoice);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return invoiceList;
    }

    public List<ProductDTO> getProductsByInvoiceID(int invoiceID) throws SQLException, ClassNotFoundException {
        List<ProductDTO> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT ProductID, ProductName, ProductIMG, Company, Quantity, Price FROM InvoiceItem WHERE InvoiceID = ?";
                stm = con.prepareStatement(query);
                stm.setInt(1, invoiceID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productIMG = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int quantity = rs.getInt("Quantity");
                    int price = rs.getInt("Price");
                    ProductDTO product = new ProductDTO(productID, productName, productIMG, company, quantity, price);
                    productList.add(product);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return productList;
    }
}
