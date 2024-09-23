/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Product;

/**
 *
 * @author HP
 */
public class ProductDTO {
    private int productID;
    private String productName;
    private String productIMG;
    private String company;
    private int price;
    private int quantity;
    public ProductDTO(){}

    public ProductDTO(int productID, String productName, String productIMG, String company, int price, int quantity) {
        this.productID = productID;
        this.productName = productName;
        this.productIMG = productIMG;
        this.company = company;
        this.price = price;
        this.quantity = quantity;
    }

    
    public ProductDTO(int productID, String productName, String productIMG, String company, int price) {
        this.productID = productID;
        this.productName = productName;
        this.productIMG = productIMG;
        this.company = company;
        this.price = price;
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

    public void setProductIMG(String ProductIMG) {
        this.productIMG = ProductIMG;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
