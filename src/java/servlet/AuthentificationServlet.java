package servlet;

import dao.UserDao;
import modele.UserModele;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthentificationServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/admin/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty()
                || password.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/login.jsp?error=empty"
            );
            return;
        }

        try {

            UserModele user = userDao.authentifier(email, password);

            if (user == null) {
                afficherErreur(
                        request,
                        response,
                        "Échec de connexion",
                        "L'adresse e-mail ou le mot de passe est incorrect."
                );
                return;
            }

            if (!user.isActif()) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/login.jsp?error=inactive"
                );
                return;
            }

            if (!"admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/login.jsp?error=access"
                );
                return;
            }

            HttpSession session = request.getSession(true);

            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/dashboard.jsp"
            );

        } catch (Exception e) {

            afficherErreur(
                    request,
                    response,
                    "Erreur de connexion",
                    "Une erreur est survenue lors de la connexion."
            );
        }
    }

    private void afficherErreur(HttpServletRequest request,
                                HttpServletResponse response,
                                String titre,
                                String message)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html lang='fr'>");
            out.println("<head>");

            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");

            out.println("<title>Erreur - Suivi Concours</title>");

            out.println("<link href='" + request.getContextPath()
                    + "/bootstrap-5.3.3-dist/css/bootstrap.min.css' rel='stylesheet'>");

            out.println("</head>");

            out.println("<body class='bg-light'>");

            out.println("<div class='container'>");
            out.println("<div class='row justify-content-center align-items-center min-vh-100'>");
            out.println("<div class='col-md-6'>");

            out.println("<div class='alert alert-danger shadow-sm' role='alert'>");

            out.println("<h5 class='alert-heading mb-1'>"
                    + titre
                    + "</h5>");

            out.println("<p class='mb-0'>"
                    + message
                    + "</p>");

            out.println("</div>");

            out.println("<div class='text-center mt-3'>");

            out.println("<a href='" + request.getContextPath()
                    + "/admin/login.jsp' class='btn btn-primary'>");

            out.println("Retour à la connexion");

            out.println("</a>");

            out.println("</div>");

            out.println("</div>");
            out.println("</div>");
            out.println("</div>");

            out.println("</body>");
            out.println("</html>");
        }
    }
}