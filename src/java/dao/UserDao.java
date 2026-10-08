/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Admin
 */

import common.AccesBdd;
import modele.UserModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    private AccesBdd accesBdd;

    public UserDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(UserModele user) {
        String sql = "INSERT INTO user "
                + "(nom, prenom, email, password, role, actif) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getNom());
            ps.setString(2, user.getPrenom());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setBoolean(6, user.isActif());

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId_user(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public UserModele trouverParId(int id_user) {
        String sql = "SELECT * FROM user WHERE id_user = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_user);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return remplirModele(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public UserModele trouverParEmail(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return remplirModele(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public UserModele authentifier(String email, String password) {
        String sql = "SELECT * FROM user "
                + "WHERE email = ? AND password = ? AND actif = 1";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return remplirModele(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<UserModele> trouverTous() {
        List<UserModele> users = new ArrayList<>();

        String sql = "SELECT * FROM user ORDER BY id_user DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public boolean modifier(UserModele user) {
        String sql = "UPDATE user SET "
                + "nom = ?, "
                + "prenom = ?, "
                + "email = ?, "
                + "password = ?, "
                + "role = ?, "
                + "actif = ? "
                + "WHERE id_user = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getNom());
            ps.setString(2, user.getPrenom());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setBoolean(6, user.isActif());
            ps.setInt(7, user.getId_user());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean changerEtat(int id_user, boolean actif) {
        String sql = "UPDATE user SET actif = ? WHERE id_user = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, actif);
            ps.setInt(2, id_user);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean supprimer(int id_user) {
        String sql = "DELETE FROM user WHERE id_user = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_user);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private UserModele remplirModele(ResultSet rs)
            throws SQLException {

        UserModele user = new UserModele();

        user.setId_user(rs.getInt("id_user"));
        user.setNom(rs.getString("nom"));
        user.setPrenom(rs.getString("prenom"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setActif(rs.getBoolean("actif"));
        user.setDate_creation(rs.getString("date_creation"));

        return user;
    }
}