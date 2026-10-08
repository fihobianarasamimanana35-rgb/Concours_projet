<%-- 
    Document   : liste
    Created on : 5 oct. 2026, 15:59:03
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modele.EpreuveModele"%>
<%@page import="modele.ConcoursModele"%>

<%
    List<EpreuveModele> epreuves =
            (List<EpreuveModele>) request.getAttribute("epreuves");

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if (epreuves == null) {
        epreuves = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Épreuves - Suivi Concours</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <style>
        :root {
            --bg: #f6f8fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
            --border: #e5e7eb;
            --text: #111827;
            --muted: #6b7280;
            --primary: #2563eb;
            --sidebar: #111827;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1e293b;
            --border: #334155;
            --text: #f3f4f6;
            --muted: #94a3b8;
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

        .sidebar {
            width: 250px;
            min-height: 100vh;
            background: var(--sidebar);
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            padding: 24px 16px;
            z-index: 1000;
        }

        .brand {
            color: #fff;
            font-size: 20px;
            font-weight: 700;
            padding: 0 12px 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .brand-icon {
            width: 38px;
            height: 38px;
            border-radius: 11px;
            background: linear-gradient(135deg, #2563eb, #4f46e5);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .nav-link-admin {
            color: #9ca3af;
            padding: 12px 14px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            margin-bottom: 4px;
            transition: .2s;
        }

        .nav-link-admin:hover,
        .nav-link-admin.active {
            background: #1f2937;
            color: #fff;
        }

        .nav-link-admin svg {
            width: 19px;
            height: 19px;
        }

        .logout {
            position: absolute;
            left: 16px;
            right: 16px;
            bottom: 20px;
            color: #9ca3af;
            text-decoration: none;
            padding: 12px 14px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logout:hover {
            background: #1f2937;
            color: #fff;
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

        .topbar-title {
            font-weight: 700;
        }

        .admin-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--muted);
            font-size: 14px;
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

        .content {
            padding: 32px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 750;
            letter-spacing: -.4px;
        }

        .page-subtitle {
            color: var(--muted);
        }

        .table-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .table-card-header {
            padding: 22px 26px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .table-card-header h5 {
            margin: 0;
            font-weight: 700;
        }

        .table-card-header p {
            margin: 4px 0 0;
            color: var(--muted);
            font-size: 13px;
        }

        .table {
            margin: 0;
            color: var(--text);
        }

        .table thead th {
            background: var(--surface-soft);
            color: var(--muted);
            border-bottom: 1px solid var(--border);
            font-size: 11px;
            font-weight: 750;
            text-transform: uppercase;
            letter-spacing: .6px;
            padding: 15px 14px;
            white-space: nowrap;
        }

        .table tbody td {
            padding: 16px 14px;
            border-color: var(--border);
            vertical-align: middle;
        }

        .table tbody tr:last-child td {
            border-bottom: 0;
        }

        .table-hover tbody tr:hover {
            background: var(--surface-soft);
        }

        .id-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 38px;
            height: 30px;
            padding: 0 9px;
            border-radius: 8px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            font-size: 12px;
            font-weight: 700;
        }

        .epreuve-name {
            font-weight: 700;
        }

        .description-preview {
            max-width: 260px;
            margin-top: 3px;
            color: var(--muted);
            font-size: 12px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .coefficient-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #eff6ff;
            color: #1d4ed8;
            border-radius: 20px;
            padding: 6px 10px;
            font-size: 12px;
            font-weight: 700;
        }

        html.dark .coefficient-badge {
            background: #172554;
            color: #93c5fd;
        }

        .action-btn {
            width: 35px;
            height: 35px;
            padding: 0;
            border-radius: 9px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .empty-state {
            padding: 70px 20px;
            text-align: center;
            color: var(--muted);
        }

        .empty-icon {
            width: 58px;
            height: 58px;
            border-radius: 16px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }

        .empty-state h5 {
            color: var(--text);
            font-weight: 700;
            margin-bottom: 5px;
        }

        .btn {
            border-radius: 10px;
            padding: 10px 17px;
            font-weight: 600;
        }

        .btn-primary {
            background: #2563eb;
            border-color: #2563eb;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;
        }

        @media(max-width: 992px) {
            .sidebar {
                width: 80px;
            }

            .brand span,
            .nav-link-admin span,
            .logout span {
                display: none;
            }

            .main {
                margin-left: 80px;
            }

            .content {
                padding: 24px;
            }
        }

        @media(max-width: 576px) {
            .topbar {
                padding: 0 18px;
            }

            .content {
                padding: 18px;
            }

            .admin-badge span {
                display: none;
            }

            .table-card-header {
                align-items: flex-start;
                gap: 15px;
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="sidebar">

    <div class="brand">
        <div class="brand-icon">
            <i data-lucide="trophy"></i>
        </div>
        <span>Suivi Concours</span>
    </div>

    <nav>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/DashboardServlet">
            <i data-lucide="layout-dashboard"></i>
            <span>Dashboard</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/ConcoursServlet?action=adminListe">
            <i data-lucide="trophy"></i>
            <span>Concours</span>
        </a>

        <a class="nav-link-admin active"
           href="<%= request.getContextPath() %>/EpreuveServlet?action=liste">
            <i data-lucide="file-text"></i>
            <span>Épreuves</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/CandidatServlet?action=liste">
            <i data-lucide="users"></i>
            <span>Candidats</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/InscriptionServlet?action=liste">
            <i data-lucide="clipboard-list"></i>
            <span>Inscriptions</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/DossierServlet?action=liste">
            <i data-lucide="folder-open"></i>
            <span>Dossiers</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/admin/resultats/liste.jsp">
            <i data-lucide="award"></i>
            <span>Résultats</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/admin/statistiques/index.jsp">
            <i data-lucide="bar-chart-3"></i>
            <span>Statistiques</span>
        </a>

    </nav>

    <a class="logout"
       href="<%= request.getContextPath() %>/LogoutServlet">
        <i data-lucide="log-out"></i>
        <span>Déconnexion</span>
    </a>

</div>

<div class="main">

    <header class="topbar">

        <div class="topbar-title">
            Gestion des épreuves
        </div>

        <div class="d-flex align-items-center gap-3">

            <button type="button"
                    class="theme-btn"
                    id="themeToggle">
                <i data-lucide="moon"></i>
            </button>

            <div class="admin-badge">
                <i data-lucide="shield-check"></i>
                <span>Administrateur</span>
            </div>

        </div>

    </header>

    <main class="content">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <div>
                <h1 class="page-title mb-1">
                    Épreuves
                </h1>

                <p class="page-subtitle mb-0">
                    Gérez les épreuves associées aux concours.
                </p>
            </div>

            <a href="<%= request.getContextPath() %>/EpreuveServlet?action=ajouter"
               class="btn btn-primary d-flex align-items-center gap-2">
                <i data-lucide="plus"></i>
                Ajouter une épreuve
            </a>

        </div>

        <% if ("ajout".equals(success)) { %>

            <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm">
                <div class="d-flex align-items-center gap-2">
                    <i data-lucide="circle-check"></i>
                    <span>L'épreuve a été ajoutée avec succès.</span>
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>

        <% } %>

        <% if ("modification".equals(success)) { %>

            <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm">
                <div class="d-flex align-items-center gap-2">
                    <i data-lucide="circle-check"></i>
                    <span>L'épreuve a été modifiée avec succès.</span>
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>

        <% } %>

        <% if ("suppression".equals(success)) { %>

            <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm">
                <div class="d-flex align-items-center gap-2">
                    <i data-lucide="circle-check"></i>
                    <span>L'épreuve a été supprimée avec succès.</span>
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>

        <% } %>

        <% if ("erreur".equals(error)) { %>

            <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm">
                <div class="d-flex align-items-center gap-2">
                    <i data-lucide="circle-alert"></i>
                    <span>Une erreur est survenue.</span>
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>

        <% } %>

        <div class="table-card">

            <div class="table-card-header">

                <div>
                    <h5>Liste des épreuves</h5>
                    <p>
                        Consultez et gérez les épreuves enregistrées.
                    </p>
                </div>

                <div class="small text-muted">
                    <%= epreuves.size() %> épreuve(s)
                </div>

            </div>

            <div class="table-responsive">

                <table class="table table-hover">

                    <thead>
                    <tr>
                        <th class="ps-4">ID</th>
                        <th>Épreuve</th>
                        <th>Concours</th>
                        <th>Heure</th>
                        <th>Durée</th>
                        <th>Coefficient</th>
                        <th class="pe-4">Actions</th>
                    </tr>
                    </thead>

                    <tbody>

                    <% if (epreuves.isEmpty()) { %>

                        <tr>
                            <td colspan="7">

                                <div class="empty-state">

                                    <div class="empty-icon">
                                        <i data-lucide="file-x-2"></i>
                                    </div>

                                    <h5>Aucune épreuve</h5>

                                    <div class="mb-3">
                                        Aucune épreuve n'est actuellement enregistrée.
                                    </div>

                                    <a href="<%= request.getContextPath() %>/EpreuveServlet?action=ajouter"
                                       class="btn btn-primary">
                                        <i data-lucide="plus"></i>
                                        Ajouter une épreuve
                                    </a>

                                </div>

                            </td>
                        </tr>

                    <% } else { %>

                        <% for (EpreuveModele epreuve : epreuves) { %>

                            <tr>

                                <td class="ps-4">
                                    <span class="id-badge">
                                        #<%= epreuve.getId_epreuve() %>
                                    </span>
                                </td>

                                <td>

                                    <div class="epreuve-name">
                                        <%= epreuve.getNom() %>
                                    </div>

                                    <% if (epreuve.getDescription() != null
                                            && !epreuve.getDescription().trim().isEmpty()) { %>

                                        <div class="description-preview">
                                            <%= epreuve.getDescription() %>
                                        </div>

                                    <% } %>

                                </td>

                                <td>
                                    <span class="text-muted">
                                        Concours #<%= epreuve.getId_concours() %>
                                    </span>
                                </td>

                                <td>
                                    <span class="d-inline-flex align-items-center gap-1">
                                        <i data-lucide="clock"
                                           style="width:15px;height:15px;"></i>

                                        <%= epreuve.getDate_epreuve() %>
                                    </span>
                                </td>

                                <td>
                                    <%= epreuve.getDuree_minutes() != null
                                            ? epreuve.getDuree_minutes() + " min"
                                            : "-" %>
                                </td>

                                <td>

                                    <span class="coefficient-badge">
                                        <i data-lucide="percent"
                                           style="width:13px;height:13px;"></i>
                                        <%= epreuve.getCoefficient() %>
                                    </span>

                                </td>

                                <td class="pe-4">

                                    <div class="d-flex gap-2">

                                        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=details&id=<%= epreuve.getId_epreuve() %>"
                                           class="btn btn-sm btn-outline-secondary action-btn"
                                           title="Détails">
                                            <i data-lucide="eye"></i>
                                        </a>

                                        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=modifier&id=<%= epreuve.getId_epreuve() %>"
                                           class="btn btn-sm btn-outline-primary action-btn"
                                           title="Modifier">
                                            <i data-lucide="pencil"></i>
                                        </a>

                                        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=supprimer&id=<%= epreuve.getId_epreuve() %>"
                                           class="btn btn-sm btn-outline-danger action-btn"
                                           title="Supprimer"
                                           onclick="return confirm('Voulez-vous vraiment supprimer cette épreuve ?');">
                                            <i data-lucide="trash-2"></i>
                                        </a>

                                    </div>

                                </td>

                            </tr>

                        <% } %>

                    <% } %>

                    </tbody>

                </table>

            </div>

        </div>

    </main>

</div>

<script src="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/lucide.min.js"></script>

<script>
    const themeToggle = document.getElementById("themeToggle");

    function applyTheme() {

        const dark =
                localStorage.getItem("theme") === "dark";

        document.documentElement.classList.toggle("dark", dark);

        themeToggle.innerHTML = dark
            ? '<i data-lucide="sun"></i>'
            : '<i data-lucide="moon"></i>';

        lucide.createIcons();
    }

    applyTheme();

    themeToggle.addEventListener("click", function () {

        const isDark =
                document.documentElement.classList.contains("dark");

        localStorage.setItem(
            "theme",
            isDark ? "light" : "dark"
        );

        applyTheme();
    });
</script>

</body>
</html>