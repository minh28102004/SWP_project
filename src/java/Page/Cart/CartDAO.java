/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Cart;

import Page.db.DBUtil;
import static Page.db.DBUtil.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nhat Hung
 */
public class CartDAO {

    public static boolean addProductToCart(int userID, int productID, int quantity) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean itemExists = false;

        try {
            int availableQuantity = getAvailableQuantity(productID);

            if (availableQuantity < quantity) {
                System.out.println("Not enough quantity available for productID: " + productID);
                return false;
            }

            con = getConnection();

            String query = "SELECT Quantity FROM Cart WHERE UserID = ? AND ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, userID);
            stm.setInt(2, productID);
            rs = stm.executeQuery();

            if (rs.next()) {
                itemExists = true;
            }

            if (itemExists) {
                query = "UPDATE Cart SET Quantity = Quantity + ? WHERE UserID = ? AND ProductID = ?";
            } else {
                query = "INSERT INTO Cart(UserID, ProductID, Quantity) VALUES (?, ?, ?)";
            }

            stm = con.prepareStatement(query);
            if (itemExists) {
                stm.setInt(1, quantity);
                stm.setInt(2, userID);
                stm.setInt(3, productID);
            } else {
                stm.setInt(1, userID);
                stm.setInt(2, productID);
                stm.setInt(3, quantity);
            }

            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;

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
    }

    public static int getAvailableQuantity(int productID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            String query = "SELECT Quantity FROM Product WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();

            if (rs.next()) {
                return rs.getInt("Quantity");
            } else {
                return 0;
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
    }

    public static List<CartDTO> getAllCartItems(int userId) {
        List<CartDTO> cartItems = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT c.CartID, c.UserID, c.ProductID, p.ProductName, p.ProductIMG, p.Company, p.Price, c.Quantity "
                        + "FROM Cart c "
                        + "JOIN Product p ON c.ProductID = p.ProductID "
                        + "WHERE c.UserID = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int cartId = rs.getInt("CartID");
                    int productId = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productImg = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int price = rs.getInt("Price");
                    int quantity = rs.getInt("Quantity");

                    CartDTO cartItem = new CartDTO(cartId, userId, productId, productName, productImg, company, price, quantity);
                    cartItems.add(cartItem);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Consider logging the exception to a logging framework
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return cartItems;
    }

    public static boolean removeCartItem(int cartId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "DELETE FROM Cart WHERE CartID = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, cartId);
                int rowsAffected = pstmt.executeUpdate();
                result = rowsAffected > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static boolean updateCartItem(int userId, int productId, int quantity) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "UPDATE Cart SET Quantity = ? WHERE UserID = ? AND ProductID = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, quantity);
                pstmt.setInt(2, userId);
                pstmt.setInt(3, productId);
                pstmt.executeUpdate();
            }
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }
    
    public int getCartQuantity(int userID,int productID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int quantity = 0;

        try {
            con = DBUtil.getConnection();
            String query = "SELECT Quantity FROM Cart WHERE ProductID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, productID);
            rs = stm.executeQuery();

            if (rs.next()) {
                quantity = rs.getInt("Quantity");
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

        return quantity;
    }
}
