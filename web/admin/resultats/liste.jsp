<%-- 
    Document   : liste
    Created on : 7 oct. 2026, 09:06:52
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.ResultatModele" %>

<%
    String contextPath = request.getContextPath();

    List<ResultatModele> resultats =
            (List<ResultatModele>) request.getAttribute("resultats");

    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Résultats - Suivi Concours</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <script src="<%= contextPath %>/js/lucide.min.js"></script>

    <style>
        :root {
            --bg: #f6f8fb;
            --surface: #ffffff;
            --text: #172033;
            --muted: #6b7280;
            --border: #e5e7eb;
            --primary: #2563eb;
            --sidebar: #111827;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --text: #f3f4f6;
            --muted: #9ca3af;
            --border: #1f2937;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--bg);
            color: var(--text);
            font-family: Arial, sans-serif;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: var(--sidebar);
            color: white;
            padding: 24px 16px;
            z-index: 1000;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 30px;
            padding: 0 10px;
        }

        .nav-link {
            color: #cbd5e1;
            padding: 12px 14px;
            border-radius: 10px;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .nav-link:hover,
        .nav-link.active {
            background: #1f2937;
            color: white;
        }

        .logout {
            position: absolute;
            bottom: 20px;
            left: 16px;
            right: 16px;
        }

        .main {
            margin-left: 250px;
            min-height: 100vh;
        }

        .topbar {
            height: 72px;
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 32px;
        }

        .content {
            padding: 32px;
        }

        .page-label {
            color: var(--primary);
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .page-title {
            margin-top: 5px;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .page-description {
            color: var(--muted);
        }

        .card-custom {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .card-header-custom {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .table {
            margin-bottom: 0;
            color: var(--text);
        }

        .table th {
            color: var(--muted);
            font-size: 13px;
            font-weight: 600;
            border-color: var(--border);
            padding: 16px;
        }

        .table td {
            border-color: var(--border);
            padding: 16px;
            vertical-align: middle;
            background: transparent;
        }

        .badge-status {
            border-radius: 20px;
            padding: 6px 10px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-publie {
            background: #dcfce7;
            color: #166534;
        }

        .badge-non-publie {
            background: #fef3c7;
            color: #92400e;
        }

        .btn-primary {
            background: var(--primary);
            border-color: var(--primary);
        }

        .btn-action {
            width: 34px;
            height: 34px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted);
        }

        .theme-btn {
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            border-radius: 10px;
            width: 40px;
            height: 40px;
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
            }

            .brand span,
            .nav-link span {
                display: none;
            }

            .main {
                margin-left: 80px;
            }
        }
    </style>
</head>

<body>

<aside class="sidebar">

    <div class="brand">
        <i data-lucide="shield-check"></i>
        <span>Suivi Concours</span>
    </div>

    <nav>

        <a href="<%= contextPath %>/DashboardServlet" class="nav-link">
            <i data-lucide="layout-dashboard"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= contextPath %>/ConcoursServlet?action=liste" class="nav-link">
            <i data-lucide="trophy"></i>
            <span>Concours</span>
        </a>

        <a href="<%= contextPath %>/EpreuveServlet?action=liste" class="nav-link">
            <i data-lucide="file-text"></i>
            <span>Épreuves</span>
        </a>

        <a href="<%= contextPath %>/CandidatServlet?action=liste" class="nav-link">
            <i data-lucide="users"></i>
            <span>Candidats</span>
        </a>

        <a href="<%= contextPath %>/InscriptionServlet?action=liste" class="nav-link">
            <i data-lucide="clipboard-list"></i>
            <span>Inscriptions</span>
        </a>

        <a href="<%= contextPath %>/DossierServlet?action=liste" class="nav-link">
            <i data-lucide="folder"></i>
            <span>Dossiers</span>
        </a>

        <a href="<%= contextPath %>/ResultatServlet?action=liste"
           class="nav-link active">
            <i data-lucide="award"></i>
            <span>Résultats</span>
        </a>

        <a href="<%= contextPath %>/StatistiquesServlet?action=data" class="nav-link">
            <i data-lucide="bar-chart-3"></i>
            <span>Statistiques</span>
        </a>

    </nav>

    <div class="logout">
        <a href="<%= contextPath %>/LogoutServlet" class="nav-link">
            <i data-lucide="log-out"></i>
            <span>Déconnexion</span>
        </a>
    </div>

</aside>

<main class="main">

    <header class="topbar">

        <div>
            <strong>Administration</strong>
        </div>

        <button class="theme-btn" id="themeToggle" title="Changer le thème">
            <i data-lucide="moon"></i>
        </button>

    </header>

    <section class="content">

        <div class="mb-4">

            <div class="page-label">
                ADMINISTRATION
            </div>

            <h1 class="page-title">
                Résultats
            </h1>

            <p class="page-description">
                Consultez, gérez et publiez les résultats du concours.
            </p>

        </div>

        <% if ("ajout".equals(success)) { %>
            <div class="alert alert-success">
                Le résultat a été ajouté avec succès.
            </div>
        <% } %>

        <% if ("modification".equals(success)) { %>
            <div class="alert alert-success">
                Le résultat a été modifié avec succès.
            </div>
        <% } %>

        <% if ("publication".equals(success)) { %>
            <div class="alert alert-success">
                Le résultat a été publié avec succès.
            </div>
        <% } %>

        <% if ("suppression".equals(success)) { %>
            <div class="alert alert-success">
                Le résultat a été supprimé avec succès.
            </div>
        <% } %>

        <div class="card-custom">

            <div class="card-header-custom">

                <div class="d-flex align-items-center gap-2">
                    <i data-lucide="award"></i>
                    <strong>Liste des résultats</strong>
                </div>

                <a href="<%= contextPath %>/ResultatServlet?action=ajouter"
                   class="btn btn-primary">
                    <i data-lucide="plus" style="width:16px;"></i>
                    Ajouter
                </a>

            </div>

            <% if (resultats == null || resultats.isEmpty()) { %>

                <div class="empty-state">

                    <i data-lucide="inbox"
                       style="width:48px;height:48px;"></i>

                    <h5 class="mt-3">
                        Aucun résultat
                    </h5>

                    <p>
                        Aucun résultat n'est actuellement enregistré.
                    </p>

                </div>

            <% } else { %>

                <div class="table-responsive">

                    <table class="table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Inscription</th>
                            <th>Rang</th>
                            <th>Note finale</th>
                            <th>Décision</th>
                            <th>Publication</th>
                            <th>Date publication</th>
                            <th class="text-end">Actions</th>
                        </tr>
                        </thead>

                        <tbody>

                        <% for (ResultatModele resultat : resultats) { %>

                            <tr>

                                <td>
                                    <strong>#<%= resultat.getId_resultat() %></strong>
                                </td>

                                <td>
                                    #<%= resultat.getId_inscription() %>
                                </td>

                                <td>
                                    <%= resultat.getRang() != null
                                            ? resultat.getRang()
                                            : "-" %>
                                </td>

                                <td>
                                    <strong>
                                        <%= resultat.getNote_finale() != null
                                                ? resultat.getNote_finale()
                                                : "-" %>
                                    </strong>
                                </td>

                                <td>
                                    <%= resultat.getDecision() != null
                                            && !resultat.getDecision().isEmpty()
                                            ? resultat.getDecision()
                                            : "-" %>
                                </td>

                                <td>
                                    <% if (resultat.isPublie()) { %>
                                        <span class="badge-status badge-publie">
                                            Publié
                                        </span>
                                    <% } else { %>
                                        <span class="badge-status badge-non-publie">
                                            Non publié
                                        </span>
                                    <% } %>
                                </td>

                                <td>
                                    <%= resultat.getDate_publication() != null
                                            && !resultat.getDate_publication().isEmpty()
                                            ? resultat.getDate_publication()
                                            : "-" %>
                                </td>

                                <td class="text-end">

                                    <a href="<%= contextPath %>/ResultatServlet?action=details&id=<%= resultat.getId_resultat() %>"
                                       class="btn btn-outline-secondary btn-action"
                                       title="Détails">
                                        <i data-lucide="eye"></i>
                                    </a>

                                    <a href="<%= contextPath %>/ResultatServlet?action=modifier&id=<%= resultat.getId_resultat() %>"
                                       class="btn btn-outline-primary btn-action"
                                       title="Modifier">
                                        <i data-lucide="pencil"></i>
                                    </a>

                                    <% if (!resultat.isPublie()) { %>

                                        <a href="<%= contextPath %>/ResultatServlet?action=publier&id=<%= resultat.getId_resultat() %>"
                                           class="btn btn-outline-success btn-action"
                                           title="Publier"
                                           onclick="return confirm('Voulez-vous publier ce résultat ?');">
                                            <i data-lucide="send"></i>
                                        </a>

                                    <% } %>

                                    <a href="<%= contextPath %>/ResultatServlet?action=supprimer&id=<%= resultat.getId_resultat() %>"
                                       class="btn btn-outline-danger btn-action"
                                       title="Supprimer"
                                       onclick="return confirm('Voulez-vous vraiment supprimer ce résultat ?');">
                                        <i data-lucide="trash-2"></i>
                                    </a>

                                </td>

                            </tr>

                        <% } %>

                        </tbody>

                    </table>

                </div>

            <% } %>

        </div>

    </section>

</main>

<script src="<%= contextPath %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<script>

    const html = document.documentElement;
    const themeToggle = document.getElementById("themeToggle");

    const savedTheme = localStorage.getItem("theme");

    if (savedTheme === "dark") {
        html.classList.add("dark");
    }

    themeToggle.addEventListener("click", function () {

        html.classList.toggle("dark");

        localStorage.setItem(
            "theme",
            html.classList.contains("dark") ? "dark" : "light"
        );

    });

    lucide.createIcons();

</script>

</body>
</html>
