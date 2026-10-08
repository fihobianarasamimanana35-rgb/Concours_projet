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
import modele.DocumentModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DocumentDao {

    private AccesBdd accesBdd;

    public DocumentDao() {
        accesBdd = new AccesBdd();
    }

    public boolean ajouter(DocumentModele document) {
        String sql = "INSERT INTO document "
                + "(id_dossier, type_document, nom_fichier, "
                + "nom_original, chemin_fichier, extension, "
                + "taille_octets, conforme) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, document.getId_dossier());
            ps.setString(2, document.getType_document());
            ps.setString(3, document.getNom_fichier());
            ps.setString(4, document.getNom_original());
            ps.setString(5, document.getChemin_fichier());
            ps.setString(6, document.getExtension());
            ps.setLong(7, document.getTaille_octets());
            ps.setBoolean(8, document.isConforme());

            int result = ps.executeUpdate();

            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        document.setId_document(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public DocumentModele trouverParId(int id_document) {
        String sql = "SELECT * FROM document "
                + "WHERE id_document = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_document);

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

    public DocumentModele trouverParType(
            int id_dossier,
            String type_document) {

        String sql = "SELECT * FROM document "
                + "WHERE id_dossier = ? "
                + "AND type_document = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);
            ps.setString(2, type_document);

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

    public List<DocumentModele> trouverParDossier(
            int id_dossier) {

        List<DocumentModele> documents = new ArrayList<>();

        String sql = "SELECT * FROM document "
                + "WHERE id_dossier = ? "
                + "ORDER BY id_document ASC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    documents.add(remplirModele(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return documents;
    }
public boolean tousDocumentsConformes(int idDossier) {

    String sql = "SELECT " +
                 "COUNT(DISTINCT type_document) AS total, " +
                 "COUNT(DISTINCT CASE WHEN conforme = 1 THEN type_document END) AS conformes " +
                 "FROM document " +
                 "WHERE id_dossier = ? " +
                 "AND type_document IN ('cin', 'copie', 'diplome_bacc', 'photo')";

    try (Connection conn = accesBdd.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, idDossier);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                int total = rs.getInt("total");
                int conformes = rs.getInt("conformes");

                return total == 4 && conformes == 4;
            }

        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;
}
    public List<DocumentModele> trouverTous() {
        List<DocumentModele> documents = new ArrayList<>();

        String sql = "SELECT * FROM document "
                + "ORDER BY id_document DESC";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                documents.add(remplirModele(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return documents;
    }

    public boolean modifier(DocumentModele document) {
        String sql = "UPDATE document SET "
                + "id_dossier = ?, "
                + "type_document = ?, "
                + "nom_fichier = ?, "
                + "nom_original = ?, "
                + "chemin_fichier = ?, "
                + "extension = ?, "
                + "taille_octets = ?, "
                + "conforme = ? "
                + "WHERE id_document = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, document.getId_dossier());
            ps.setString(2, document.getType_document());
            ps.setString(3, document.getNom_fichier());
            ps.setString(4, document.getNom_original());
            ps.setString(5, document.getChemin_fichier());
            ps.setString(6, document.getExtension());
            ps.setLong(7, document.getTaille_octets());
            ps.setBoolean(8, document.isConforme());
            ps.setInt(9, document.getId_document());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean changerConformite(
            int id_document,
            boolean conforme) {

        String sql = "UPDATE document "
                + "SET conforme = ? "
                + "WHERE id_document = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, conforme);
            ps.setInt(2, id_document);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean existeTypeDocument(
            int id_dossier,
            String type_document) {

        String sql = "SELECT COUNT(*) FROM document "
                + "WHERE id_dossier = ? "
                + "AND type_document = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);
            ps.setString(2, type_document);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public int compterParDossier(int id_dossier) {
        String sql = "SELECT COUNT(*) FROM document "
                + "WHERE id_dossier = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int compterDocumentsConformes(int id_dossier) {
        String sql = "SELECT COUNT(*) FROM document "
                + "WHERE id_dossier = ? "
                + "AND conforme = 1";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_dossier);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean supprimer(int id_document) {
        String sql = "DELETE FROM document "
                + "WHERE id_document = ?";

        try (Connection conn = accesBdd.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id_document);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private DocumentModele remplirModele(ResultSet rs)
            throws SQLException {

        DocumentModele document = new DocumentModele();

        document.setId_document(
                rs.getInt("id_document")
        );

        document.setId_dossier(
                rs.getInt("id_dossier")
        );

        document.setType_document(
                rs.getString("type_document")
        );

        document.setNom_fichier(
                rs.getString("nom_fichier")
        );

        document.setNom_original(
                rs.getString("nom_original")
        );

        document.setChemin_fichier(
                rs.getString("chemin_fichier")
        );

        document.setExtension(
                rs.getString("extension")
        );

        document.setTaille_octets(
                rs.getLong("taille_octets")
        );

        document.setConforme(
                rs.getBoolean("conforme")
        );

        document.setDate_upload(
                rs.getString("date_upload")
        );

        return document;
    }
}