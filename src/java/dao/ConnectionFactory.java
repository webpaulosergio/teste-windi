package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    public Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost/windi", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Erro de Conexão: " + e);
        }
    }

}
