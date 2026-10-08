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

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InscriptionServlet extends HttpServlet {

    private final InscriptionDao inscriptionDao = new InscriptionDao();
    private final CandidatDao candidatDao = new CandidatDao();
    private final ConcoursDao concoursDao = new ConcoursDao();
    private final DossierDao dossierDao = new DossierDao();
    private final DocumentDao documentDao = new DocumentDao();

    // =========================================================
    // GET
    // =========================================================
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if (action == null || action.equals("liste")) {

            liste(request, response);

        } else if (action.equals("ajouter")) {

            afficherAjouter(request, response);

        } else if (action.equals("modifier")) {

            afficherModifier(request, response);

        } else if (action.equals("details")) {

            details(request, response);

        } else if (action.equals("supprimer")) {

            supprimer(request, response);

        } else if (action.equals("parConcours")) {

            parConcours(request, response);

        } else if (action.equals("parCandidat")) {

            parCandidat(request, response);

        } else {

            liste(request, response);
        }
    }

    // =========================================================
    // POST
    // =========================================================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {

            ajouter(request, response);

        } else if ("modifier".equals(action)) {

            modifier(request, response);

        } else if ("valider".equals(action)) {

            valider(request, response);

        } else if ("rejeter".equals(action)) {

            rejeter(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );
        }
    }

    // =========================================================
    // LISTE DES INSCRIPTIONS
    // =========================================================
    private void liste(HttpServletRequest request,
                       HttpServletResponse response)
            throws ServletException, IOException {

        List<InscriptionModele> inscriptions =
                inscriptionDao.trouverTous();

        request.setAttribute("inscriptions", inscriptions);

        request.getRequestDispatcher(
                "/admin/inscriptions/liste.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // AFFICHER AJOUTER
    // =========================================================
    private void afficherAjouter(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {

        List<CandidatModele> candidats =
                candidatDao.trouverTous();

        List<ConcoursModele> concours =
                concoursDao.trouverTous();

        request.setAttribute("candidats", candidats);
        request.setAttribute("concours", concours);

        request.getRequestDispatcher(
                "/admin/inscriptions/ajouter.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // AFFICHER MODIFIER / VALIDATION
    // =========================================================
    private void afficherModifier(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );

            return;
        }

        int id;

        try {

            id = Integer.parseInt(idParam);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );

            return;
        }

        // -----------------------------------------------------
        // Inscription
        // -----------------------------------------------------
        InscriptionModele inscription =
                inscriptionDao.trouverParId(id);

        if (inscription == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=notfound"
            );

            return;
        }

        // -----------------------------------------------------
        // Candidat
        // -----------------------------------------------------
        CandidatModele candidat =
                candidatDao.trouverParId(
                        inscription.getId_candidat()
                );

        // -----------------------------------------------------
        // Concours
        // IMPORTANT :
        // Ici on récupère UN ConcoursModele
        // et non une List<ConcoursModele>
        // -----------------------------------------------------
        ConcoursModele concours =
                concoursDao.trouverParId(
                        inscription.getId_concours()
                );

        // -----------------------------------------------------
        // Dossier
        // -----------------------------------------------------
        DossierModele dossier =
                dossierDao.trouverParInscription(
                        inscription.getId_inscription()
                );

        // -----------------------------------------------------
        // Documents
        // -----------------------------------------------------
        List<DocumentModele> documents = null;

        if (dossier != null) {

            documents =
                    documentDao.trouverParDossier(
                            dossier.getId_dossier()
                    );
        }

        // -----------------------------------------------------
        // Attributs JSP
        // -----------------------------------------------------
        request.setAttribute("inscription", inscription);
        request.setAttribute("candidat", candidat);
        request.setAttribute("concours", concours);
        request.setAttribute("dossier", dossier);
        request.setAttribute("documents", documents);

        request.getRequestDispatcher(
                "/admin/inscriptions/modifier.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // DETAILS
    // =========================================================
    private void details(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );

            return;
        }

        int id;

        try {

            id = Integer.parseInt(idParam);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );

            return;
        }

        InscriptionModele inscription =
                inscriptionDao.trouverParId(id);

        if (inscription == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=notfound"
            );

            return;
        }

        CandidatModele candidat =
                candidatDao.trouverParId(
                        inscription.getId_candidat()
                );

        ConcoursModele concours =
                concoursDao.trouverParId(
                        inscription.getId_concours()
                );

        request.setAttribute("inscription", inscription);
        request.setAttribute("candidat", candidat);
        request.setAttribute("concours", concours);

        request.getRequestDispatcher(
                "/admin/inscriptions/details.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // AJOUTER
    // =========================================================
    private void ajouter(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        try {

            int idCandidat =
                    Integer.parseInt(
                            request.getParameter("id_candidat")
                    );

            int idConcours =
                    Integer.parseInt(
                            request.getParameter("id_concours")
                    );

            // -------------------------------------------------
            // Vérifier doublon
            // -------------------------------------------------
            if (inscriptionDao.existeInscription(
                    idCandidat,
                    idConcours)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=duplicate"
                );

                return;
            }

            InscriptionModele inscription =
                    new InscriptionModele();

            inscription.setId_candidat(idCandidat);

            inscription.setId_concours(idConcours);

            inscription.setNumero_inscription(
                    request.getParameter(
                            "numero_inscription"
                    )
            );

            inscription.setCode_suivi(
                    request.getParameter(
                            "code_suivi"
                    )
            );

            inscription.setDate_inscription(
                    request.getParameter(
                            "date_inscription"
                    )
            );

            inscription.setStatut(
                    request.getParameter(
                            "statut"
                    )
            );

            inscription.setMotif_rejet(
                    request.getParameter(
                            "motif_rejet"
                    )
            );

            inscription.setDate_validation(
                    request.getParameter(
                            "date_validation"
                    )
            );

            inscriptionDao.ajouter(inscription);

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&success=ajout"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );
        }
    }

    // =========================================================
    // MODIFIER
    // =========================================================
    private void modifier(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        try {

            int idInscription =
                    Integer.parseInt(
                            request.getParameter(
                                    "id_inscription"
                            )
                    );

            int idCandidat =
                    Integer.parseInt(
                            request.getParameter(
                                    "id_candidat"
                            )
                    );

            int idConcours =
                    Integer.parseInt(
                            request.getParameter(
                                    "id_concours"
                            )
                    );

            InscriptionModele inscription =
                    new InscriptionModele();

            inscription.setId_inscription(
                    idInscription
            );

            inscription.setId_candidat(
                    idCandidat
            );

            inscription.setId_concours(
                    idConcours
            );

            inscription.setNumero_inscription(
                    request.getParameter(
                            "numero_inscription"
                    )
            );

            inscription.setCode_suivi(
                    request.getParameter(
                            "code_suivi"
                    )
            );

            inscription.setDate_inscription(
                    request.getParameter(
                            "date_inscription"
                    )
            );

            inscription.setStatut(
                    request.getParameter(
                            "statut"
                    )
            );

            inscription.setMotif_rejet(
                    request.getParameter(
                            "motif_rejet"
                    )
            );

            inscription.setDate_validation(
                    request.getParameter(
                            "date_validation"
                    )
            );

            inscriptionDao.modifier(inscription);

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&success=modification"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );
        }
    }

    // =========================================================
    // VALIDER UNE INSCRIPTION
    // =========================================================
    private void valider(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );

            return;
        }

        try {

            int idInscription =
                    Integer.parseInt(idParam);

            InscriptionModele inscription =
                    inscriptionDao.trouverParId(
                            idInscription
                    );

            if (inscription == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=notfound"
                );

                return;
            }

            // -------------------------------------------------
            // Vérifier que l'inscription est encore en attente
            // -------------------------------------------------
            if (!InscriptionDao.STATUT_EN_ATTENTE.equals(
                    inscription.getStatut())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=already_processed"
                );

                return;
            }

            // -------------------------------------------------
            // Validation
            // -------------------------------------------------
            boolean resultat =
                    inscriptionDao.valider(
                            idInscription
                    );

            if (resultat) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&success=validation"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=validation"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );
        }
    }

    // =========================================================
    // REJETER UNE INSCRIPTION
    // =========================================================
    private void rejeter(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        String idParam =
                request.getParameter("id");

        String motifRejet =
                request.getParameter("motif_rejet");

        // -----------------------------------------------------
        // Vérifier ID
        // -----------------------------------------------------
        if (idParam == null ||
            idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );

            return;
        }

        // -----------------------------------------------------
        // Vérifier motif
        // -----------------------------------------------------
        if (motifRejet == null ||
            motifRejet.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=modifier&id="
                    + idParam
                    + "&error=motif_required"
            );

            return;
        }

        try {

            int idInscription =
                    Integer.parseInt(idParam);

            InscriptionModele inscription =
                    inscriptionDao.trouverParId(
                            idInscription
                    );

            if (inscription == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=notfound"
                );

                return;
            }

            // -------------------------------------------------
            // Vérifier que l'inscription est en attente
            // -------------------------------------------------
            if (!InscriptionDao.STATUT_EN_ATTENTE.equals(
                    inscription.getStatut())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=already_processed"
                );

                return;
            }

            // -------------------------------------------------
            // Rejet
            // -------------------------------------------------
            boolean resultat =
                    inscriptionDao.rejeter(
                            idInscription,
                            motifRejet.trim()
                    );

            if (resultat) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&success=rejet"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/InscriptionServlet?action=liste&error=rejet"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );
        }
    }

    // =========================================================
    // SUPPRIMER
    // =========================================================
    private void supprimer(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        String idParam =
                request.getParameter("id");

        if (idParam == null ||
            idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );

            return;
        }

        try {

            int id =
                    Integer.parseInt(idParam);

            inscriptionDao.supprimer(id);

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&success=suppression"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste&error=invalid"
            );
        }
    }

    // =========================================================
    // INSCRIPTIONS PAR CONCOURS
    // =========================================================
    private void parConcours(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        String idParam =
                request.getParameter("id_concours");

        if (idParam == null ||
            idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );

            return;
        }

        try {

            int idConcours =
                    Integer.parseInt(idParam);

            List<InscriptionModele> inscriptions =
                    inscriptionDao.trouverParConcours(
                            idConcours
                    );

            request.setAttribute(
                    "inscriptions",
                    inscriptions
            );

            request.getRequestDispatcher(
                    "/admin/inscriptions/liste.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );
        }
    }

    // =========================================================
    // INSCRIPTIONS PAR CANDIDAT
    // =========================================================
    private void parCandidat(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        String idParam =
                request.getParameter("id_candidat");

        if (idParam == null ||
            idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );

            return;
        }

        try {

            int idCandidat =
                    Integer.parseInt(idParam);

            List<InscriptionModele> inscriptions =
                    inscriptionDao.trouverParCandidat(
                            idCandidat
                    );

            request.setAttribute(
                    "inscriptions",
                    inscriptions
            );

            request.getRequestDispatcher(
                    "/admin/inscriptions/liste.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/InscriptionServlet?action=liste"
            );
        }
    }
}