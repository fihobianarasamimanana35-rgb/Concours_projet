<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modele.InscriptionModele" %>

<%
    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails de l'inscription - Administration</title>

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
            --primary-soft: #eff6ff;
            --sidebar: #111827;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1f2937;
            --text: #f3f4f6;
            --muted: #9ca3af;
            --border: #1f2937;
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
            display: flex;
            align-items: center;
            justify-content: center;
            background: #2563eb;
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
            max-width: 1200px;
        }

        .card-custom {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .card-header-custom {
            padding: 22px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-title {
            margin: 0;
            font-size: 17px;
            font-weight: 700;
        }

        .card-body-custom {
            padding: 24px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            padding: 17px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 12px;
        }

        .info-label {
            display: block;
            color: var(--muted);
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .04em;
            margin-bottom: 7px;
        }

        .info-value {
            font-size: 15px;
            font-weight: 600;
            color: var(--text);
            word-break: break-word;
        }

        .id-badge {
            background: var(--primary-soft);
            color: var(--primary);
            border-radius: 9px;
            padding: 7px 11px;
            font-size: 13px;
            font-weight: 700;
        }

        .motif-box {
            margin-top: 22px;
            padding: 18px;
            border-radius: 12px;
            background: #fff7ed;
            border: 1px solid #fed7aa;
            color: #9a3412;
        }

        html.dark .motif-box {
            background: #431407;
            border-color: #7c2d12;
            color: #fdba74;
        }

        .empty-card {
            text-align: center;
            padding: 60px 25px;
        }

        .empty-icon {
            width: 58px;
            height: 58px;
            border-radius: 16px;
            background: var(--surface-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            color: var(--muted);
        }

        .empty-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty-text {
            color: var(--muted);
            margin-bottom: 22px;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border-radius: 10px;
            padding: 10px 16px;
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

            .info-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .topbar {
                padding: 0 18px;
            }

            .content {
                padding: 18px;
            }

            .card-body-custom {
                padding: 18px;
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

        <a class="nav-link-admin"
           href="<%= contextPath %>/ConcoursServlet?action=liste">
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
           href="<%= contextPath %>/ResultatServlet?action=liste">
            <i data-lucide="bar-chart-3"></i>
            <span>Résultats</span>
        </a>

        <a class="nav-link-admin"
           href="<%= contextPath %>/admin/statistiques/index.jsp">
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
            <div class="page-title">Détails de l'inscription</div>
            <div class="breadcrumb-custom">
                Administration / Inscriptions / Détails
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

        <div class="mb-4">

            <a href="<%= contextPath %>/InscriptionServlet?action=liste"
               class="btn btn-outline-secondary btn-back">
                <i data-lucide="arrow-left"></i>
                Retour aux inscriptions
            </a>

        </div>


        <% if (inscription != null) { %>

        <div class="card-custom">

            <div class="card-header-custom">

                <div>
                    <h2 class="card-title">
                        Informations de l'inscription
                    </h2>
                    <div class="breadcrumb-custom">
                        Consultation détaillée
                    </div>
                </div>

                <div class="id-badge">
                    #<%= inscription.getId_inscription() %>
                </div>

            </div>


            <div class="card-body-custom">

                <div class="info-grid">

                    <div class="info-item">
                        <span class="info-label">
                            Numéro d'inscription
                        </span>

                        <div class="info-value">
                            <%= inscription.getNumero_inscription() != null
                                    ? inscription.getNumero_inscription()
                                    : "-" %>
                        </div>
                    </div>


                    <div class="info-item">
                        <span class="info-label">
                            Code de suivi
                        </span>

                        <div class="info-value">
                            <%= inscription.getCode_suivi() != null
                                    ? inscription.getCode_suivi()
                                    : "-" %>
                        </div>
                    </div>


                    <div class="info-item">
                        <span class="info-label">
                            Candidat
                        </span>

                        <div class="info-value">
                            Candidat #<%= inscription.getId_candidat() %>
                        </div>
                    </div>


                    <div class="info-item">
                        <span class="info-label">
                            Concours
                        </span>

                        <div class="info-value">
                            Concours #<%= inscription.getId_concours() %>
                        </div>
                    </div>


                    <div class="info-item">
                        <span class="info-label">
                            Date d'inscription
                        </span>

                        <div class="info-value">
                            <%= inscription.getDate_inscription() != null
                                    ? inscription.getDate_inscription()
                                    : "-" %>
                        </div>
                    </div>


                    <div class="info-item">
                        <span class="info-label">
                            Statut
                        </span>

                        <div class="info-value">

                            <%
                                String statut = inscription.getStatut();

                                if (statut == null || statut.trim().isEmpty()) {
                            %>

                                <span class="badge bg-secondary">
                                    -
                                </span>

                            <%
                                } else if ("valide".equalsIgnoreCase(statut)) {
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
                                } else {
                            %>

                                <span class="badge bg-secondary">
                                    <%= statut %>
                                </span>

                            <%
                                }
                            %>

                        </div>
                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Date de validation
                        </span>

                        <div class="info-value">
                            <%= inscription.getDate_validation() != null
                                    ? inscription.getDate_validation()
                                    : "-" %>
                        </div>

                    </div>

                </div>


                <%
                    String motif = inscription.getMotif_rejet();

                    if (motif != null && !motif.trim().isEmpty()) {
                %>

                <div class="motif-box">

                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i data-lucide="triangle-alert"></i>

                        <strong>
                            Motif du rejet
                        </strong>
                    </div>

                    <div>
                        <%= motif %>
                    </div>

                </div>

                <% } %>

            </div>

        </div>

        <% } else { %>


        <div class="card-custom">

            <div class="empty-card">

                <div class="empty-icon">
                    <i data-lucide="file-question"></i>
                </div>

                <div class="empty-title">
                    Inscription introuvable
                </div>

                <div class="empty-text">
                    L'inscription demandée n'existe pas ou n'est plus disponible.
                </div>

                <a href="<%= contextPath %>/InscriptionServlet?action=liste"
                   class="btn btn-primary btn-back">
                    <i data-lucide="arrow-left"></i>
                    Retour aux inscriptions
                </a>

            </div>

        </div>

        <% } %>

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