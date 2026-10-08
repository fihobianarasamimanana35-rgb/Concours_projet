package servlet;

import dao.AdminDao;
import dao.UserDao;
import modele.AdminModele;
import modele.UserModele;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminServlet extends HttpServlet {

    private final AdminDao adminDao = new AdminDao();
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
            response.sendRedirect("AdminServlet?action=liste");
        }
    }

    private void liste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<AdminModele> admins = adminDao.trouverTous();

        request.setAttribute("admins", admins);

        request.getRequestDispatcher("/admin/admins/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<UserModele> users = userDao.trouverTous();

        request.setAttribute("users", users);

        request.getRequestDispatcher("/admin/admins/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AdminModele admin = adminDao.trouverParId(id);
        List<UserModele> users = userDao.trouverTous();

        request.setAttribute("admin", admin);
        request.setAttribute("users", users);

        request.getRequestDispatcher("/admin/admins/modifier.jsp")
                .forward(request, response);
    }

    private void details(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AdminModele admin = adminDao.trouverParId(id);

        request.setAttribute("admin", admin);

        request.getRequestDispatcher("/admin/admins/details.jsp")
                .forward(request, response);
    }

    private void ajouter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        AdminModele admin = new AdminModele();

        admin.setId_user(Integer.parseInt(request.getParameter("id_user")));
        admin.setMatricule(request.getParameter("matricule"));

        adminDao.ajouter(admin);

        response.sendRedirect("AdminServlet?action=liste&success=ajout");
    }

    private void modifier(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        AdminModele admin = new AdminModele();

        admin.setId_admin(Integer.parseInt(request.getParameter("id_admin")));
        admin.setId_user(Integer.parseInt(request.getParameter("id_user")));
        admin.setMatricule(request.getParameter("matricule"));

        adminDao.modifier(admin);

        response.sendRedirect("AdminServlet?action=liste&success=modification");
    }

    private void supprimer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        adminDao.supprimer(id);

        response.sendRedirect("AdminServlet?action=liste&success=suppression");
    }
}