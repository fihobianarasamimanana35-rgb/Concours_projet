<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Tableau de bord - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css"
          rel="stylesheet">

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

            --success: #16a34a;
            --warning: #d97706;
            --danger: #dc2626;
        }

        html.dark {
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

        html {
            scroll-behavior: smooth;
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
            transition: background .25s ease, color .25s ease;
        }

        /* =====================================================
           SIDEBAR
        ===================================================== */

        .sidebar {
            position: fixed;
            inset: 0 auto 0 0;
            width: 250px;
            background: var(--sidebar);
            padding: 20px 14px;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            box-shadow: 8px 0 30px rgba(15, 23, 42, .08);
        }

        .brand {
            height: 52px;
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 0 12px;
            color: #fff;
            font-size: 18px;
            font-weight: 750;
            margin-bottom: 25px;
            letter-spacing: -.2px;
        }

        .brand-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: linear-gradient(
                135deg,
                #2563eb,
                #3b82f6
            );
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow:
                0 8px 20px rgba(37, 99, 235, .3);
            flex-shrink: 0;
        }

        .brand-icon svg {
            width: 20px;
            height: 20px;
        }

        .nav-section {
            color: #64748b;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            padding: 0 12px;
            margin: 12px 0 8px;
            letter-spacing: .1em;
        }

        .nav-link-admin {
            display: flex;
            align-items: center;
            gap: 12px;
            min-height: 44px;
            padding: 10px 13px;
            margin-bottom: 4px;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 500;
            transition:
                background .2s ease,
                color .2s ease,
                transform .2s ease;
        }

        .nav-link-admin svg {
            width: 18px;
            height: 18px;
            flex-shrink: 0;
        }

        .nav-link-admin:hover {
            background: var(--sidebar-hover);
            color: #fff;
            transform: translateX(2px);
        }

        .nav-link-admin.active {
            background: linear-gradient(
                135deg,
                #2563eb,
                #3b82f6
            );
            color: #fff;
            box-shadow:
                0 7px 18px rgba(37, 99, 235, .22);
        }

        .logout {
            position: absolute;
            left: 14px;
            right: 14px;
            bottom: 18px;
            display: flex;
            align-items: center;
            gap: 12px;
            min-height: 44px;
            padding: 10px 13px;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: 10px;
            font-size: 13.5px;
            transition: .2s ease;
        }

        .logout svg {
            width: 18px;
        }

        .logout:hover {
            background: rgba(220, 38, 38, .12);
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

        .topbar-left {
            display: flex;
            flex-direction: column;
        }

        .page-title {
            font-size: 16px;
            font-weight: 750;
            letter-spacing: -.2px;
        }

        .page-breadcrumb {
            color: var(--muted);
            font-size: 11px;
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
            cursor: pointer;
            transition: .2s ease;
        }

        .theme-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-1px);
        }

        .content {
            padding: 32px;
            max-width: 1700px;
            margin: auto;
        }

        /* =====================================================
           HERO
        ===================================================== */

        .hero {
            position: relative;
            overflow: hidden;
            background:
                radial-gradient(
                    circle at 85% 20%,
                    rgba(255,255,255,.16),
                    transparent 28%
                ),
                linear-gradient(
                    135deg,
                    #1e40af,
                    #2563eb 55%,
                    #3b82f6
                );
            border-radius: 18px;
            padding: 34px;
            color: #fff;
            margin-bottom: 25px;
            box-shadow:
                0 15px 35px rgba(37, 99, 235, .18);
        }

        .hero::after {
            content: "";
            position: absolute;
            width: 220px;
            height: 220px;
            right: -70px;
            top: -100px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,.15);
            box-shadow:
                0 0 0 30px rgba(255,255,255,.04),
                0 0 0 60px rgba(255,255,255,.025);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 700px;
        }

        .hero-label {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .08em;
            opacity: .78;
            margin-bottom: 10px;
        }

        .hero-label svg {
            width: 15px;
        }

        .hero h1 {
            font-size: 28px;
            line-height: 1.2;
            font-weight: 750;
            margin: 0 0 9px;
            letter-spacing: -.5px;
        }

        .hero p {
            margin: 0;
            font-size: 14px;
            line-height: 1.7;
            opacity: .86;
        }

        /* =====================================================
           METRICS
        ===================================================== */

        .metric-card {
            position: relative;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 21px;
            height: 100%;
            overflow: hidden;
            transition: .22s ease;
        }

        .metric-card::after {
            content: "";
            position: absolute;
            width: 75px;
            height: 75px;
            border-radius: 50%;
            right: -30px;
            bottom: -35px;
            background: rgba(37,99,235,.045);
        }

        .metric-card:hover {
            transform: translateY(-3px);
            border-color: rgba(37,99,235,.3);
            box-shadow:
                0 12px 28px rgba(15,23,42,.07);
        }

        .metric-icon {
            width: 42px;
            height: 42px;
            border-radius: 11px;
            background: rgba(37,99,235,.1);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 17px;
        }

        .metric-icon svg {
            width: 20px;
        }

        .metric-value {
            font-size: 27px;
            font-weight: 750;
            letter-spacing: -.5px;
            line-height: 1.1;
        }

        .metric-label {
            color: var(--muted);
            font-size: 12.5px;
            margin-top: 5px;
        }

        /* =====================================================
           CARDS
        ===================================================== */

        .content-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 24px;
        }

        .card-title {
            font-size: 15px;
            font-weight: 750;
            letter-spacing: -.1px;
        }

        .card-subtitle {
            color: var(--muted);
            font-size: 12.5px;
            margin-top: 3px;
        }

        /* =====================================================
           ACTIVITY
        ===================================================== */

        .activity-item {
            display: flex;
            align-items: center;
            gap: 13px;
            padding: 14px 0;
            border-bottom: 1px solid var(--border);
        }

        .activity-item:last-child {
            border-bottom: 0;
        }

        .activity-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: var(--surface-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            flex-shrink: 0;
        }

        .activity-icon svg {
            width: 18px;
        }

        .activity-title {
            font-size: 13.5px;
            font-weight: 650;
        }

        .activity-date {
            color: var(--muted);
            font-size: 11.5px;
            margin-top: 2px;
        }

        /* =====================================================
           QUICK ACTIONS
        ===================================================== */

        .quick-card {
            display: block;
            padding: 18px;
            text-decoration: none;
            color: var(--text);
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 13px;
            height: 100%;
            transition: .22s ease;
        }

        .quick-card:hover {
            transform: translateY(-3px);
            border-color: rgba(37,99,235,.4);
            box-shadow:
                0 10px 24px rgba(15,23,42,.07);
            color: var(--text);
        }

        .quick-icon {
            width: 39px;
            height: 39px;
            border-radius: 10px;
            background: rgba(37,99,235,.1);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
        }

        .quick-icon svg {
            width: 18px;
        }

        .quick-title {
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 3px;
        }

        .quick-text {
            color: var(--muted);
            font-size: 11.5px;
            line-height: 1.4;
        }

        /* =====================================================
           BUTTON
        ===================================================== */

        .btn-primary {
            background: var(--primary);
            border-color: var(--primary);
            border-radius: 9px;
            font-weight: 600;
            padding: 8px 14px;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media (max-width: 1100px) {

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

            .sidebar {
                padding-left: 10px;
                padding-right: 10px;
            }

            .logout {
                left: 10px;
                right: 10px;
            }
        }

        @media (max-width: 768px) {

            .content {
                padding: 22px 16px;
            }

            .topbar {
                padding: 0 16px;
            }

            .hero {
                padding: 26px;
            }

            .hero h1 {
                font-size: 23px;
            }

            .page-breadcrumb {
                display: none;
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

            .hero {
                padding: 22px;
                border-radius: 14px;
            }

            .content-card {
                padding: 18px;
            }

            .metric-card {
                padding: 18px;
            }

            .hero p {
                font-size: 13px;
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

        <div class="brand">

            <div class="brand-icon">
                <i data-lucide="shield-check"></i>
            </div>

            <span>Suivi Concours</span>

        </div>

        <div class="nav-section">
            Administration
        </div>

        <a href="${pageContext.request.contextPath}/DashboardServlet"
           class="nav-link-admin active">

            <i data-lucide="layout-dashboard"></i>

            <span>Tableau de bord</span>

        </a>

        <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminListe"
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
           class="nav-link-admin">

            <i data-lucide="files"></i>

            <span>Documents</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/resultats/liste.jsp"
           class="nav-link-admin">

            <i data-lucide="award"></i>

            <span>Résultats</span>

        </a>

        <a href="${pageContext.request.contextPath}/admin/statistiques/index.jsp"
           class="nav-link-admin">

            <i data-lucide="bar-chart-3"></i>

            <span>Statistiques</span>

        </a>

    </div>

    <a href="${pageContext.request.contextPath}/LogoutServlet"
       class="logout">

        <i data-lucide="log-out"></i>

        <span>Déconnexion</span>

    </a>

</aside>


<!-- =========================================================
     MAIN
========================================================= -->

<main class="main">

    <header class="topbar">

        <div class="topbar-left">

            <div class="page-title">
                Tableau de bord
            </div>

            <div class="page-breadcrumb">
                Administration / Vue générale
            </div>

        </div>

        <button type="button"
                id="themeToggle"
                class="theme-btn"
                title="Changer le thème">

            <i data-lucide="moon"></i>

        </button>

    </header>


    <section class="content">

        <!-- HERO -->

        <div class="hero">

            <div class="hero-content">

                <div class="hero-label">

                    <i data-lucide="sparkles"></i>

                    Espace administration

                </div>

                <h1>
                    Bonjour, Administrateur.
                </h1>

                <p>
                    Gérez les concours, les candidats, les inscriptions
                    et les résultats depuis votre espace d'administration.
                </p>

            </div>

        </div>


        <!-- =================================================
             STATISTIQUES
        ================================================= -->

        <div class="row g-4 mb-4">

            <div class="col-xl-3 col-md-6">

                <div class="metric-card">

                    <div class="metric-icon">
                        <i data-lucide="trophy"></i>
                    </div>

                    <div class="metric-value">
                        ${nombreConcours}
                    </div>

                    <div class="metric-label">
                        Concours
                    </div>

                </div>

            </div>


            <div class="col-xl-3 col-md-6">

                <div class="metric-card">

                    <div class="metric-icon">
                        <i data-lucide="users"></i>
                    </div>

                    <div class="metric-value">
                        ${nombreCandidats}
                    </div>

                    <div class="metric-label">
                        Candidats
                    </div>

                </div>

            </div>


            <div class="col-xl-3 col-md-6">

                <div class="metric-card">

                    <div class="metric-icon">
                        <i data-lucide="file-check"></i>
                    </div>

                    <div class="metric-value">
                        ${nombreInscriptions}
                    </div>

                    <div class="metric-label">
                        Inscriptions
                    </div>

                </div>

            </div>


            <div class="col-xl-3 col-md-6">

                <div class="metric-card">

                    <div class="metric-icon">
                        <i data-lucide="award"></i>
                    </div>

                    <div class="metric-value">
                        ${nombreResultatsPublies}
                    </div>

                    <div class="metric-label">
                        Résultats publiés
                    </div>

                </div>

            </div>

        </div>


        <!-- =================================================
             ACTIVITÉ + ACCÈS RAPIDES
        ================================================= -->

        <div class="row g-4 mb-4">


            <div class="col-lg-7">

                <div class="content-card h-100">

                    <div class="mb-3">

                        <div class="card-title">
                            Activité récente
                        </div>

                        <div class="card-subtitle">
                            Les dernières opérations du système
                        </div>

                    </div>


                    <div class="activity-item">

                        <div class="activity-icon">
                            <i data-lucide="trophy"></i>
                        </div>

                        <div>

                            <div class="activity-title">
                                Aucun concours récent
                            </div>

                            <div class="activity-date">
                                Aucune activité disponible
                            </div>

                        </div>

                    </div>


                    <div class="activity-item">

                        <div class="activity-icon">
                            <i data-lucide="users"></i>
                        </div>

                        <div>

                            <div class="activity-title">
                                Aucun candidat récent
                            </div>

                            <div class="activity-date">
                                Aucune activité disponible
                            </div>

                        </div>

                    </div>


                    <div class="activity-item">

                        <div class="activity-icon">
                            <i data-lucide="file-check"></i>
                        </div>

                        <div>

                            <div class="activity-title">
                                Aucune inscription récente
                            </div>

                            <div class="activity-date">
                                Aucune activité disponible
                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <div class="col-lg-5">

                <div class="content-card h-100">

                    <div class="mb-3">

                        <div class="card-title">
                            Accès rapides
                        </div>

                        <div class="card-subtitle">
                            Accédez rapidement aux principales fonctions
                        </div>

                    </div>


                    <div class="row g-3">


                        <div class="col-6">

                            <a href="${pageContext.request.contextPath}/ConcoursServlet?action=ajouter"
                               class="quick-card">

                                <div class="quick-icon">
                                    <i data-lucide="plus"></i>
                                </div>

                                <div class="quick-title">
                                    Nouveau concours
                                </div>

                                <div class="quick-text">
                                    Créer un concours
                                </div>

                            </a>

                        </div>


                        <div class="col-6">

                            <a href="${pageContext.request.contextPath}/EpreuveServlet?action=ajouter"
                               class="quick-card">

                                <div class="quick-icon">
                                    <i data-lucide="clipboard-plus"></i>
                                </div>

                                <div class="quick-title">
                                    Nouvelle épreuve
                                </div>

                                <div class="quick-text">
                                    Ajouter une épreuve
                                </div>

                            </a>

                        </div>


                        <div class="col-6">

                            <a href="${pageContext.request.contextPath}/CandidatServlet?action=ajouter"
                               class="quick-card">

                                <div class="quick-icon">
                                    <i data-lucide="user-plus"></i>
                                </div>

                                <div class="quick-title">
                                    Nouveau candidat
                                </div>

                                <div class="quick-text">
                                    Ajouter un candidat
                                </div>

                            </a>

                        </div>


                        <div class="col-6">

                            <a href="${pageContext.request.contextPath}/InscriptionServlet?action=liste"
                               class="quick-card">

                                <div class="quick-icon">
                                    <i data-lucide="file-search"></i>
                                </div>

                                <div class="quick-title">
                                    Inscriptions
                                </div>

                                <div class="quick-text">
                                    Consulter les inscriptions
                                </div>

                            </a>

                        </div>


                    </div>

                </div>

            </div>

        </div>


        <!-- =================================================
             GESTION DES CONCOURS
        ================================================= -->

        <div class="content-card">

            <div class="d-flex justify-content-between align-items-center gap-3">

                <div>

                    <div class="card-title">
                        Gestion des concours
                    </div>

                    <div class="card-subtitle">
                        Accédez à la gestion complète des concours.
                    </div>

                </div>

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminListe"
                   class="btn btn-primary btn-sm">

                    Voir les concours

                </a>

            </div>

        </div>

    </section>

</main>


<script src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>


<script>

    const html = document.documentElement;

    const themeToggle =
        document.getElementById("themeToggle");


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