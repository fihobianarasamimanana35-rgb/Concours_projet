package servlet;

import dao.DossierDao;
import dao.InscriptionDao;
import modele.DossierModele;
import modele.InscriptionModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DossierServlet extends HttpServlet {

    private final DossierDao dossierDao = new DossierDao();
    private final InscriptionDao inscriptionDao = new InscriptionDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        } else if (action.equals("parInscription")) {
            parInscription(request, response);
        } else {
            liste(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            ajouter(request, response);
        } else if ("modifier".equals(action)) {
            modifier(request, response);
        } else {
            response.sendRedirect("DossierServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<DossierModele> dossiers = dossierDao.trouverTous();

        request.setAttribute("dossiers", dossiers);

        request.getRequestDispatcher("/admin/dossiers/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<InscriptionModele> inscriptions =
                inscriptionDao.trouverTous();

        request.setAttribute("inscriptions", inscriptions);

        request.getRequestDispatcher("/admin/dossiers/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        DossierModele dossier = dossierDao.trouverParId(id);

        List<InscriptionModele> inscriptions =
                inscriptionDao.trouverTous();

        request.setAttribute("dossier", dossier);
        request.setAttribute("inscriptions", inscriptions);

        request.getRequestDispatcher("/admin/dossiers/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        DossierModele dossier = dossierDao.trouverParId(id);

        InscriptionModele inscription =
                inscriptionDao.trouverParId(
                        dossier.getId_inscription()
                );

        request.setAttribute("dossier", dossier);
        request.setAttribute("inscription", inscription);

        request.getRequestDispatcher("/admin/dossiers/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        DossierModele dossier = new DossierModele();

        dossier.setId_inscription(
                Integer.parseInt(request.getParameter("id_inscription"))
        );
        dossier.setNiveau_etude(
                request.getParameter("niveau_etude")
        );
        dossier.setDiplome(
                request.getParameter("diplome")
        );
        dossier.setAnnee_diplome(
                Integer.parseInt(request.getParameter("annee_diplome"))
        );
        dossier.setEtablissement(
                request.getParameter("etablissement")
        );
        dossier.setComplet(
                Boolean.parseBoolean(request.getParameter("complet"))
        );
        dossier.setDate_creation(
                request.getParameter("date_creation")
        );
        dossier.setDate_verification(
                request.getParameter("date_verification")
        );
        dossier.setMotif_incomplet(
                request.getParameter("motif_incomplet")
        );

        dossierDao.ajouter(dossier);

        response.sendRedirect(
                "DossierServlet?action=liste&success=ajout"
        );
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        DossierModele dossier = new DossierModele();

        dossier.setId_dossier(
                Integer.parseInt(request.getParameter("id_dossier"))
        );
        dossier.setId_inscription(
                Integer.parseInt(request.getParameter("id_inscription"))
        );
        dossier.setNiveau_etude(
                request.getParameter("niveau_etude")
        );
        dossier.setDiplome(
                request.getParameter("diplome")
        );
        dossier.setAnnee_diplome(
                Integer.parseInt(request.getParameter("annee_diplome"))
        );
        dossier.setEtablissement(
                request.getParameter("etablissement")
        );
        dossier.setComplet(
                Boolean.parseBoolean(request.getParameter("complet"))
        );
        dossier.setDate_creation(
                request.getParameter("date_creation")
        );
        dossier.setDate_verification(
                request.getParameter("date_verification")
        );
        dossier.setMotif_incomplet(
                request.getParameter("motif_incomplet")
        );

        dossierDao.modifier(dossier);

        response.sendRedirect(
                "DossierServlet?action=liste&success=modification"
        );
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        dossierDao.supprimer(id);

        response.sendRedirect(
                "DossierServlet?action=liste&success=suppression"
        );
    }

    private void parInscription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idInscription =
                Integer.parseInt(request.getParameter("id_inscription"));

        DossierModele dossier =
                dossierDao.trouverParInscription(idInscription);

        request.setAttribute("dossier", dossier);

        request.getRequestDispatcher("/admin/dossiers/details.jsp")
                .forward(request, response);
    }
}