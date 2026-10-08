
package dao;

import common.AccesBdd;
import modele.InscriptionModele;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;


/**
 * ============================================================
 * DAO INSCRIPTION
 * ============================================================
 *
 * Gestion de la table :
 *
 * inscription
 *
 * Champs :
 *
 * id_inscription
 * id_candidat
 * id_concours
 * numero_inscription
 * code_suivi
 * date_inscription
 * statut
 * motif_rejet
 * date_validation
 *
 * Statuts autorisés par la base :
 *
 * en_attente
 * valide
 * rejete
 */
public class InscriptionDao {

    // ============================================================
    // CONSTANTES DES STATUTS
    // ============================================================

    public static final String STATUT_EN_ATTENTE =
            "en_attente";

    public static final String STATUT_VALIDE =
            "valide";

    public static final String STATUT_REJETE =
            "rejete";

    // ============================================================
    // AJOUTER UNE INSCRIPTION
    // ============================================================

    /**
     * Ajoute une nouvelle inscription.
     *
     * L'inscription est normalement créée avec :
     *
     * statut = en_attente
     *
     * @param inscription inscription à enregistrer
     * @return true si l'insertion réussit
     */
    private AccesBdd AccesBdd;

    public InscriptionDao() {
        AccesBdd = new AccesBdd();
    }
    public boolean ajouter(
            InscriptionModele inscription) {

        String sql =
                "INSERT INTO inscription "
                + "(id_candidat, "
                + "id_concours, "
                + "numero_inscription, "
                + "code_suivi, "
                + "statut, "
                + "motif_rejet, "
                + "date_validation) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            ps.setInt(
                    1,
                    inscription.getId_candidat()
            );

            ps.setInt(
                    2,
                    inscription.getId_concours()
            );

            ps.setString(
                    3,
                    inscription.getNumero_inscription()
            );

            ps.setString(
                    4,
                    inscription.getCode_suivi()
            );

            /*
             * IMPORTANT :
             *
             * Si aucun statut n'est fourni,
             * on utilise en_attente.
             */
            String statut =
                    inscription.getStatut();

            if (statut == null
                    || statut.trim().isEmpty()) {

                statut =
                        STATUT_EN_ATTENTE;
            }

            /*
             * Sécurité :
             * seuls les statuts de la base sont acceptés.
             */
            if (!statutValide(statut)) {

                statut =
                        STATUT_EN_ATTENTE;
            }

            ps.setString(
                    5,
                    statut
            );

            /*
             * motif_rejet
             */
            if (inscription.getMotif_rejet() == null
                    || inscription.getMotif_rejet()
                            .trim()
                            .isEmpty()) {

                ps.setNull(
                        6,
                        java.sql.Types.VARCHAR
                );

            } else {

                ps.setString(
                        6,
                        inscription.getMotif_rejet()
                );
            }

            /*
             * date_validation
             *
             * Une nouvelle inscription n'est normalement
             * pas encore validée.
             */
            if (inscription.getDate_validation() == null
                    || inscription.getDate_validation()
                            .trim()
                            .isEmpty()) {

                ps.setNull(
                        7,
                        java.sql.Types.TIMESTAMP
                );

            } else {

                ps.setTimestamp(
                        7,
                        convertirTimestamp(
                                inscription.getDate_validation()
                        )
                );
            }

            int resultat =
                    ps.executeUpdate();

            if (resultat == 0) {
                return false;
            }

            /*
             * Récupération de l'ID AUTO_INCREMENT.
             */
            try (
                    ResultSet rs =
                            ps.getGeneratedKeys()
            ) {

                if (rs.next()) {

                    inscription.setId_inscription(
                            rs.getInt(1)
                    );
                }
            }

            /*
             * Si la base a généré automatiquement
             * date_inscription, on n'a pas besoin
             * de la modifier.
             */
            return true;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // ============================================================
    // TROUVER PAR ID
    // ============================================================

    public InscriptionModele trouverParId(
            int idInscription) {

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "WHERE id_inscription = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    idInscription
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return mapper(
                            rs
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER PAR NUMÉRO INSCRIPTION
    // ============================================================

    public InscriptionModele trouverParNumero(
            String numeroInscription) {

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "WHERE numero_inscription = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    numeroInscription
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return mapper(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER PAR CODE DE SUIVI
    // ============================================================

    public InscriptionModele trouverParCodeSuivi(
            String codeSuivi) {

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "WHERE code_suivi = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    codeSuivi
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return mapper(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // ============================================================
    // TROUVER TOUTES LES INSCRIPTIONS
    // ============================================================

    public List<InscriptionModele> trouverTous() {

        List<InscriptionModele> liste =
                new ArrayList<>();

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "ORDER BY date_inscription DESC";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                liste.add(
                        mapper(rs)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return liste;
    }

    // ============================================================
    // TROUVER PAR CANDIDAT
    // ============================================================

    public List<InscriptionModele> trouverParCandidat(
            int idCandidat) {

        List<InscriptionModele> liste =
                new ArrayList<>();

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "WHERE id_candidat = ? "
                + "ORDER BY date_inscription DESC";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    idCandidat
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    liste.add(
                            mapper(rs)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return liste;
    }

    // ============================================================
    // TROUVER PAR CONCOURS
    // ============================================================

    public List<InscriptionModele> trouverParConcours(
            int idConcours) {

        List<InscriptionModele> liste =
                new ArrayList<>();

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "WHERE id_concours = ? "
                + "ORDER BY date_inscription DESC";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    idConcours
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    liste.add(
                            mapper(rs)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return liste;
    }

    // ============================================================
    // TROUVER PAR STATUT
    // ============================================================

    public List<InscriptionModele> trouverParStatut(
            String statut) {

        List<InscriptionModele> liste =
                new ArrayList<>();

        if (!statutValide(statut)) {
            return liste;
        }

        String sql =
                "SELECT * "
                + "FROM inscription "
                + "WHERE statut = ? "
                + "ORDER BY date_inscription DESC";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    statut
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    liste.add(
                            mapper(rs)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return liste;
    }

    // ============================================================
    // VÉRIFIER SI INSCRIPTION EXISTE
    // ============================================================

    /**
     * Vérifie si un candidat est déjà inscrit
     * à un concours.
     */
    public boolean existeInscription(
            int idCandidat,
            int idConcours) {

        String sql =
                "SELECT COUNT(*) "
                + "FROM inscription "
                + "WHERE id_candidat = ? "
                + "AND id_concours = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    idCandidat
            );

            ps.setInt(
                    2,
                    idConcours
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    // ============================================================
    // MODIFIER INSCRIPTION
    // ============================================================

    public boolean modifier(
            InscriptionModele inscription) {

        String sql =
                "UPDATE inscription "
                + "SET id_candidat = ?, "
                + "id_concours = ?, "
                + "numero_inscription = ?, "
                + "code_suivi = ?, "
                + "statut = ?, "
                + "motif_rejet = ?, "
                + "date_validation = ? "
                + "WHERE id_inscription = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    inscription.getId_candidat()
            );

            ps.setInt(
                    2,
                    inscription.getId_concours()
            );

            ps.setString(
                    3,
                    inscription.getNumero_inscription()
            );

            ps.setString(
                    4,
                    inscription.getCode_suivi()
            );

            String statut =
                    inscription.getStatut();

            if (!statutValide(statut)) {

                return false;
            }

            ps.setString(
                    5,
                    statut
            );

            if (inscription.getMotif_rejet() == null
                    || inscription.getMotif_rejet()
                            .trim()
                            .isEmpty()) {

                ps.setNull(
                        6,
                        java.sql.Types.VARCHAR
                );

            } else {

                ps.setString(
                        6,
                        inscription.getMotif_rejet()
                );
            }

            /*
             * Date validation.
             */
            if (inscription.getDate_validation() == null
                    || inscription.getDate_validation()
                            .trim()
                            .isEmpty()) {

                ps.setNull(
                        7,
                        java.sql.Types.TIMESTAMP
                );

            } else {

                ps.setTimestamp(
                        7,
                        convertirTimestamp(
                                inscription.getDate_validation()
                        )
                );
            }

            ps.setInt(
                    8,
                    inscription.getId_inscription()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // ============================================================
    // VALIDER INSCRIPTION
    // ============================================================

    /**
     * Validation administrative.
     *
     * Statut :
     *
     * valide
     */
    public boolean valider(
            int idInscription) {

        String sql =
                "UPDATE inscription "
                + "SET statut = ?, "
                + "motif_rejet = NULL, "
                + "date_validation = NOW() "
                + "WHERE id_inscription = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    STATUT_VALIDE
            );

            ps.setInt(
                    2,
                    idInscription
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // ============================================================
    // REJETER INSCRIPTION
    // ============================================================

    /**
     * Rejet administratif.
     */
    public boolean rejeter(
            int idInscription,
            String motifRejet) {

        String sql =
                "UPDATE inscription "
                + "SET statut = ?, "
                + "motif_rejet = ?, "
                + "date_validation = NOW() "
                + "WHERE id_inscription = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    STATUT_REJETE
            );

            if (motifRejet == null
                    || motifRejet.trim().isEmpty()) {

                ps.setNull(
                        2,
                        java.sql.Types.VARCHAR
                );

            } else {

                ps.setString(
                        2,
                        motifRejet
                );
            }

            ps.setInt(
                    3,
                    idInscription
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // ============================================================
    // VALIDER AUTOMATIQUEMENT
    // ============================================================

    /**
     * Méthode conservée pour compatibilité
     * avec le reste du projet.
     *
     * IMPORTANT :
     * la valeur utilisée est maintenant "valide"
     * et non "Validee".
     */
    public boolean validerAutomatiquement(
            int idInscription) {

        return valider(
                idInscription
        );
    }

    // ============================================================
    // REJETER AUTOMATIQUEMENT
    // ============================================================

    /**
     * Méthode conservée pour compatibilité.
     *
     * IMPORTANT :
     * la valeur utilisée est "rejete"
     * et non "Rejetee".
     */
    public boolean rejeterAutomatiquement(
            int idInscription,
            String motifRejet) {

        return rejeter(
                idInscription,
                motifRejet
        );
    }

    // ============================================================
    // SUPPRIMER
    // ============================================================

    public boolean supprimer(
            int idInscription) {

        String sql =
                "DELETE FROM inscription "
                + "WHERE id_inscription = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    idInscription
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // ============================================================
    // COMPTER PAR CONCOURS
    // ============================================================

    public int compterParConcours(
            int idConcours) {

        String sql =
                "SELECT COUNT(*) "
                + "FROM inscription "
                + "WHERE id_concours = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    idConcours
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }

    // ============================================================
    // COMPTER PAR STATUT
    // ============================================================

    public int compterParStatut(
            String statut) {

        if (!statutValide(statut)) {
            return 0;
        }

        String sql =
                "SELECT COUNT(*) "
                + "FROM inscription "
                + "WHERE statut = ?";

        try (
                Connection connexion =
                        AccesBdd.getConnection();

                PreparedStatement ps =
                        connexion.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    statut
            );

            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }

    // ============================================================
    // COMPTER INSCRIPTIONS EN ATTENTE
    // ============================================================

    public int compterEnAttente() {

        return compterParStatut(
                STATUT_EN_ATTENTE
        );
    }

    // ============================================================
    // COMPTER INSCRIPTIONS VALIDÉES
    // ============================================================

    public int compterValidees() {

        return compterParStatut(
                STATUT_VALIDE
        );
    }

    // ============================================================
    // COMPTER INSCRIPTIONS REJETÉES
    // ============================================================

    public int compterRejetees() {

        return compterParStatut(
                STATUT_REJETE
        );
    }

    // ============================================================
    // MAPPER RESULTSET → MODELE
    // ============================================================

    private InscriptionModele mapper(
            ResultSet rs)
            throws Exception {

        InscriptionModele inscription =
                new InscriptionModele();

        inscription.setId_inscription(
                rs.getInt(
                        "id_inscription"
                )
        );

        inscription.setId_candidat(
                rs.getInt(
                        "id_candidat"
                )
        );

        inscription.setId_concours(
                rs.getInt(
                        "id_concours"
                )
        );

        inscription.setNumero_inscription(
                rs.getString(
                        "numero_inscription"
                )
        );

        inscription.setCode_suivi(
                rs.getString(
                        "code_suivi"
                )
        );

        /*
         * date_inscription
         */
        java.sql.Timestamp dateInscription =
                rs.getTimestamp(
                        "date_inscription"
                );

        if (dateInscription != null) {

            inscription.setDate_inscription(
                    dateInscription
                            .toLocalDateTime()
                            .toString()
            );
        } else {

            inscription.setDate_inscription(
                    null
            );
        }

        /*
         * statut
         */
        inscription.setStatut(
                rs.getString(
                        "statut"
                )
        );

        /*
         * motif rejet
         */
        inscription.setMotif_rejet(
                rs.getString(
                        "motif_rejet"
                )
        );

        /*
         * date validation
         */
        java.sql.Timestamp dateValidation =
                rs.getTimestamp(
                        "date_validation"
                );

        if (dateValidation != null) {

            inscription.setDate_validation(
                    dateValidation
                            .toLocalDateTime()
                            .toString()
            );

        } else {

            inscription.setDate_validation(
                    null
            );
        }

        return inscription;
    }

    // ============================================================
    // VÉRIFIER STATUT
    // ============================================================

    private boolean statutValide(
            String statut) {

        if (statut == null) {
            return false;
        }

        return STATUT_EN_ATTENTE.equals(statut)
                || STATUT_VALIDE.equals(statut)
                || STATUT_REJETE.equals(statut);
    }

    // ============================================================
    // CONVERTIR STRING → TIMESTAMP
    // ============================================================

    private java.sql.Timestamp convertirTimestamp(
            String valeur) {

        if (valeur == null
                || valeur.trim().isEmpty()) {

            return null;
        }

        try {

            /*
             * Exemple :
             *
             * 2026-10-07T13:45:30
             */
            return java.sql.Timestamp.valueOf(
                    valeur.replace(
                            "T",
                            " "
                    )
            );

        } catch (Exception e) {

            return null;
        }
    }
}
