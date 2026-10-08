<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.DossierModele" %>

<%
    List<DossierModele> dossiers =
            (List<DossierModele>) request.getAttribute("dossiers");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dossiers - Suivi Concours</title>

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
            color:var(--muted);
            font-size:13px;
            margin-bottom:8px;
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

        .toolbar {
            padding:20px 24px;
            border-bottom:1px solid var(--border);
            display:flex;
            align-items:center;
            justify-content:space-between;
        }

        .toolbar-title {
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

        .count-badge {
            display:inline-flex;
            align-items:center;
            justify-content:center;
            min-width:30px;
            height:25px;
            padding:0 9px;
            border-radius:20px;
            background:var(--primary-soft);
            color:var(--primary);
            font-size:12px;
            font-weight:700;
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

        .id-value {
            color:var(--primary);
            font-weight:700;
        }

        .inscription-value {
            display:inline-flex;
            align-items:center;
            padding:6px 10px;
            border-radius:8px;
            background:var(--surface-soft);
            border:1px solid var(--border);
            font-size:12px;
            font-weight:650;
        }

        .status-badge {
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:7px 11px;
            border-radius:20px;
            font-size:12px;
            font-weight:700;
            white-space:nowrap;
        }

        .status-complet {
            background:#dcfce7;
            color:#15803d;
        }

        .status-incomplet {
            background:#fef3c7;
            color:#b45309;
        }

        .action-btn {
            width:36px;
            height:36px;
            border-radius:9px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            background:var(--surface);
            color:var(--muted);
            border:1px solid var(--border);
            text-decoration:none;
            transition:.2s ease;
        }

        .action-btn:hover {
            background:var(--primary-soft);
            border-color:#bfdbfe;
            color:var(--primary);
        }

        .empty-state {
            padding:65px 20px;
            text-align:center;
            color:var(--muted);
        }

        .empty-icon {
            width:68px;
            height:68px;
            border-radius:20px;
            background:var(--surface-soft);
            display:flex;
            align-items:center;
            justify-content:center;
            margin:0 auto;
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

        @media(max-width:1200px) {

            .table {
                min-width:1000px;
            }

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
            Gestion des dossiers
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
                ADMINISTRATION
            </div>

            <h1 class="page-title mb-1">
                Dossiers
            </h1>

            <p class="page-subtitle mb-0">
                Consultez et vérifiez les dossiers des candidats.
            </p>

        </div>


        <div class="card-custom overflow-hidden">

            <div class="toolbar">

                <div class="toolbar-title">

                    <div class="section-icon">
                        <i data-lucide="folder-open" size="19"></i>
                    </div>

                    <span>
                        Liste des dossiers
                    </span>

                    <% if (dossiers != null) { %>

                        <span class="count-badge">
                            <%= dossiers.size() %>
                        </span>

                    <% } %>

                </div>

            </div>


            <%
                if (dossiers != null && !dossiers.isEmpty()) {
            %>

            <div class="table-responsive">

                <table class="table align-middle">

                    <thead>

                    <tr>

                        <th>ID</th>
                        <th>Inscription</th>
                        <th>Niveau d'étude</th>
                        <th>Diplôme</th>
                        <th>Année</th>
                        <th>Établissement</th>
                        <th>État</th>
                        <th class="text-end">Actions</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        for (DossierModele dossier : dossiers) {
                    %>

                    <tr>

                        <td>

                            <span class="id-value">
                                #<%= dossier.getId_dossier() %>
                            </span>

                        </td>

                        <td>

                            <span class="inscription-value">
                                #<%= dossier.getId_inscription() %>
                            </span>

                        </td>

                        <td>
                            <div class="fw-semibold">
                                <%= dossier.getNiveau_etude() %>
                            </div>
                        </td>

                        <td>
                            <div class="fw-semibold">
                                <%= dossier.getDiplome() %>
                            </div>
                        </td>

                        <td>
                            <span class="text-secondary">
                                <%= dossier.getAnnee_diplome() %>
                            </span>
                        </td>

                        <td>
                            <span class="text-secondary">
                                <%= dossier.getEtablissement() %>
                            </span>
                        </td>

                        <td>

                            <% if (dossier.isComplet()) { %>

                                <span class="status-badge status-complet">

                                    <i data-lucide="check-circle" size="14"></i>
                                    Complet

                                </span>

                            <% } else { %>

                                <span class="status-badge status-incomplet">

                                    <i data-lucide="clock-3" size="14"></i>
                                    Incomplet

                                </span>

                            <% } %>

                        </td>

                        <td class="text-end">

                            <div class="d-inline-flex gap-2">

                                <a href="${pageContext.request.contextPath}/DossierServlet?action=details&id=<%= dossier.getId_dossier() %>"
                                   class="action-btn"
                                   title="Détails">

                                    <i data-lucide="eye" size="16"></i>

                                </a>

                                <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste&id_dossier=<%= dossier.getId_dossier() %>"
                                   class="action-btn"
                                   title="Documents">

                                    <i data-lucide="files" size="16"></i>

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

                    <i data-lucide="folder-x" size="32"></i>

                </div>

                <h5 class="mt-3 mb-2">
                    Aucun dossier
                </h5>

                <p class="mb-0">
                    Aucun dossier n'est actuellement enregistré.
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