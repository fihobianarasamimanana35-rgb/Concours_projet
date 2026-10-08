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
import modele.ConcoursModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ConcoursDao {

    private AccesBdd accesBdd;

    public ConcoursDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(ConcoursModele concours) {
        String sql = "INSERT INTO concours "
                + "(code_concours, nom, description, date_debut, "
                + "date_fin, nombre_places, statut, date_publication) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, concours.getCode_concours());
            ps.setString(2, concours.getNom());
            ps.setString(3, concours.getDescription());
            ps.setString(4, concours.getDate_debut());
            ps.setString(5, concours.getDate_fin());
            ps.setInt(6, concours.getNombre_places());
            ps.setString(7, concours.getStatut());

            if (concours.getDate_publication() == null
                    || concours.getDate_publication().trim().isEmpty()) {
                ps.setNull(8, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(8, concours.getDate_publication());
            }

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        concours.setId_concours(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public ConcoursModele trouverParId(int id_concours) {
        String sql = "SELECT * FROM concours WHERE id_concours = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_concours);

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

    public ConcoursModele trouverParCode(String code_concours) {
        String sql = "SELECT * FROM concours WHERE code_concours = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code_concours);

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

    public List<ConcoursModele> trouverTous() {
        List<ConcoursModele> concours = new ArrayList<>();

        String sql = "SELECT * FROM concours "
                + "ORDER BY id_concours DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                concours.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return concours;
    }

    public List<ConcoursModele> trouverPublies() {
        List<ConcoursModele> concours = new ArrayList<>();

        String sql = "SELECT * FROM concours "
                + "WHERE statut = 'publie' "
                + "AND date_fin >= NOW() "
                + "ORDER BY date_debut ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                concours.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return concours;
    }

    public List<ConcoursModele> trouverOuverts() {
        List<ConcoursModele> concours = new ArrayList<>();

        String sql = "SELECT * FROM concours "
                + "WHERE statut = 'publie' "
                + "AND NOW() BETWEEN date_debut AND date_fin "
                + "ORDER BY date_debut ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                concours.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return concours;
    }

    public boolean modifier(ConcoursModele concours) {
        String sql = "UPDATE concours SET "
                + "code_concours = ?, "
                + "nom = ?, "
                + "description = ?, "
                + "date_debut = ?, "
                + "date_fin = ?, "
                + "nombre_places = ?, "
                + "statut = ?, "
                + "date_publication = ? "
                + "WHERE id_concours = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, concours.getCode_concours());
            ps.setString(2, concours.getNom());
            ps.setString(3, concours.getDescription());
            ps.setString(4, concours.getDate_debut());
            ps.setString(5, concours.getDate_fin());
            ps.setInt(6, concours.getNombre_places());
            ps.setString(7, concours.getStatut());

            if (concours.getDate_publication() == null
                    || concours.getDate_publication().trim().isEmpty()) {
                ps.setNull(8, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(8, concours.getDate_publication());
            }

            ps.setInt(9, concours.getId_concours());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean changerStatut(int id_concours, String statut) {
        String sql = "UPDATE concours SET statut = ? ";

        if ("publie".equalsIgnoreCase(statut)) {
            sql += ", date_publication = NOW() ";
        }

        sql += "WHERE id_concours = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, statut);
            ps.setInt(2, id_concours);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean supprimer(int id_concours) {
        String sql = "DELETE FROM concours WHERE id_concours = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_concours);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private ConcoursModele remplirModele(ResultSet rs)
            throws SQLException {

        ConcoursModele concours = new ConcoursModele();

        concours.setId_concours(rs.getInt("id_concours"));
        concours.setCode_concours(rs.getString("code_concours"));
        concours.setNom(rs.getString("nom"));
        concours.setDescription(rs.getString("description"));
        concours.setDate_debut(rs.getString("date_debut"));
        concours.setDate_fin(rs.getString("date_fin"));
        concours.setNombre_places(rs.getInt("nombre_places"));
        concours.setStatut(rs.getString("statut"));
        concours.setDate_publication(rs.getString("date_publication"));
        concours.setDate_creation(rs.getString("date_creation"));
        concours.setDate_modification(rs.getString("date_modification"));

        return concours;
    }
}