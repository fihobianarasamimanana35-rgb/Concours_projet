<%-- 
    Document   : details
    Created on : 7 oct. 2026, 09:08:05
    Author     : Admin
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modele.ResultatModele" %>
<%@ page import="modele.InscriptionModele" %>

<%
    String contextPath = request.getContextPath();

    ResultatModele resultat =
            (ResultatModele) request.getAttribute("resultat");

    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails du résultat - Suivi Concours</title>

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

        .card-title-custom {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 17px 24px;
            border-bottom: 1px solid var(--border);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: var(--muted);
            font-size: 14px;
        }

        .info-value {
            font-weight: 600;
            text-align: right;
        }

        .badge-status {
            border-radius: 20px;
            padding: 7px 12px;
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

        <strong>Administration</strong>

        <button class="theme-btn" id="themeToggle">
            <i data-lucide="moon"></i>
        </button>

    </header>

    <section class="content">

        <div class="mb-4">

            <div class="page-label">
                RÉSULTATS
            </div>

            <h1 class="page-title">
                Détails du résultat
            </h1>

            <p class="page-description">
                Consultez les informations détaillées du résultat.
            </p>

        </div>

        <% if (resultat == null) { %>

            <div class="alert alert-danger">
                Résultat introuvable.
            </div>

            <a href="<%= contextPath %>/ResultatServlet?action=liste"
               class="btn btn-primary">
                Retour à la liste
            </a>

        <% } else { %>

            <div class="row g-4">

                <div class="col-lg-8">

                    <div class="card-custom">

                        <div class="card-title-custom">

                            <i data-lucide="award"></i>

                            Informations du résultat

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                Identifiant
                            </span>

                            <span class="info-value">
                                #<%= resultat.getId_resultat() %>
                            </span>

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                Inscription
                            </span>

                            <span class="info-value">
                                #<%= resultat.getId_inscription() %>
                            </span>

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                Rang
                            </span>

                            <span class="info-value">
                                <%= resultat.getRang() != null
                                        ? resultat.getRang()
                                        : "-" %>
                            </span>

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                Note finale
                            </span>

                            <span class="info-value">

                                <%= resultat.getNote_finale() != null
                                        ? resultat.getNote_finale()
                                        : "-" %>

                            </span>

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                Décision
                            </span>

                            <span class="info-value">

                                <%= resultat.getDecision() != null
                                        && !resultat.getDecision().isEmpty()
                                        ? resultat.getDecision()
                                        : "-" %>

                            </span>

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                Date de publication
                            </span>

                            <span class="info-value">

                                <%= resultat.getDate_publication() != null
                                        && !resultat.getDate_publication().isEmpty()
                                        ? resultat.getDate_publication()
                                        : "-" %>

                            </span>

                        </div>

                        <div class="info-row">

                            <span class="info-label">
                                État de publication
                            </span>

                            <span class="info-value">

                                <% if (resultat.isPublie()) { %>

                                    <span class="badge-status badge-publie">
                                        Publié
                                    </span>

                                <% } else { %>

                                    <span class="badge-status badge-non-publie">
                                        Non publié
                                    </span>

                                <% } %>

                            </span>

                        </div>

                    </div>

                </div>

                <div class="col-lg-4">

                    <div class="card-custom">

                        <div class="card-title-custom">

                            <i data-lucide="settings"></i>

                            Actions

                        </div>

                        <div class="p-4">

                            <div class="d-grid gap-2">

                                <a href="<%= contextPath %>/ResultatServlet?action=modifier&id=<%= resultat.getId_resultat() %>"
                                   class="btn btn-primary">

                                    <i data-lucide="pencil"
                                       style="width:16px;"></i>

                                    Modifier

                                </a>

                                <% if (!resultat.isPublie()) { %>

                                    <a href="<%= contextPath %>/ResultatServlet?action=publier&id=<%= resultat.getId_resultat() %>"
                                       class="btn btn-success"
                                       onclick="return confirm('Voulez-vous publier ce résultat ?');">

                                        <i data-lucide="send"
                                           style="width:16px;"></i>

                                        Publier

                                    </a>

                                <% } %>

                                <a href="<%= contextPath %>/ResultatServlet?action=supprimer&id=<%= resultat.getId_resultat() %>"
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Voulez-vous vraiment supprimer ce résultat ?');">

                                    <i data-lucide="trash-2"
                                       style="width:16px;"></i>

                                    Supprimer

                                </a>

                                <a href="<%= contextPath %>/ResultatServlet?action=liste"
                                   class="btn btn-outline-secondary">

                                    <i data-lucide="arrow-left"
                                       style="width:16px;"></i>

                                    Retour

                                </a>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        <% } %>

    </section>

</main>

<script>

    const html = document.documentElement;
    const themeToggle = document.getElementById("themeToggle");

    if (localStorage.getItem("theme") === "dark") {
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
