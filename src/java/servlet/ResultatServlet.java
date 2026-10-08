package servlet;

import dao.InscriptionDao;
import dao.ResultatDao;
import modele.InscriptionModele;
import modele.ResultatModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResultatServlet extends HttpServlet {

    private final ResultatDao resultatDao = new ResultatDao();
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
        } else if (action.equals("publier")) {
            publier(request, response);
        } else if (action.equals("parInscription")) {
            parInscription(request, response);
        } else if (action.equals("publies")) {
            publies(request, response);
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
        } else if ("publier".equals(action)) {
            publier(request, response);
        } else {
            response.sendRedirect("ResultatServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ResultatModele> resultats =
                resultatDao.trouverTous();

        request.setAttribute("resultats", resultats);

        request.getRequestDispatcher("/admin/resultats/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<InscriptionModele> inscriptions =
                inscriptionDao.trouverTous();

        request.setAttribute("inscriptions", inscriptions);

        request.getRequestDispatcher("/admin/resultats/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ResultatModele resultat =
                resultatDao.trouverParId(id);

        List<InscriptionModele> inscriptions =
                inscriptionDao.trouverTous();

        request.setAttribute("resultat", resultat);
        request.setAttribute("inscriptions", inscriptions);

        request.getRequestDispatcher("/admin/resultats/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ResultatModele resultat =
                resultatDao.trouverParId(id);

        InscriptionModele inscription =
                inscriptionDao.trouverParId(
                        resultat.getId_inscription()
                );

        request.setAttribute("resultat", resultat);
        request.setAttribute("inscription", inscription);

        request.getRequestDispatcher("/admin/resultats/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        ResultatModele resultat = new ResultatModele();

        resultat.setId_inscription(
                Integer.parseInt(request.getParameter("id_inscription"))
        );

        String rang = request.getParameter("rang");

        if (rang != null && !rang.isEmpty()) {
            resultat.setRang(Integer.parseInt(rang));
        }

        String note = request.getParameter("note_finale");

        if (note != null && !note.isEmpty()) {
            resultat.setNote_finale(Double.parseDouble(note));
        }

        resultat.setDecision(
                request.getParameter("decision")
        );

        resultat.setPublie(
                Boolean.parseBoolean(request.getParameter("publie"))
        );

        resultat.setDate_publication(
                request.getParameter("date_publication")
        );

        resultatDao.ajouter(resultat);

        response.sendRedirect(
                "ResultatServlet?action=liste&success=ajout"
        );
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        ResultatModele resultat = new ResultatModele();

        resultat.setId_resultat(
                Integer.parseInt(request.getParameter("id_resultat"))
        );
        resultat.setId_inscription(
                Integer.parseInt(request.getParameter("id_inscription"))
        );

        String rang = request.getParameter("rang");

        if (rang != null && !rang.isEmpty()) {
            resultat.setRang(Integer.parseInt(rang));
        }

        String note = request.getParameter("note_finale");

        if (note != null && !note.isEmpty()) {
            resultat.setNote_finale(Double.parseDouble(note));
        }

        resultat.setDecision(
                request.getParameter("decision")
        );

        resultat.setPublie(
                Boolean.parseBoolean(request.getParameter("publie"))
        );

        resultat.setDate_publication(
                request.getParameter("date_publication")
        );

        resultatDao.modifier(resultat);

        response.sendRedirect(
                "ResultatServlet?action=liste&success=modification"
        );
    }

    private void publier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        resultatDao.publier(id);

        response.sendRedirect(
                "ResultatServlet?action=liste&success=publication"
        );
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        resultatDao.supprimer(id);

        response.sendRedirect(
                "ResultatServlet?action=liste&success=suppression"
        );
    }

    private void parInscription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idInscription =
                Integer.parseInt(request.getParameter("id_inscription"));

        ResultatModele resultat =
                resultatDao.trouverParInscription(idInscription);

        request.setAttribute("resultat", resultat);

        request.getRequestDispatcher("/admin/resultats/details.jsp")
                .forward(request, response);
    }

    private void publies(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ResultatModele> resultats =
                resultatDao.trouverPublies();

        request.setAttribute("resultats", resultats);

        request.getRequestDispatcher("/resultats.jsp")
                .forward(request, response);
    }
}