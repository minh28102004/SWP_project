/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Invoice;

/**
 *
 * @author Nhat Hung
 */
public class InvoiceItemDTO {
    private int invoiceItemID; 
    private int invoiceID;
    private int productID;
    private String productName;
    private String productIMG;
    private String company;
    private int quantity;
    private double price;

    public InvoiceItemDTO() {
    }

    public InvoiceItemDTO(int invoiceItemID, int invoiceID, int productID, String productName, String productIMG, String company, int quantity, double price) {
        this.invoiceItemID = invoiceItemID;
        this.invoiceID = invoiceID;
        this.productID = productID;
        this.productName = productName;
        this.productIMG = productIMG;
        this.company = company;
        this.quantity = quantity;
        this.price = price;
    }

    public int getInvoiceItemID() {
        return invoiceItemID;
    }

    public void setInvoiceItemID(int invoiceItemID) {
        this.invoiceItemID = invoiceItemID;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductIMG() {
        return productIMG;
    }

    public void setProductIMG(String productIMG) {
        this.productIMG = productIMG;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    
}
