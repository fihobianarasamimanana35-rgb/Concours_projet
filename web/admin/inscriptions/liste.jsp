<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.InscriptionModele" %>

<%
    List<InscriptionModele> inscriptions =
            (List<InscriptionModele>) request.getAttribute("inscriptions");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Inscriptions - Administration</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <style>

        :root {
            --bg: #f6f8fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
            --text: #111827;
            --muted: #6b7280;
            --border: #e5e7eb;
            --primary: #2563eb;
            --sidebar: #111827;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1f2937;
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
            background: #2563eb;
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
            transition: .2s ease;
        }

        .nav-link-admin:hover,
        .nav-link-admin.active {
            background: #1f2937;
            color: #fff;
        }

        .nav-link-admin svg {
            width: 19px;
            height: 19px;
            flex-shrink: 0;
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

        .page-title {
            font-size: 18px;
            font-weight: 700;
            margin: 0;
        }

        .breadcrumb-custom {
            color: var(--muted);
            font-size: 13px;
            margin-top: 3px;
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
        }

        .content {
            padding: 32px;
        }

        .page-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 24px;
        }

        .heading-title {
            font-size: 26px;
            font-weight: 750;
            margin: 0;
        }

        .heading-description {
            color: var(--muted);
            margin: 5px 0 0;
        }

        .card-custom {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .table-custom {
            margin: 0;
            min-width: 900px;
            color: var(--text);
        }

        .table-custom thead th {
            background: var(--surface-soft);
            border-bottom: 1px solid var(--border);
            color: var(--muted);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .04em;
            padding: 15px 18px;
            white-space: nowrap;
        }

        .table-custom tbody td {
            border-bottom: 1px solid var(--border);
            padding: 16px 18px;
            vertical-align: middle;
        }

        .table-custom tbody tr:last-child td {
            border-bottom: 0;
        }

        .table-custom tbody tr:hover {
            background: var(--surface-soft);
        }

        .id-number {
            color: var(--primary);
            font-weight: 700;
        }

        .code-text {
            font-family: monospace;
            font-size: 13px;
            font-weight: 600;
        }

        .candidate-text {
            font-weight: 600;
        }

        .date-text {
            color: var(--muted);
            font-size: 14px;
        }

        .action-group {
            display: flex;
            gap: 6px;
            white-space: nowrap;
        }

        .action-btn {
            width: 36px;
            height: 36px;
            border-radius: 9px;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: .2s ease;
        }

        .action-btn:hover {
            background: var(--surface-soft);
            transform: translateY(-1px);
        }

        .action-btn svg {
            width: 16px;
            height: 16px;
        }

        .action-btn.delete {
            color: #dc2626;
        }

        .empty-state {
            padding: 70px 25px;
            text-align: center;
        }

        .empty-icon {
            width: 64px;
            height: 64px;
            border-radius: 18px;
            background: var(--surface-soft);
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
        }

        .empty-title {
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 7px;
        }

        .empty-text {
            color: var(--muted);
            margin: 0;
        }

        @media (max-width: 992px) {

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

        @media (max-width: 576px) {

            .topbar {
                padding: 0 18px;
            }

            .content {
                padding: 18px;
            }

            .page-heading {
                align-items: flex-start;
            }

            .heading-title {
                font-size: 22px;
            }

        }

    </style>

    <script src="<%= contextPath %>/js/lucide.min.js"></script>

</head>


<body>


<aside class="sidebar">

    <div class="brand">

        <div class="brand-icon">
            <i data-lucide="shield-check"></i>
        </div>

        <span>Gestion Concours</span>

    </div>


    <nav>

        <a class="nav-link-admin"
           href="<%= contextPath %>/DashboardServlet">
            <i data-lucide="layout-dashboard"></i>
            <span>Dashboard</span>
        </a>


        <!-- Route conservée : adminListe -->
        <a class="nav-link-admin"
           href="<%= contextPath %>/ConcoursServlet?action=adminListe">
            <i data-lucide="trophy"></i>
            <span>Concours</span>
        </a>


        <a class="nav-link-admin"
           href="<%= contextPath %>/EpreuveServlet?action=liste">
            <i data-lucide="clipboard-list"></i>
            <span>Épreuves</span>
        </a>


        <a class="nav-link-admin"
           href="<%= contextPath %>/CandidatServlet?action=liste">
            <i data-lucide="users"></i>
            <span>Candidats</span>
        </a>


        <a class="nav-link-admin active"
           href="<%= contextPath %>/InscriptionServlet?action=liste">
            <i data-lucide="file-signature"></i>
            <span>Inscriptions</span>
        </a>


        <a class="nav-link-admin"
           href="<%= contextPath %>/DossierServlet?action=liste">
            <i data-lucide="folder-open"></i>
            <span>Dossiers</span>
        </a>


        <a class="nav-link-admin"
           href="<%= contextPath %>/DocumentServlet?action=liste">
            <i data-lucide="files"></i>
            <span>Documents</span>
        </a>


        <a class="nav-link-admin"
           href="<%= contextPath %>/ResultatServlet?action=liste">
            <i data-lucide="bar-chart-3"></i>
            <span>Résultats</span>
        </a>


        <!-- Route conservée : StatistiquesServlet?action=data -->
        <a class="nav-link-admin"
           href="<%= contextPath %>/StatistiquesServlet?action=data">
            <i data-lucide="chart-no-axes-combined"></i>
            <span>Statistiques</span>
        </a>

    </nav>


    <a class="logout"
       href="<%= contextPath %>/LogoutServlet">

        <i data-lucide="log-out"></i>

        <span>Déconnexion</span>

    </a>

</aside>



<main class="main">


    <header class="topbar">

        <div>

            <div class="page-title">
                Inscriptions
            </div>

            <div class="breadcrumb-custom">
                Administration / Gestion des inscriptions
            </div>

        </div>


        <button class="theme-btn"
                id="themeToggle"
                type="button"
                title="Changer le thème">

            <i data-lucide="moon"></i>

        </button>

    </header>



    <section class="content">


        <div class="page-heading">

            <div>

                <h1 class="heading-title">
                    Inscriptions
                </h1>

                <p class="heading-description">
                    Consultez et gérez les inscriptions aux concours.
                </p>

            </div>

        </div>



        <div class="card-custom">


            <% if (inscriptions != null && !inscriptions.isEmpty()) { %>


            <div class="table-wrapper">

                <table class="table table-custom">

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>N° inscription</th>

                        <th>Code suivi</th>

                        <th>Candidat</th>

                        <th>Concours</th>

                        <th>Date inscription</th>

                        <th>Statut</th>

                        <th>Actions</th>

                    </tr>

                    </thead>


                    <tbody>


                    <% for (InscriptionModele inscription : inscriptions) { %>


                    <tr>


                        <td>

                            <span class="id-number">
                                #<%= inscription.getId_inscription() %>
                            </span>

                        </td>


                        <td>

                            <span class="code-text">

                                <%= inscription.getNumero_inscription() != null
                                        ? inscription.getNumero_inscription()
                                        : "-" %>

                            </span>

                        </td>


                        <td>

                            <span class="code-text">

                                <%= inscription.getCode_suivi() != null
                                        ? inscription.getCode_suivi()
                                        : "-" %>

                            </span>

                        </td>


                        <td>

                            <span class="candidate-text">
                                Candidat #<%= inscription.getId_candidat() %>
                            </span>

                        </td>


                        <td>

                            <span class="candidate-text">
                                Concours #<%= inscription.getId_concours() %>
                            </span>

                        </td>


                        <td>

                            <span class="date-text">

                                <%= inscription.getDate_inscription() != null
                                        ? inscription.getDate_inscription()
                                        : "-" %>

                            </span>

                        </td>


                        <td>


                            <%
                                String statut = inscription.getStatut();

                                if ("valide".equalsIgnoreCase(statut)) {
                            %>

                                <span class="badge bg-success">
                                    Valide
                                </span>

                            <%
                                } else if ("en attente".equalsIgnoreCase(statut)
                                        || "attente".equalsIgnoreCase(statut)
                                        || "en_attente".equalsIgnoreCase(statut)) {
                            %>

                                <span class="badge bg-warning text-dark">
                                    En attente
                                </span>

                            <%
                                } else if ("rejete".equalsIgnoreCase(statut)
                                        || "rejeté".equalsIgnoreCase(statut)) {
                            %>

                                <span class="badge bg-danger">
                                    Rejeté
                                </span>

                            <%
                                } else if (statut != null && !statut.trim().isEmpty()) {
                            %>

                                <span class="badge bg-secondary">
                                    <%= statut %>
                                </span>

                            <%
                                } else {
                            %>

                                <span class="badge bg-secondary">
                                    -
                                </span>

                            <%
                                }
                            %>


                        </td>


                        <td>


                            <div class="action-group">


                                <a class="action-btn"
                                   href="<%= contextPath %>/InscriptionServlet?action=details&id=<%= inscription.getId_inscription() %>"
                                   title="Voir les détails"
                                   aria-label="Voir les détails">

                                    <i data-lucide="eye"></i>

                                </a>


                                <a class="action-btn"
                                   href="<%= contextPath %>/InscriptionServlet?action=modifier&id=<%= inscription.getId_inscription() %>"
                                   title="Modifier / valider"
                                   aria-label="Modifier ou valider">

                                    <i data-lucide="pencil"></i>

                                </a>


                                <a class="action-btn delete"
                                   href="<%= contextPath %>/InscriptionServlet?action=supprimer&id=<%= inscription.getId_inscription() %>"
                                   title="Supprimer"
                                   aria-label="Supprimer"
                                   onclick="return confirm('Voulez-vous vraiment supprimer cette inscription ?');">

                                    <i data-lucide="trash-2"></i>

                                </a>


                            </div>


                        </td>


                    </tr>


                    <% } %>


                    </tbody>

                </table>

            </div>


            <% } else { %>


            <div class="empty-state">

                <div class="empty-icon">

                    <i data-lucide="file-signature"></i>

                </div>

                <div class="empty-title">
                    Aucune inscription
                </div>

                <p class="empty-text">
                    Aucune inscription n'est actuellement disponible.
                </p>

            </div>


            <% } %>


        </div>


    </section>


</main>



<script src="<%= contextPath %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>


<script>

    const savedTheme = localStorage.getItem("theme");

    if (savedTheme === "dark") {
        document.documentElement.classList.add("dark");
    }


    document.getElementById("themeToggle").addEventListener("click", function () {

        document.documentElement.classList.toggle("dark");

        const dark =
            document.documentElement.classList.contains("dark");

        localStorage.setItem("theme", dark ? "dark" : "light");

    });


    lucide.createIcons();

</script>


</body>
</html>