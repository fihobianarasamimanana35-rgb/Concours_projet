package servlet;

import dao.StatistiquesDao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StatistiquesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StatistiquesDao statistiquesDao =
            new StatistiquesDao();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("dashboard")) {

            dashboard(request, response);

        } else if (action.equals("data")) {

            data(response);

        } else {

            dashboard(request, response);
        }
    }

    /**
     * Affiche la page des statistiques.
     */
    private void dashboard(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        chargerStatistiques(request);

        request.getRequestDispatcher(
                "/admin/statistiques/index.jsp"
        ).forward(request, response);
    }

    /**
     * Charge les statistiques pour la JSP.
     */
    private void chargerStatistiques(
            HttpServletRequest request) {

        request.setAttribute(
                "totalDossiers",
                statistiquesDao.compterDossiers()
        );

        request.setAttribute(
                "dossiersComplets",
                statistiquesDao.compterDossiersComplets()
        );

        request.setAttribute(
                "dossiersIncomplets",
                statistiquesDao.compterDossiersIncomplets()
        );

        request.setAttribute(
                "totalDocuments",
                statistiquesDao.compterDocuments()
        );

        request.setAttribute(
                "documentsConformes",
                statistiquesDao.compterDocumentsConformes()
        );

        request.setAttribute(
                "documentsNonConformes",
                statistiquesDao.compterDocumentsNonConformes()
        );

        request.setAttribute(
                "totalResultats",
                statistiquesDao.compterResultats()
        );

        request.setAttribute(
                "resultatsPublies",
                statistiquesDao.compterResultatsPublies()
        );

        request.setAttribute(
                "resultatsNonPublies",
                statistiquesDao.compterResultatsNonPublies()
        );

        request.setAttribute(
                "decisionAdmis",
                statistiquesDao.compterDecision("admis")
        );

        request.setAttribute(
                "decisionNonAdmis",
                statistiquesDao.compterDecision("non admis")
        );
    }

    /**
     * Retourne les statistiques en JSON.
     *
     * Cette méthode est appelée par AJAX
     * toutes les 5 secondes.
     */
    private void data(
            HttpServletResponse response)
            throws IOException {

        response.setContentType(
                "application/json"
        );

        response.setCharacterEncoding(
                "UTF-8"
        );

        int dossiers =
                statistiquesDao.compterDossiers();

        int dossiersComplets =
                statistiquesDao.compterDossiersComplets();

        int dossiersIncomplets =
                statistiquesDao.compterDossiersIncomplets();

        int documents =
                statistiquesDao.compterDocuments();

        int documentsConformes =
                statistiquesDao.compterDocumentsConformes();

        int documentsNonConformes =
                statistiquesDao.compterDocumentsNonConformes();

        int resultats =
                statistiquesDao.compterResultats();

        int resultatsPublies =
                statistiquesDao.compterResultatsPublies();

        int resultatsNonPublies =
                statistiquesDao.compterResultatsNonPublies();

        int admis =
                statistiquesDao.compterDecision("admis");

        int nonAdmis =
                statistiquesDao.compterDecision("non admis");

        String json =
                "{"
                + "\"dossiers\":" + dossiers + ","
                + "\"dossiersComplets\":" + dossiersComplets + ","
                + "\"dossiersIncomplets\":" + dossiersIncomplets + ","
                + "\"documents\":" + documents + ","
                + "\"documentsConformes\":" + documentsConformes + ","
                + "\"documentsNonConformes\":" + documentsNonConformes + ","
                + "\"resultats\":" + resultats + ","
                + "\"resultatsPublies\":" + resultatsPublies + ","
                + "\"resultatsNonPublies\":" + resultatsNonPublies + ","
                + "\"admis\":" + admis + ","
                + "\"nonAdmis\":" + nonAdmis
                + "}";

        response.getWriter().write(json);
    }
}