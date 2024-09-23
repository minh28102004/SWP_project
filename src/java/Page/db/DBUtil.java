/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author HP
 */
public class DBUtil {
    private static final String userName = "sa";
    private static final String password = "12345";
    private static final String DATABASE = "Group_6";
    public static Connection getConnection() throws SQLException, ClassNotFoundException{
        Connection con = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        //2. create url
        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DATABASE;
        //3.tao con
        con = DriverManager.getConnection(url,userName,password);
        return con;
    }
}
