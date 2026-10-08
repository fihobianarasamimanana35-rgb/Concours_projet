/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package common;

/**
 *
 * @author Admin
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import config.config;

public class AccesBdd {

    private Connection conn = null;
    private ResultSet resultSet = null;
    private String driver;
    private String url;
    private String user; // variable local
    private String password;

    public AccesBdd() //constructeur 
    {
        config config = new config();
        this.driver = config.driver; //variable globale mampifandray sql sy java
        this.url = config.url;
        this.user = config.user;
        this.password = config.password;
    }

    /**
     * @param args
     */
    public void loadDriver() {
        try {
            //chargement Driver
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            System.err.println("Driver non trouvé");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {

    try {

        Class.forName(driver);

        if (conn == null || conn.isClosed()) {

            conn = DriverManager.getConnection(
                    url,
                    user,
                    password
            );

            System.out.println("Connexion MySQL réussie");

        }

    } catch (ClassNotFoundException e) {

        System.out.println("Driver MySQL introuvable");
        e.printStackTrace();

    } catch (SQLException e) {

        System.out.println("Erreur connexion MySQL : " + e.getMessage());
        e.printStackTrace();
    }

    return conn;
}

    public ResultSet executeSelect(String sql) {
        Statement statement;
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            statement = getConnection().createStatement();
            resultSet = statement.executeQuery(sql);

            return resultSet;
        } catch (Exception e) {
            //throw new RuntimeException(e);
            System.out.println(e);
        }
        return resultSet;
    }

    public void executeUpdate(String sql) {
        Statement statement;
        try {
            statement = getConnection().createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void closeConnection() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) { //misy diso sql SQLException
            e.printStackTrace();
        }
    }
}
