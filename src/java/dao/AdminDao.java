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
import modele.AdminModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {

    private AccesBdd accesBdd;

    public AdminDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(AdminModele admin) {
        String sql = "INSERT INTO admin "
                + "(id_user, matricule) "
                + "VALUES (?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, admin.getId_user());
            ps.setString(2, admin.getMatricule());

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        admin.setId_admin(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public AdminModele trouverParId(int id_admin) {
        String sql = "SELECT * FROM admin WHERE id_admin = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_admin);

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

    public AdminModele trouverParIdUser(int id_user) {
        String sql = "SELECT * FROM admin WHERE id_user = ?";

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

    public AdminModele trouverParMatricule(String matricule) {
        String sql = "SELECT * FROM admin WHERE matricule = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, matricule);

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

    public List<AdminModele> trouverTous() {
        List<AdminModele> admins = new ArrayList<>();

        String sql = "SELECT * FROM admin ORDER BY id_admin DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                admins.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return admins;
    }

    public boolean modifier(AdminModele admin) {
        String sql = "UPDATE admin SET "
                + "id_user = ?, "
                + "matricule = ? "
                + "WHERE id_admin = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, admin.getId_user());
            ps.setString(2, admin.getMatricule());
            ps.setInt(3, admin.getId_admin());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean supprimer(int id_admin) {
        String sql = "DELETE FROM admin WHERE id_admin = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_admin);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private AdminModele remplirModele(ResultSet rs)
            throws SQLException {

        AdminModele admin = new AdminModele();

        admin.setId_admin(rs.getInt("id_admin"));
        admin.setId_user(rs.getInt("id_user"));
        admin.setMatricule(rs.getString("matricule"));

        return admin;
    }
}