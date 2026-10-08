<%--
    Document   : liste
    Created on : 7 oct. 2026, 08:28:10
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modele.CandidatModele"%>

<%
    List<CandidatModele> candidats =
            (List<CandidatModele>) request.getAttribute("candidats");

    if (candidats == null) {
        response.sendRedirect(
                request.getContextPath()
                + "/CandidatsServlet"
        );
        return;
    }
%>

<!DOCTYPE html>

<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Candidats - Suivi Concours</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">


    <style>

        :root {

            --bg: #f5f7fb;
            --surface: #ffffff;
            --surface-secondary: #f8fafc;

            --text: #172033;
            --muted: #64748b;

            --border: #e5e7eb;

            --primary: #2563eb;
            --primary-dark: #1d4ed8;

            --sidebar: #0f172a;
            --sidebar-hover: #1e293b;
            --sidebar-text: #94a3b8;

        }


        body.dark {

            --bg: #0b1120;
            --surface: #111827;
            --surface-secondary: #1e293b;

            --text: #f8fafc;
            --muted: #94a3b8;

            --border: #263244;

            --primary: #3b82f6;
            --primary-dark: #2563eb;

            --sidebar: #020617;
            --sidebar-hover: #172033;
            --sidebar-text: #94a3b8;

        }


        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            background: var(--bg);

            color: var(--text);

            font-family:
                Inter,
                system-ui,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                sans-serif;

            transition:
                background .25s ease,
                color .25s ease;

        }


        /* =====================================================
           SIDEBAR
        ===================================================== */

        .sidebar {

            position: fixed;

            top: 0;
            bottom: 0;
            left: 0;

            width: 250px;

            background: var(--sidebar);

            padding: 20px 14px;

            z-index: 1000;

            box-shadow:
                8px 0 30px rgba(15,23,42,.08);

        }


        .sidebar-brand {

            height: 52px;

            display: flex;

            align-items: center;

            gap: 11px;

            padding: 0 12px;

            color: #fff;

            font-size: 18px;

            font-weight: 750;

            margin-bottom: 25px;

        }


        .brand-icon {

            width: 36px;
            height: 36px;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            display: flex;

            align-items: center;
            justify-content: center;

            box-shadow:
                0 8px 20px rgba(37,99,235,.3);

            flex-shrink: 0;

        }


        .sidebar-section {

            color: #64748b;

            font-size: 10px;

            font-weight: 800;

            text-transform: uppercase;

            padding: 0 12px;

            margin: 12px 0 8px;

            letter-spacing: .1em;

        }


        .sidebar a {

            color: var(--sidebar-text);

            text-decoration: none;

            display: flex;

            align-items: center;

            gap: 12px;

            min-height: 44px;

            padding: 10px 13px;

            margin-bottom: 4px;

            border-radius: 10px;

            font-size: 13.5px;

            font-weight: 500;

            transition: .2s ease;

        }


        .sidebar a svg {

            width: 18px;
            height: 18px;

            flex-shrink: 0;

        }


        .sidebar a:hover {

            color: white;

            background: var(--sidebar-hover);

            transform: translateX(2px);

        }


        .sidebar a.active {

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            box-shadow:
                0 7px 18px rgba(37,99,235,.22);

        }


        .sidebar-footer {

            position: absolute;

            left: 14px;
            right: 14px;
            bottom: 18px;

        }


        .sidebar-footer a:hover {

            background: rgba(220,38,38,.12);

            color: #fca5a5;

        }


        /* =====================================================
           MAIN
        ===================================================== */

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

            position: sticky;

            top: 0;

            z-index: 900;

        }


        .topbar-title {

            font-size: 16px;

            font-weight: 750;

            letter-spacing: -.2px;

        }


        .topbar-subtitle {

            color: var(--muted);

            font-size: 11px;

            margin-top: 2px;

        }


        .admin-profile {

            display: flex;

            align-items: center;

            gap: 9px;

            color: var(--muted);

            font-size: 12px;

        }


        .admin-avatar {

            width: 35px;
            height: 35px;

            border-radius: 10px;

            background: rgba(37,99,235,.1);

            color: var(--primary);

            display: flex;

            align-items: center;

            justify-content: center;

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

            cursor: pointer;

            transition: .2s ease;

        }


        .theme-btn:hover {

            color: var(--primary);

            border-color: var(--primary);

            transform: translateY(-1px);

        }


        .content {

            padding: 32px;

            max-width: 1700px;

            margin: auto;

        }


        /* =====================================================
           PAGE HEADER
        ===================================================== */

        .page-header {

            display: flex;

            justify-content: space-between;

            align-items: flex-end;

            gap: 20px;

            margin-bottom: 25px;

        }


        .page-kicker {

            color: var(--primary);

            font-size: 11px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .08em;

            margin-bottom: 7px;

        }


        .page-header h1 {

            font-size: 26px;

            font-weight: 750;

            letter-spacing: -.5px;

            margin: 0 0 5px;

        }


        .page-header p {

            color: var(--muted);

            font-size: 13px;

            margin: 0;

        }


        /* =====================================================
           MAIN CARD
        ===================================================== */

        .table-card {

            background: var(--surface);

            border: 1px solid var(--border);

            border-radius: 17px;

            overflow: hidden;

            box-shadow:
                0 8px 25px rgba(15,23,42,.035);

        }


        .table-card-header {

            padding: 21px 24px;

            border-bottom: 1px solid var(--border);

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

        }


        .table-card-title {

            font-size: 15px;

            font-weight: 750;

        }


        .table-card-subtitle {

            color: var(--muted);

            font-size: 12px;

            margin-top: 3px;

        }


        .count-badge {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            background: var(--surface-secondary);

            color: var(--muted);

            border: 1px solid var(--border);

            padding: 7px 10px;

            border-radius: 9px;

            font-size: 11px;

            font-weight: 650;

        }


        .count-badge strong {

            color: var(--text);

        }


        .table-wrapper {

            overflow-x: auto;

        }


        .table {

            margin: 0;

            min-width: 950px;

            color: var(--text);

        }


        .table thead th {

            background: var(--surface-secondary);

            color: var(--muted);

            border-bottom: 1px solid var(--border);

            border-top: 0;

            padding: 13px 20px;

            font-size: 10.5px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .06em;

            white-space: nowrap;

        }


        .table tbody td {

            padding: 15px 20px;

            border-color: var(--border);

            vertical-align: middle;

            font-size: 13px;

        }


        .table tbody tr {

            transition: background .15s ease;

        }


        .table tbody tr:hover {

            background: var(--surface-secondary);

        }


        .candidate-number {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            background: rgba(37,99,235,.09);

            color: var(--primary);

            border: 1px solid rgba(37,99,235,.12);

            padding: 6px 9px;

            border-radius: 8px;

            font-size: 11px;

            font-weight: 750;

            white-space: nowrap;

        }


        .candidate-name {

            font-weight: 700;

            color: var(--text);

        }


        .candidate-firstname {

            color: var(--text);

        }


        .gender-badge {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-width: 30px;

            padding: 5px 8px;

            border-radius: 7px;

            background: var(--surface-secondary);

            color: var(--muted);

            font-size: 11px;

            font-weight: 700;

        }


        .contact-value {

            color: var(--muted);

            font-size: 12px;

        }


        .email-value {

            max-width: 210px;

            overflow: hidden;

            text-overflow: ellipsis;

            white-space: nowrap;

        }


        .action-btn {

            width: 34px;
            height: 34px;

            display: inline-flex;

            align-items: center;
            justify-content: center;

            border: 1px solid var(--border);

            background: var(--surface);

            color: var(--muted);

            border-radius: 9px;

            text-decoration: none;

            transition: .2s ease;

        }


        .action-btn:hover {

            background: rgba(37,99,235,.09);

            color: var(--primary);

            border-color: rgba(37,99,235,.25);

            transform: translateY(-1px);

        }


        .action-btn svg {

            width: 16px;
            height: 16px;

        }


        /* =====================================================
           EMPTY STATE
        ===================================================== */

        .empty-state {

            padding: 80px 20px;

            text-align: center;

            color: var(--muted);

        }


        .empty-icon {

            width: 70px;
            height: 70px;

            margin: 0 auto 18px;

            border-radius: 18px;

            background: var(--surface-secondary);

            display: flex;

            align-items: center;
            justify-content: center;

            color: var(--muted);

        }


        .empty-icon svg {

            width: 32px;
            height: 32px;

        }


        .empty-state h5 {

            color: var(--text);

            font-size: 16px;

            font-weight: 750;

            margin-bottom: 5px;

        }


        .empty-state p {

            font-size: 12px;

        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media (max-width: 1100px) {

            .sidebar {

                width: 78px;

            }

            .sidebar-brand span,
            .sidebar-section,
            .sidebar a span {

                display: none;

            }

            .sidebar-brand {

                justify-content: center;

                padding: 0;

            }

            .sidebar a {

                justify-content: center;

            }

            .sidebar-footer {

                left: 10px;
                right: 10px;

            }

            .main {

                margin-left: 78px;

            }

        }


        @media (max-width: 768px) {

            .content {

                padding: 22px 16px;

            }

            .topbar {

                padding: 0 16px;

            }

            .admin-profile span {

                display: none;

            }

            .page-header {

                align-items: flex-start;

                flex-direction: column;

            }

        }


        @media (max-width: 576px) {

            .sidebar {

                width: 64px;

            }

            .main {

                margin-left: 64px;

            }

            .content {

                padding: 18px 12px;

            }

            .topbar {

                height: 64px;

            }

            .page-header h1 {

                font-size: 23px;

            }

            .table-card-header {

                padding: 18px;

            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     SIDEBAR
========================================================= -->

<aside class="sidebar">

    <div>

        <div class="sidebar-brand">

            <div class="brand-icon">
                <i data-lucide="shield-check"></i>
            </div>

            <span>Suivi Concours</span>

        </div>


        <div class="sidebar-section">
            Administration
        </div>


        <a href="<%= request.getContextPath() %>/DashboardServlet">

            <i data-lucide="layout-dashboard"></i>

            <span>Tableau de bord</span>

        </a>


        <a href="<%= request.getContextPath() %>/ConcoursServlet?action=adminListe">

            <i data-lucide="trophy"></i>

            <span>Concours</span>

        </a>


        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=liste">

            <i data-lucide="clipboard-list"></i>

            <span>Épreuves</span>

        </a>


        <a class="active"
           href="<%= request.getContextPath() %>/CandidatsServlet">

            <i data-lucide="users"></i>

            <span>Candidats</span>

        </a>


        <a href="<%= request.getContextPath() %>/InscriptionServlet?action=liste">

            <i data-lucide="file-check"></i>

            <span>Inscriptions</span>

        </a>


        <a href="<%= request.getContextPath() %>/DossierServlet?action=liste">

            <i data-lucide="folder-open"></i>

            <span>Dossiers</span>

        </a>


        <a href="<%= request.getContextPath() %>/DocumentServlet?action=liste">

            <i data-lucide="files"></i>

            <span>Documents</span>

        </a>


        <a href="<%= request.getContextPath() %>/admin/resultats/liste.jsp">

            <i data-lucide="award"></i>

            <span>Résultats</span>

        </a>


        <a href="<%= request.getContextPath() %>/admin/statistiques/index.jsp">

            <i data-lucide="bar-chart-3"></i>

            <span>Statistiques</span>

        </a>

    </div>


    <div class="sidebar-footer">

        <a href="<%= request.getContextPath() %>/LogoutServlet">

            <i data-lucide="log-out"></i>

            <span>Déconnexion</span>

        </a>

    </div>

</aside>


<!-- =========================================================
     MAIN
========================================================= -->

<main class="main">


    <header class="topbar">

        <div>

            <div class="topbar-title">
                Gestion des candidats
            </div>

            <div class="topbar-subtitle">
                Administration / Candidats
            </div>

        </div>


        <div class="d-flex align-items-center gap-3">


            <button type="button"
                    class="theme-btn"
                    id="themeToggle"
                    title="Changer le thème">

                <i data-lucide="moon"></i>

            </button>


            <div class="admin-profile">

                <div class="admin-avatar">

                    <i data-lucide="shield-check"></i>

                </div>

                <span>
                    Administrateur
                </span>

            </div>


        </div>

    </header>


    <section class="content">


        <!-- =================================================
             HEADER
        ================================================= -->

        <div class="page-header">

            <div>

                <div class="page-kicker">
                    Gestion
                </div>

                <h1>
                    Candidats
                </h1>

                <p>
                    Consultez et gérez les candidats inscrits aux concours.
                </p>

            </div>

        </div>


        <!-- =================================================
             TABLE
        ================================================= -->

        <div class="table-card">


            <div class="table-card-header">

                <div>

                    <div class="table-card-title">
                        Liste des candidats
                    </div>

                    <div class="table-card-subtitle">
                        Consultez les informations enregistrées
                        pour chaque candidat.
                    </div>

                </div>


                <div class="count-badge">

                    <i data-lucide="users"
                       style="width:14px;height:14px;"></i>

                    <strong>
                        <%= candidats.size() %>
                    </strong>

                    candidat(s)

                </div>

            </div>


            <% if (candidats.isEmpty()) { %>


                <div class="empty-state">

                    <div class="empty-icon">

                        <i data-lucide="users"></i>

                    </div>

                    <h5>
                        Aucun candidat
                    </h5>

                    <p class="mb-0">
                        Aucun candidat n'est actuellement enregistré.
                    </p>

                </div>


            <% } else { %>


                <div class="table-wrapper">

                    <table class="table align-middle">


                        <thead>

                            <tr>

                                <th>
                                    N° candidat
                                </th>

                                <th>
                                    Nom
                                </th>

                                <th>
                                    Prénom
                                </th>

                                <th>
                                    Sexe
                                </th>

                                <th>
                                    CIN
                                </th>

                                <th>
                                    Téléphone
                                </th>

                                <th>
                                    Email
                                </th>

                                <th class="text-end">
                                    Actions
                                </th>

                            </tr>

                        </thead>


                        <tbody>


                        <% for (CandidatModele candidat : candidats) { %>


                            <tr>


                                <td>

                                    <span class="candidate-number">

                                        <i data-lucide="hash"
                                           style="width:13px;height:13px;"></i>

                                        <%= candidat.getNumero_candidat() %>

                                    </span>

                                </td>


                                <td>

                                    <span class="candidate-name">

                                        <%= candidat.getNom() %>

                                    </span>

                                </td>


                                <td>

                                    <span class="candidate-firstname">

                                        <%= candidat.getPrenom() %>

                                    </span>

                                </td>


                                <td>

                                    <span class="gender-badge">

                                        <%= candidat.getSexe() != null
                                                ? candidat.getSexe()
                                                : "-" %>

                                    </span>

                                </td>


                                <td>

                                    <span class="contact-value">

                                        <%= candidat.getCin() != null
                                                ? candidat.getCin()
                                                : "-" %>

                                    </span>

                                </td>


                                <td>

                                    <span class="contact-value">

                                        <%= candidat.getTelephone() != null
                                                ? candidat.getTelephone()
                                                : "-" %>

                                    </span>

                                </td>


                                <td>

                                    <span class="contact-value email-value">

                                        <%= candidat.getEmail() != null
                                                ? candidat.getEmail()
                                                : "-" %>

                                    </span>

                                </td>


                                <td class="text-end">

                                    <a href="<%= request.getContextPath() %>/CandidatServlet?action=details&id=<%= candidat.getId_candidat() %>"
                                       class="action-btn"
                                       title="Voir les détails">

                                        <i data-lucide="eye"></i>

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


<script src="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<script src="<%= request.getContextPath() %>/js/lucide.min.js"></script>


<script>

    const themeToggle =
        document.getElementById("themeToggle");


    function appliquerTheme() {

        const dark =
            localStorage.getItem("theme") === "dark";

        document.body.classList.toggle(
            "dark",
            dark
        );


        themeToggle.innerHTML = dark
            ? '<i data-lucide="sun"></i>'
            : '<i data-lucide="moon"></i>';


        lucide.createIcons();

    }


    themeToggle.addEventListener(
        "click",
        function () {

            const dark =
                document.body.classList.contains("dark");

            localStorage.setItem(
                "theme",
                dark ? "light" : "dark"
            );

            appliquerTheme();

        }
    );


    appliquerTheme();

</script>


</body>

</html>