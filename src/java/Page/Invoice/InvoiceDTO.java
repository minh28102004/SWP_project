/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Invoice;

import Page.Product.ProductDTO;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author Nhat Hung
 */
public class InvoiceDTO {

    private int invoiceID;
    private int userID;
    private LocalDateTime invoiceDate;
    private double totalAmount;
    private String shippingMethod;
    private List<ProductDTO> products;

    public InvoiceDTO() {
        
    }

    public InvoiceDTO(int invoiceID, int userID, LocalDateTime invoiceDate, double totalAmount, String shippingMethod, List<ProductDTO> products) {
        this.invoiceID = invoiceID;
        this.userID = userID;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        this.shippingMethod = shippingMethod;
        this.products = products;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public LocalDateTime getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(LocalDateTime invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public List<ProductDTO> getProducts() {
        return products;
    }

    public void setProducts(List<ProductDTO> products) {
        this.products = products;
    }
}