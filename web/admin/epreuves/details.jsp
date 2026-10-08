<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modele.EpreuveModele"%>
<%@page import="modele.ConcoursModele"%>

<%
    EpreuveModele epreuve =
            (EpreuveModele) request.getAttribute("epreuve");

    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    if (epreuve == null) {
        response.sendRedirect(
                request.getContextPath()
                + "/EpreuveServlet?action=liste"
        );
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails de l'épreuve - Suivi Concours</title>

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
            max-width: 1200px;
        }

        .breadcrumb-link {
            text-decoration: none;
            color: var(--muted);
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-size: 14px;
            margin-bottom: 18px;
        }

        .breadcrumb-link:hover {
            color: var(--primary);
        }

        .page-title {
            font-size: 28px;
            font-weight: 750;
            margin-bottom: 5px;
        }

        .page-subtitle {
            color: var(--muted);
            margin-bottom: 28px;
        }

        .detail-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .detail-header {
            padding: 25px 28px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .title-wrap {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .title-icon {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        html.dark .title-icon {
            background: #172554;
        }

        .detail-header h3 {
            margin: 0;
            font-size: 20px;
            font-weight: 750;
        }

        .id-label {
            color: var(--muted);
            font-size: 13px;
            margin-top: 3px;
        }

        .detail-body {
            padding: 28px;
        }

        .detail-box {
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 18px;
            height: 100%;
        }

        .detail-label {
            color: var(--muted);
            font-size: 12px;
            font-weight: 650;
            text-transform: uppercase;
            letter-spacing: .4px;
            margin-bottom: 7px;
        }

        .detail-value {
            font-size: 16px;
            font-weight: 650;
            display: flex;
            align-items: center;
            gap: 8px;
            word-break: break-word;
        }

        .description-box {
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 20px;
            min-height: 110px;
            line-height: 1.6;
        }

        .btn {
            border-radius: 10px;
            padding: 10px 17px;
            font-weight: 600;
        }

        .btn-outline-secondary {
            color: var(--text);
            border-color: var(--border);
        }

        .btn-outline-secondary:hover {
            color: var(--text);
            background: var(--surface-soft);
            border-color: var(--border);
        }

        .action-bar {
            margin-top: 28px;
            padding-top: 22px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
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
        }

        @media(max-width: 576px) {
            .topbar {
                padding: 0 18px;
            }

            .content {
                padding: 18px;
            }

            .detail-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .admin-badge span {
                display: none;
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

        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=liste"
           class="breadcrumb-link">
            <i data-lucide="arrow-left"></i>
            Retour aux épreuves
        </a>

        <h1 class="page-title">
            Détails de l'épreuve
        </h1>

        <p class="page-subtitle">
            Consultez les informations complètes de cette épreuve.
        </p>

        <div class="detail-card">

            <div class="detail-header">

                <div class="title-wrap">

                    <div class="title-icon">
                        <i data-lucide="file-text"></i>
                    </div>

                    <div>
                        <h3>
                            <%= epreuve.getNom() %>
                        </h3>

                        <div class="id-label">
                            Épreuve #<%= epreuve.getId_epreuve() %>
                        </div>
                    </div>

                </div>

                <a href="<%= request.getContextPath() %>/EpreuveServlet?action=modifier&id=<%= epreuve.getId_epreuve() %>"
                   class="btn btn-primary d-flex align-items-center gap-2">
                    <i data-lucide="pencil"></i>
                    Modifier
                </a>

            </div>

            <div class="detail-body">

                <div class="row g-4">

                    <div class="col-md-6">

                        <div class="detail-box">

                            <div class="detail-label">
                                Concours
                            </div>

                            <div class="detail-value">

                                <% if (concours != null) { %>

                                    <%= concours.getCode_concours() %>
                                    -
                                    <%= concours.getNom() %>

                                <% } else { %>

                                    Concours #<%= epreuve.getId_concours() %>

                                <% } %>

                            </div>

                        </div>

                    </div>

                    <div class="col-md-6">

                        <div class="detail-box">

                            <div class="detail-label">
                                Heure de l'épreuve
                            </div>

                            <div class="detail-value">

                                <i data-lucide="clock"></i>

                                <%= epreuve.getDate_epreuve() != null
                                        ? epreuve.getDate_epreuve()
                                        : "-" %>

                            </div>

                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="detail-box">

                            <div class="detail-label">
                                Durée
                            </div>

                            <div class="detail-value">
                                <%= epreuve.getDuree_minutes() != null
                                        ? epreuve.getDuree_minutes() + " minutes"
                                        : "-" %>
                            </div>

                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="detail-box">

                            <div class="detail-label">
                                Coefficient
                            </div>

                            <div class="detail-value">
                                <%= epreuve.getCoefficient() %>
                            </div>

                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="detail-box">

                            <div class="detail-label">
                                Date de création
                            </div>

                            <div class="detail-value">

                                <%= epreuve.getDate_creation() != null
                                        ? epreuve.getDate_creation()
                                        : "-" %>

                            </div>

                        </div>

                    </div>

                    <div class="col-12">

                        <div class="detail-label">
                            Description
                        </div>

                        <div class="description-box">

                            <% if (epreuve.getDescription() != null
                                    && !epreuve.getDescription().trim().isEmpty()) { %>

                                <%= epreuve.getDescription() %>

                            <% } else { %>

                                <span class="text-muted">
                                    Aucune description disponible.
                                </span>

                            <% } %>

                        </div>

                    </div>

                </div>

                <div class="action-bar">

                    <a href="<%= request.getContextPath() %>/EpreuveServlet?action=liste"
                       class="btn btn-outline-secondary">
                        Retour
                    </a>

                    <a href="<%= request.getContextPath() %>/EpreuveServlet?action=modifier&id=<%= epreuve.getId_epreuve() %>"
                       class="btn btn-primary d-flex align-items-center gap-2">
                        <i data-lucide="pencil"></i>
                        Modifier
                    </a>

                </div>

            </div>

        </div>

    </main>

</div>

<script src="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/lucide.min.js"></script>

<script>
    const themeToggle = document.getElementById("themeToggle");

    function applyTheme() {
        const dark = localStorage.getItem("theme") === "dark";

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