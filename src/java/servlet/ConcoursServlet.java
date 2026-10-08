package servlet;

import dao.ConcoursDao;
import modele.ConcoursModele;
import modele.UserModele;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ConcoursServlet extends HttpServlet {

    private final ConcoursDao concoursDao = new ConcoursDao();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("liste")) {
            liste(request, response);

        } else if (action.equals("details")) {
            details(request, response);

        } else if (action.equals("adminListe")) {
            listeAdmin(request, response);

        } else if (action.equals("adminDetails")) {
            detailsAdmin(request, response);

        } else if (action.equals("ajouter")) {
            if (!verifierAdmin(request, response)) {
                return;
            }
            afficherAjouter(request, response);

        } else if (action.equals("modifier")) {
            if (!verifierAdmin(request, response)) {
                return;
            }
            afficherModifier(request, response);

        } else if (action.equals("supprimer")) {
            if (!verifierAdmin(request, response)) {
                return;
            }
            supprimer(request, response);

        } else {
            liste(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!verifierAdmin(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            ajouter(request, response);

        } else if ("modifier".equals(action)) {
            modifier(request, response);

        } else {
            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe"
            );
        }
    }

    private boolean verifierAdmin(HttpServletRequest request,
                                  HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/login.jsp?error=session"
            );
            return false;
        }

        UserModele user = (UserModele) session.getAttribute("user");

        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/login.jsp?error=access"
            );
            return false;
        }

        return true;
    }

    private void liste(HttpServletRequest request,
                       HttpServletResponse response)
            throws ServletException, IOException {

        List<ConcoursModele> concours = concoursDao.trouverTous();

        request.setAttribute("concours", concours);

        request.getRequestDispatcher("/concours/liste.jsp")
                .forward(request, response);
    }

    private void listeAdmin(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        if (!verifierAdmin(request, response)) {
            return;
        }

        List<ConcoursModele> concours = concoursDao.trouverTous();

        request.setAttribute("concours", concours);

        request.getRequestDispatcher("/admin/concours/liste.jsp")
                .forward(request, response);
    }

    private void afficherAjouter(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/admin/concours/ajouter.jsp")
                .forward(request, response);
    }

    private void afficherModifier(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&error=id"
            );
            return;
        }

        try {

            int id = Integer.parseInt(idParam);

            ConcoursModele concours =
                    concoursDao.trouverParId(id);

            if (concours == null) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=adminListe&error=introuvable"
                );
                return;
            }

            request.setAttribute("concours", concours);

            request.getRequestDispatcher(
                    "/admin/concours/modifier.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&error=id"
            );
        }
    }

    private void details(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=liste"
            );
            return;
        }

        try {

            int id = Integer.parseInt(idParam);

            ConcoursModele concours =
                    concoursDao.trouverParId(id);

            if (concours == null) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=liste"
                );
                return;
            }

            request.setAttribute("concours", concours);

            request.getRequestDispatcher(
                    "/concours/details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=liste"
            );
        }
    }

    private void detailsAdmin(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        if (!verifierAdmin(request, response)) {
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe"
            );
            return;
        }

        try {

            int id = Integer.parseInt(idParam);

            ConcoursModele concours =
                    concoursDao.trouverParId(id);

            if (concours == null) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=adminListe"
                );
                return;
            }

            request.setAttribute("concours", concours);

            request.getRequestDispatcher(
                    "/admin/concours/details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe"
            );
        }
    }

    private void ajouter(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        String code = request.getParameter("code_concours");
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        String dateDebut = request.getParameter("date_debut");
        String dateFin = request.getParameter("date_fin");
        String nombrePlacesParam = request.getParameter("nombre_places");
        String statut = request.getParameter("statut");

        if (code == null || code.trim().isEmpty()
                || nom == null || nom.trim().isEmpty()
                || dateDebut == null || dateDebut.trim().isEmpty()
                || dateFin == null || dateFin.trim().isEmpty()
                || nombrePlacesParam == null
                || nombrePlacesParam.trim().isEmpty()
                || statut == null || statut.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=ajouter&error=champs"
            );
            return;
        }

        try {

            int nombrePlaces =
                    Integer.parseInt(nombrePlacesParam);

            LocalDate debut =
                    LocalDate.parse(dateDebut);

            LocalDate fin =
                    LocalDate.parse(dateFin);

            if (nombrePlaces < 1) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=ajouter&error=places"
                );
                return;
            }

            if (!debut.isBefore(fin)) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=ajouter&error=dates"
                );
                return;
            }

            ConcoursModele concours =
                    new ConcoursModele();

            concours.setCode_concours(code.trim());
            concours.setNom(nom.trim());
            concours.setDescription(description);
            concours.setDate_debut(dateDebut);
            concours.setDate_fin(dateFin);
            concours.setNombre_places(nombrePlaces);
            concours.setStatut(statut);

            String maintenant =
                    LocalDateTime.now().format(
                            DateTimeFormatter.ofPattern(
                                    "yyyy-MM-dd HH:mm:ss"
                            )
                    );

            concours.setDate_creation(maintenant);
            concours.setDate_modification(maintenant);

            if (!"ouvert".equalsIgnoreCase(statut)) {
                concours.setDate_publication(null);
            } else {
                concours.setDate_publication(maintenant);
            }

            concoursDao.ajouter(concours);

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&success=ajout"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=ajouter&error=places"
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=ajouter&error=dates"
            );
        }
    }

    private void modifier(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        try {

            int id =
                    Integer.parseInt(
                            request.getParameter("id_concours")
                    );

            String code =
                    request.getParameter("code_concours");

            String nom =
                    request.getParameter("nom");

            String description =
                    request.getParameter("description");

            String dateDebut =
                    request.getParameter("date_debut");

            String dateFin =
                    request.getParameter("date_fin");

            int nombrePlaces =
                    Integer.parseInt(
                            request.getParameter("nombre_places")
                    );

            String statut =
                    request.getParameter("statut");

            if (nombrePlaces < 1) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=modifier&id="
                        + id
                        + "&error=places"
                );
                return;
            }

            LocalDate debut =
                    LocalDate.parse(dateDebut);

            LocalDate fin =
                    LocalDate.parse(dateFin);

            if (!debut.isBefore(fin)) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=modifier&id="
                        + id
                        + "&error=dates"
                );
                return;
            }

            ConcoursModele concours =
                    concoursDao.trouverParId(id);

            if (concours == null) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/ConcoursServlet?action=adminListe&error=introuvable"
                );
                return;
            }

            concours.setCode_concours(code.trim());
            concours.setNom(nom.trim());
            concours.setDescription(description);
            concours.setDate_debut(dateDebut);
            concours.setDate_fin(dateFin);
            concours.setNombre_places(nombrePlaces);
            concours.setStatut(statut);

            concours.setDate_modification(
                    LocalDateTime.now().format(
                            DateTimeFormatter.ofPattern(
                                    "yyyy-MM-dd HH:mm:ss"
                            )
                    )
            );

            concoursDao.modifier(concours);

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&success=modification"
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&error=modification"
            );
        }
    }

    private void supprimer(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        try {

            int id =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            concoursDao.supprimer(id);

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&success=suppression"
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ConcoursServlet?action=adminListe&error=suppression"
            );
        }
    }
}