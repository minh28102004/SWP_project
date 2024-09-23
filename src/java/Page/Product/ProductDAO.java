/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Product;

import Page.db.DBUtil;
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
public class ProductDAO {

    public int getTotalProductsWith2Keywords(String brand, String productLine) throws SQLException, ClassNotFoundException {
        int count = 0;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT COUNT(*) AS TotalCount FROM Product WHERE ProductName LIKE ? AND ProductName LIKE ?";
                stm = con.prepareStatement(query);
                stm.setString(1, "%" + brand + "%");
                stm.setString(2, "%" + productLine + "%");
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("TotalCount");
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
        return count;
    }

    public List<ProductDTO> getProductWith2KeyWordPagination(String brand, String productLine, int pageIndex) throws SQLException, ClassNotFoundException {
        List<ProductDTO> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int pageSize = 12;
        int startRow = (pageIndex - 1) * pageSize;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS RowNum, * FROM Product WHERE ProductName LIKE ? AND ProductName LIKE ? ) AS RowConstrainedResult WHERE RowNum > ? AND RowNum <= ?";
                stm = con.prepareStatement(query);
                stm.setString(1, "%" + brand + "%");
                stm.setString(2, "%" + productLine + "%");
                stm.setInt(3, startRow);
                stm.setInt(4, startRow + pageSize);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productIMG = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int price = rs.getInt("Price");
                    ProductDTO product = new ProductDTO(productID, productName, productIMG, company, price);
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

    public List<ProductDTO> getProductsSelectedFromCart(int userID, List<Integer> cartIDs) throws SQLException, ClassNotFoundException {
        List<ProductDTO> products = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                StringBuilder queryBuilder = new StringBuilder();
                queryBuilder.append("SELECT p.ProductID, p.ProductName, p.ProductIMG, p.Company, p.Price, c.Quantity ");
                queryBuilder.append("FROM Product p ");
                queryBuilder.append("JOIN Cart c ON p.ProductID = c.ProductID ");
                queryBuilder.append("WHERE c.CartID IN (");

                for (int i = 0; i < cartIDs.size(); i++) {
                    queryBuilder.append("?");
                    if (i < cartIDs.size() - 1) {
                        queryBuilder.append(", ");
                    }
                }
                queryBuilder.append(") AND c.UserID = ?");

                stm = con.prepareStatement(queryBuilder.toString());

                int parameterIndex = 1;
                for (int cartID : cartIDs) {
                    stm.setInt(parameterIndex++, cartID);
                }
                stm.setInt(parameterIndex, userID);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productIMG = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int price = rs.getInt("Price");
                    int quantity = rs.getInt("Quantity");

                    ProductDTO product = new ProductDTO(productID, productName, productIMG, company, price, quantity);
                    products.add(product);
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

        return products;
    }

    public int getProductQuantity(int productID) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int quantity = 0;

        try {
            con = DBUtil.getConnection(); // Assume DBUtil provides a static method to get a database connection
            String query = "SELECT Quantity FROM Product WHERE ProductID = ?";
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

    public boolean createNewProduct(String name, String image, String company, int price, int quantity) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "INSERT INTO Product VALUES(?,?,?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, name);
                stm.setString(2, image);
                stm.setString(3, company);
                stm.setInt(4, price);
                stm.setInt(5, quantity);
                int affectedRows = stm.executeUpdate();
                return affectedRows != 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean updateProduct(int id, String name, String company, int price, int quantity) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "UPDATE Product SET ProductName = ?, Company = ?, Price = ?, Quantity = ? WHERE ProductID = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, name);
                stm.setString(2, company);
                stm.setInt(3, price);
                stm.setInt(4, quantity);
                stm.setInt(5, id);
                int affectedRows = stm.executeUpdate();
                return affectedRows == 1;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    
    public boolean updateProductQuantity(int id, int quantity) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "UPDATE Product SET Quantity = ? WHERE ProductID = ?";
                stm = con.prepareStatement(query);
                stm.setInt(1, quantity);
                stm.setInt(2, id);
                int affectedRows = stm.executeUpdate();
                return affectedRows == 1;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
}
