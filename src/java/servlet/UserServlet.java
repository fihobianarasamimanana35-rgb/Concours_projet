package servlet;

import dao.UserDao;
import modele.UserModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

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
            response.sendRedirect("UserServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<UserModele> users = userDao.trouverTous();

        request.setAttribute("users", users);

        request.getRequestDispatcher("/admin/users/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/admin/users/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        UserModele user = userDao.trouverParId(id);

        request.setAttribute("user", user);

        request.getRequestDispatcher("/admin/users/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        UserModele user = userDao.trouverParId(id);

        request.setAttribute("user", user);

        request.getRequestDispatcher("/admin/users/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        UserModele user = new UserModele();

        user.setNom(request.getParameter("nom"));
        user.setPrenom(request.getParameter("prenom"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        user.setActif(Boolean.parseBoolean(request.getParameter("actif")));
        user.setDate_creation(request.getParameter("date_creation"));

        userDao.ajouter(user);

        response.sendRedirect("UserServlet?action=liste&success=ajout");
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        UserModele user = new UserModele();

        user.setId_user(Integer.parseInt(request.getParameter("id_user")));
        user.setNom(request.getParameter("nom"));
        user.setPrenom(request.getParameter("prenom"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        user.setActif(Boolean.parseBoolean(request.getParameter("actif")));
        user.setDate_creation(request.getParameter("date_creation"));

        userDao.modifier(user);

        response.sendRedirect("UserServlet?action=liste&success=modification");
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        userDao.supprimer(id);

        response.sendRedirect("UserServlet?action=liste&success=suppression");
    }
}