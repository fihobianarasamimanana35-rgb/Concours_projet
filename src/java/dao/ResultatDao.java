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
import modele.ResultatModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ResultatDao {

    private AccesBdd accesBdd;

    public ResultatDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(ResultatModele resultat) {
        String sql = "INSERT INTO resultat "
                + "(id_inscription, rang, note_finale, "
                + "decision, publie, date_publication) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, resultat.getId_inscription());

            if (resultat.getRang() == null) {
                ps.setNull(2, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, resultat.getRang());
            }

            if (resultat.getNote_finale() == null) {
                ps.setNull(3, java.sql.Types.DECIMAL);
            } else {
                ps.setDouble(3, resultat.getNote_finale());
            }

            if (resultat.getDecision() == null
                    || resultat.getDecision().trim().isEmpty()) {
                ps.setNull(4, java.sql.Types.VARCHAR);
            } else {
                ps.setString(4, resultat.getDecision());
            }

            ps.setBoolean(5, resultat.isPublie());

            if (resultat.getDate_publication() == null
                    || resultat.getDate_publication().trim().isEmpty()) {
                ps.setNull(6, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(6, resultat.getDate_publication());
            }

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        resultat.setId_resultat(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public ResultatModele trouverParId(int id_resultat) {
        String sql = "SELECT * FROM resultat "
                + "WHERE id_resultat = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_resultat);

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

    public ResultatModele trouverParInscription(
            int id_inscription) {

        String sql = "SELECT * FROM resultat "
                + "WHERE id_inscription = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_inscription);

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

    public List<ResultatModele> trouverTous() {
        List<ResultatModele> resultats = new ArrayList<>();

        String sql = "SELECT * FROM resultat "
                + "ORDER BY rang ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                resultats.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultats;
    }

    public List<ResultatModele> trouverPublies() {
        List<ResultatModele> resultats = new ArrayList<>();

        String sql = "SELECT * FROM resultat "
                + "WHERE publie = 1 "
                + "ORDER BY rang ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                resultats.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultats;
    }

    public List<ResultatModele> trouverParDecision(
            String decision) {

        List<ResultatModele> resultats = new ArrayList<>();

        String sql = "SELECT * FROM resultat "
                + "WHERE decision = ? "
                + "ORDER BY rang ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, decision);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultats.add(remplirModele(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultats;
    }

    public boolean modifier(ResultatModele resultat) {
        String sql = "UPDATE resultat SET "
                + "id_inscription = ?, "
                + "rang = ?, "
                + "note_finale = ?, "
                + "decision = ?, "
                + "publie = ?, "
                + "date_publication = ? "
                + "WHERE id_resultat = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, resultat.getId_inscription());

            if (resultat.getRang() == null) {
                ps.setNull(2, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, resultat.getRang());
            }

            if (resultat.getNote_finale() == null) {
                ps.setNull(3, java.sql.Types.DECIMAL);
            } else {
                ps.setDouble(3, resultat.getNote_finale());
            }

            if (resultat.getDecision() == null
                    || resultat.getDecision().trim().isEmpty()) {
                ps.setNull(4, java.sql.Types.VARCHAR);
            } else {
                ps.setString(4, resultat.getDecision());
            }

            ps.setBoolean(5, resultat.isPublie());

            if (resultat.getDate_publication() == null
                    || resultat.getDate_publication().trim().isEmpty()) {
                ps.setNull(6, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(6, resultat.getDate_publication());
            }

            ps.setInt(7, resultat.getId_resultat());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean publier(int id_resultat) {
        String sql = "UPDATE resultat SET "
                + "publie = 1, "
                + "date_publication = NOW() "
                + "WHERE id_resultat = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_resultat);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean depublier(int id_resultat) {
        String sql = "UPDATE resultat SET "
                + "publie = 0, "
                + "date_publication = NULL "
                + "WHERE id_resultat = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_resultat);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean supprimer(int id_resultat) {
        String sql = "DELETE FROM resultat "
                + "WHERE id_resultat = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_resultat);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private ResultatModele remplirModele(ResultSet rs)
            throws SQLException {

        ResultatModele resultat = new ResultatModele();

        resultat.setId_resultat(
                rs.getInt("id_resultat")
        );

        resultat.setId_inscription(
                rs.getInt("id_inscription")
        );

        int rang = rs.getInt("rang");

        if (rs.wasNull()) {
            resultat.setRang(null);
        } else {
            resultat.setRang(rang);
        }

        double note = rs.getDouble("note_finale");

        if (rs.wasNull()) {
            resultat.setNote_finale(null);
        } else {
            resultat.setNote_finale(note);
        }

        resultat.setDecision(
                rs.getString("decision")
        );

        resultat.setPublie(
                rs.getBoolean("publie")
        );

        resultat.setDate_publication(
                rs.getString("date_publication")
        );

        return resultat;
    }
}
