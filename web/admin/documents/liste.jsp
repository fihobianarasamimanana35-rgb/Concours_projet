<%-- 
    Document   : liste
    Created on : 7 oct. 2026, 08:57:04
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.DocumentModele" %>

<%
    List<DocumentModele> documents =
            (List<DocumentModele>) request.getAttribute("documents");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Documents - Suivi Concours</title>

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
        }

        /* =========================
           HEADER
           ========================= */

        .page-heading {
            margin-bottom:28px;
        }

        .eyebrow {
            color:var(--primary);
            font-size:10px;
            font-weight:800;
            letter-spacing:.08em;
            text-transform:uppercase;
            margin-bottom:5px;
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
           CARD
           ========================= */

        .documents-card {
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:17px;
            overflow:hidden;
        }

        .card-toolbar {
            padding:20px 22px;
            border-bottom:1px solid var(--border);
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:15px;
        }

        .card-title-wrap {
            display:flex;
            align-items:center;
            gap:11px;
        }

        .card-icon {
            width:38px;
            height:38px;
            border-radius:10px;
            background:var(--primary-soft);
            color:var(--primary);
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .card-title {
            font-size:15px;
            font-weight:700;
        }

        .card-count {
            color:var(--muted);
            font-size:11px;
            margin-top:2px;
        }

        /* =========================
           TABLE
           ========================= */

        .table {
            color:var(--text);
            margin:0;
        }

        .table > :not(caption) > * > * {
            background:transparent;
            border-color:var(--border);
            padding:16px 17px;
            vertical-align:middle;
        }

        .table thead th {
            background:var(--surface-soft);
            color:var(--muted);
            font-size:10px;
            font-weight:750;
            text-transform:uppercase;
            letter-spacing:.05em;
            white-space:nowrap;
        }

        .table tbody tr {
            transition:.18s ease;
        }

        .table tbody tr:hover {
            background:var(--surface-soft);
        }

        .document-id {
            color:var(--muted);
            font-size:12px;
            font-weight:650;
        }

        .folder-id {
            display:inline-flex;
            align-items:center;
            gap:6px;
            color:var(--text);
            font-weight:650;
            font-size:13px;
        }

        .folder-id svg {
            color:var(--primary);
        }

        .type-badge {
            display:inline-flex;
            align-items:center;
            gap:5px;
            padding:6px 9px;
            border-radius:999px;
            font-size:10px;
            font-weight:700;
        }

        .type-cin {
            background:#eff6ff;
            color:#2563eb;
        }

        .type-copie {
            background:#ecfeff;
            color:#0891b2;
        }

        .type-diplome {
            background:#fffbeb;
            color:#d97706;
        }

        .type-photo {
            background:#f0fdf4;
            color:#16a34a;
        }

        .type-other {
            background:var(--surface-soft);
            color:var(--muted);
        }

        html.dark .type-cin {
            background:#172554;
        }

        html.dark .type-copie {
            background:#083344;
        }

        html.dark .type-diplome {
            background:#451a03;
        }

        html.dark .type-photo {
            background:#052e16;
        }

        .file-main {
            font-weight:650;
            font-size:13px;
            max-width:270px;
            overflow:hidden;
            text-overflow:ellipsis;
            white-space:nowrap;
        }

        .file-sub {
            color:var(--muted);
            font-size:10px;
            max-width:270px;
            overflow:hidden;
            text-overflow:ellipsis;
            white-space:nowrap;
            margin-top:3px;
        }

        .extension {
            color:var(--muted);
            font-size:12px;
            font-weight:650;
            text-transform:uppercase;
        }

        .size {
            color:var(--muted);
            font-size:12px;
            white-space:nowrap;
        }

        .status-badge {
            display:inline-flex;
            align-items:center;
            gap:5px;
            padding:6px 10px;
            border-radius:999px;
            font-size:10px;
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

        .action-btn {
            width:34px;
            height:34px;
            border:1px solid var(--border);
            background:var(--surface);
            color:var(--muted);
            border-radius:8px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            text-decoration:none;
            transition:.2s;
        }

        .action-btn:hover {
            border-color:var(--primary);
            color:var(--primary);
            background:var(--primary-soft);
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
            margin-bottom:7px;
        }

        .empty-state p {
            color:var(--muted);
            margin-bottom:0;
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

            .card-toolbar {
                padding:17px;
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
                Gestion des documents
            </div>

            <div class="topbar-subtitle">
                Administration des documents déposés
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

        <div class="page-heading">

            <div class="eyebrow">
                Administration
            </div>

            <h1>
                Documents
            </h1>

            <p>
                Consultez les documents déposés dans les dossiers des candidats.
            </p>

        </div>


        <div class="documents-card">

            <div class="card-toolbar">

                <div class="card-title-wrap">

                    <div class="card-icon">

                        <i data-lucide="files" size="19"></i>

                    </div>

                    <div>

                        <div class="card-title">
                            Liste des documents
                        </div>

                        <div class="card-count">

                            <%
                                if (documents != null) {
                            %>

                                <%= documents.size() %> document(s)

                            <%
                                }
                            %>

                        </div>

                    </div>

                </div>

            </div>


            <%
                if (documents != null && !documents.isEmpty()) {
            %>


            <div class="table-responsive">

                <table class="table align-middle">

                    <thead>

                    <tr>

                        <th>ID</th>
                        <th>Dossier</th>
                        <th>Type</th>
                        <th>Fichier</th>
                        <th>Extension</th>
                        <th>Taille</th>
                        <th>Conformité</th>
                        <th class="text-end">
                            Actions
                        </th>

                    </tr>

                    </thead>


                    <tbody>

                    <%
                        for (DocumentModele document : documents) {
                    %>

                    <tr>

                        <td>

                            <span class="document-id">
                                #<%= document.getId_document() %>
                            </span>

                        </td>


                        <td>

                            <span class="folder-id">

                                <i data-lucide="folder"
                                   size="15"></i>

                                #<%= document.getId_dossier() %>

                            </span>

                        </td>


                        <td>

                            <%
                                String type =
                                        document.getType_document();

                                if ("cin".equals(type)) {
                            %>

                                <span class="type-badge type-cin">

                                    <i data-lucide="credit-card"
                                       size="12"></i>

                                    CIN

                                </span>

                            <%
                                } else if ("copie".equals(type)) {
                            %>

                                <span class="type-badge type-copie">

                                    <i data-lucide="copy"
                                       size="12"></i>

                                    Copie

                                </span>

                            <%
                                } else if ("diplome_bacc".equals(type)) {
                            %>

                                <span class="type-badge type-diplome">

                                    <i data-lucide="graduation-cap"
                                       size="12"></i>

                                    Diplôme / BACC

                                </span>

                            <%
                                } else if ("photo".equals(type)) {
                            %>

                                <span class="type-badge type-photo">

                                    <i data-lucide="image"
                                       size="12"></i>

                                    Photo

                                </span>

                            <%
                                } else {
                            %>

                                <span class="type-badge type-other">

                                    <%= type %>

                                </span>

                            <%
                                }
                            %>

                        </td>


                        <td>

                            <div class="file-main"
                                 title="<%= document.getNom_original() %>">

                                <%= document.getNom_original() %>

                            </div>

                            <div class="file-sub"
                                 title="<%= document.getNom_fichier() %>">

                                <%= document.getNom_fichier() %>

                            </div>

                        </td>


                        <td>

                            <span class="extension">

                                <%= document.getExtension() %>

                            </span>

                        </td>


                        <td>

                            <span class="size">

                                <%= document.getTaille_octets() %>
                                octets

                            </span>

                        </td>


                        <td>

                            <% if (document.isConforme()) { %>

                                <span class="status-badge status-conforme">

                                    <i data-lucide="circle-check"
                                       size="13"></i>

                                    Conforme

                                </span>

                            <% } else { %>

                                <span class="status-badge status-non-conforme">

                                    <i data-lucide="triangle-alert"
                                       size="13"></i>

                                    Non conforme

                                </span>

                            <% } %>

                        </td>


                        <td class="text-end">

                            <div class="d-inline-flex gap-2">

                                <a href="${pageContext.request.contextPath}/DocumentServlet?action=details&id=<%= document.getId_document() %>"
                                   class="action-btn"
                                   title="Détails">

                                    <i data-lucide="eye"
                                       size="16"></i>

                                </a>


                                <a href="${pageContext.request.contextPath}/DossierServlet?action=details&id=<%= document.getId_dossier() %>"
                                   class="action-btn"
                                   title="Voir le dossier">

                                    <i data-lucide="folder-open"
                                       size="16"></i>

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

                    <i data-lucide="file-x"
                       size="38"></i>

                </div>

                <h4>
                    Aucun document
                </h4>

                <p>
                    Aucun document n'est actuellement enregistré.
                </p>

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