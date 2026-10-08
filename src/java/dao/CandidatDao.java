package dao;

import common.AccesBdd;
import modele.CandidatModele;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidatDao {

    private AccesBdd db;

    public CandidatDao() {
        db = new AccesBdd();
    }

    // ============================================================
    // AJOUTER UN CANDIDAT
    // ============================================================
    public boolean ajouter(CandidatModele candidat) {

        String sql = "INSERT INTO candidat " +
                "(numero_candidat, nom, prenom, date_naissance, lieu_naissance, " +
                "sexe, numero_copie, cin, telephone, email, adresse) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    sql,
                    Statement.RETURN_GENERATED_KEYS
            );

            ps.setString(1, candidat.getNumero_candidat());
            ps.setString(2, candidat.getNom());
            ps.setString(3, candidat.getPrenom());
            ps.setString(4, candidat.getDate_naissance());
            ps.setString(5, candidat.getLieu_naissance());
            ps.setString(6, candidat.getSexe());
            ps.setString(7, candidat.getNumero_copie());
            ps.setString(8, candidat.getCin());
            ps.setString(9, candidat.getTelephone());
            ps.setString(10, candidat.getEmail());
            ps.setString(11, candidat.getAdresse());

            int lignes = ps.executeUpdate();

            if (lignes > 0) {

                ResultSet rs = ps.getGeneratedKeys();

                if (rs.next()) {
                    candidat.setId_candidat(rs.getInt(1));
                }

                rs.close();
                ps.close();

                return true;
            }

            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ============================================================
    // TROUVER PAR ID
    // ============================================================
    public CandidatModele trouverParId(int id_candidat) {

        String sql = "SELECT * FROM candidat WHERE id_candidat = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id_candidat);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                CandidatModele candidat = mapper(rs);

                rs.close();
                ps.close();

                return candidat;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER PAR NUMERO CANDIDAT
    // ============================================================
    public CandidatModele trouverParNumero(String numero_candidat) {

        String sql = "SELECT * FROM candidat WHERE numero_candidat = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, numero_candidat);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                CandidatModele candidat = mapper(rs);

                rs.close();
                ps.close();

                return candidat;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER PAR CIN
    // ============================================================
    public CandidatModele trouverParCin(String cin) {

        String sql = "SELECT * FROM candidat WHERE cin = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cin);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                CandidatModele candidat = mapper(rs);

                rs.close();
                ps.close();

                return candidat;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER PAR NUMERO COPIE
    // ============================================================
    public CandidatModele trouverParNumeroCopie(String numero_copie) {

        String sql = "SELECT * FROM candidat WHERE numero_copie = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, numero_copie);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                CandidatModele candidat = mapper(rs);

                rs.close();
                ps.close();

                return candidat;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER TOUS LES CANDIDATS
    // ============================================================
    public List<CandidatModele> trouverTous() {

        List<CandidatModele> candidats = new ArrayList<>();

        String sql = "SELECT * FROM candidat ORDER BY id_candidat DESC";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                candidats.add(mapper(rs));
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return candidats;
    }

    // ============================================================
    // MODIFIER
    // ============================================================
    public boolean modifier(CandidatModele candidat) {

        String sql = "UPDATE candidat SET " +
                "numero_candidat = ?, " +
                "nom = ?, " +
                "prenom = ?, " +
                "date_naissance = ?, " +
                "lieu_naissance = ?, " +
                "sexe = ?, " +
                "numero_copie = ?, " +
                "cin = ?, " +
                "telephone = ?, " +
                "email = ?, " +
                "adresse = ? " +
                "WHERE id_candidat = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, candidat.getNumero_candidat());
            ps.setString(2, candidat.getNom());
            ps.setString(3, candidat.getPrenom());
            ps.setString(4, candidat.getDate_naissance());
            ps.setString(5, candidat.getLieu_naissance());
            ps.setString(6, candidat.getSexe());
            ps.setString(7, candidat.getNumero_copie());
            ps.setString(8, candidat.getCin());
            ps.setString(9, candidat.getTelephone());
            ps.setString(10, candidat.getEmail());
            ps.setString(11, candidat.getAdresse());
            ps.setInt(12, candidat.getId_candidat());

            int lignes = ps.executeUpdate();

            ps.close();

            return lignes > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ============================================================
    // SUPPRIMER
    // ============================================================
    public boolean supprimer(int id_candidat) {

        String sql = "DELETE FROM candidat WHERE id_candidat = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id_candidat);

            int lignes = ps.executeUpdate();

            ps.close();

            return lignes > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ============================================================
    // VERIFIER SI CIN EXISTE
    // ============================================================
    public boolean existeCin(String cin) {

        if (cin == null || cin.trim().isEmpty()) {
            return false;
        }

        String sql = "SELECT COUNT(*) FROM candidat WHERE cin = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cin);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                boolean existe = rs.getInt(1) > 0;

                rs.close();
                ps.close();

                return existe;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ============================================================
    // VERIFIER SI NUMERO COPIE EXISTE
    // ============================================================
    public boolean existeNumeroCopie(String numero_copie) {

        if (numero_copie == null || numero_copie.trim().isEmpty()) {
            return false;
        }

        String sql = "SELECT COUNT(*) FROM candidat WHERE numero_copie = ?";

        try {
            Connection conn = db.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, numero_copie);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                boolean existe = rs.getInt(1) > 0;

                rs.close();
                ps.close();

                return existe;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ============================================================
    // MAPPER
    // ============================================================
    private CandidatModele mapper(ResultSet rs) throws SQLException {

        CandidatModele candidat = new CandidatModele();

        candidat.setId_candidat(
                rs.getInt("id_candidat")
        );

        candidat.setNumero_candidat(
                rs.getString("numero_candidat")
        );

        candidat.setNom(
                rs.getString("nom")
        );

        candidat.setPrenom(
                rs.getString("prenom")
        );

        candidat.setDate_naissance(
                rs.getString("date_naissance")
        );

        candidat.setLieu_naissance(
                rs.getString("lieu_naissance")
        );

        candidat.setSexe(
                rs.getString("sexe")
        );

        candidat.setNumero_copie(
                rs.getString("numero_copie")
        );

        candidat.setCin(
                rs.getString("cin")
        );

        candidat.setTelephone(
                rs.getString("telephone")
        );

        candidat.setEmail(
                rs.getString("email")
        );

        candidat.setAdresse(
                rs.getString("adresse")
        );

        candidat.setDate_creation(
                rs.getString("date_creation")
        );

        return candidat;
    }
}