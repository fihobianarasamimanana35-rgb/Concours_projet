package dao;

import common.AccesBdd;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO des statistiques.
 *
 * Les statistiques sont calculées directement
 * depuis les tables existantes.
 */
public class StatistiquesDao {

    private final AccesBdd accesBdd;

    public StatistiquesDao() {
        accesBdd = new AccesBdd();
    }

    /**
     * Nombre total de dossiers.
     */
    public int compterDossiers() {

        String sql = "SELECT COUNT(*) FROM dossier";

        return compter(sql);
    }

    /**
     * Nombre de dossiers complets.
     */
    public int compterDossiersComplets() {

        String sql =
                "SELECT COUNT(*) FROM dossier WHERE complet = 1";

        return compter(sql);
    }

    /**
     * Nombre de dossiers incomplets.
     */
    public int compterDossiersIncomplets() {

        String sql =
                "SELECT COUNT(*) FROM dossier WHERE complet = 0";

        return compter(sql);
    }

    /**
     * Nombre total de documents.
     */
    public int compterDocuments() {

        String sql =
                "SELECT COUNT(*) FROM document";

        return compter(sql);
    }

    /**
     * Nombre de documents conformes.
     */
    public int compterDocumentsConformes() {

        String sql =
                "SELECT COUNT(*) FROM document WHERE conforme = 1";

        return compter(sql);
    }

    /**
     * Nombre de documents non conformes.
     */
    public int compterDocumentsNonConformes() {

        String sql =
                "SELECT COUNT(*) FROM document WHERE conforme = 0";

        return compter(sql);
    }

    /**
     * Nombre total de résultats.
     */
    public int compterResultats() {

        String sql =
                "SELECT COUNT(*) FROM resultat";

        return compter(sql);
    }

    /**
     * Nombre de résultats publiés.
     */
    public int compterResultatsPublies() {

        String sql =
                "SELECT COUNT(*) FROM resultat WHERE publie = 1";

        return compter(sql);
    }

    /**
     * Nombre de résultats non publiés.
     */
    public int compterResultatsNonPublies() {

        String sql =
                "SELECT COUNT(*) FROM resultat WHERE publie = 0";

        return compter(sql);
    }

    /**
     * Nombre de résultats selon la décision.
     */
    public int compterDecision(String decision) {

        String sql =
                "SELECT COUNT(*) FROM resultat WHERE decision = ?";

        Connection conn = null;

        try {

            conn = accesBdd.getConnection();

            if (conn == null) {
                return 0;
            }

            try (PreparedStatement ps =
                         conn.prepareStatement(sql)) {

                ps.setString(1, decision);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {

            System.out.println(
                    "Erreur statistiques décision : "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Méthode générique pour COUNT(*).
     */
    private int compter(String sql) {

        Connection conn = null;

        try {

            conn = accesBdd.getConnection();

            if (conn == null) {
                return 0;
            }

            try (PreparedStatement ps =
                         conn.prepareStatement(sql);

                 ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {

            System.out.println(
                    "Erreur statistiques : "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return 0;
    }
}