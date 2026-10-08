<%--
    Document   : index
    Created on : 7 oct. 2026, 09:20:38
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Statistiques - Gestion Concours</title>


    <!-- Bootstrap local -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css">


    <!-- Lucide local -->
    <script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>


    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <style>

        /* =========================================================
           VARIABLES
           ========================================================= */

        :root {

            --bg: #f6f8fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;

            --text: #111827;
            --muted: #6b7280;

            --border: #e5e7eb;

            --primary: #2563eb;
            --primary-soft: #eff6ff;

            --success: #16a34a;
            --success-soft: #f0fdf4;

            --warning: #d97706;
            --warning-soft: #fffbeb;

            --danger: #dc2626;
            --danger-soft: #fef2f2;

            --sidebar: #111827;

            --shadow:
                0 1px 2px rgba(15, 23, 42, .04),
                0 8px 24px rgba(15, 23, 42, .04);
        }


        html.dark {

            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1f2937;

            --text: #f3f4f6;
            --muted: #9ca3af;

            --border: #1f2937;

            --primary: #60a5fa;
            --primary-soft: #172554;

            --success: #4ade80;
            --success-soft: #052e16;

            --warning: #fbbf24;
            --warning-soft: #451a03;

            --danger: #f87171;
            --danger-soft: #450a0a;

            --shadow:
                0 8px 30px rgba(0, 0, 0, .18);
        }


        /* =========================================================
           GLOBAL
           ========================================================= */

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
                background-color .2s ease,
                color .2s ease;
        }


        /* =========================================================
           SIDEBAR
           ========================================================= */

        .sidebar {

            width: 250px;

            min-height: 100vh;

            position: fixed;

            left: 0;
            top: 0;
            bottom: 0;

            padding: 24px 16px;

            background: var(--sidebar);

            z-index: 1000;
        }


        .brand {

            color: #ffffff;

            font-size: 20px;

            font-weight: 700;

            padding:
                0
                12px
                28px;

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

            flex-shrink: 0;
        }


        .brand-icon svg {

            width: 20px;
            height: 20px;
        }


        .nav-link-admin {

            color: #9ca3af;

            padding:
                12px
                14px;

            border-radius: 10px;

            display: flex;

            align-items: center;

            gap: 12px;

            text-decoration: none;

            margin-bottom: 4px;

            transition:
                background .2s ease,
                color .2s ease,
                transform .2s ease;
        }


        .nav-link-admin:hover {

            background: #1f2937;

            color: #ffffff;

            transform: translateX(2px);
        }


        .nav-link-admin.active {

            background: #1f2937;

            color: #ffffff;
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
        }


        /* =========================================================
           MAIN
           ========================================================= */

        .main {

            margin-left: 250px;

            min-height: 100vh;
        }


        /* =========================================================
           TOPBAR
           ========================================================= */

        .topbar {

            height: 72px;

            background: var(--surface);

            border-bottom:
                1px solid
                var(--border);

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding:
                0
                32px;

            position: sticky;

            top: 0;

            z-index: 900;
        }


        .topbar-left {

            display: flex;

            flex-direction: column;
        }


        .topbar-title {

            font-size: 18px;

            font-weight: 700;

            line-height: 1.2;
        }


        .topbar-subtitle {

            color: var(--muted);

            font-size: 12px;

            margin-top: 3px;
        }


        .topbar-actions {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .theme-btn {

            width: 40px;
            height: 40px;

            border:
                1px solid
                var(--border);

            background:
                var(--surface);

            color:
                var(--text);

            border-radius: 10px;

            display: flex;

            align-items: center;
            justify-content: center;

            cursor: pointer;

            transition:
                background .2s ease,
                border-color .2s ease;
        }


        .theme-btn:hover {

            background:
                var(--surface-soft);
        }


        .theme-btn svg {

            width: 18px;
            height: 18px;
        }


        /* =========================================================
           CONTENT
           ========================================================= */

        .content {

            padding: 32px;
        }


        .page-heading {

            display: flex;

            align-items: flex-end;

            justify-content: space-between;

            gap: 20px;

            margin-bottom: 28px;
        }


        .page-label {

            color: var(--primary);

            font-size: 11px;

            font-weight: 800;

            letter-spacing: .10em;

            margin-bottom: 6px;
        }


        .page-title {

            font-size: 28px;

            font-weight: 750;

            margin: 0 0 5px;
        }


        .page-description {

            color: var(--muted);

            margin: 0;
        }


        .live-indicator {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            color: var(--muted);

            font-size: 12px;

            white-space: nowrap;
        }


        .live-dot {

            width: 8px;
            height: 8px;

            border-radius: 50%;

            background: #22c55e;

            box-shadow:
                0 0 0 4px
                rgba(34, 197, 94, .10);
        }


        /* =========================================================
           STAT CARDS
           ========================================================= */

        .stat-card {

            background:
                var(--surface);

            border:
                1px solid
                var(--border);

            border-radius: 16px;

            padding: 21px;

            height: 100%;

            box-shadow:
                var(--shadow);

            transition:
                transform .2s ease,
                box-shadow .2s ease;
        }


        .stat-card:hover {

            transform: translateY(-2px);

            box-shadow:
                0 12px 30px
                rgba(15, 23, 42, .07);
        }


        .stat-top {

            display: flex;

            align-items: flex-start;

            justify-content: space-between;
        }


        .stat-label {

            color: var(--muted);

            font-size: 13px;

            font-weight: 600;
        }


        .stat-value {

            font-size: 30px;

            line-height: 1.2;

            font-weight: 750;

            margin-top: 7px;
        }


        .stat-description {

            color: var(--muted);

            font-size: 12px;

            margin-top: 7px;
        }


        .stat-icon {

            width: 44px;
            height: 44px;

            border-radius: 12px;

            background:
                var(--primary-soft);

            color:
                var(--primary);

            display: flex;

            align-items: center;
            justify-content: center;

            flex-shrink: 0;
        }


        .stat-icon svg {

            width: 21px;
            height: 21px;
        }


        .stat-icon.success {

            background:
                var(--success-soft);

            color:
                var(--success);
        }


        .stat-icon.warning {

            background:
                var(--warning-soft);

            color:
                var(--warning);
        }


        .stat-icon.danger {

            background:
                var(--danger-soft);

            color:
                var(--danger);
        }


        /* =========================================================
           CHART CARDS
           ========================================================= */

        .card-custom {

            background:
                var(--surface);

            border:
                1px solid
                var(--border);

            border-radius: 16px;

            overflow: hidden;

            box-shadow:
                var(--shadow);
        }


        .card-header-custom {

            min-height: 68px;

            padding:
                16px
                22px;

            border-bottom:
                1px solid
                var(--border);

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;
        }


        .card-header-left {

            display: flex;

            align-items: center;

            gap: 11px;
        }


        .card-header-icon {

            width: 38px;
            height: 38px;

            border-radius: 10px;

            background:
                var(--primary-soft);

            color:
                var(--primary);

            display: flex;

            align-items: center;
            justify-content: center;
        }


        .card-header-icon svg {

            width: 19px;
            height: 19px;
        }


        .card-header-title {

            font-weight: 700;

            font-size: 15px;

            margin: 0;
        }


        .card-header-description {

            color: var(--muted);

            font-size: 11px;

            margin-top: 2px;
        }


        .chart-container {

            position: relative;

            height: 340px;

            padding:
                22px;
        }


        .chart-container-small {

            height: 340px;
        }


        /* =========================================================
           REFRESH
           ========================================================= */

        .refresh-status {

            color: var(--muted);

            font-size: 11px;

            display: flex;

            align-items: center;

            gap: 7px;

            white-space: nowrap;
        }


        .refresh-dot {

            width: 7px;
            height: 7px;

            border-radius: 50%;

            background:
                #22c55e;

            animation:
                pulseDot 1.8s infinite;
        }


        @keyframes pulseDot {

            0% {
                opacity: 1;
            }

            50% {
                opacity: .35;
            }

            100% {
                opacity: 1;
            }
        }


        /* =========================================================
           RESPONSIVE
           ========================================================= */

        @media (max-width: 1200px) {

            .content {
                padding: 25px;
            }

            .topbar {
                padding:
                    0
                    25px;
            }
        }


        @media (max-width: 992px) {

            .sidebar {

                width: 80px;

                padding:
                    24px
                    10px;
            }


            .brand {

                justify-content: center;

                padding-left: 0;
                padding-right: 0;
            }


            .brand span,
            .nav-link-admin span {

                display: none;
            }


            .nav-link-admin {

                justify-content: center;

                padding:
                    12px;
            }


            .logout {

                left: 10px;
                right: 10px;
            }


            .main {

                margin-left: 80px;
            }


            .page-heading {

                align-items: flex-start;

                flex-direction: column;
            }

        }


        @media (max-width: 576px) {

            .content {

                padding:
                    20px
                    16px;
            }


            .topbar {

                padding:
                    0
                    16px;
            }


            .page-title {

                font-size: 23px;
            }


            .page-description {

                font-size: 13px;
            }


            .live-indicator {

                display: none;
            }


            .chart-container {

                height: 300px;

                padding:
                    16px;
            }


            .card-header-custom {

                padding:
                    15px
                    17px;
            }


            .refresh-status {

                display: none;
            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     SIDEBAR
     ========================================================= -->

<aside class="sidebar">


    <div class="brand">

        <div class="brand-icon">

            <i data-lucide="shield-check"></i>

        </div>

        <span>
            Gestion Concours
        </span>

    </div>


    <nav>


        <a href="${pageContext.request.contextPath}/DashboardServlet"
           class="nav-link-admin">

            <i data-lucide="layout-dashboard"></i>

            <span>
                Tableau de bord
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="trophy"></i>

            <span>
                Concours
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/EpreuveServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="clipboard-list"></i>

            <span>
                Épreuves
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/CandidatServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="users"></i>

            <span>
                Candidats
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/InscriptionServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="file-signature"></i>

            <span>
                Inscriptions
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/DossierServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="folder-open"></i>

            <span>
                Dossiers
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/DocumentServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="files"></i>

            <span>
                Documents
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/ResultatServlet?action=liste"
           class="nav-link-admin">

            <i data-lucide="award"></i>

            <span>
                Résultats
            </span>

        </a>


        <a href="${pageContext.request.contextPath}/StatistiquesServlet?action=dashboard"
           class="nav-link-admin active">

            <i data-lucide="chart-no-axes-combined"></i>

            <span>
                Statistiques
            </span>

        </a>


    </nav>


    <div class="logout">

        <a href="${pageContext.request.contextPath}/LogoutServlet"
           class="nav-link-admin">

            <i data-lucide="log-out"></i>

            <span>
                Déconnexion
            </span>

        </a>

    </div>

</aside>



<!-- =========================================================
     MAIN
     ========================================================= -->

<main class="main">


    <!-- TOPBAR -->

    <header class="topbar">


        <div class="topbar-left">

            <div class="topbar-title">
                Statistiques
            </div>

            <div class="topbar-subtitle">
                Analyse et suivi des données du concours
            </div>

        </div>


        <div class="topbar-actions">

            <button
                class="theme-btn"
                id="themeToggle"
                type="button"
                title="Changer le thème"
                aria-label="Changer le thème">

                <i data-lucide="moon"></i>

            </button>

        </div>


    </header>



    <!-- CONTENT -->

    <section class="content">


        <!-- PAGE HEADING -->

        <div class="page-heading">


            <div>

                <div class="page-label">
                    ADMINISTRATION
                </div>


                <h1 class="page-title">
                    Statistiques
                </h1>


                <p class="page-description">
                    Vue générale et dynamique des données du concours.
                </p>

            </div>


            <div class="live-indicator">

                <span class="live-dot"></span>

                Données actualisées automatiquement

            </div>


        </div>



        <!-- =================================================
             COMPTEURS
             ================================================= -->

        <div class="row g-4 mb-4">


            <!-- DOSSIERS -->

            <div class="col-xl-3 col-md-6">

                <div class="stat-card">

                    <div class="stat-top">


                        <div>

                            <div class="stat-label">
                                Dossiers
                            </div>


                            <div class="stat-value"
                                 id="totalDossiers">

                                ${totalDossiers}

                            </div>


                            <div class="stat-description">
                                Total des dossiers
                            </div>

                        </div>


                        <div class="stat-icon">

                            <i data-lucide="folder"></i>

                        </div>


                    </div>

                </div>

            </div>



            <!-- DOSSIERS COMPLETS -->

            <div class="col-xl-3 col-md-6">

                <div class="stat-card">

                    <div class="stat-top">


                        <div>

                            <div class="stat-label">
                                Dossiers complets
                            </div>


                            <div class="stat-value"
                                 id="dossiersComplets">

                                ${dossiersComplets}

                            </div>


                            <div class="stat-description">
                                Dossiers prêts à être vérifiés
                            </div>

                        </div>


                        <div class="stat-icon success">

                            <i data-lucide="folder-check"></i>

                        </div>


                    </div>

                </div>

            </div>



            <!-- DOCUMENTS -->

            <div class="col-xl-3 col-md-6">

                <div class="stat-card">

                    <div class="stat-top">


                        <div>

                            <div class="stat-label">
                                Documents
                            </div>


                            <div class="stat-value"
                                 id="totalDocuments">

                                ${totalDocuments}

                            </div>


                            <div class="stat-description">
                                Pièces déposées
                            </div>

                        </div>


                        <div class="stat-icon warning">

                            <i data-lucide="file-text"></i>

                        </div>


                    </div>

                </div>

            </div>



            <!-- RESULTATS -->

            <div class="col-xl-3 col-md-6">

                <div class="stat-card">

                    <div class="stat-top">


                        <div>

                            <div class="stat-label">
                                Résultats
                            </div>


                            <div class="stat-value"
                                 id="totalResultats">

                                ${totalResultats}

                            </div>


                            <div class="stat-description">
                                Résultats enregistrés
                            </div>

                        </div>


                        <div class="stat-icon">

                            <i data-lucide="award"></i>

                        </div>


                    </div>

                </div>

            </div>


        </div>



        <!-- =================================================
             GRAPHIQUES
             ================================================= -->

        <div class="row g-4">


            <!-- =================================================
                 DOSSIERS
                 ================================================= -->

            <div class="col-xl-8">

                <div class="card-custom">


                    <div class="card-header-custom">


                        <div class="card-header-left">


                            <div class="card-header-icon">

                                <i data-lucide="folder"></i>

                            </div>


                            <div>

                                <div class="card-header-title">
                                    État des dossiers
                                </div>

                                <div class="card-header-description">
                                    Répartition des dossiers complets et incomplets
                                </div>

                            </div>


                        </div>


                        <div class="refresh-status">

                            <span class="refresh-dot"></span>

                            Actualisation automatique

                        </div>


                    </div>


                    <div class="chart-container">

                        <canvas id="dossiersChart"></canvas>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 DOCUMENTS
                 ================================================= -->

            <div class="col-xl-4">

                <div class="card-custom">


                    <div class="card-header-custom">


                        <div class="card-header-left">


                            <div class="card-header-icon">

                                <i data-lucide="pie-chart"></i>

                            </div>


                            <div>

                                <div class="card-header-title">
                                    Documents
                                </div>

                                <div class="card-header-description">
                                    État de conformité
                                </div>

                            </div>


                        </div>


                    </div>


                    <div class="chart-container chart-container-small">

                        <canvas id="documentsChart"></canvas>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 RESULTATS
                 ================================================= -->

            <div class="col-xl-8">

                <div class="card-custom">


                    <div class="card-header-custom">


                        <div class="card-header-left">


                            <div class="card-header-icon">

                                <i data-lucide="bar-chart-3"></i>

                            </div>


                            <div>

                                <div class="card-header-title">
                                    Décisions
                                </div>

                                <div class="card-header-description">
                                    Répartition des candidats admis et non admis
                                </div>

                            </div>


                        </div>


                    </div>


                    <div class="chart-container">

                        <canvas id="resultatsChart"></canvas>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 PUBLICATION
                 ================================================= -->

            <div class="col-xl-4">

                <div class="card-custom">


                    <div class="card-header-custom">


                        <div class="card-header-left">


                            <div class="card-header-icon">

                                <i data-lucide="send"></i>

                            </div>


                            <div>

                                <div class="card-header-title">
                                    Publication
                                </div>

                                <div class="card-header-description">
                                    État de publication des résultats
                                </div>

                            </div>


                        </div>


                    </div>


                    <div class="chart-container chart-container-small">

                        <canvas id="publicationChart"></canvas>

                    </div>


                </div>

            </div>


        </div>


    </section>


</main>



<!-- =========================================================
     JAVASCRIPT
     ========================================================= -->

<script>


    /* =========================================================
       VARIABLES
       ========================================================= */

    let dossiersChart = null;

    let documentsChart = null;

    let resultatsChart = null;

    let publicationChart = null;



    /* =========================================================
       THEME
       ========================================================= */

    const savedTheme =
        localStorage.getItem("theme");


    if (savedTheme === "dark") {

        document.documentElement
                .classList.add("dark");

    }



    /* =========================================================
       THEME TOGGLE
       ========================================================= */

    document.getElementById("themeToggle")
        .addEventListener("click", function () {


            const html =
                document.documentElement;


            html.classList.toggle("dark");


            const dark =
                html.classList.contains("dark");


            localStorage.setItem(
                "theme",
                dark ? "dark" : "light"
            );


            /*
             * On redessine les graphiques
             * pour actualiser leurs couleurs.
             */

            if (window.lastStatisticsData) {

                afficherGraphiques(
                    window.lastStatisticsData
                );

            }

        });



    /* =========================================================
       CHARGEMENT DES STATISTIQUES
       ========================================================= */

    function actualiserStatistiques() {


        fetch(
            "${pageContext.request.contextPath}/StatistiquesServlet?action=data"
        )


        .then(function(response) {


            if (!response.ok) {

                throw new Error(
                    "Erreur HTTP : "
                    + response.status
                );

            }


            return response.json();

        })


        .then(function(data) {


            /*
             * Conserver les données
             * pour le changement de thème.
             */

            window.lastStatisticsData =
                data;



            /* =========================
               COMPTEURS
               ========================= */


            document.getElementById(
                "totalDossiers"
            ).textContent =
                data.dossiers;


            document.getElementById(
                "dossiersComplets"
            ).textContent =
                data.dossiersComplets;


            document.getElementById(
                "totalDocuments"
            ).textContent =
                data.documents;


            document.getElementById(
                "totalResultats"
            ).textContent =
                data.resultats;



            /* =========================
               GRAPHIQUES
               ========================= */

            afficherGraphiques(data);


        })


        .catch(function(error) {


            console.error(
                "Erreur statistiques :",
                error
            );


        });

    }



    /* =========================================================
       COULEURS DES GRAPHIQUES
       ========================================================= */

    function getChartColors() {


        const dark =
            document.documentElement
                .classList
                .contains("dark");


        return {

            text:
                dark
                    ? "#d1d5db"
                    : "#374151",

            grid:
                dark
                    ? "#1f2937"
                    : "#e5e7eb",

            primary:
                dark
                    ? "#60a5fa"
                    : "#2563eb",

            success:
                dark
                    ? "#4ade80"
                    : "#16a34a",

            warning:
                dark
                    ? "#fbbf24"
                    : "#d97706",

            danger:
                dark
                    ? "#f87171"
                    : "#dc2626",

            muted:
                dark
                    ? "#9ca3af"
                    : "#6b7280"

        };

    }



    /* =========================================================
       GRAPHIQUES
       ========================================================= */

    function afficherGraphiques(data) {


        const colors =
            getChartColors();



        /* =====================================================
           DOSSIERS
           ===================================================== */

        if (dossiersChart !== null) {

            dossiersChart.destroy();

        }


        dossiersChart = new Chart(

            document.getElementById(
                "dossiersChart"
            ),

            {

                type: "bar",


                data: {

                    labels: [

                        "Complets",

                        "Incomplets"

                    ],


                    datasets: [{

                        label:
                            "Nombre de dossiers",


                        data: [

                            data.dossiersComplets,

                            data.dossiersIncomplets

                        ],


                        backgroundColor: [

                            colors.success,

                            colors.danger

                        ],


                        borderRadius: 8,


                        borderWidth: 0

                    }]

                },


                options: {

                    responsive: true,

                    maintainAspectRatio: false,


                    plugins: {

                        legend: {

                            display: false

                        }

                    },


                    scales: {

                        x: {

                            ticks: {

                                color:
                                    colors.text

                            },


                            grid: {

                                display: false

                            }

                        },


                        y: {

                            beginAtZero: true,


                            ticks: {

                                precision: 0,

                                color:
                                    colors.text

                            },


                            grid: {

                                color:
                                    colors.grid

                            }

                        }

                    }

                }

            }

        );



        /* =====================================================
           DOCUMENTS
           ===================================================== */

        if (documentsChart !== null) {

            documentsChart.destroy();

        }


        documentsChart = new Chart(

            document.getElementById(
                "documentsChart"
            ),

            {

                type: "doughnut",


                data: {

                    labels: [

                        "Conformes",

                        "Non conformes"

                    ],


                    datasets: [{

                        data: [

                            data.documentsConformes,

                            data.documentsNonConformes

                        ],


                        backgroundColor: [

                            colors.success,

                            colors.danger

                        ],


                        borderWidth: 2,


                        borderColor:
                            document
                                .documentElement
                                .classList
                                .contains("dark")
                                ? "#111827"
                                : "#ffffff"

                    }]

                },


                options: {

                    responsive: true,

                    maintainAspectRatio: false,


                    cutout: "68%",


                    plugins: {

                        legend: {

                            position: "bottom",

                            labels: {

                                color:
                                    colors.text,

                                padding: 18,

                                usePointStyle: true

                            }

                        }

                    }

                }

            }

        );



        /* =====================================================
           RESULTATS
           ===================================================== */

        if (resultatsChart !== null) {

            resultatsChart.destroy();

        }


        resultatsChart = new Chart(

            document.getElementById(
                "resultatsChart"
            ),

            {

                type: "bar",


                data: {

                    labels: [

                        "Admis",

                        "Non admis"

                    ],


                    datasets: [{

                        label:
                            "Nombre de candidats",


                        data: [

                            data.admis,

                            data.nonAdmis

                        ],


                        backgroundColor: [

                            colors.success,

                            colors.danger

                        ],


                        borderRadius: 8,


                        borderWidth: 0

                    }]

                },


                options: {

                    responsive: true,

                    maintainAspectRatio: false,


                    plugins: {

                        legend: {

                            display: false

                        }

                    },


                    scales: {

                        x: {

                            ticks: {

                                color:
                                    colors.text

                            },


                            grid: {

                                display: false

                            }

                        },


                        y: {

                            beginAtZero: true,


                            ticks: {

                                precision: 0,

                                color:
                                    colors.text

                            },


                            grid: {

                                color:
                                    colors.grid

                            }

                        }

                    }

                }

            }

        );



        /* =====================================================
           PUBLICATION
           ===================================================== */

        if (publicationChart !== null) {

            publicationChart.destroy();

        }


        publicationChart = new Chart(

            document.getElementById(
                "publicationChart"
            ),

            {

                type: "doughnut",


                data: {

                    labels: [

                        "Publiés",

                        "Non publiés"

                    ],


                    datasets: [{

                        data: [

                            data.resultatsPublies,

                            data.resultatsNonPublies

                        ],


                        backgroundColor: [

                            colors.primary,

                            colors.muted

                        ],


                        borderWidth: 2,


                        borderColor:
                            document
                                .documentElement
                                .classList
                                .contains("dark")
                                ? "#111827"
                                : "#ffffff"

                    }]

                },


                options: {

                    responsive: true,

                    maintainAspectRatio: false,


                    cutout: "68%",


                    plugins: {

                        legend: {

                            position: "bottom",

                            labels: {

                                color:
                                    colors.text,

                                padding: 18,

                                usePointStyle: true

                            }

                        }

                    }

                }

            }

        );

    }



    /* =========================================================
       PREMIER CHARGEMENT
       ========================================================= */

    actualiserStatistiques();



    /* =========================================================
       ACTUALISATION AUTOMATIQUE
       ========================================================= */

    setInterval(

        actualiserStatistiques,

        5000

    );



    /* =========================================================
       LUCIDE
       ========================================================= */

    lucide.createIcons();


</script>


</body>

</html>