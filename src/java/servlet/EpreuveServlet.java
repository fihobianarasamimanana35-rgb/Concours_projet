package servlet;

import dao.ConcoursDao;
import dao.EpreuveDao;
import modele.ConcoursModele;
import modele.EpreuveModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EpreuveServlet extends HttpServlet {

    private final EpreuveDao epreuveDao = new EpreuveDao();
    private final ConcoursDao concoursDao = new ConcoursDao();

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
            response.sendRedirect("EpreuveServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<EpreuveModele> epreuves = epreuveDao.trouverTous();
        
        List<ConcoursModele> concours = concoursDao.trouverTous();
        request.setAttribute("epreuves", epreuves);
        
        request.setAttribute("concours", concours);
        request.getRequestDispatcher("/admin/epreuves/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ConcoursModele> concours = concoursDao.trouverTous();

        request.setAttribute("concours", concours);

        request.getRequestDispatcher("/admin/epreuves/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        EpreuveModele epreuve = epreuveDao.trouverParId(id);
        List<ConcoursModele> concours = concoursDao.trouverTous();

        request.setAttribute("epreuve", epreuve);
        request.setAttribute("concours", concours);

        request.getRequestDispatcher("/admin/epreuves/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        EpreuveModele epreuve = epreuveDao.trouverParId(id);
        ConcoursModele concours =
        concoursDao.trouverParId(epreuve.getId_concours());

request.setAttribute("concours", concours);
        request.setAttribute("epreuve", epreuve);
        request.setAttribute("concours",concours);
        request.getRequestDispatcher("/admin/epreuves/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        EpreuveModele epreuve = new EpreuveModele();

        epreuve.setId_concours(
                Integer.parseInt(request.getParameter("id_concours"))
        );
        epreuve.setNom(request.getParameter("nom"));
        epreuve.setDescription(request.getParameter("description"));
        epreuve.setDate_epreuve(request.getParameter("date_epreuve"));

        String duree = request.getParameter("duree_minutes");

        if (duree != null && !duree.isEmpty()) {
            epreuve.setDuree_minutes(Integer.parseInt(duree));
        }

        epreuve.setCoefficient(
                Double.parseDouble(request.getParameter("coefficient"))
        );
        epreuve.setDate_creation(request.getParameter("date_creation"));

        epreuveDao.ajouter(epreuve);

        response.sendRedirect("EpreuveServlet?action=liste&success=ajout");
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        EpreuveModele epreuve = new EpreuveModele();

        epreuve.setId_epreuve(
                Integer.parseInt(request.getParameter("id_epreuve"))
        );
        epreuve.setId_concours(
                Integer.parseInt(request.getParameter("id_concours"))
        );
        epreuve.setNom(request.getParameter("nom"));
        epreuve.setDescription(request.getParameter("description"));
        epreuve.setDate_epreuve(request.getParameter("date_epreuve"));

        String duree = request.getParameter("duree_minutes");

        if (duree != null && !duree.isEmpty()) {
            epreuve.setDuree_minutes(Integer.parseInt(duree));
        }

        epreuve.setCoefficient(
                Double.parseDouble(request.getParameter("coefficient"))
        );
        epreuve.setDate_creation(request.getParameter("date_creation"));

        epreuveDao.modifier(epreuve);

        response.sendRedirect("EpreuveServlet?action=liste&success=modification");
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        epreuveDao.supprimer(id);

        response.sendRedirect("EpreuveServlet?action=liste&success=suppression");
    }
}