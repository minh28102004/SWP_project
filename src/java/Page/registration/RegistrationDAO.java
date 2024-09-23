/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.registration;

import Page.Product.ProductDTO;
import com.sun.javafx.scene.control.skin.VirtualFlow;
import Page.db.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class RegistrationDAO {

    public RegistrationDTO authenticate(String userName, String password) throws SQLException, ClassNotFoundException {
        RegistrationDTO user = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, userName);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String roleId = rs.getString("RoleID");
                    user = new RegistrationDTO(userName, password, roleId);
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
        return user;
    }

    public boolean checkAccountExist(String userName) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Users WHERE Username = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, userName);
                rs = stm.executeQuery();
                return rs.next();
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
        return false;
    }

    public boolean createNewAccount(String userName, String fullName, String password, String address, String sex, String phoneNumber, String email) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "INSERT INTO Users(Username, Fullname, Password, Address, Sex, Phonenumber, Email,RoleID) VALUES(?,?,?,?,?,?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, userName);
                stm.setString(2, fullName);
                stm.setString(3, password);
                stm.setString(4, address);
                stm.setString(5, sex);
                stm.setString(6, phoneNumber);
                stm.setString(7, email);
                stm.setString(8, "US");
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


    public RegistrationDTO getUser(String userName) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        RegistrationDTO user = null;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Users WHERE Username = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, userName);
                rs = stm.executeQuery();

                if (rs.next()) {
                    String userID = rs.getString("UserID");
                    String fullName = rs.getString("Fullname");
                    String password = rs.getString("Password");
                    String address = rs.getString("Address");
                    String sex = rs.getString("Sex");
                    String phoneNumber = rs.getString("Phonenumber");
                    String email = rs.getString("Email");
                    String roleID = rs.getString("RoleID");

                    user = new RegistrationDTO(userID, userName, fullName, password, address, sex, phoneNumber, email, roleID); // Include roleID
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
        return user;
    }

    public List<RegistrationDTO> getAllUser() throws SQLException, ClassNotFoundException {
        List<RegistrationDTO> userList = new ArrayList();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Users";
                stm = con.prepareStatement(query);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String userName = rs.getString("Username");
                    String fullName = rs.getString("Fullname");
                    String password = "*******";
                    String address = rs.getString("Address");
                    String sex = rs.getString("Sex");
                    String phoneNumber = rs.getString("Phonenumber");
                    String email = rs.getString("Email");
                    String roleId = rs.getString("RoleID");
                    RegistrationDTO user = new RegistrationDTO(userID, userName, fullName, password, address, sex, phoneNumber, email, roleId);
                    userList.add(user);
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
        return userList;
    }

    public List<ProductDTO> getAllProduct() throws SQLException, ClassNotFoundException {
        List<ProductDTO> productList = new ArrayList();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String querry = "SELECT * FROM Product";
                stm = con.prepareStatement(querry);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productIMG = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int price = rs.getInt("Price");
                    int quantity = rs.getInt("Quantity");
                    productList.add(new ProductDTO(productID, productName, productIMG, company, price, quantity));
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
            return productList;
        }
    }

    public List<ProductDTO> search(String searchValue) throws SQLException, ClassNotFoundException {
        List<ProductDTO> productList = new ArrayList();
        if (searchValue == null || searchValue.trim().isEmpty()) {
            return productList;
        }
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Product WHERE ProductName like ?";
                stm = con.prepareStatement(query);
                stm.setString(1, "%" + searchValue + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productIMG = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int price = rs.getInt("Price");
                    productList.add(new ProductDTO(productID, productName, productIMG, company, price, 10));
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
            return productList;
        }
    }

    public List<RegistrationDTO> searchUser(String searchValue) throws SQLException, ClassNotFoundException {
        List<RegistrationDTO> userList = new ArrayList();
        if (searchValue == null || searchValue.trim().isEmpty()) {
            return userList;
        }
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Users WHERE Fullname like ?";
                stm = con.prepareStatement(query);
                stm.setString(1, "%" + searchValue + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String userName = rs.getString("Username");
                    String fullName = rs.getString("Fullname");
                    String password = "*******";
                    String address = rs.getString("Address");
                    String sex = rs.getString("Sex");
                    String phoneNumber = rs.getString("Phonenumber");
                    String email = rs.getString("Email");
                    String roleId = rs.getString("RoleID");
                    RegistrationDTO user = new RegistrationDTO(userID, userName, fullName, password, address, sex, phoneNumber, email, roleId);
                    userList.add(user);
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
            return userList;
        }
    }

    public boolean update(String fullname, String password, String address, String sex, String phoneNumber, String email, String userName) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "UPDATE Users SET Fullname=?,Password=?,Address=?,Sex=?,Phonenumber=?,Email=? WHERE Username=?";
                stm = con.prepareStatement(query);
                stm.setString(1, fullname);
                stm.setString(2, password);
                stm.setString(3, address);
                stm.setString(4, sex);
                stm.setString(5, phoneNumber);
                stm.setString(6, email);
                stm.setString(7, userName);
                int affectedRow = stm.executeUpdate();
                return affectedRow == 1;
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

    public boolean deleteProduct(String id) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "DELETE FROM Product WHERE ProductID = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, id);
                int affectRows = stm.executeUpdate();
                return affectRows > 0;
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

    public boolean deleteUser(String userName) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "DELETE FROM Users WHERE Username = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, userName);
                int affectRows = stm.executeUpdate();
                return affectRows > 0;
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

    public boolean updateUser(String userName, String roleId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "UPDATE Users SET RoleID = ? WHERE Username = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, roleId);
                stm.setString(2, userName);
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

    public int getTotalProducts() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT COUNT(*) FROM Product";
                stm = con.prepareStatement(query);
                rs = stm.executeQuery();
                while (rs.next()) {
                    return rs.getInt(1);
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
        return 0;
    }

    public List<ProductDTO> pagingProduct(int index) throws SQLException, ClassNotFoundException {
        List<ProductDTO> productList = new ArrayList();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String query = "SELECT * FROM Product ORDER BY ProductID OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
                stm = con.prepareStatement(query);
                stm.setInt(1, ((index - 1) * 12));
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String productIMG = rs.getString("ProductIMG");
                    String company = rs.getString("Company");
                    int price = rs.getInt("Price");
                    productList.add(new ProductDTO(productID, productName, productIMG, company, price));
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
