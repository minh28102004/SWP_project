/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Cart;

/**
 *
 * @author Nhat Hung
 */
public class CartDTO {
    private int cartId;
    private int userID;
    private int productId;
    private String productName;
    private String productImg;
    private String company;
    private int price;
    private int quantity;
    private double subTotal;
    

    public CartDTO(int cartId, int userID, int productId, String productName, String productImg, String company, int price, int quantity) {
        this.cartId = cartId;
        this.userID = userID;
        this.productId = productId;
        this.productName = productName;
        this.productImg = productImg;
        this.company = company;
        this.price = price;
        this.quantity = quantity;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
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
    
    public double getSubTotal() {
        return subTotal = quantity * price;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }
}

