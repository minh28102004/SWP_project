/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Invoice;

import Page.Product.ProductDTO;
import Page.db.DBUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nhat Hung
 */
public class InvoiceDAO {

    public int getNextInvoiceIDFromDatabase() throws SQLException, ClassNotFoundException {
        int nextID = 0;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT NEXT VALUE FOR InvoiceSeq AS NextID";
                stm = con.prepareStatement(query);
                rs = stm.executeQuery();
                if (rs.next()) {
                    nextID = rs.getInt("NextID");
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
        return nextID;
    }

    public void saveInvoice(InvoiceDTO invoice) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stmInvoice = null;
        PreparedStatement stmInvoiceItem = null;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                con.setAutoCommit(false);

                String invoiceQuery = "INSERT INTO Invoice (InvoiceID, UserID, InvoiceDate, TotalAmount, ShippingMethod) "
                        + "VALUES (?, ?, ?, ?, ?)";
                stmInvoice = con.prepareStatement(invoiceQuery);
                stmInvoice.setInt(1, invoice.getInvoiceID());
                stmInvoice.setInt(2, invoice.getUserID());
                stmInvoice.setTimestamp(3, Timestamp.valueOf(invoice.getInvoiceDate()));
                stmInvoice.setDouble(4, invoice.getTotalAmount());
                stmInvoice.setString(5, invoice.getShippingMethod());
                stmInvoice.executeUpdate();

                String invoiceItemQuery = "INSERT INTO InvoiceItem (InvoiceID, ProductID, ProductName, ProductIMG, Company, Quantity, Price) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?)";
                stmInvoiceItem = con.prepareStatement(invoiceItemQuery);
                for (ProductDTO product : invoice.getProducts()) {
                    stmInvoiceItem.setInt(1, invoice.getInvoiceID());
                    stmInvoiceItem.setInt(2, product.getProductID());
                    stmInvoiceItem.setString(3, product.getProductName());
                    stmInvoiceItem.setString(4, product.getProductIMG());
                    stmInvoiceItem.setString(5, product.getCompany());
                    stmInvoiceItem.setInt(6, product.getQuantity());
                    stmInvoiceItem.setDouble(7, product.getPrice());
                    stmInvoiceItem.executeUpdate();
                }
                con.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                con.rollback();
            }
            throw e;
        } finally {
            if (stmInvoice != null) {
                stmInvoice.close();
            }
            if (stmInvoiceItem != null) {
                stmInvoiceItem.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    
}
