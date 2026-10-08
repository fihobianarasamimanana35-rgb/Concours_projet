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
import modele.EpreuveModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class EpreuveDao {

    private AccesBdd accesBdd;

    public EpreuveDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(EpreuveModele epreuve) {
        String sql = "INSERT INTO epreuve "
                + "(id_concours, nom, description, date_epreuve, "
                + "duree_minutes, coefficient) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, epreuve.getId_concours());
            ps.setString(2, epreuve.getNom());
            ps.setString(3, epreuve.getDescription());

            if (epreuve.getDate_epreuve() == null
                    || epreuve.getDate_epreuve().trim().isEmpty()) {
                ps.setNull(4, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(4, epreuve.getDate_epreuve());
            }

            if (epreuve.getDuree_minutes() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, epreuve.getDuree_minutes());
            }

            ps.setDouble(6, epreuve.getCoefficient());

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        epreuve.setId_epreuve(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public EpreuveModele trouverParId(int id_epreuve) {
        String sql = "SELECT * FROM epreuve WHERE id_epreuve = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_epreuve);

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

    public List<EpreuveModele> trouverTous() {
        List<EpreuveModele> epreuves = new ArrayList<>();

        String sql = "SELECT e.*, c.code_concours, c.nom AS nom_concours FROM epreuve e INNER JOIN concours c ON e.id_concours = c.id_concours ORDER BY e.id_epreuve DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                epreuves.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return epreuves;
    }

    public List<EpreuveModele> trouverParConcours(int id_concours) {
        List<EpreuveModele> epreuves = new ArrayList<>();

        String sql = "SELECT * FROM epreuve "
                + "WHERE id_concours = ? "
                + "ORDER BY date_epreuve ASC, id_epreuve ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_concours);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    epreuves.add(remplirModele(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return epreuves;
    }

    public boolean modifier(EpreuveModele epreuve) {
        String sql = "UPDATE epreuve SET "
                + "id_concours = ?, "
                + "nom = ?, "
                + "description = ?, "
                + "date_epreuve = ?, "
                + "duree_minutes = ?, "
                + "coefficient = ? "
                + "WHERE id_epreuve = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, epreuve.getId_concours());
            ps.setString(2, epreuve.getNom());
            ps.setString(3, epreuve.getDescription());

            if (epreuve.getDate_epreuve() == null
                    || epreuve.getDate_epreuve().trim().isEmpty()) {
                ps.setNull(4, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(4, epreuve.getDate_epreuve());
            }

            if (epreuve.getDuree_minutes() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, epreuve.getDuree_minutes());
            }

            ps.setDouble(6, epreuve.getCoefficient());
            ps.setInt(7, epreuve.getId_epreuve());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean supprimer(int id_epreuve) {
        String sql = "DELETE FROM epreuve WHERE id_epreuve = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_epreuve);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private EpreuveModele remplirModele(ResultSet rs)
            throws SQLException {

        EpreuveModele epreuve = new EpreuveModele();

        epreuve.setId_epreuve(rs.getInt("id_epreuve"));
        epreuve.setId_concours(rs.getInt("id_concours"));
        epreuve.setNom(rs.getString("nom"));
        epreuve.setDescription(rs.getString("description"));
        epreuve.setDate_epreuve(rs.getString("date_epreuve"));

        int duree = rs.getInt("duree_minutes");

        if (rs.wasNull()) {
            epreuve.setDuree_minutes(null);
        } else {
            epreuve.setDuree_minutes(duree);
        }

        epreuve.setCoefficient(rs.getDouble("coefficient"));
        epreuve.setDate_creation(rs.getString("date_creation"));

        return epreuve;
    }
}