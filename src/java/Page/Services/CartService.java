/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Services;

import Page.Cart.CartDAO;
import Page.Cart.CartDTO;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Nhat Hung
 */
public class CartService {

    private CartDAO cartDAO = new CartDAO();

    public static boolean updateCartItem(int userID, int productId, int quantity) throws SQLException, ClassNotFoundException {
        return CartDAO.updateCartItem(userID, productId, quantity);
    }

    public static boolean removeCartItem(int cartId) {
        return CartDAO.removeCartItem(cartId);
    }

    public static List<CartDTO> getAllCartItems(int userId) {
        return CartDAO.getAllCartItems(userId);
    }

    public static boolean addProductToCart(int userID, int productId, int quantity) throws SQLException, ClassNotFoundException {
        return CartDAO.addProductToCart(userID, productId, quantity);
    }

}
