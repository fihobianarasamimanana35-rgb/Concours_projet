<%-- 
    Document   : liste
    Created on : 5 oct. 2026, 15:07:43
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.ConcoursModele" %>

<%
    List<ConcoursModele> concours =
            (List<ConcoursModele>) request.getAttribute("concours");
%>

<!DOCTYPE html>
<html lang="fr">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Concours - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        :root {
            --bg: #f5f7fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
            --text: #172033;
            --muted: #6b7280;
            --border: #e5e7eb;
            --sidebar: #111827;
            --sidebar-hover: #1f2937;
            --primary: #2563eb;
            --primary-soft: #eff6ff;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1f2937;
            --text: #f3f4f6;
            --muted: #9ca3af;
            --border: #374151;
            --sidebar: #020617;
            --sidebar-hover: #1f2937;
            --primary: #3b82f6;
            --primary-soft: #172554;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--bg);
            color: var(--text);
            font-family: Inter, system-ui, -apple-system,
                         BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        /* SIDEBAR */

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
            background: var(--sidebar);
            padding: 22px 16px;
            z-index: 1000;
        }

        .brand {
            height: 52px;
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 0 12px;
            color: #fff;
            font-size: 19px;
            font-weight: 700;
            margin-bottom: 24px;
        }

        .brand-icon {
            width: 35px;
            height: 35px;
            border-radius: 10px;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(37, 99, 235, .25);
        }

        .nav-section {
            color: #6b7280;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            padding: 0 12px;
            margin: 18px 0 8px;
            letter-spacing: .08em;
        }

        .nav-link-admin {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 13px;
            margin-bottom: 4px;
            color: #9ca3af;
            text-decoration: none;
            border-radius: 10px;
            font-size: 14px;
            transition: all .2s ease;
        }

        .nav-link-admin svg {
            width: 18px;
            height: 18px;
            flex-shrink: 0;
        }

        .nav-link-admin:hover {
            background: var(--sidebar-hover);
            color: #fff;
            transform: translateX(2px);
        }

        .nav-link-admin.active {
            background: #2563eb;
            color: #fff;
            box-shadow: 0 6px 16px rgba(37, 99, 235, .20);
        }

        .logout {
            position: absolute;
            left: 16px;
            right: 16px;
            bottom: 18px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 13px;
            color: #9ca3af;
            text-decoration: none;
            border-radius: 10px;
            font-size: 14px;
        }

        .logout:hover {
            background: var(--sidebar-hover);
            color: #fff;
        }

        /* MAIN */

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

        .page-title {
            font-size: 17px;
            font-weight: 700;
        }

        .page-subtitle {
            color: var(--muted);
            font-size: 12px;
            margin-top: 2px;
        }

        .theme-btn {
            width: 40px;
            height: 40px;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .theme-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        .content {
            padding: 32px;
        }

        /* HEADER */

        .page-heading {
            margin-bottom: 28px;
        }

        .eyebrow {
            color: var(--primary);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: .08em;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .page-heading h1 {
            font-size: 28px;
            font-weight: 750;
            letter-spacing: -.02em;
            margin-bottom: 5px;
        }

        .page-heading p {
            color: var(--muted);
            margin: 0;
        }

        .btn {
            border-radius: 9px;
            font-weight: 600;
        }

        .btn-primary {
            background: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;
        }

        /* CARD */

        .card-custom {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .card-toolbar {
            padding: 18px 22px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .card-title-wrap {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .card-icon {
            width: 36px;
            height: 36px;
            border-radius: 9px;
            background: var(--primary-soft);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-title {
            font-size: 15px;
            font-weight: 700;
            margin: 0;
        }

        .card-count {
            font-size: 12px;
            color: var(--muted);
        }

        /* TABLE */

        .table {
            color: var(--text);
            margin: 0;
        }

        .table > :not(caption) > * > * {
            background: transparent;
            border-color: var(--border);
            padding: 17px 18px;
            vertical-align: middle;
        }

        .table thead th {
            color: var(--muted);
            font-size: 11px;
            font-weight: 750;
            text-transform: uppercase;
            letter-spacing: .05em;
            white-space: nowrap;
            background: var(--surface-soft);
        }

        .table tbody tr {
            transition: background .18s ease;
        }

        .table tbody tr:hover {
            background: var(--surface-soft);
        }

        .contest-name {
            font-weight: 700;
            color: var(--text);
            margin-bottom: 3px;
        }

        .contest-description {
            color: var(--muted);
            font-size: 12px;
            max-width: 360px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .date-main {
            font-weight: 600;
            font-size: 13px;
        }

        .date-sub {
            color: var(--muted);
            font-size: 12px;
            margin-top: 2px;
        }

        .places {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-weight: 650;
        }

        .places svg {
            color: var(--primary);
        }

        .badge-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 11px;
            border-radius: 999px;
            background: var(--primary-soft);
            color: var(--primary);
            font-size: 11px;
            font-weight: 700;
            text-transform: capitalize;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--muted);
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: .2s;
        }

        .action-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: var(--primary-soft);
        }

        .action-btn.delete:hover {
            border-color: #dc2626;
            color: #dc2626;
            background: #fef2f2;
        }

        /* EMPTY */

        .empty-state {
            padding: 75px 25px;
            text-align: center;
        }

        .empty-icon {
            width: 72px;
            height: 72px;
            border-radius: 18px;
            background: var(--surface-soft);
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
        }

        .empty-state h5 {
            font-weight: 700;
            margin-bottom: 7px;
        }

        .empty-state p {
            color: var(--muted);
            margin-bottom: 22px;
        }

        @media (max-width: 992px) {

            .sidebar {
                width: 78px;
            }

            .brand span,
            .nav-link-admin span,
            .nav-section,
            .logout span {
                display: none;
            }

            .brand {
                justify-content: center;
                padding: 0;
            }

            .nav-link-admin,
            .logout {
                justify-content: center;
            }

            .main {
                margin-left: 78px;
            }

            .content {
                padding: 25px;
            }
        }

        @media (max-width: 576px) {

            .topbar {
                padding: 0 15px;
            }

            .content {
                padding: 20px 15px;
            }

            .page-heading h1 {
                font-size: 24px;
            }

            .card-toolbar {
                align-items: flex-start;
            }

            .contest-description {
                max-width: 200px;
            }
        }

    </style>

</head>

<body>

<aside class="sidebar">

    <div class="brand">

        <div class="brand-icon">
            <i data-lucide="shield-check"></i>
        </div>

        <span>Suivi Concours</span>

    </div>

    <div class="nav-section">
        Administration
    </div>

    <nav>

        <a href="${pageContext.request.contextPath}/DashboardServlet"
           class="nav-link-admin">

            <i data-lucide="layout-dashboard"></i>
            <span>Tableau de bord</span>

        </a>

        <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
           class="nav-link-admin active">

            <i data-lucide="trophy"></i>
            <span>Concours</span>

        </a>

        <a href="${pageContext.request.contextPath}/EpreuveServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="clipboard-list"></i>
            <span>Épreuves</span>

        </a>

        <a href="${pageContext.request.contextPath}/CandidatServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="users"></i>
            <span>Candidats</span>

        </a>

        <a href="${pageContext.request.contextPath}/InscriptionServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="file-check"></i>
            <span>Inscriptions</span>

        </a>

        <a href="${pageContext.request.contextPath}/DossierServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="folder-open"></i>
            <span>Dossiers</span>

        </a>

        <a href="${pageContext.request.contextPath}/ResultatServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="award"></i>
            <span>Résultats</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/statistiques/index.jsp"
           class="nav-link-admin">

            <i data-lucide="bar-chart-3"></i>
            <span>Statistiques</span>

        </a>

    </nav>

    <a href="${pageContext.request.contextPath}/LogoutServlet"
       class="logout">

        <i data-lucide="log-out"></i>
        <span>Déconnexion</span>

    </a>

</aside>

<main class="main">

    <header class="topbar">

        <div>

            <div class="page-title">
                Gestion des concours
            </div>

            <div class="page-subtitle">
                Administration des concours
            </div>

        </div>

        <button type="button"
                id="themeToggle"
                class="theme-btn"
                aria-label="Changer le thème">

            <i data-lucide="moon"></i>

        </button>

    </header>

    <section class="content">

        <div class="page-heading">

            <div class="eyebrow">
                Administration
            </div>

            <div class="d-flex flex-wrap justify-content-between
                        align-items-end gap-3">

                <div>

                    <h1>
                        Concours
                    </h1>

                    <p>
                        Gérez les concours disponibles sur la plateforme.
                    </p>

                </div>

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=ajouter"
                   class="btn btn-primary d-flex align-items-center gap-2">

                    <i data-lucide="plus" size="17"></i>
                    Nouveau concours

                </a>

            </div>

        </div>

        <div class="card-custom">

            <div class="card-toolbar">

                <div class="card-title-wrap">

                    <div class="card-icon">
                        <i data-lucide="trophy" size="18"></i>
                    </div>

                    <div>

                        <div class="card-title">
                            Liste des concours
                        </div>

                        <div class="card-count">

                            <%
                                if (concours != null) {
                            %>

                            <%= concours.size() %> concours enregistré(s)

                            <%
                                }
                            %>

                        </div>

                    </div>

                </div>

            </div>

            <%
                if (concours != null && !concours.isEmpty()) {
            %>

            <div class="table-responsive">

                <table class="table align-middle">

                    <thead>

                    <tr>
                        <th>Concours</th>
                        <th>Période</th>
                        <th>Places</th>
                        <th>Statut</th>
                        <th class="text-end">Actions</th>
                    </tr>

                    </thead>

                    <tbody>

                    <%
                        for (ConcoursModele c : concours) {
                    %>

                    <tr>

                        <td>

                            <div class="contest-name">
                                <%= c.getNom() %>
                            </div>

                            <div class="contest-description">

                                <%= c.getDescription() != null
                                        ? c.getDescription()
                                        : "" %>

                            </div>

                        </td>

                        <td>

                            <div class="date-main">
                                <%= c.getDate_debut() %>
                            </div>

                            <div class="date-sub">
                                au <%= c.getDate_fin() %>
                            </div>

                        </td>

                        <td>

                            <span class="places">

                                <i data-lucide="users" size="15"></i>

                                <%= c.getNombre_places() %>

                            </span>

                        </td>

                        <td>

                            <span class="badge-status">

                                <i data-lucide="circle-check" size="13"></i>

                                <%= c.getStatut() %>

                            </span>

                        </td>

                        <td class="text-end">

                            <div class="d-inline-flex gap-2">

                                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminDetails&id=<%= c.getId_concours() %>"
                                   class="action-btn"
                                   title="Détails">

                                    <i data-lucide="eye" size="16"></i>

                                </a>

                                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=modifier&id=<%= c.getId_concours() %>"
                                   class="action-btn"
                                   title="Modifier">

                                    <i data-lucide="pencil" size="16"></i>

                                </a>

                                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=supprimer&id=<%= c.getId_concours() %>"
                                   class="action-btn delete"
                                   title="Supprimer"
                                   onclick="return confirm('Voulez-vous vraiment supprimer ce concours ?');">

                                    <i data-lucide="trash-2" size="16"></i>

                                </a>

                            </div>

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

            <%
                } else {
            %>

            <div class="empty-state">

                <div class="empty-icon">

                    <i data-lucide="trophy" size="38"></i>

                </div>

                <h5>
                    Aucun concours
                </h5>

                <p>
                    Aucun concours n'est actuellement enregistré.
                </p>

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=ajouter"
                   class="btn btn-primary">

                    Ajouter un concours

                </a>

            </div>

            <%
                }
            %>

        </div>

    </section>

</main>

<script src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>

<script>

    const html = document.documentElement;
    const themeToggle = document.getElementById("themeToggle");

    function appliquerTheme() {

        const dark =
            localStorage.getItem("theme") === "dark";

        html.classList.toggle("dark", dark);

        themeToggle.innerHTML = dark
            ? '<i data-lucide="sun"></i>'
            : '<i data-lucide="moon"></i>';

        lucide.createIcons();
    }

    themeToggle.addEventListener("click", function () {

        const dark =
            html.classList.contains("dark");

        localStorage.setItem(
            "theme",
            dark ? "light" : "dark"
        );

        appliquerTheme();

    });

    appliquerTheme();

</script>

</body>
</html>