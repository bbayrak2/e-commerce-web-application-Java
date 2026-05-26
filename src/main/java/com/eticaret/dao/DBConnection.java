package com.eticaret.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) return connection;
        try {
                        String url = "jdbc:mysql://mysql_db:3306/eticaret_sistemi?useSSL=false";
            String user = "root";
            String password = "root"; 
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}