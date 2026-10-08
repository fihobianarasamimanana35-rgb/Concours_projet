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
import modele.DossierModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DossierDao {

    private AccesBdd accesBdd;

    public DossierDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(DossierModele dossier) {
        String sql = "INSERT INTO dossier "
                + "(id_inscription, niveau_etude, diplome, "
                + "annee_diplome, etablissement, complet, "
                + "date_verification, motif_incomplet) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, dossier.getId_inscription());
            ps.setString(2, dossier.getNiveau_etude());
            ps.setString(3, dossier.getDiplome());
            ps.setInt(4, dossier.getAnnee_diplome());
            ps.setString(5, dossier.getEtablissement());
            ps.setBoolean(6, dossier.isComplet());

            if (dossier.getDate_verification() == null
                    || dossier.getDate_verification().trim().isEmpty()) {
                ps.setNull(7, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(7, dossier.getDate_verification());
            }

            if (dossier.getMotif_incomplet() == null
                    || dossier.getMotif_incomplet().trim().isEmpty()) {
                ps.setNull(8, java.sql.Types.VARCHAR);
            } else {
                ps.setString(8, dossier.getMotif_incomplet());
            }

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        dossier.setId_dossier(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public DossierModele trouverParId(int id_dossier) {
        String sql = "SELECT * FROM dossier "
                + "WHERE id_dossier = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);

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

    public DossierModele trouverParInscription(
            int id_inscription) {

        String sql = "SELECT * FROM dossier "
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

    public List<DossierModele> trouverTous() {
        List<DossierModele> dossiers = new ArrayList<>();

        String sql = "SELECT * FROM dossier "
                + "ORDER BY id_dossier DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                dossiers.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dossiers;
    }

    public List<DossierModele> trouverComplets() {
        List<DossierModele> dossiers = new ArrayList<>();

        String sql = "SELECT * FROM dossier "
                + "WHERE complet = 1 "
                + "ORDER BY id_dossier DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                dossiers.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dossiers;
    }

    public List<DossierModele> trouverIncomplets() {
        List<DossierModele> dossiers = new ArrayList<>();

        String sql = "SELECT * FROM dossier "
                + "WHERE complet = 0 "
                + "ORDER BY id_dossier DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                dossiers.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dossiers;
    }

    public boolean modifier(DossierModele dossier) {
        String sql = "UPDATE dossier SET "
                + "id_inscription = ?, "
                + "niveau_etude = ?, "
                + "diplome = ?, "
                + "annee_diplome = ?, "
                + "etablissement = ?, "
                + "complet = ?, "
                + "date_verification = ?, "
                + "motif_incomplet = ? "
                + "WHERE id_dossier = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, dossier.getId_inscription());
            ps.setString(2, dossier.getNiveau_etude());
            ps.setString(3, dossier.getDiplome());
            ps.setInt(4, dossier.getAnnee_diplome());
            ps.setString(5, dossier.getEtablissement());
            ps.setBoolean(6, dossier.isComplet());

            if (dossier.getDate_verification() == null
                    || dossier.getDate_verification().trim().isEmpty()) {
                ps.setNull(7, java.sql.Types.TIMESTAMP);
            } else {
                ps.setString(7, dossier.getDate_verification());
            }

            if (dossier.getMotif_incomplet() == null
                    || dossier.getMotif_incomplet().trim().isEmpty()) {
                ps.setNull(8, java.sql.Types.VARCHAR);
            } else {
                ps.setString(8, dossier.getMotif_incomplet());
            }

            ps.setInt(9, dossier.getId_dossier());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean marquerComplet(int id_dossier) {
        String sql = "UPDATE dossier SET "
                + "complet = 1, "
                + "date_verification = NOW(), "
                + "motif_incomplet = NULL "
                + "WHERE id_dossier = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean marquerIncomplet(
            int id_dossier,
            String motif) {

        String sql = "UPDATE dossier SET "
                + "complet = 0, "
                + "date_verification = NOW(), "
                + "motif_incomplet = ? "
                + "WHERE id_dossier = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, motif);
            ps.setInt(2, id_dossier);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean supprimer(int id_dossier) {
        String sql = "DELETE FROM dossier "
                + "WHERE id_dossier = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private DossierModele remplirModele(ResultSet rs)
            throws SQLException {

        DossierModele dossier = new DossierModele();

        dossier.setId_dossier(rs.getInt("id_dossier"));
        dossier.setId_inscription(rs.getInt("id_inscription"));
        dossier.setNiveau_etude(rs.getString("niveau_etude"));
        dossier.setDiplome(rs.getString("diplome"));
        dossier.setAnnee_diplome(rs.getInt("annee_diplome"));
        dossier.setEtablissement(rs.getString("etablissement"));
        dossier.setComplet(rs.getBoolean("complet"));
        dossier.setDate_creation(rs.getString("date_creation"));
        dossier.setDate_verification(
                rs.getString("date_verification")
        );
        dossier.setMotif_incomplet(
                rs.getString("motif_incomplet")
        );

        return dossier;
    }
}