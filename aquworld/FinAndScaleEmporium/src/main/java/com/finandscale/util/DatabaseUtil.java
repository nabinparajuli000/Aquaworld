package com.finandscale.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/fin_scale_emporium?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; // Your XAMPP MySQL username
    private static final String PASSWORD = ""; // Your XAMPP MySQL password (often empty by default)

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MySQL JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}