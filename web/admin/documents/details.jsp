<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modele.DocumentModele" %>

<%
    DocumentModele document =
            (DocumentModele) request.getAttribute("document");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails document - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        :root {
            --bg:#f5f7fb;
            --surface:#ffffff;
            --surface-soft:#f8fafc;
            --text:#172033;
            --muted:#6b7280;
            --border:#e5e7eb;
            --primary:#2563eb;
            --primary-soft:#eff6ff;
            --success:#16a34a;
            --success-soft:#f0fdf4;
            --warning:#d97706;
            --warning-soft:#fffbeb;
            --danger:#dc2626;
            --sidebar:#111827;
            --sidebar-hover:#1f2937;
        }

        html.dark {
            --bg:#0f172a;
            --surface:#111827;
            --surface-soft:#1f2937;
            --text:#f3f4f6;
            --muted:#9ca3af;
            --border:#374151;
            --primary:#3b82f6;
            --primary-soft:#172554;
            --success:#22c55e;
            --success-soft:#052e16;
            --warning:#f59e0b;
            --warning-soft:#451a03;
            --danger:#ef4444;
            --sidebar:#020617;
            --sidebar-hover:#1f2937;
        }

        * {
            box-sizing:border-box;
        }

        body {
            margin:0;
            background:var(--bg);
            color:var(--text);
            font-family:Inter,system-ui,-apple-system,
                         BlinkMacSystemFont,"Segoe UI",sans-serif;
        }

        /* =========================
           SIDEBAR
           ========================= */

        .sidebar {
            width:250px;
            min-height:100vh;
            background:var(--sidebar);
            position:fixed;
            left:0;
            top:0;
            bottom:0;
            padding:22px 16px;
            z-index:1000;
        }

        .brand {
            height:52px;
            color:#fff;
            font-size:19px;
            font-weight:700;
            padding:0 12px;
            display:flex;
            align-items:center;
            gap:11px;
            margin-bottom:24px;
        }

        .brand-icon {
            width:35px;
            height:35px;
            border-radius:10px;
            background:linear-gradient(135deg,#2563eb,#3b82f6);
            display:flex;
            align-items:center;
            justify-content:center;
            box-shadow:0 5px 15px rgba(37,99,235,.25);
        }

        .nav-section {
            color:#6b7280;
            font-size:10px;
            font-weight:700;
            text-transform:uppercase;
            letter-spacing:.08em;
            padding:0 12px;
            margin:18px 0 8px;
        }

        .nav-link-admin {
            color:#9ca3af;
            padding:11px 13px;
            border-radius:10px;
            display:flex;
            align-items:center;
            gap:12px;
            text-decoration:none;
            margin-bottom:4px;
            font-size:14px;
            transition:.2s ease;
        }

        .nav-link-admin svg {
            width:18px;
            height:18px;
            flex-shrink:0;
        }

        .nav-link-admin:hover {
            background:var(--sidebar-hover);
            color:#fff;
            transform:translateX(2px);
        }

        .nav-link-admin.active {
            background:#2563eb;
            color:#fff;
            box-shadow:0 6px 16px rgba(37,99,235,.20);
        }

        .logout {
            position:absolute;
            left:16px;
            right:16px;
            bottom:18px;
            color:#9ca3af;
            text-decoration:none;
            padding:11px 13px;
            border-radius:10px;
            display:flex;
            align-items:center;
            gap:12px;
            font-size:14px;
        }

        .logout:hover {
            background:var(--sidebar-hover);
            color:#fff;
        }

        /* =========================
           MAIN
           ========================= */

        .main {
            margin-left:250px;
            min-height:100vh;
        }

        .topbar {
            height:72px;
            background:var(--surface);
            border-bottom:1px solid var(--border);
            display:flex;
            align-items:center;
            justify-content:space-between;
            padding:0 32px;
        }

        .topbar-title {
            font-size:17px;
            font-weight:700;
        }

        .topbar-subtitle {
            color:var(--muted);
            font-size:12px;
            margin-top:2px;
        }

        .theme-btn {
            width:40px;
            height:40px;
            border:1px solid var(--border);
            background:var(--surface);
            color:var(--text);
            border-radius:10px;
            display:flex;
            align-items:center;
            justify-content:center;
            transition:.2s;
        }

        .theme-btn:hover {
            border-color:var(--primary);
            color:var(--primary);
        }

        .content {
            padding:32px;
            max-width:1250px;
        }

        /* =========================
           PAGE HEADER
           ========================= */

        .breadcrumb-custom {
            color:var(--muted);
            font-size:12px;
            margin-bottom:8px;
        }

        .breadcrumb-custom a {
            color:var(--primary);
            text-decoration:none;
            font-weight:600;
        }

        .breadcrumb-custom a:hover {
            text-decoration:underline;
        }

        .page-heading {
            margin-bottom:28px;
        }

        .page-heading h1 {
            font-size:28px;
            font-weight:750;
            letter-spacing:-.02em;
            margin:0 0 5px;
        }

        .page-heading p {
            color:var(--muted);
            margin:0;
        }

        /* =========================
           MAIN DOCUMENT CARD
           ========================= */

        .document-card {
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:17px;
            overflow:hidden;
        }

        .document-header {
            padding:24px;
            border-bottom:1px solid var(--border);
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:20px;
        }

        .document-heading {
            display:flex;
            align-items:center;
            gap:14px;
        }

        .document-icon {
            width:48px;
            height:48px;
            border-radius:13px;
            background:var(--primary-soft);
            color:var(--primary);
            display:flex;
            align-items:center;
            justify-content:center;
            flex-shrink:0;
        }

        .document-heading h5 {
            margin:0;
            font-size:16px;
            font-weight:700;
        }

        .document-heading p {
            margin:4px 0 0;
            color:var(--muted);
            font-size:12px;
        }

        /* =========================
           STATUS
           ========================= */

        .status-badge {
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:7px 12px;
            border-radius:999px;
            font-size:11px;
            font-weight:700;
        }

        .status-conforme {
            color:var(--success);
            background:var(--success-soft);
        }

        .status-non-conforme {
            color:var(--warning);
            background:var(--warning-soft);
        }

        /* =========================
           INFO
           ========================= */

        .document-body {
            padding:28px 24px;
        }

        .info-box {
            height:100%;
            border:1px solid var(--border);
            background:var(--surface);
            border-radius:12px;
            padding:17px;
            transition:.2s ease;
        }

        .info-box:hover {
            border-color:rgba(37,99,235,.35);
            box-shadow:0 5px 18px rgba(15,23,42,.05);
        }

        .info-label {
            font-size:10px;
            color:var(--muted);
            text-transform:uppercase;
            letter-spacing:.06em;
            font-weight:750;
            margin-bottom:7px;
        }

        .info-value {
            font-size:14px;
            font-weight:650;
            word-break:break-word;
        }

        .info-value.muted {
            color:var(--muted);
        }

        .file-name {
            display:flex;
            align-items:center;
            gap:9px;
        }

        .file-name svg {
            color:var(--primary);
            flex-shrink:0;
        }

        .path-box {
            background:var(--surface-soft);
            border-radius:9px;
            padding:12px;
            font-family:monospace;
            font-size:12px;
            color:var(--muted);
            word-break:break-all;
        }

        /* =========================
           ACTIONS
           ========================= */

        .action-bar {
            padding:20px 24px;
            border-top:1px solid var(--border);
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:10px;
        }

        .action-group {
            display:flex;
            flex-wrap:wrap;
            gap:9px;
        }

        .btn {
            border-radius:9px;
            font-weight:600;
        }

        .btn-light-custom {
            background:var(--surface);
            color:var(--text);
            border:1px solid var(--border);
        }

        .btn-light-custom:hover {
            background:var(--surface-soft);
            color:var(--text);
        }

        .btn-primary {
            background:var(--primary);
            border-color:var(--primary);
        }

        .btn-primary:hover {
            background:#1d4ed8;
            border-color:#1d4ed8;
        }

        /* =========================
           EMPTY
           ========================= */

        .empty-state {
            padding:75px 25px;
            text-align:center;
        }

        .empty-icon {
            width:72px;
            height:72px;
            border-radius:18px;
            background:var(--surface-soft);
            color:var(--muted);
            display:flex;
            align-items:center;
            justify-content:center;
            margin:0 auto 18px;
        }

        .empty-state h4 {
            font-weight:700;
        }

        .empty-state p {
            color:var(--muted);
            margin-bottom:22px;
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media(max-width:992px) {

            .sidebar {
                width:78px;
            }

            .brand span,
            .nav-link-admin span,
            .nav-section,
            .logout span {
                display:none;
            }

            .brand {
                justify-content:center;
                padding:0;
            }

            .nav-link-admin,
            .logout {
                justify-content:center;
            }

            .main {
                margin-left:78px;
            }

            .content {
                padding:25px;
            }

        }

        @media(max-width:576px) {

            .topbar {
                padding:0 15px;
            }

            .content {
                padding:20px 15px;
            }

            .page-heading h1 {
                font-size:24px;
            }

            .document-header {
                align-items:flex-start;
                flex-direction:column;
            }

            .document-body {
                padding:20px 16px;
            }

            .action-bar {
                flex-direction:column;
                align-items:stretch;
            }

            .action-group {
                flex-direction:column;
            }

            .action-group .btn,
            .action-bar > .btn {
                width:100%;
                justify-content:center;
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
           class="nav-link-admin">

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

        <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste"
           class="nav-link-admin active">

            <i data-lucide="files"></i>
            <span>Documents</span>

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

            <div class="topbar-title">
                Détails du document
            </div>

            <div class="topbar-subtitle">
                Consultation du document déposé
            </div>

        </div>

        <button id="themeToggle"
                type="button"
                class="theme-btn"
                aria-label="Changer le thème">

            <i data-lucide="moon"></i>

        </button>

    </header>


    <section class="content">

        <div class="breadcrumb-custom">

            <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste">
                Documents
            </a>

            <span class="mx-1">/</span>

            Détails

        </div>


        <div class="page-heading">

            <h1>
                Détails du document
            </h1>

            <p>
                Consultez les informations du document déposé.
            </p>

        </div>


        <% if (document != null) { %>


        <div class="document-card">

            <div class="document-header">

                <div class="document-heading">

                    <div class="document-icon">

                        <i data-lucide="file-text" size="24"></i>

                    </div>

                    <div>

                        <h5>
                            Informations du document
                        </h5>

                        <p>
                            Document #<%= document.getId_document() %>
                        </p>

                    </div>

                </div>


                <% if (document.isConforme()) { %>

                    <span class="status-badge status-conforme">

                        <i data-lucide="circle-check" size="14"></i>

                        Conforme

                    </span>

                <% } else { %>

                    <span class="status-badge status-non-conforme">

                        <i data-lucide="triangle-alert" size="14"></i>

                        Non conforme

                    </span>

                <% } %>

            </div>


            <div class="document-body">

                <div class="row g-3">


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Identifiant
                            </div>

                            <div class="info-value">
                                #<%= document.getId_document() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Dossier
                            </div>

                            <div class="info-value">

                                <i data-lucide="folder-open"
                                   size="15"
                                   class="me-1"></i>

                                #<%= document.getId_dossier() %>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Type de document
                            </div>

                            <div class="info-value">

                                <%= document.getType_document() %>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Extension
                            </div>

                            <div class="info-value">

                                <%= document.getExtension() %>

                            </div>

                        </div>

                    </div>


                    <div class="col-12">

                        <div class="info-box">

                            <div class="info-label">
                                Nom original
                            </div>

                            <div class="info-value file-name">

                                <i data-lucide="file-text"
                                   size="17"></i>

                                <span>
                                    <%= document.getNom_original() %>
                                </span>

                            </div>

                        </div>

                    </div>


                    <div class="col-12">

                        <div class="info-box">

                            <div class="info-label">
                                Nom du fichier
                            </div>

                            <div class="info-value">

                                <%= document.getNom_fichier() %>

                            </div>

                        </div>

                    </div>


                    <div class="col-12">

                        <div class="info-box">

                            <div class="info-label">
                                Chemin du fichier
                            </div>

                            <div class="path-box">

                                <%= document.getChemin_fichier() %>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Taille
                            </div>

                            <div class="info-value">

                                <i data-lucide="hard-drive"
                                   size="15"
                                   class="me-1"></i>

                                <%= document.getTaille_octets() %> octets

                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Date d'upload
                            </div>

                            <div class="info-value">

                                <i data-lucide="calendar"
                                   size="15"
                                   class="me-1"></i>

                                <%= document.getDate_upload() %>

                            </div>

                        </div>

                    </div>


                    <div class="col-12">

                        <div class="info-box">

                            <div class="info-label">
                                Conformité du document
                            </div>

                            <div>

                                <% if (document.isConforme()) { %>

                                    <span class="status-badge status-conforme">

                                        <i data-lucide="circle-check"
                                           size="14"></i>

                                        Document conforme

                                    </span>

                                <% } else { %>

                                    <span class="status-badge status-non-conforme">

                                        <i data-lucide="triangle-alert"
                                           size="14"></i>

                                        Document non conforme

                                    </span>

                                <% } %>

                            </div>

                        </div>

                    </div>


                </div>

            </div>


            <div class="action-bar">

                <a href="${pageContext.request.contextPath}/DossierServlet?action=details&id=<%= document.getId_dossier() %>"
                   class="btn btn-light-custom d-flex align-items-center gap-2">

                    <i data-lucide="arrow-left" size="16"></i>

                    Retour au dossier

                </a>


                <div class="action-group">

                    <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste"
                       class="btn btn-light-custom d-flex align-items-center gap-2">

                        <i data-lucide="files" size="16"></i>

                        Tous les documents

                    </a>


                    <a href="${pageContext.request.contextPath}/<%= document.getChemin_fichier() %>"
                       target="_blank"
                       class="btn btn-primary d-flex align-items-center gap-2">

                        <i data-lucide="external-link" size="16"></i>

                        Ouvrir le fichier

                    </a>

                </div>

            </div>

        </div>


        <% } else { %>


        <div class="document-card">

            <div class="empty-state">

                <div class="empty-icon">

                    <i data-lucide="file-x" size="38"></i>

                </div>

                <h4>
                    Document introuvable
                </h4>

                <p>
                    Le document demandé n'existe pas ou n'est plus disponible.
                </p>

                <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste"
                   class="btn btn-primary">

                    Retour aux documents

                </a>

            </div>

        </div>


        <% } %>

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