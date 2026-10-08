package servlet;

import dao.DocumentDao;
import dao.DossierDao;
import modele.DocumentModele;
import modele.DossierModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DocumentServlet extends HttpServlet {

    private final DocumentDao documentDao = new DocumentDao();
    private final DossierDao dossierDao = new DossierDao();

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
        } else if (action.equals("parDossier")) {
            parDossier(request, response);
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
            response.sendRedirect("DocumentServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<DocumentModele> documents =
                documentDao.trouverTous();

        request.setAttribute("documents", documents);

        request.getRequestDispatcher("/admin/documents/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<DossierModele> dossiers =
                dossierDao.trouverTous();

        request.setAttribute("dossiers", dossiers);

        request.getRequestDispatcher("/admin/documents/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        DocumentModele document =
                documentDao.trouverParId(id);

        List<DossierModele> dossiers =
                dossierDao.trouverTous();

        request.setAttribute("document", document);
        request.setAttribute("dossiers", dossiers);

        request.getRequestDispatcher("/admin/documents/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        DocumentModele document =
                documentDao.trouverParId(id);

        DossierModele dossier =
                dossierDao.trouverParId(
                        document.getId_dossier()
                );

        request.setAttribute("document", document);
        request.setAttribute("dossier", dossier);

        request.getRequestDispatcher("/admin/documents/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        DocumentModele document = new DocumentModele();

        document.setId_dossier(
                Integer.parseInt(request.getParameter("id_dossier"))
        );
        document.setType_document(
                request.getParameter("type_document")
        );
        document.setNom_fichier(
                request.getParameter("nom_fichier")
        );
        document.setNom_original(
                request.getParameter("nom_original")
        );
        document.setChemin_fichier(
                request.getParameter("chemin_fichier")
        );
        document.setExtension(
                request.getParameter("extension")
        );
        document.setTaille_octets(
                Long.parseLong(request.getParameter("taille_octets"))
        );
        document.setConforme(
                Boolean.parseBoolean(request.getParameter("conforme"))
        );
        document.setDate_upload(
                request.getParameter("date_upload")
        );

        documentDao.ajouter(document);

        response.sendRedirect(
                "DocumentServlet?action=liste&success=ajout"
        );
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        DocumentModele document = new DocumentModele();

        document.setId_document(
                Integer.parseInt(request.getParameter("id_document"))
        );
        document.setId_dossier(
                Integer.parseInt(request.getParameter("id_dossier"))
        );
        document.setType_document(
                request.getParameter("type_document")
        );
        document.setNom_fichier(
                request.getParameter("nom_fichier")
        );
        document.setNom_original(
                request.getParameter("nom_original")
        );
        document.setChemin_fichier(
                request.getParameter("chemin_fichier")
        );
        document.setExtension(
                request.getParameter("extension")
        );
        document.setTaille_octets(
                Long.parseLong(request.getParameter("taille_octets"))
        );
        document.setConforme(
                Boolean.parseBoolean(request.getParameter("conforme"))
        );
        document.setDate_upload(
                request.getParameter("date_upload")
        );

        documentDao.modifier(document);

        response.sendRedirect(
                "DocumentServlet?action=liste&success=modification"
        );
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        documentDao.supprimer(id);

        response.sendRedirect(
                "DocumentServlet?action=liste&success=suppression"
        );
    }

    private void parDossier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idDossier =
                Integer.parseInt(request.getParameter("id_dossier"));

        List<DocumentModele> documents =
                documentDao.trouverParDossier(idDossier);

        request.setAttribute("documents", documents);

        request.getRequestDispatcher("/admin/documents/liste.jsp")
                .forward(request, response);
    }
}