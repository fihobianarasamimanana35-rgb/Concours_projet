package servlet;

import dao.DashboardDao;
import modele.UserModele;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DashboardServlet extends HttpServlet {

    private final DashboardDao dashboardDao = new DashboardDao();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/login.jsp?error=session"
            );
            return;
        }

        UserModele user = (UserModele) session.getAttribute("user");

        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/login.jsp?error=access"
            );
            return;
        }

        int nombreConcours =
                dashboardDao.compterConcours();

        int nombreCandidats =
                dashboardDao.compterCandidats();

        int nombreInscriptions =
                dashboardDao.compterInscriptions();

        int nombreResultatsPublies =
                dashboardDao.compterResultatsPublies();

        request.setAttribute(
                "nombreConcours",
                nombreConcours
        );

        request.setAttribute(
                "nombreCandidats",
                nombreCandidats
        );

        request.setAttribute(
                "nombreInscriptions",
                nombreInscriptions
        );

        request.setAttribute(
                "nombreResultatsPublies",
                nombreResultatsPublies
        );

        request.setAttribute(
                "user",
                user
        );

        request.getRequestDispatcher(
                "/admin/dashboard.jsp"
        ).forward(
                request,
                response
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}