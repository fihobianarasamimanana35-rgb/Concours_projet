<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modele.DossierModele" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.DocumentModele" %>

<%
    DossierModele dossier =
            (DossierModele) request.getAttribute("dossier");

    List<DocumentModele> documents =
            (List<DocumentModele>) request.getAttribute("documents");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails dossier - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        :root {
            --bg:#f6f8fb;
            --surface:#ffffff;
            --surface-soft:#f8fafc;
            --text:#172033;
            --muted:#6b7280;
            --border:#e5e7eb;
            --primary:#2563eb;
            --primary-soft:#eff6ff;
            --success:#16a34a;
            --warning:#d97706;
            --sidebar:#111827;
        }

        html.dark {
            --bg:#0f172a;
            --surface:#111827;
            --surface-soft:#172033;
            --text:#f3f4f6;
            --muted:#9ca3af;
            --border:#1f2937;
            --primary-soft:#172554;
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

        .sidebar {
            width:250px;
            min-height:100vh;
            background:var(--sidebar);
            position:fixed;
            left:0;
            top:0;
            bottom:0;
            padding:24px 16px;
            z-index:1000;
        }

        .brand {
            color:#fff;
            font-size:20px;
            font-weight:700;
            padding:0 12px 28px;
            display:flex;
            align-items:center;
            gap:10px;
        }

        .brand-icon {
            width:38px;
            height:38px;
            border-radius:11px;
            background:linear-gradient(135deg,#2563eb,#4f46e5);
            display:flex;
            align-items:center;
            justify-content:center;
            flex-shrink:0;
        }

        .nav-link-admin {
            color:#9ca3af;
            padding:12px 14px;
            border-radius:10px;
            display:flex;
            align-items:center;
            gap:12px;
            text-decoration:none;
            margin-bottom:4px;
            transition:.2s ease;
        }

        .nav-link-admin:hover,
        .nav-link-admin.active {
            background:#1f2937;
            color:#fff;
        }

        .nav-link-admin svg {
            width:19px;
            height:19px;
            flex-shrink:0;
        }

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
            font-size:16px;
            font-weight:700;
        }

        .theme-btn {
            width:40px;
            height:40px;
            border-radius:10px;
            display:flex;
            align-items:center;
            justify-content:center;
            background:var(--surface);
            color:var(--text);
            border:1px solid var(--border);
        }

        .theme-btn:hover {
            background:var(--surface-soft);
            color:var(--primary);
        }

        .content {
            padding:32px;
            max-width:1500px;
        }

        .breadcrumb-admin {
            display:flex;
            align-items:center;
            gap:8px;
            color:var(--muted);
            font-size:13px;
            margin-bottom:8px;
        }

        .breadcrumb-admin a {
            color:var(--muted);
            text-decoration:none;
        }

        .breadcrumb-admin a:hover {
            color:var(--primary);
        }

        .page-title {
            font-size:28px;
            font-weight:750;
            letter-spacing:-.5px;
        }

        .page-subtitle {
            color:var(--muted);
        }

        .card-custom {
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:16px;
            box-shadow:0 4px 16px rgba(15,23,42,.035);
        }

        .section-header {
            padding:20px 24px;
            border-bottom:1px solid var(--border);
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:15px;
        }

        .section-title {
            display:flex;
            align-items:center;
            gap:10px;
            font-weight:700;
        }

        .section-icon {
            width:38px;
            height:38px;
            border-radius:10px;
            background:var(--primary-soft);
            color:var(--primary);
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .info-box {
            height:100%;
            padding:18px;
            border:1px solid var(--border);
            border-radius:12px;
            background:var(--surface-soft);
        }

        .info-label {
            font-size:12px;
            font-weight:600;
            color:var(--muted);
            text-transform:uppercase;
            letter-spacing:.4px;
            margin-bottom:7px;
        }

        .info-value {
            font-size:15px;
            font-weight:650;
            color:var(--text);
            word-break:break-word;
        }

        .status-badge {
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:7px 11px;
            border-radius:20px;
            font-size:12px;
            font-weight:700;
        }

        .status-complet {
            background:#dcfce7;
            color:#15803d;
        }

        .status-incomplet {
            background:#fef3c7;
            color:#b45309;
        }

        .alert-warning-custom {
            background:#fffbeb;
            border:1px solid #fde68a;
            color:#92400e;
            border-radius:12px;
            padding:16px 18px;
        }

        html.dark .alert-warning-custom {
            background:#29200b;
            border-color:#5b4310;
            color:#fbbf24;
        }

        .table {
            color:var(--text);
            margin-bottom:0;
        }

        .table thead th {
            color:var(--muted);
            font-size:12px;
            font-weight:700;
            text-transform:uppercase;
            letter-spacing:.35px;
            white-space:nowrap;
            background:var(--surface-soft);
        }

        .table > :not(caption) > * > * {
            background:transparent;
            border-color:var(--border);
            padding:15px 18px;
        }

        .table tbody tr {
            transition:.15s ease;
        }

        .table tbody tr:hover {
            background:var(--surface-soft);
        }

        .document-type {
            display:inline-flex;
            align-items:center;
            gap:7px;
            padding:6px 10px;
            border-radius:8px;
            background:var(--primary-soft);
            color:var(--primary);
            font-size:12px;
            font-weight:700;
        }

        .conformity {
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:6px 10px;
            border-radius:20px;
            font-size:12px;
            font-weight:700;
        }

        .conformity-ok {
            background:#dcfce7;
            color:#15803d;
        }

        .conformity-no {
            background:#fef3c7;
            color:#b45309;
        }

        .empty-state {
            padding:60px 20px;
            text-align:center;
            color:var(--muted);
        }

        .empty-icon {
            width:64px;
            height:64px;
            border-radius:18px;
            background:var(--surface-soft);
            display:flex;
            align-items:center;
            justify-content:center;
            margin:0 auto;
        }

        .action-bar {
            display:flex;
            align-items:center;
            justify-content:space-between;
            margin-top:24px;
        }

        .btn-admin {
            border-radius:10px;
            font-weight:600;
            padding:10px 15px;
            display:inline-flex;
            align-items:center;
            gap:8px;
        }

        .btn-light-admin {
            background:var(--surface);
            color:var(--text);
            border:1px solid var(--border);
        }

        .btn-light-admin:hover {
            background:var(--surface-soft);
            color:var(--text);
        }

        .logout {
            position:absolute;
            left:16px;
            right:16px;
            bottom:20px;
            color:#9ca3af;
            text-decoration:none;
            padding:12px 14px;
            border-radius:10px;
            display:flex;
            align-items:center;
            gap:12px;
            transition:.2s ease;
        }

        .logout:hover {
            background:#1f2937;
            color:#fff;
        }

        @media(max-width:992px) {

            .sidebar {
                width:80px;
            }

            .brand {
                justify-content:center;
                padding-left:0;
                padding-right:0;
            }

            .brand span,
            .nav-link-admin span,
            .logout span {
                display:none;
            }

            .nav-link-admin {
                justify-content:center;
                padding:12px;
            }

            .main {
                margin-left:80px;
            }

            .content {
                padding:24px;
            }

        }

        @media(max-width:576px) {

            .topbar {
                padding:0 18px;
            }

            .content {
                padding:18px;
            }

            .page-title {
                font-size:23px;
            }

            .section-header {
                align-items:flex-start;
                flex-direction:column;
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
           class="nav-link-admin active">

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

        <div class="topbar-title">
            Détails du dossier
        </div>

        <button id="themeToggle"
                type="button"
                class="theme-btn"
                title="Changer le thème">

            <i data-lucide="moon"></i>

        </button>

    </header>


    <section class="content">

        <div class="mb-4">

            <div class="breadcrumb-admin">

                <a href="${pageContext.request.contextPath}/DossierServlet?action=liste">
                    Dossiers
                </a>

                <i data-lucide="chevron-right" size="14"></i>

                <span>Détails</span>

            </div>

            <h1 class="page-title mb-1">
                Détails du dossier
            </h1>

            <p class="page-subtitle mb-0">
                Consultez les informations et les documents du dossier.
            </p>

        </div>


        <% if (dossier != null) { %>


        <div class="card-custom mb-4">

            <div class="section-header">

                <div class="section-title">

                    <div class="section-icon">
                        <i data-lucide="folder-open" size="19"></i>
                    </div>

                    <span>
                        Informations du dossier
                    </span>

                </div>

                <% if (dossier.isComplet()) { %>

                    <span class="status-badge status-complet">

                        <i data-lucide="check-circle" size="14"></i>
                        Dossier complet

                    </span>

                <% } else { %>

                    <span class="status-badge status-incomplet">

                        <i data-lucide="alert-circle" size="14"></i>
                        Dossier incomplet

                    </span>

                <% } %>

            </div>


            <div class="p-4">

                <div class="row g-3">

                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                Identifiant
                            </div>

                            <div class="info-value">
                                #<%= dossier.getId_dossier() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                Inscription
                            </div>

                            <div class="info-value">
                                #<%= dossier.getId_inscription() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-4">

                        <div class="info-box">

                            <div class="info-label">
                                État
                            </div>

                            <div class="info-value">

                                <% if (dossier.isComplet()) { %>

                                    <span class="status-badge status-complet">
                                        <i data-lucide="check" size="14"></i>
                                        Complet
                                    </span>

                                <% } else { %>

                                    <span class="status-badge status-incomplet">
                                        <i data-lucide="clock-3" size="14"></i>
                                        Incomplet
                                    </span>

                                <% } %>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Niveau d'étude
                            </div>

                            <div class="info-value">
                                <%= dossier.getNiveau_etude() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Diplôme
                            </div>

                            <div class="info-value">
                                <%= dossier.getDiplome() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Année du diplôme
                            </div>

                            <div class="info-value">
                                <%= dossier.getAnnee_diplome() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Établissement
                            </div>

                            <div class="info-value">
                                <%= dossier.getEtablissement() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Date de création
                            </div>

                            <div class="info-value">
                                <%= dossier.getDate_creation() %>
                            </div>

                        </div>

                    </div>


                    <div class="col-md-6">

                        <div class="info-box">

                            <div class="info-label">
                                Date de vérification
                            </div>

                            <div class="info-value">

                                <%= dossier.getDate_verification() != null
                                        ? dossier.getDate_verification()
                                        : "Non vérifié" %>

                            </div>

                        </div>

                    </div>


                    <% if (dossier.getMotif_incomplet() != null
                            && !dossier.getMotif_incomplet().trim().isEmpty()) { %>

                    <div class="col-12">

                        <div class="alert-warning-custom">

                            <div class="d-flex gap-3">

                                <i data-lucide="alert-triangle" size="20"></i>

                                <div>

                                    <strong>
                                        Motif du dossier incomplet :
                                    </strong>

                                    <div class="mt-1">
                                        <%= dossier.getMotif_incomplet() %>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <% } %>

                </div>

            </div>

        </div>


        <div class="card-custom overflow-hidden">

            <div class="section-header">

                <div class="section-title">

                    <div class="section-icon">
                        <i data-lucide="files" size="19"></i>
                    </div>

                    <span>
                        Documents du dossier
                    </span>

                </div>

                <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste&id_dossier=<%= dossier.getId_dossier() %>"
                   class="btn btn-primary btn-admin">

                    <i data-lucide="files" size="16"></i>

                    Voir tous

                </a>

            </div>


            <%
                if (documents != null && !documents.isEmpty()) {
            %>

            <div class="table-responsive">

                <table class="table align-middle">

                    <thead>

                    <tr>

                        <th>Type</th>
                        <th>Nom original</th>
                        <th>Extension</th>
                        <th>Taille</th>
                        <th>Conformité</th>
                        <th class="text-end">Action</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        for (DocumentModele document : documents) {
                    %>

                    <tr>

                        <td>

                            <span class="document-type">

                                <i data-lucide="file-text" size="14"></i>

                                <%= document.getType_document() %>

                            </span>

                        </td>

                        <td>

                            <div class="fw-semibold">
                                <%= document.getNom_original() %>
                            </div>

                        </td>

                        <td>

                            <span class="badge bg-secondary-subtle text-secondary">
                                <%= document.getExtension() %>
                            </span>

                        </td>

                        <td>
                            <span class="text-secondary">
                                <%= document.getTaille_octets() %> octets
                            </span>
                        </td>

                        <td>

                            <% if (document.isConforme()) { %>

                            <span class="conformity conformity-ok">

                                <i data-lucide="check-circle" size="14"></i>
                                Conforme

                            </span>

                            <% } else { %>

                            <span class="conformity conformity-no">

                                <i data-lucide="alert-circle" size="14"></i>
                                Non conforme

                            </span>

                            <% } %>

                        </td>

                        <td class="text-end">

                            <a href="${pageContext.request.contextPath}/DocumentServlet?action=details&id=<%= document.getId_document() %>"
                               class="btn btn-sm btn-light border"
                               title="Voir le document">

                                <i data-lucide="eye" size="16"></i>

                            </a>

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

                    <i data-lucide="file-x" size="30"></i>

                </div>

                <h5 class="mt-3 mb-2">
                    Aucun document
                </h5>

                <p class="mb-0">
                    Aucun document enregistré pour ce dossier.
                </p>

            </div>

            <%
                }
            %>

        </div>


        <div class="action-bar">

            <a href="${pageContext.request.contextPath}/DossierServlet?action=liste"
               class="btn btn-light-admin btn-admin">

                <i data-lucide="arrow-left" size="16"></i>

                Retour aux dossiers

            </a>

        </div>


        <% } else { %>


        <div class="card-custom">

            <div class="empty-state">

                <div class="empty-icon">

                    <i data-lucide="folder-x" size="32"></i>

                </div>

                <h5 class="mt-3 mb-2">
                    Dossier introuvable
                </h5>

                <p class="mb-0">
                    Le dossier demandé est introuvable.
                </p>

                <a href="${pageContext.request.contextPath}/DossierServlet?action=liste"
                   class="btn btn-primary btn-admin mt-4">

                    <i data-lucide="arrow-left" size="16"></i>

                    Retour aux dossiers

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

    function updateThemeIcon() {

        themeToggle.innerHTML =
            html.classList.contains("dark")
                ? '<i data-lucide="sun"></i>'
                : '<i data-lucide="moon"></i>';

        lucide.createIcons();

    }

    if (localStorage.getItem("theme") === "dark") {
        html.classList.add("dark");
    }

    updateThemeIcon();

    themeToggle.addEventListener("click", function () {

        html.classList.toggle("dark");

        localStorage.setItem(
            "theme",
            html.classList.contains("dark") ? "dark" : "light"
        );

        updateThemeIcon();

    });

    lucide.createIcons();

</script>

</body>
</html>