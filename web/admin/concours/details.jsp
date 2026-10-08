<%-- 
    Document   : details
    Created on : 5 oct. 2026, 15:08:08
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modele.ConcoursModele" %>

<%
    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails concours - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css" rel="stylesheet">

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
            --success: #16a34a;
            --danger: #dc2626;
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
            color: #ffffff;
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
            color: #ffffff;
            transform: translateX(2px);
        }

        .nav-link-admin.active {
            background: #2563eb;
            color: #ffffff;
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
            transition: .2s;
        }

        .logout:hover {
            background: var(--sidebar-hover);
            color: #ffffff;
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
            transition: .2s;
        }

        .theme-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        .content {
            padding: 32px;
            max-width: 1250px;
        }

        /* PAGE HEADER */

        .breadcrumb-custom {
            color: var(--muted);
            font-size: 13px;
            margin-bottom: 8px;
        }

        .breadcrumb-custom a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .breadcrumb-custom a:hover {
            text-decoration: underline;
        }

        .page-heading {
            margin-bottom: 28px;
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

        /* HERO */

        .contest-hero {
            background: linear-gradient(
                135deg,
                var(--surface),
                var(--surface-soft)
            );
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 26px;
            margin-bottom: 22px;
        }

        .contest-icon {
            width: 58px;
            height: 58px;
            border-radius: 15px;
            background: var(--primary-soft);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .contest-icon svg {
            width: 28px;
            height: 28px;
        }

        .contest-code {
            color: var(--muted);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .07em;
            margin-bottom: 4px;
        }

        .contest-title {
            font-size: 24px;
            font-weight: 750;
            margin: 0;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            background: var(--primary-soft);
            color: var(--primary);
            font-size: 12px;
            font-weight: 700;
            text-transform: capitalize;
        }

        /* CARDS */

        .card-custom {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .section-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .section-icon {
            width: 36px;
            height: 36px;
            border-radius: 9px;
            background: var(--primary-soft);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .section-title {
            margin: 0;
            font-size: 15px;
            font-weight: 700;
        }

        .section-subtitle {
            color: var(--muted);
            font-size: 12px;
            margin-top: 2px;
        }

        .section-body {
            padding: 24px;
        }

        .info-box {
            padding: 18px;
            border: 1px solid var(--border);
            border-radius: 12px;
            height: 100%;
            background: var(--surface);
            transition: .2s;
        }

        .info-box:hover {
            border-color: rgba(37, 99, 235, .35);
            box-shadow: 0 5px 18px rgba(15, 23, 42, .05);
        }

        .info-label {
            font-size: 11px;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: .06em;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .info-value {
            font-weight: 650;
            font-size: 15px;
        }

        .description {
            color: var(--muted);
            line-height: 1.75;
            white-space: pre-line;
        }

        .date-value {
            display: flex;
            align-items: center;
            gap: 9px;
            font-weight: 650;
        }

        .date-value svg {
            color: var(--primary);
            width: 17px;
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-top: 24px;
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

        .btn-light {
            background: var(--surface);
            color: var(--text);
            border-color: var(--border);
        }

        .btn-light:hover {
            background: var(--surface-soft);
            color: var(--text);
        }

        /* EMPTY */

        .empty-state {
            padding: 70px 25px;
            text-align: center;
        }

        .empty-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 20px;
            border-radius: 18px;
            background: var(--surface-soft);
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .empty-state h4 {
            font-weight: 700;
        }

        .empty-state p {
            color: var(--muted);
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

            .contest-hero {
                padding: 20px;
            }

            .contest-hero .d-flex {
                align-items: flex-start !important;
            }

            .contest-title {
                font-size: 20px;
            }

            .action-bar {
                flex-direction: column-reverse;
                align-items: stretch;
            }

            .action-bar .btn {
                width: 100%;
            }

            .section-body {
                padding: 18px;
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

    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
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

    <a href="${pageContext.request.contextPath}/LogoutServlet"
       class="logout">
        <i data-lucide="log-out"></i>
        <span>Déconnexion</span>
    </a>

</aside>

<main class="main">

    <header class="topbar">

        <div>
            <div class="page-title">Détails du concours</div>
            <div class="page-subtitle">Consultation des informations</div>
        </div>

        <button type="button"
                id="themeToggle"
                class="theme-btn"
                aria-label="Changer le thème">
            <i data-lucide="moon"></i>
        </button>

    </header>

    <section class="content">

        <%
            if (concours != null) {
        %>

        <div class="breadcrumb-custom">
            <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste">
                Concours
            </a>
            <span class="mx-1">/</span>
            Détails
        </div>

        <div class="page-heading">
            <h1>Détails du concours</h1>
            <p>Consultez les informations complètes du concours sélectionné.</p>
        </div>

        <div class="contest-hero">

            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">

                <div class="d-flex align-items-center gap-3">

                    <div class="contest-icon">
                        <i data-lucide="trophy"></i>
                    </div>

                    <div>

                        <div class="contest-code">
                            Concours
                        </div>

                        <h2 class="contest-title">
                            <%= concours.getNom() %>
                        </h2>

                    </div>

                </div>

                <span class="status-badge">
                    <i data-lucide="circle-check" size="14"></i>
                    <%= concours.getStatut() %>
                </span>

            </div>

        </div>

        <div class="card-custom mb-4">

            <div class="section-header">

                <div class="section-icon">
                    <i data-lucide="info"></i>
                </div>

                <div>
                    <h5 class="section-title">
                        Informations générales
                    </h5>

                    <div class="section-subtitle">
                        Informations principales du concours
                    </div>
                </div>

            </div>

            <div class="section-body">

                <div class="row g-3">

                    <div class="col-md-8">

                        <div class="info-box">

                            <div class="info-label">
                                Nom du concours
                            </div>

                            <div class="info-value fs-5">
                                <%= concours.getNom() %>
                            </div>

                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                Statut
                            </div>

                            <div class="info-value">
                                <span class="status-badge">
                                    <%= concours.getStatut() %>
                                </span>
                            </div>

                        </div>

                    </div>

                    <div class="col-12">

                        <div class="info-box">

                            <div class="info-label">
                                Description
                            </div>

                            <div class="description">
                                <%= concours.getDescription() != null &&
                                    !concours.getDescription().isEmpty()
                                        ? concours.getDescription()
                                        : "Aucune description disponible." %>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <div class="card-custom">

            <div class="section-header">

                <div class="section-icon">
                    <i data-lucide="calendar-days"></i>
                </div>

                <div>
                    <h5 class="section-title">
                        Période et capacité
                    </h5>

                    <div class="section-subtitle">
                        Dates d'inscription et nombre de places
                    </div>
                </div>

            </div>

            <div class="section-body">

                <div class="row g-3">

                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                Date de début
                            </div>

                            <div class="date-value">
                                <i data-lucide="calendar"></i>
                                <%= concours.getDate_debut() %>
                            </div>

                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                Date de fin
                            </div>

                            <div class="date-value">
                                <i data-lucide="calendar-check"></i>
                                <%= concours.getDate_fin() %>
                            </div>

                        </div>

                    </div>

                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                Nombre de places
                            </div>

                            <div class="date-value">
                                <i data-lucide="users"></i>
                                <%= concours.getNombre_places() %>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <div class="action-bar">

            <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
               class="btn btn-light border d-flex align-items-center gap-2">

                <i data-lucide="arrow-left" size="17"></i>
                Retour aux concours

            </a>

            <div class="d-flex gap-2">

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=modifier&id=<%= concours.getId_concours() %>"
                   class="btn btn-primary d-flex align-items-center gap-2">

                    <i data-lucide="pencil" size="17"></i>
                    Modifier

                </a>

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=supprimer&id=<%= concours.getId_concours() %>"
                   class="btn btn-outline-danger d-flex align-items-center gap-2"
                   onclick="return confirm('Voulez-vous vraiment supprimer ce concours ?');">

                    <i data-lucide="trash-2" size="17"></i>
                    Supprimer

                </a>

            </div>

        </div>

        <%
            } else {
        %>

        <div class="card-custom">

            <div class="empty-state">

                <div class="empty-icon">
                    <i data-lucide="circle-alert" size="38"></i>
                </div>

                <h4>Concours introuvable</h4>

                <p>
                    Le concours demandé n'existe pas ou n'est plus disponible.
                </p>

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
                   class="btn btn-primary">
                    Retour à la liste
                </a>

            </div>

        </div>

        <%
            }
        %>

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