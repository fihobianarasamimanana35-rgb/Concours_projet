package servlet;

import dao.CandidatDao;
import modele.CandidatModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CandidatServlet extends HttpServlet {

    private final CandidatDao candidatDao = new CandidatDao();

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
            response.sendRedirect("CandidatServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<CandidatModele> candidats = candidatDao.trouverTous();

        request.setAttribute("candidats", candidats);

        request.getRequestDispatcher("/admin/candidats/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/admin/candidats/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        CandidatModele candidat = candidatDao.trouverParId(id);

        request.setAttribute("candidat", candidat);

        request.getRequestDispatcher("/admin/candidats/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        CandidatModele candidat = candidatDao.trouverParId(id);

        request.setAttribute("candidat", candidat);

        request.getRequestDispatcher("/admin/candidats/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        CandidatModele candidat = new CandidatModele();

        candidat.setNumero_candidat(request.getParameter("numero_candidat"));
        candidat.setNom(request.getParameter("nom"));
        candidat.setPrenom(request.getParameter("prenom"));
        candidat.setDate_naissance(request.getParameter("date_naissance"));
        candidat.setLieu_naissance(request.getParameter("lieu_naissance"));
        candidat.setSexe(request.getParameter("sexe"));
        candidat.setCin(request.getParameter("cin"));
        candidat.setTelephone(request.getParameter("telephone"));
        candidat.setEmail(request.getParameter("email"));
        candidat.setAdresse(request.getParameter("adresse"));
        candidat.setDate_creation(request.getParameter("date_creation"));

        candidatDao.ajouter(candidat);

        response.sendRedirect("CandidatServlet?action=liste&success=ajout");
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        CandidatModele candidat = new CandidatModele();

        candidat.setId_candidat(
                Integer.parseInt(request.getParameter("id_candidat"))
        );
        candidat.setNumero_candidat(request.getParameter("numero_candidat"));
        candidat.setNom(request.getParameter("nom"));
        candidat.setPrenom(request.getParameter("prenom"));
        candidat.setDate_naissance(request.getParameter("date_naissance"));
        candidat.setLieu_naissance(request.getParameter("lieu_naissance"));
        candidat.setSexe(request.getParameter("sexe"));
        candidat.setCin(request.getParameter("cin"));
        candidat.setTelephone(request.getParameter("telephone"));
        candidat.setEmail(request.getParameter("email"));
        candidat.setAdresse(request.getParameter("adresse"));
        candidat.setDate_creation(request.getParameter("date_creation"));

        candidatDao.modifier(candidat);

        response.sendRedirect("CandidatServlet?action=liste&success=modification");
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        candidatDao.supprimer(id);

        response.sendRedirect("CandidatServlet?action=liste&success=suppression");
    }
}