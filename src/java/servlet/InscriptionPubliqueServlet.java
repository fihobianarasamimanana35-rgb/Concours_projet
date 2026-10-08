package servlet;

import dao.CandidatDao;
import dao.ConcoursDao;
import dao.DocumentDao;
import dao.DossierDao;
import dao.InscriptionDao;

import modele.CandidatModele;
import modele.ConcoursModele;
import modele.DocumentModele;
import modele.DossierModele;
import modele.InscriptionModele;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;

import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * ================================================================
 * INSCRIPTION PUBLIQUE
 * ================================================================
 *
 * CHEMINS REELS DU PROJET :
 *
 * Web Pages/
 * ├── concours/
 * │   ├── liste.jsp
 * │   └── details.jsp
 * │
 * └── inscription/
 *     ├── candidat.jsp
 *     ├── dossier.jsp
 *     ├── documents.jsp
 *     ├── validation.jsp
 *     └── confirmation.jsp
 *
 * URL UNIQUE DU SERVLET :
 *
 * /InscriptionPubliqueServlet
 *
 * FLUX :
 *
 * commencer
 *      ↓
 * candidat
 *      ↓
 * dossier
 *      ↓
 * documents
 *      ↓
 * confirmation
 *
 * POST :
 *
 * candidat
 * dossier
 * document
 * valider
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 40 * 1024 * 1024
)
public class InscriptionPubliqueServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CandidatDao candidatDao;
    private ConcoursDao concoursDao;
    private InscriptionDao inscriptionDao;
    private DossierDao dossierDao;
    private DocumentDao documentDao;

    private static final DateTimeFormatter DATE_FORMAT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd");

    private static final long TAILLE_MAX_FICHIER =
            10L * 1024L * 1024L;

    // ============================================================
    // INITIALISATION
    // ============================================================

    @Override
    public void init() throws ServletException {

        candidatDao = new CandidatDao();
        concoursDao = new ConcoursDao();
        inscriptionDao = new InscriptionDao();
        dossierDao = new DossierDao();
        documentDao = new DocumentDao();
    }

    // ============================================================
    // GET
    // ============================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action =
                trim(request.getParameter("action"));

        if (action.isEmpty()) {
            action = "concours";
        }

        switch (action) {

            // ----------------------------------------------------
            // Bouton "S'inscrire à ce concours"
            // ----------------------------------------------------
            case "commencer":
                commencerInscription(request, response);
                break;
            case "suivi":
                afficherSuivi(request, response);
                break;
            // ----------------------------------------------------
            // Liste concours
            // ----------------------------------------------------
            case "concours":
                afficherConcours(request, response);
                break;

            // ----------------------------------------------------
            // Candidat
            // ----------------------------------------------------
            case "candidat":
                afficherCandidat(request, response);
                break;

            // ----------------------------------------------------
            // Dossier
            // ----------------------------------------------------
            case "dossier":
                afficherDossier(request, response);
                break;

            // ----------------------------------------------------
            // Documents
            // ----------------------------------------------------
            case "documents":
            case "document":
                afficherDocuments(request, response);
                break;

            // ----------------------------------------------------
            // Confirmation
            // ----------------------------------------------------
            case "confirmation":
                afficherConfirmation(request, response);
                break;

            // ----------------------------------------------------
            // URL inconnue
            // ----------------------------------------------------
            default:
                rediriger(
                        request,
                        response,
                        "concours"
                );
                break;
        }
    }

    // ============================================================
    // POST
    // ============================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action =
                trim(request.getParameter("action"));

        if (action.isEmpty()) {
            action = "concours";
        }

        switch (action) {

            case "concours":
                traiterConcours(request, response);
                break;
            case "suivi":
    afficherSuivi(request, response);
    break;
            case "candidat":
                traiterCandidat(request, response);
                break;

            case "dossier":
                traiterDossier(request, response);
                break;

            case "document":
            case "documents":
                traiterDocument(request, response);
                break;

            case "valider":
                traiterValidationFinale(request, response);
                break;

            default:
                rediriger(
                        request,
                        response,
                        "concours"
                );
                break;
        }
    }

    // ============================================================
    // REDIRECTION CENTRALE
    // ============================================================

    private void rediriger(
            HttpServletRequest request,
            HttpServletResponse response,
            String action)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                + "/InscriptionPubliqueServlet?action="
                + action
        );
    }

    // ============================================================
    // ETAPE 1
    // COMMENCER INSCRIPTION
    // ============================================================
/**
 * Affiche la page de suivi d'une inscription.
 *
 * GET :
 * /InscriptionPubliqueServlet?action=suivi
 *
 * POST :
 * /InscriptionPubliqueServlet
 * action=suivi
 * code_suivi=XXXXXX
 */
private void afficherSuivi(HttpServletRequest request,
                           HttpServletResponse response)
        throws ServletException, IOException {

    String codeSuivi = request.getParameter("code_suivi");

    // Première ouverture de la page
    if (codeSuivi == null || codeSuivi.trim().isEmpty()) {
        request.getRequestDispatcher("/inscription/suivi.jsp")
               .forward(request, response);
        return;
    }

    codeSuivi = codeSuivi.trim();

    try {

        InscriptionDao inscriptionDao = new InscriptionDao();

        // Recherche de l'inscription avec le code de suivi
        InscriptionModele inscription =
                inscriptionDao.trouverParCodeSuivi(codeSuivi);

        // Aucun résultat
        if (inscription == null) {
            request.setAttribute(
                    "erreur",
                    "Aucune inscription ne correspond à ce code de suivi."
            );

            request.setAttribute("code_suivi", codeSuivi);

            request.getRequestDispatcher("/inscription/suivi.jsp")
                   .forward(request, response);
            return;
        }

        // Récupération du candidat
        CandidatModele candidat = null;

        if (inscription.getId_candidat() > 0) {
            CandidatDao candidatDao = new CandidatDao();

            candidat =
                    candidatDao.trouverParId(
                            inscription.getId_candidat()
                    );
        }

        // Récupération du concours
        ConcoursModele concours = null;

        if (inscription.getId_concours() > 0) {
            ConcoursDao concoursDao = new ConcoursDao();

            concours =
                    concoursDao.trouverParId(
                            inscription.getId_concours()
                    );
        }

        // Données envoyées à suivi.jsp
        request.setAttribute("inscription", inscription);
        request.setAttribute("candidat", candidat);
        request.setAttribute("concours", concours);
        request.setAttribute("code_suivi", codeSuivi);

        request.getRequestDispatcher("/inscription/suivi.jsp")
               .forward(request, response);

    } catch (Exception e) {

        e.printStackTrace();

        request.setAttribute(
                "erreur",
                "Une erreur est survenue lors de la recherche de votre inscription."
        );

        request.setAttribute("code_suivi", codeSuivi);

        request.getRequestDispatcher("/inscription/suivi.jsp")
               .forward(request, response);
    }
}
    private void commencerInscription(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idConcoursParam =
                trim(request.getParameter("id_concours"));

        if (!estEntier(idConcoursParam)) {

            request.setAttribute(
                    "erreur",
                    "Le concours sélectionné est invalide."
            );

            afficherConcours(
                    request,
                    response
            );

            return;
        }

        int idConcours;

        try {

            idConcours =
                    Integer.parseInt(idConcoursParam);

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "erreur",
                    "Le concours sélectionné est invalide."
            );

            afficherConcours(
                    request,
                    response
            );

            return;
        }

        ConcoursModele concours =
                concoursDao.trouverParId(idConcours);

        if (concours == null) {

            request.setAttribute(
                    "erreur",
                    "Le concours sélectionné n'existe pas."
            );

            afficherConcours(
                    request,
                    response
            );

            return;
        }

        HttpSession session =
                request.getSession(true);

        // --------------------------------------------------------
        // Nettoyer l'ancienne inscription
        // --------------------------------------------------------

        session.removeAttribute(
                "inscription_id_candidat"
        );

        session.removeAttribute(
                "inscription_candidat"
        );

        session.removeAttribute(
                "inscription"
        );

        session.removeAttribute(
                "dossier"
        );

        // --------------------------------------------------------
        // Stocker le concours
        // --------------------------------------------------------

        session.setAttribute(
                "inscription_id_concours",
                idConcours
        );

        session.setAttribute(
                "inscription_concours",
                concours
        );

        // --------------------------------------------------------
        // REDIRECTION EXACTE
        // --------------------------------------------------------

        rediriger(
                request,
                response,
                "candidat"
        );
    }

    // ============================================================
    // ETAPE 1
    // AFFICHER CONCOURS
    // ============================================================

    private void afficherConcours(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<ConcoursModele> concours =
                    concoursDao.trouverTous();

            request.setAttribute(
                    "concours",
                    concours
            );

            /*
             * CHEMIN REEL :
             *
             * Web Pages/concours/liste.jsp
             */
            request.getRequestDispatcher(
                    "/concours/liste.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "erreur",
                    "Impossible de charger la liste des concours."
            );

            request.getRequestDispatcher(
                    "/concours/liste.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }

    // ============================================================
    // ETAPE 1
    // TRAITER CONCOURS
    // ============================================================

    private void traiterConcours(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idConcoursParam =
                trim(
                        request.getParameter(
                                "id_concours"
                        )
                );

        if (!estEntier(idConcoursParam)) {

            request.setAttribute(
                    "erreur",
                    "Veuillez sélectionner un concours valide."
            );

            afficherConcours(
                    request,
                    response
            );

            return;
        }

        int idConcours =
                Integer.parseInt(idConcoursParam);

        ConcoursModele concours =
                concoursDao.trouverParId(
                        idConcours
                );

        if (concours == null) {

            request.setAttribute(
                    "erreur",
                    "Le concours sélectionné n'existe pas."
            );

            afficherConcours(
                    request,
                    response
            );

            return;
        }

        HttpSession session =
                request.getSession(true);

        session.setAttribute(
                "inscription_id_concours",
                idConcours
        );

        session.setAttribute(
                "inscription_concours",
                concours
        );

        rediriger(
                request,
                response,
                "candidat"
        );
    }

    // ============================================================
    // ETAPE 2
    // AFFICHER CANDIDAT
    // ============================================================

    private void afficherCandidat(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription_id_concours"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        ConcoursModele concours =
                (ConcoursModele) session.getAttribute(
                        "inscription_concours"
                );

        request.setAttribute(
                "concours",
                concours
        );

        /*
         * CHEMIN REEL :
         *
         * Web Pages/inscription/candidat.jsp
         */
        request.getRequestDispatcher(
                "/inscription/candidat.jsp"
        ).forward(
                request,
                response
        );
    }

    // ============================================================
    // ETAPE 2
    // TRAITER CANDIDAT
    // ============================================================

    private void traiterCandidat(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription_id_concours"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        Integer idConcours =
                (Integer) session.getAttribute(
                        "inscription_id_concours"
                );

        // --------------------------------------------------------
        // Champs
        // --------------------------------------------------------

        String nom =
                trim(request.getParameter("nom"));

        String prenom =
                trim(request.getParameter("prenom"));

        String dateNaissance =
                trim(
                        request.getParameter(
                                "date_naissance"
                        )
                );

        String lieuNaissance =
                trim(
                        request.getParameter(
                                "lieu_naissance"
                        )
                );

        String sexe =
                trim(request.getParameter("sexe"));

        String cin =
                trim(request.getParameter("cin"));

        String numeroCopie =
                trim(
                        request.getParameter(
                                "numero_copie"
                        )
                );

        String telephone =
                trim(
                        request.getParameter(
                                "telephone"
                        )
                );

        String email =
                trim(
                        request.getParameter(
                                "email"
                        )
                );

        String adresse =
                trim(
                        request.getParameter(
                                "adresse"
                        )
                );

        // --------------------------------------------------------
        // Champs obligatoires
        // --------------------------------------------------------

        if (nom.isEmpty()
                || prenom.isEmpty()
                || dateNaissance.isEmpty()
                || lieuNaissance.isEmpty()
                || sexe.isEmpty()
                || telephone.isEmpty()
                || email.isEmpty()
                || adresse.isEmpty()) {

            request.setAttribute(
                    "erreur",
                    "Veuillez remplir tous les champs obligatoires."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Sexe
        // --------------------------------------------------------

        if (!"M".equals(sexe)
                && !"F".equals(sexe)) {

            request.setAttribute(
                    "erreur",
                    "Le sexe sélectionné est invalide."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Date naissance
        // --------------------------------------------------------

        LocalDate dateNaissanceParsed;

        try {

            dateNaissanceParsed =
                    LocalDate.parse(
                            dateNaissance,
                            DATE_FORMAT
                    );

        } catch (Exception e) {

            request.setAttribute(
                    "erreur",
                    "La date de naissance est invalide."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        LocalDate aujourdHui =
                LocalDate.now();

        if (dateNaissanceParsed.isAfter(
                aujourdHui
        )) {

            request.setAttribute(
                    "erreur",
                    "La date de naissance ne peut pas être dans le futur."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        int age =
                Period.between(
                        dateNaissanceParsed,
                        aujourdHui
                ).getYears();

        if (age < 16) {

            request.setAttribute(
                    "erreur",
                    "Le candidat doit avoir au moins 16 ans."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // MAJEUR / MINEUR
        // --------------------------------------------------------

        if (age >= 18) {

            if (cin.isEmpty()) {

                request.setAttribute(
                        "erreur",
                        "La CIN est obligatoire pour un candidat majeur."
                );

                conserverParametresCandidat(
                        request
                );

                afficherCandidat(
                        request,
                        response
                );

                return;
            }

            if (!cin.matches(
                    "[0-9]{12}"
            )) {

                request.setAttribute(
                        "erreur",
                        "La CIN doit contenir exactement 12 chiffres."
                );

                conserverParametresCandidat(
                        request
                );

                afficherCandidat(
                        request,
                        response
                );

                return;
            }

            numeroCopie = null;

        } else {

            if (numeroCopie.isEmpty()) {

                request.setAttribute(
                        "erreur",
                        "Le numéro de copie est obligatoire pour un candidat mineur."
                );

                conserverParametresCandidat(
                        request
                );

                afficherCandidat(
                        request,
                        response
                );

                return;
            }

            cin = null;
        }

        // --------------------------------------------------------
        // Téléphone
        // --------------------------------------------------------

        if (!telephone.matches(
                "(032|033|034|037|038)[0-9]{7}"
        )) {

            request.setAttribute(
                    "erreur",
                    "Le numéro de téléphone est invalide."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Email
        // --------------------------------------------------------

        if (!email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
        )) {

            request.setAttribute(
                    "erreur",
                    "L'adresse email est invalide."
            );

            conserverParametresCandidat(
                    request
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        // ========================================================
        // RECHERCHE CANDIDAT
        // ========================================================

        CandidatModele candidatExistant;

        if (age >= 18) {

            candidatExistant =
                    candidatDao.trouverParCin(cin);

        } else {

            candidatExistant =
                    candidatDao.trouverParNumeroCopie(
                            numeroCopie
                    );
        }

        CandidatModele candidat;

        // ========================================================
        // CANDIDAT EXISTANT
        // ========================================================

        if (candidatExistant != null) {

            candidat =
                    candidatExistant;

            candidat.setNom(nom);
            candidat.setPrenom(prenom);
            candidat.setDate_naissance(
                    dateNaissance
            );
            candidat.setLieu_naissance(
                    lieuNaissance
            );
            candidat.setSexe(sexe);
            candidat.setCin(cin);
            candidat.setNumero_copie(
                    numeroCopie
            );
            candidat.setTelephone(
                    telephone
            );
            candidat.setEmail(email);
            candidat.setAdresse(adresse);

            boolean modifie =
                    candidatDao.modifier(
                            candidat
                    );

            if (!modifie) {

                request.setAttribute(
                        "erreur",
                        "Impossible de mettre à jour les informations du candidat."
                );

                conserverParametresCandidat(
                        request
                );

                afficherCandidat(
                        request,
                        response
                );

                return;
            }

        } else {

            // ====================================================
            // NOUVEAU CANDIDAT
            // ====================================================

            candidat =
                    new CandidatModele();

            candidat.setNumero_candidat(
                    genererNumeroCandidat()
            );

            candidat.setNom(nom);
            candidat.setPrenom(prenom);
            candidat.setDate_naissance(
                    dateNaissance
            );
            candidat.setLieu_naissance(
                    lieuNaissance
            );
            candidat.setSexe(sexe);
            candidat.setCin(cin);
            candidat.setNumero_copie(
                    numeroCopie
            );
            candidat.setTelephone(
                    telephone
            );
            candidat.setEmail(email);
            candidat.setAdresse(adresse);

            boolean ajoute =
                    candidatDao.ajouter(
                            candidat
                    );

            if (!ajoute) {

                request.setAttribute(
                        "erreur",
                        "Impossible d'enregistrer le candidat."
                );

                conserverParametresCandidat(
                        request
                );

                afficherCandidat(
                        request,
                        response
                );

                return;
            }

            candidat =
                    candidatDao.trouverParNumero(
                            candidat.getNumero_candidat()
                    );

            if (candidat == null) {

                request.setAttribute(
                        "erreur",
                        "Le candidat a été enregistré mais son identifiant n'a pas pu être récupéré."
                );

                afficherCandidat(
                        request,
                        response
                );

                return;
            }
        }

        // ========================================================
        // INSCRIPTION EXISTANTE
        // ========================================================

        if (inscriptionDao.existeInscription(
                candidat.getId_candidat(),
                idConcours
        )) {

            List<InscriptionModele> inscriptions =
                    inscriptionDao.trouverParCandidat(
                            candidat.getId_candidat()
                    );

            InscriptionModele inscriptionExistante =
                    null;

            if (inscriptions != null) {

                for (InscriptionModele inscription :
                        inscriptions) {

                    if (inscription != null
                            && inscription.getId_concours()
                            == idConcours) {

                        inscriptionExistante =
                                inscription;

                        break;
                    }
                }
            }

            if (inscriptionExistante != null) {

                session.setAttribute(
                        "inscription_id_candidat",
                        candidat.getId_candidat()
                );

                session.setAttribute(
                        "inscription_candidat",
                        candidat
                );

                session.setAttribute(
                        "inscription",
                        inscriptionExistante
                );

                rediriger(
                        request,
                        response,
                        "dossier"
                );

                return;
            }
        }

        // ========================================================
        // CREATION INSCRIPTION
        // ========================================================

        InscriptionModele inscription =
                new InscriptionModele();

        inscription.setId_candidat(
                candidat.getId_candidat()
        );

        inscription.setId_concours(
                idConcours
        );

        inscription.setNumero_inscription(
                genererNumeroInscription()
        );

        inscription.setCode_suivi(
                genererCodeSuivi()
        );

        inscription.setStatut(
                InscriptionDao.STATUT_EN_ATTENTE
        );

        boolean ajouteInscription =
                inscriptionDao.ajouter(
                        inscription
                );

        if (!ajouteInscription) {

            request.setAttribute(
                    "erreur",
                    "Impossible de créer l'inscription au concours."
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        inscription =
                inscriptionDao.trouverParNumero(
                        inscription.getNumero_inscription()
                );

        if (inscription == null) {

            request.setAttribute(
                    "erreur",
                    "L'inscription a été créée mais n'a pas pu être récupérée."
            );

            afficherCandidat(
                    request,
                    response
            );

            return;
        }

        // ========================================================
        // SESSION
        // ========================================================

        session.setAttribute(
                "inscription_id_candidat",
                candidat.getId_candidat()
        );

        session.setAttribute(
                "inscription_candidat",
                candidat
        );

        session.setAttribute(
                "inscription",
                inscription
        );

        // ========================================================
        // REDIRECTION EXACTE
        // ========================================================

        rediriger(
                request,
                response,
                "dossier"
        );
    }

    // ============================================================
    // ETAPE 3
    // AFFICHER DOSSIER
    // ============================================================

    private void afficherDossier(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        InscriptionModele inscription =
                (InscriptionModele) session.getAttribute(
                        "inscription"
                );

        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        if (dossier != null) {

            request.setAttribute(
                    "dossier",
                    dossier
            );

            session.setAttribute(
                    "dossier",
                    dossier
            );
        }

        request.setAttribute(
                "inscription",
                inscription
        );

        request.setAttribute(
                "concours",
                session.getAttribute(
                        "inscription_concours"
                )
        );

        request.setAttribute(
                "candidat",
                session.getAttribute(
                        "inscription_candidat"
                )
        );

        /*
         * CHEMIN REEL :
         *
         * Web Pages/inscription/dossier.jsp
         */
        request.getRequestDispatcher(
                "/inscription/dossier.jsp"
        ).forward(
                request,
                response
        );
    }

    // ============================================================
    // ETAPE 3
    // TRAITER DOSSIER
    // ============================================================

    private void traiterDossier(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        InscriptionModele inscription =
                (InscriptionModele) session.getAttribute(
                        "inscription"
                );

        String niveauEtude =
                trim(
                        request.getParameter(
                                "niveau_etude"
                        )
                );

        String diplome =
                trim(
                        request.getParameter(
                                "diplome"
                        )
                );

        String anneeDiplomeParam =
                trim(
                        request.getParameter(
                                "annee_diplome"
                        )
                );

        String etablissement =
                trim(
                        request.getParameter(
                                "etablissement"
                        )
                );

        // --------------------------------------------------------
        // Validation
        // --------------------------------------------------------

        if (niveauEtude.isEmpty()
                || diplome.isEmpty()
                || anneeDiplomeParam.isEmpty()
                || etablissement.isEmpty()) {

            request.setAttribute(
                    "erreur",
                    "Veuillez remplir tous les champs du dossier."
            );

            conserverParametresDossier(
                    request
            );

            afficherDossier(
                    request,
                    response
            );

            return;
        }

        if (!estEntier(
                anneeDiplomeParam
        )) {

            request.setAttribute(
                    "erreur",
                    "L'année du diplôme est invalide."
            );

            conserverParametresDossier(
                    request
            );

            afficherDossier(
                    request,
                    response
            );

            return;
        }

        int anneeDiplome =
                Integer.parseInt(
                        anneeDiplomeParam
                );

        int anneeActuelle =
                LocalDate.now().getYear();

        if (anneeDiplome < 1950
                || anneeDiplome > anneeActuelle) {

            request.setAttribute(
                    "erreur",
                    "L'année du diplôme est invalide."
            );

            conserverParametresDossier(
                    request
            );

            afficherDossier(
                    request,
                    response
            );

            return;
        }

        // ========================================================
        // DOSSIER EXISTANT ?
        // ========================================================

        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        if (dossier == null) {

            dossier =
                    new DossierModele();

            dossier.setId_inscription(
                    inscription.getId_inscription()
            );

            dossier.setNiveau_etude(
                    niveauEtude
            );

            dossier.setDiplome(
                    diplome
            );

            dossier.setAnnee_diplome(
                    anneeDiplome
            );

            dossier.setEtablissement(
                    etablissement
            );

            dossier.setComplet(false);

            boolean ajoute =
                    dossierDao.ajouter(
                            dossier
                    );

            if (!ajoute) {

                request.setAttribute(
                        "erreur",
                        "Impossible d'enregistrer le dossier."
                );

                conserverParametresDossier(
                        request
                );

                afficherDossier(
                        request,
                        response
                );

                return;
            }

            dossier =
                    dossierDao.trouverParInscription(
                            inscription.getId_inscription()
                    );

            if (dossier == null) {

                request.setAttribute(
                        "erreur",
                        "Le dossier a été créé mais n'a pas pu être récupéré."
                );

                afficherDossier(
                        request,
                        response
                );

                return;
            }

        } else {

            dossier.setNiveau_etude(
                    niveauEtude
            );

            dossier.setDiplome(
                    diplome
            );

            dossier.setAnnee_diplome(
                    anneeDiplome
            );

            dossier.setEtablissement(
                    etablissement
            );

            dossier.setComplet(false);

            boolean modifie =
                    dossierDao.modifier(
                            dossier
                    );

            if (!modifie) {

                request.setAttribute(
                        "erreur",
                        "Impossible de mettre à jour le dossier."
                );

                conserverParametresDossier(
                        request
                );

                afficherDossier(
                        request,
                        response
                );

                return;
            }
        }

        session.setAttribute(
                "dossier",
                dossier
        );

        // ========================================================
        // REDIRECTION EXACTE
        // ========================================================

        rediriger(
                request,
                response,
                "documents"
        );
    }

    // ============================================================
    // ETAPE 4
    // AFFICHER DOCUMENTS
    // ============================================================

    private void afficherDocuments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        InscriptionModele inscription =
                (InscriptionModele) session.getAttribute(
                        "inscription"
                );

        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        if (dossier == null) {

            rediriger(
                    request,
                    response,
                    "dossier"
            );

            return;
        }

        List<DocumentModele> documents =
                documentDao.trouverParDossier(
                        dossier.getId_dossier()
                );

        request.setAttribute(
                "dossier",
                dossier
        );

        request.setAttribute(
                "documents",
                documents
        );

        request.setAttribute(
                "inscription",
                inscription
        );

        request.setAttribute(
                "candidat",
                session.getAttribute(
                        "inscription_candidat"
                )
        );

        request.setAttribute(
                "concours",
                session.getAttribute(
                        "inscription_concours"
                )
        );

        /*
         * CHEMIN REEL :
         *
         * Web Pages/inscription/documents.jsp
         */
        request.getRequestDispatcher(
                "/inscription/documents.jsp"
        ).forward(
                request,
                response
        );
    }

    // ============================================================
    // ETAPE 4
    // UPLOAD DOCUMENT
    // ============================================================

    private void traiterDocument(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        InscriptionModele inscription =
                (InscriptionModele) session.getAttribute(
                        "inscription"
                );

        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        if (dossier == null) {

            rediriger(
                    request,
                    response,
                    "dossier"
            );

            return;
        }

        String typeDocument =
                trim(
                        request.getParameter(
                                "type_document"
                        )
                );

        if (typeDocument.isEmpty()) {

            request.setAttribute(
                    "erreur",
                    "Le type de document est obligatoire."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        if (!typeDocumentAutorise(
                typeDocument
        )) {

            request.setAttribute(
                    "erreur",
                    "Type de document non autorisé."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Candidat
        // --------------------------------------------------------

        CandidatModele candidat =
                (CandidatModele) session.getAttribute(
                        "inscription_candidat"
                );

        if (candidat == null) {

            candidat =
                    candidatDao.trouverParId(
                            inscription.getId_candidat()
                    );
        }

        if (candidat == null) {

            request.setAttribute(
                    "erreur",
                    "Impossible de récupérer le candidat."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Age
        // --------------------------------------------------------

        int age =
                calculerAge(
                        candidat.getDate_naissance()
                );

        if (age >= 18
                && "copie".equals(
                        typeDocument
                )) {

            request.setAttribute(
                    "erreur",
                    "La copie n'est pas requise pour un candidat majeur."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        if (age < 18
                && "cin".equals(
                        typeDocument
                )) {

            request.setAttribute(
                    "erreur",
                    "La CIN n'est pas requise pour un candidat mineur."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Fichier
        // --------------------------------------------------------

        Part part =
                request.getPart(
                        typeDocument
                );

        if (part == null
                || part.getSize() <= 0) {

            request.setAttribute(
                    "erreur",
                    "Veuillez sélectionner un fichier."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        if (part.getSize()
                > TAILLE_MAX_FICHIER) {

            request.setAttribute(
                    "erreur",
                    "Le fichier ne doit pas dépasser 10 Mo."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        String nomOriginal =
                getNomOriginal(part);

        String extension =
                obtenirExtension(
                        nomOriginal
                );

        if (!extensionAutorisee(
                extension
        )) {

            request.setAttribute(
                    "erreur",
                    "Format de fichier non autorisé. Utilisez PDF, JPG, JPEG ou PNG."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Dossier physique
        // --------------------------------------------------------

        String realPath =
                getServletContext().getRealPath(
                        "/uploads/documents"
                );

        if (realPath == null) {

            request.setAttribute(
                    "erreur",
                    "Impossible de déterminer le dossier de stockage."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        File dossierUpload =
                new File(realPath);

        if (!dossierUpload.exists()
                && !dossierUpload.mkdirs()) {

            request.setAttribute(
                    "erreur",
                    "Impossible de créer le dossier de stockage."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Nom unique
        // --------------------------------------------------------

        String nomFichier =
                UUID.randomUUID()
                        .toString()
                        + "."
                        + extension;

        Path chemin =
                Paths.get(
                        dossierUpload.getAbsolutePath(),
                        nomFichier
                );

        // --------------------------------------------------------
        // Sauvegarde physique
        // --------------------------------------------------------

        try (
                InputStream input =
                        part.getInputStream()
        ) {

            Files.copy(
                    input,
                    chemin,
                    StandardCopyOption.REPLACE_EXISTING
            );

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "erreur",
                    "Impossible d'enregistrer le fichier."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Recherche document existant
        // --------------------------------------------------------

        List<DocumentModele> documentsExistants =
                documentDao.trouverParDossier(
                        dossier.getId_dossier()
                );

        DocumentModele documentExistant =
                chercherDocumentParType(
                        documentsExistants,
                        typeDocument
                );

        boolean operationReussie;

        // --------------------------------------------------------
        // NOUVEAU DOCUMENT
        // --------------------------------------------------------

        if (documentExistant == null) {

            DocumentModele document =
                    new DocumentModele();

            document.setId_dossier(
                    dossier.getId_dossier()
            );

            document.setType_document(
                    typeDocument
            );

            document.setNom_fichier(
                    nomFichier
            );

            document.setNom_original(
                    nomOriginal
            );

            document.setChemin_fichier(
                    "/uploads/documents/"
                    + nomFichier
            );

            document.setExtension(
                    extension
            );

            document.setTaille_octets(
                    part.getSize()
            );

            document.setConforme(false);

            operationReussie =
                    documentDao.ajouter(
                            document
                    );

        } else {

            // ----------------------------------------------------
            // REMPLACEMENT
            // ----------------------------------------------------

            String ancienChemin =
                    documentExistant.getChemin_fichier();

            documentExistant.setNom_fichier(
                    nomFichier
            );

            documentExistant.setNom_original(
                    nomOriginal
            );

            documentExistant.setChemin_fichier(
                    "/uploads/documents/"
                    + nomFichier
            );

            documentExistant.setExtension(
                    extension
            );

            documentExistant.setTaille_octets(
                    part.getSize()
            );

            documentExistant.setConforme(false);

            operationReussie =
                    documentDao.modifier(
                            documentExistant
                    );

            if (operationReussie) {

                supprimerAncienFichier(
                        ancienChemin
                );
            }
        }

        // --------------------------------------------------------
        // Echec BDD
        // --------------------------------------------------------

        if (!operationReussie) {

            try {

                Files.deleteIfExists(
                        chemin
                );

            } catch (Exception e) {

                e.printStackTrace();
            }

            request.setAttribute(
                    "erreur",
                    "Impossible d'enregistrer le document dans la base de données."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        request.setAttribute(
                "succes",
                "Document enregistré avec succès."
        );

        afficherDocuments(
                request,
                response
        );
    }

    // ============================================================
    // ETAPE 5
    // VALIDATION FINALE
    // ============================================================

    private void traiterValidationFinale(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        InscriptionModele inscription =
                (InscriptionModele) session.getAttribute(
                        "inscription"
                );

        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        if (dossier == null) {

            request.setAttribute(
                    "erreur",
                    "Le dossier n'existe pas."
            );

            afficherDossier(
                    request,
                    response
            );

            return;
        }

        CandidatModele candidat =
                (CandidatModele) session.getAttribute(
                        "inscription_candidat"
                );

        if (candidat == null) {

            candidat =
                    candidatDao.trouverParId(
                            inscription.getId_candidat()
                    );
        }

        if (candidat == null) {

            request.setAttribute(
                    "erreur",
                    "Impossible de récupérer les informations du candidat."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Documents
        // --------------------------------------------------------

        List<DocumentModele> documents =
                documentDao.trouverParDossier(
                        dossier.getId_dossier()
                );

        int age =
                calculerAge(
                        candidat.getDate_naissance()
                );

        boolean identite =
                false;

        boolean diplome =
                false;

        boolean photo =
                false;

        for (DocumentModele document :
                documents) {

            if (document == null) {
                continue;
            }

            String type =
                    trim(
                            document.getType_document()
                    );

            if (age >= 18
                    && "cin".equals(type)) {

                identite = true;
            }

            if (age < 18
                    && "copie".equals(type)) {

                identite = true;
            }

            if ("diplome_bacc".equals(type)) {

                diplome = true;
            }

            if ("photo".equals(type)) {

                photo = true;
            }
        }

        boolean complet =
                identite
                && diplome
                && photo;

        if (!complet) {

            StringBuilder message =
                    new StringBuilder();

            message.append(
                    "Votre dossier est incomplet. Documents manquants : "
            );

            boolean premier = true;

            if (!identite) {

                message.append(
                        age >= 18
                        ? "CIN"
                        : "copie"
                );

                premier = false;
            }

            if (!diplome) {

                if (!premier) {
                    message.append(", ");
                }

                message.append(
                        "diplôme BACC"
                );

                premier = false;
            }

            if (!photo) {

                if (!premier) {
                    message.append(", ");
                }

                message.append(
                        "photo"
                );
            }

            request.setAttribute(
                    "erreur",
                    message.toString()
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Dossier complet
        // --------------------------------------------------------

        dossier.setComplet(true);

        dossier.setMotif_incomplet(null);

        boolean dossierModifie =
                dossierDao.modifier(
                        dossier
                );

        if (!dossierModifie) {

            request.setAttribute(
                    "erreur",
                    "Impossible de finaliser le dossier."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        // --------------------------------------------------------
        // Inscription reste EN_ATTENTE
        // --------------------------------------------------------

        inscription.setStatut(
                InscriptionDao.STATUT_EN_ATTENTE
        );

        boolean inscriptionModifiee =
                inscriptionDao.modifier(
                        inscription
                );

        if (!inscriptionModifiee) {

            request.setAttribute(
                    "erreur",
                    "Le dossier est complet mais l'inscription n'a pas pu être mise à jour."
            );

            afficherDocuments(
                    request,
                    response
            );

            return;
        }

        session.setAttribute(
                "inscription",
                inscription
        );

        session.setAttribute(
                "dossier",
                dossier
        );

        // ========================================================
        // REDIRECTION EXACTE
        // ========================================================

        rediriger(
                request,
                response,
                "confirmation"
        );
    }

    // ============================================================
    // ETAPE 6
    // CONFIRMATION
    // ============================================================

    private void afficherConfirmation(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute(
                        "inscription"
                ) == null) {

            rediriger(
                    request,
                    response,
                    "concours"
            );

            return;
        }

        InscriptionModele inscription =
                (InscriptionModele) session.getAttribute(
                        "inscription"
                );

        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        if (dossier == null
                || !dossier.isComplet()) {

            rediriger(
                    request,
                    response,
                    "documents"
            );

            return;
        }

        CandidatModele candidat =
                (CandidatModele) session.getAttribute(
                        "inscription_candidat"
                );

        if (candidat == null) {

            candidat =
                    candidatDao.trouverParId(
                            inscription.getId_candidat()
                    );
        }

        request.setAttribute(
                "candidat",
                candidat
        );

        request.setAttribute(
                "inscription",
                inscription
        );

        request.setAttribute(
                "dossier",
                dossier
        );

        request.setAttribute(
                "concours",
                session.getAttribute(
                        "inscription_concours"
                )
        );

        /*
         * CHEMIN REEL :
         *
         * Web Pages/inscription/confirmation.jsp
         */
        request.getRequestDispatcher(
                "/inscription/confirmation.jsp"
        ).forward(
                request,
                response
        );
    }

    // ============================================================
    // UTILITAIRE
    // ============================================================

    private String trim(String valeur) {

        if (valeur == null) {
            return "";
        }

        return valeur.trim();
    }

    // ============================================================
    // VERIFIER ENTIER
    // ============================================================

    private boolean estEntier(String valeur) {

        if (valeur == null
                || valeur.trim().isEmpty()) {

            return false;
        }

        try {

            Integer.parseInt(
                    valeur.trim()
            );

            return true;

        } catch (NumberFormatException e) {

            return false;
        }
    }

    // ============================================================
    // NUMERO CANDIDAT
    // ============================================================

    private String genererNumeroCandidat() {

        String numero;

        do {

            numero =
                    "CAND-"
                    + LocalDate.now().format(
                            DateTimeFormatter.BASIC_ISO_DATE
                    )
                    + "-"
                    + UUID.randomUUID()
                            .toString()
                            .substring(
                                    0,
                                    8
                            )
                            .toUpperCase();

        } while (
                candidatDao.trouverParNumero(
                        numero
                ) != null
        );

        return numero;
    }

    // ============================================================
    // NUMERO INSCRIPTION
    // ============================================================

    private String genererNumeroInscription() {

        String numero;

        do {

            numero =
                    "INS-"
                    + LocalDate.now().format(
                            DateTimeFormatter.BASIC_ISO_DATE
                    )
                    + "-"
                    + UUID.randomUUID()
                            .toString()
                            .substring(
                                    0,
                                    8
                            )
                            .toUpperCase();

        } while (
                inscriptionDao.trouverParNumero(
                        numero
                ) != null
        );

        return numero;
    }

    // ============================================================
    // CODE SUIVI
    // ============================================================

    private String genererCodeSuivi() {

        return "SUIVI-"
                + UUID.randomUUID()
                        .toString()
                        .replace(
                                "-",
                                ""
                        )
                        .substring(
                                0,
                                12
                        )
                        .toUpperCase();
    }

    // ============================================================
    // CALCUL AGE
    // ============================================================

    private int calculerAge(
            String dateNaissance) {

        try {

            LocalDate naissance =
                    LocalDate.parse(
                            dateNaissance,
                            DATE_FORMAT
                    );

            return Period.between(
                    naissance,
                    LocalDate.now()
            ).getYears();

        } catch (Exception e) {

            return 0;
        }
    }

    // ============================================================
    // TYPE DOCUMENT
    // ============================================================

    private boolean typeDocumentAutorise(
            String typeDocument) {

        return "cin".equals(typeDocument)
                || "copie".equals(typeDocument)
                || "diplome_bacc".equals(typeDocument)
                || "photo".equals(typeDocument);
    }

    // ============================================================
    // EXTENSION
    // ============================================================

    private boolean extensionAutorisee(
            String extension) {

        if (extension == null) {
            return false;
        }

        extension =
                extension.toLowerCase();

        return "pdf".equals(extension)
                || "jpg".equals(extension)
                || "jpeg".equals(extension)
                || "png".equals(extension);
    }

    // ============================================================
    // OBTENIR EXTENSION
    // ============================================================

    private String obtenirExtension(
            String nomFichier) {

        if (nomFichier == null) {
            return "";
        }

        int index =
                nomFichier.lastIndexOf(".");

        if (index < 0) {
            return "";
        }

        return nomFichier
                .substring(index + 1)
                .toLowerCase();
    }

    // ============================================================
    // NOM ORIGINAL
    // ============================================================

    private String getNomOriginal(
            Part part) {

        String contentDisposition =
                part.getHeader(
                        "content-disposition"
                );

        if (contentDisposition == null) {
            return "document";
        }

        String[] elements =
                contentDisposition.split(";");

        for (String element :
                elements) {

            element =
                    element.trim();

            if (element.startsWith(
                    "filename="
            )) {

                String nom =
                        element.substring(
                                element.indexOf("=") + 1
                        ).trim();

                nom =
                        nom.replace(
                                "\"",
                                ""
                        );

                nom =
                        nom.replace(
                                "\\",
                                "/"
                        );

                int slash =
                        nom.lastIndexOf("/");

                if (slash >= 0) {

                    nom =
                            nom.substring(
                                    slash + 1
                            );
                }

                return nom;
            }
        }

        return "document";
    }

    // ============================================================
    // DOCUMENT PAR TYPE
    // ============================================================

    private DocumentModele chercherDocumentParType(
            List<DocumentModele> documents,
            String type) {

        if (documents == null) {
            return null;
        }

        for (DocumentModele document :
                documents) {

            if (document == null) {
                continue;
            }

            if (type.equals(
                    trim(
                            document.getType_document()
                    )
            )) {

                return document;
            }
        }

        return null;
    }

    // ============================================================
    // SUPPRIMER ANCIEN FICHIER
    // ============================================================

    private void supprimerAncienFichier(
            String cheminFichier) {

        if (cheminFichier == null
                || cheminFichier.trim().isEmpty()) {

            return;
        }

        try {

            String realPath =
                    getServletContext().getRealPath(
                            cheminFichier
                    );

            if (realPath != null) {

                Files.deleteIfExists(
                        Paths.get(realPath)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    // ============================================================
    // CONSERVER CHAMPS CANDIDAT
    // ============================================================

    private void conserverParametresCandidat(
            HttpServletRequest request) {

        request.setAttribute(
                "nom",
                request.getParameter("nom")
        );

        request.setAttribute(
                "prenom",
                request.getParameter("prenom")
        );

        request.setAttribute(
                "date_naissance",
                request.getParameter(
                        "date_naissance"
                )
        );

        request.setAttribute(
                "lieu_naissance",
                request.getParameter(
                        "lieu_naissance"
                )
        );

        request.setAttribute(
                "sexe",
                request.getParameter("sexe")
        );

        request.setAttribute(
                "cin",
                request.getParameter("cin")
        );

        request.setAttribute(
                "numero_copie",
                request.getParameter(
                        "numero_copie"
                )
        );

        request.setAttribute(
                "telephone",
                request.getParameter(
                        "telephone"
                )
        );

        request.setAttribute(
                "email",
                request.getParameter("email")
        );

        request.setAttribute(
                "adresse",
                request.getParameter("adresse")
        );
    }

    // ============================================================
    // CONSERVER CHAMPS DOSSIER
    // ============================================================

    private void conserverParametresDossier(
            HttpServletRequest request) {

        request.setAttribute(
                "niveau_etude",
                request.getParameter(
                        "niveau_etude"
                )
        );

        request.setAttribute(
                "diplome",
                request.getParameter(
                        "diplome"
                )
        );

        request.setAttribute(
                "annee_diplome",
                request.getParameter(
                        "annee_diplome"
                )
        );

        request.setAttribute(
                "etablissement",
                request.getParameter(
                        "etablissement"
                )
        );
    }
}