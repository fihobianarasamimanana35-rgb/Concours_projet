<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Ajouter un concours - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        /* =========================================================
           VARIABLES
           ========================================================= */

        :root {
            --bg: #f4f7fb;
            --surface: #ffffff;
            --surface-secondary: #f8fafc;
            --surface-hover: #f1f5f9;

            --text: #172033;
            --text-secondary: #475569;
            --muted: #64748b;

            --border: #e5e7eb;

            --sidebar: #0f172a;
            --sidebar-hover: #1e293b;

            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --primary-soft: rgba(37, 99, 235, .10);

            --danger: #dc3545;
            --danger-soft: rgba(220, 53, 69, .10);

            --shadow-sm: 0 2px 8px rgba(15, 23, 42, .04);
            --shadow-md: 0 10px 30px rgba(15, 23, 42, .07);
        }

        html.dark {
            --bg: #0b1120;
            --surface: #111827;
            --surface-secondary: #172033;
            --surface-hover: #1e293b;

            --text: #f8fafc;
            --text-secondary: #cbd5e1;
            --muted: #94a3b8;

            --border: #263244;

            --sidebar: #020617;
            --sidebar-hover: #172033;

            --primary: #3b82f6;
            --primary-dark: #60a5fa;
            --primary-soft: rgba(59, 130, 246, .14);

            --danger: #f87171;
            --danger-soft: rgba(248, 113, 113, .12);

            --shadow-sm: 0 2px 8px rgba(0, 0, 0, .20);
            --shadow-md: 0 10px 30px rgba(0, 0, 0, .25);
        }


        /* =========================================================
           BASE
           ========================================================= */

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

            transition:
                background .25s ease,
                color .25s ease;
        }


        /* =========================================================
           SIDEBAR
           ========================================================= */

        .sidebar {
            position: fixed;

            top: 0;
            left: 0;
            bottom: 0;

            width: 250px;

            background: var(--sidebar);

            padding: 20px 14px;

            z-index: 1000;

            overflow-y: auto;

            box-shadow:
                4px 0 20px rgba(0, 0, 0, .08);
        }

        .sidebar::-webkit-scrollbar {
            width: 4px;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #334155;
            border-radius: 10px;
        }

        .brand {
            height: 54px;

            display: flex;
            align-items: center;

            gap: 11px;

            padding: 0 12px;

            color: #ffffff;

            font-size: 19px;
            font-weight: 750;

            margin-bottom: 18px;
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
                0 6px 15px rgba(37, 99, 235, .25);

            flex-shrink: 0;
        }

        .brand-icon svg {
            width: 20px;
            height: 20px;
        }

        .nav-section {
            color: #64748b;

            font-size: 10px;
            font-weight: 700;

            text-transform: uppercase;

            padding: 0 12px;

            margin: 20px 0 8px;

            letter-spacing: .09em;
        }

        .nav-link-admin {
            display: flex;
            align-items: center;

            gap: 12px;

            padding: 11px 13px;

            margin-bottom: 4px;

            color: #94a3b8;

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
            color: #ffffff;

            transform: translateX(2px);
        }

        .nav-link-admin.active {
            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #1d4ed8
                );

            color: #ffffff;

            box-shadow:
                0 5px 15px rgba(37, 99, 235, .22);
        }

        .logout {
            position: absolute;

            left: 14px;
            right: 14px;
            bottom: 18px;

            display: flex;
            align-items: center;

            gap: 12px;

            padding: 11px 13px;

            color: #94a3b8;

            text-decoration: none;

            border-radius: 10px;

            font-size: 13.5px;
            font-weight: 500;

            transition: .2s;
        }

        .logout svg {
            width: 18px;
            height: 18px;
        }

        .logout:hover {
            background: var(--sidebar-hover);
            color: #ffffff;
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

            border-bottom: 1px solid var(--border);

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 32px;

            position: sticky;
            top: 0;

            z-index: 900;

            box-shadow: var(--shadow-sm);
        }

        .topbar-left {
            display: flex;
            align-items: center;

            gap: 11px;
        }

        .topbar-icon {
            width: 36px;
            height: 36px;

            border-radius: 10px;

            background: var(--primary-soft);

            color: var(--primary);

            display: flex;
            align-items: center;
            justify-content: center;
        }

        .topbar-icon svg {
            width: 18px;
            height: 18px;
        }

        .page-title {
            font-size: 15px;
            font-weight: 750;
        }

        .page-subtitle {
            color: var(--muted);

            font-size: 11px;

            margin-top: 1px;
        }

        .topbar-right {
            display: flex;
            align-items: center;

            gap: 10px;
        }

        .admin-profile {
            display: flex;
            align-items: center;

            gap: 8px;

            padding: 6px 10px;

            border: 1px solid var(--border);

            border-radius: 10px;

            color: var(--text-secondary);

            font-size: 12px;
            font-weight: 600;
        }

        .admin-icon {
            width: 28px;
            height: 28px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 8px;

            background: var(--primary-soft);

            color: var(--primary);
        }

        .admin-icon svg {
            width: 15px;
            height: 15px;
        }

        .theme-btn {
            width: 40px;
            height: 40px;

            border: 1px solid var(--border);

            background: var(--surface);

            color: var(--text-secondary);

            border-radius: 10px;

            display: flex;
            align-items: center;
            justify-content: center;

            transition: .2s;
        }

        .theme-btn:hover {
            background: var(--surface-hover);

            color: var(--primary);

            border-color: var(--primary);
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

            max-width: 1250px;
        }

        .breadcrumb-custom {
            display: flex;
            align-items: center;

            gap: 4px;

            font-size: 12px;

            color: var(--muted);

            margin-bottom: 10px;
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
            font-size: 27px;

            font-weight: 750;

            letter-spacing: -.025em;

            margin: 0 0 6px;
        }

        .page-heading p {
            color: var(--muted);

            font-size: 14px;

            margin: 0;
        }


        /* =========================================================
           FORM CARD
           ========================================================= */

        .form-card {
            background: var(--surface);

            border: 1px solid var(--border);

            border-radius: 18px;

            overflow: hidden;

            box-shadow: var(--shadow-md);
        }

        .card-header-custom {
            display: flex;
            align-items: center;

            gap: 14px;

            padding: 22px 26px;

            border-bottom: 1px solid var(--border);
        }

        .header-icon {
            width: 42px;
            height: 42px;

            flex-shrink: 0;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 11px;

            background: var(--primary-soft);

            color: var(--primary);
        }

        .header-icon svg {
            width: 20px;
            height: 20px;
        }

        .card-header-custom h5 {
            margin: 0;

            color: var(--text);

            font-size: 16px;
            font-weight: 750;
        }

        .card-header-custom p {
            margin: 4px 0 0;

            color: var(--muted);

            font-size: 12px;
        }


        /* =========================================================
           FORM BODY
           ========================================================= */

        .form-body {
            padding: 28px 26px;
        }

        .form-section-title {
            display: flex;
            align-items: center;

            gap: 8px;

            color: var(--text);

            font-size: 13px;
            font-weight: 750;

            margin-bottom: 18px;
        }

        .form-section-title::before {
            content: "";

            width: 4px;
            height: 18px;

            border-radius: 5px;

            background: var(--primary);
        }

        .form-label {
            color: var(--text);

            font-size: 13px;
            font-weight: 650;

            margin-bottom: 7px;
        }

        .required {
            color: var(--danger);

            font-weight: 700;
        }

        .form-control,
        .form-select {
            min-height: 46px;

            background: var(--surface);

            color: var(--text);

            border: 1px solid var(--border);

            border-radius: 9px;

            padding: 10px 13px;

            font-size: 13.5px;

            transition:
                border-color .2s ease,
                box-shadow .2s ease,
                background .2s ease;
        }

        .form-control::placeholder {
            color: #94a3b8;
        }

        .form-control:hover,
        .form-select:hover {
            border-color: #cbd5e1;
        }

        .form-control:focus,
        .form-select:focus {
            background: var(--surface);

            color: var(--text);

            border-color: var(--primary);

            box-shadow:
                0 0 0 3px var(--primary-soft);
        }

        textarea.form-control {
            min-height: 130px;

            resize: vertical;
        }

        .form-text {
            color: var(--muted);

            font-size: 11px;

            margin-top: 6px;
        }

        .field-icon-wrapper {
            position: relative;
        }

        .field-icon-wrapper .form-control,
        .field-icon-wrapper .form-select {
            padding-left: 40px;
        }

        .field-icon {
            position: absolute;

            left: 13px;
            top: 50%;

            transform: translateY(-50%);

            color: var(--muted);

            pointer-events: none;

            z-index: 2;
        }

        .field-icon svg {
            width: 16px;
            height: 16px;
        }

        .textarea-icon {
            position: absolute;

            left: 13px;
            top: 14px;

            color: var(--muted);

            pointer-events: none;

            z-index: 2;
        }

        .textarea-icon svg {
            width: 16px;
            height: 16px;
        }

        .textarea-with-icon {
            padding-left: 40px !important;
        }


        /* =========================================================
           DATE INFO
           ========================================================= */

        .date-info {
            display: flex;
            align-items: flex-start;

            gap: 10px;

            margin-top: 24px;

            padding: 13px 15px;

            background: var(--primary-soft);

            border: 1px solid rgba(37, 99, 235, .15);

            border-radius: 10px;

            color: var(--text-secondary);

            font-size: 12px;

            line-height: 1.5;
        }

        .date-info svg {
            width: 17px;
            height: 17px;

            flex-shrink: 0;

            color: var(--primary);

            margin-top: 1px;
        }


        /* =========================================================
           ERROR
           ========================================================= */

        .date-error {
            display: flex;
            align-items: flex-start;

            gap: 9px;

            border-radius: 10px;

            border: 1px solid rgba(220, 53, 69, .2);

            background: var(--danger-soft);

            color: var(--danger);

            padding: 13px 15px;

            font-size: 12px;
        }

        .date-error svg {
            width: 17px;
            height: 17px;

            flex-shrink: 0;
        }


        /* =========================================================
           FORM FOOTER
           ========================================================= */

        .form-footer {
            padding: 19px 26px;

            border-top: 1px solid var(--border);

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 10px;

            background: var(--surface-secondary);
        }

        .footer-info {
            color: var(--muted);

            font-size: 11px;
        }

        .footer-actions {
            display: flex;

            align-items: center;

            gap: 9px;
        }

        .btn {
            min-height: 42px;

            border-radius: 9px;

            padding: 9px 15px;

            font-size: 13px;

            font-weight: 650;

            display: inline-flex;

            align-items: center;

            justify-content: center;

            gap: 8px;
        }

        .btn svg {
            width: 16px;
            height: 16px;
        }

        .btn-cancel {
            color: var(--text-secondary);

            background: var(--surface);

            border: 1px solid var(--border);
        }

        .btn-cancel:hover {
            color: var(--text);

            background: var(--surface-hover);

            border-color: #cbd5e1;
        }

        .btn-primary {
            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #1d4ed8
                );

            border-color: #2563eb;

            color: #ffffff;

            box-shadow:
                0 5px 14px rgba(37, 99, 235, .18);
        }

        .btn-primary:hover {
            background:
                linear-gradient(
                    135deg,
                    #1d4ed8,
                    #1e40af
                );

            border-color: #1d4ed8;

            color: #ffffff;

            transform: translateY(-1px);

            box-shadow:
                0 7px 17px rgba(37, 99, 235, .25);
        }

        .btn-primary:disabled {
            opacity: .55;

            cursor: not-allowed;

            transform: none;

            box-shadow: none;
        }


        /* =========================================================
           DARK MODE
           ========================================================= */

        html.dark .btn-light {
            background: var(--surface);

            color: var(--text);

            border-color: var(--border);
        }

        html.dark .btn-light:hover {
            background: var(--surface-hover);
        }


        /* =========================================================
           RESPONSIVE
           ========================================================= */

        @media (max-width: 992px) {

            .sidebar {
                width: 78px;

                padding: 20px 10px;
            }

            .brand {
                justify-content: center;

                padding: 0;
            }

            .brand span,
            .nav-link-admin span,
            .nav-section,
            .logout span {
                display: none;
            }

            .nav-link-admin,
            .logout {
                justify-content: center;
            }

            .nav-link-admin {
                padding: 12px;
            }

            .logout {
                left: 10px;
                right: 10px;
            }

            .main {
                margin-left: 78px;
            }

            .content {
                padding: 26px;
            }

        }


        @media (max-width: 768px) {

            .topbar {
                height: 66px;

                padding: 0 20px;
            }

            .page-subtitle {
                display: none;
            }

            .admin-profile {
                padding: 6px;

                border: none;
            }

            .admin-profile span {
                display: none;
            }

            .content {
                padding: 22px 18px;
            }

            .form-body {
                padding: 23px 20px;
            }

            .card-header-custom {
                padding: 19px 20px;
            }

            .form-footer {
                padding: 17px 20px;
            }

            .footer-info {
                display: none;
            }

        }


        @media (max-width: 576px) {

            .sidebar {
                display: none;
            }

            .main {
                margin-left: 0;
            }

            .topbar {
                padding: 0 15px;
            }

            .content {
                padding: 18px 13px;
            }

            .page-heading h1 {
                font-size: 23px;
            }

            .page-heading {
                margin-bottom: 22px;
            }

            .form-card {
                border-radius: 14px;
            }

            .form-body {
                padding: 20px 16px;
            }

            .card-header-custom {
                padding: 17px 16px;
            }

            .form-footer {
                padding: 16px;

                flex-direction: column;
                align-items: stretch;
            }

            .footer-actions {
                width: 100%;
            }

            .footer-actions .btn {
                flex: 1;
            }

            .date-info {
                margin-top: 20px;
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


    <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminListe"
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


    <!-- TOPBAR -->

    <header class="topbar">

        <div class="topbar-left">

            <div class="topbar-icon">

                <i data-lucide="trophy"></i>

            </div>

            <div>

                <div class="page-title">
                    Concours
                </div>

                <div class="page-subtitle">
                    Gestion des concours
                </div>

            </div>

        </div>


        <div class="topbar-right">

            <button type="button"
                    id="themeToggle"
                    class="theme-btn"
                    title="Changer le thème"
                    aria-label="Changer le thème">

                <i data-lucide="moon"></i>

            </button>


            <div class="admin-profile">

                <div class="admin-icon">

                    <i data-lucide="shield-check"></i>

                </div>

                <span>Administrateur</span>

            </div>

        </div>

    </header>



    <!-- =====================================================
         CONTENT
         ===================================================== -->

    <section class="content">


        <!-- PAGE HEADING -->

        <div class="page-heading">


            <div class="breadcrumb-custom">

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=ajouter">

                    Concours

                </a>

                <span>/</span>

                <span>Ajouter</span>

            </div>


            <h1>
                Ajouter un concours
            </h1>


            <p>
                Créez un nouveau concours et définissez sa période d'inscription.
            </p>


        </div>



        <!-- =================================================
             FORM
             ================================================= -->

        <form method="post"
              action="${pageContext.request.contextPath}/ConcoursServlet?action=ajouter"
              id="concoursForm">


            <div class="form-card">


                <!-- HEADER -->

                <div class="card-header-custom">

                    <div class="header-icon">

                        <i data-lucide="plus-circle"></i>

                    </div>


                    <div>

                        <h5>
                            Informations du concours
                        </h5>

                        <p>
                            Les champs marqués d'un astérisque sont obligatoires.
                        </p>

                    </div>

                </div>



                <!-- BODY -->

                <div class="form-body">


                    <div class="form-section-title">
                        Informations générales
                    </div>


                    <div class="row g-4">


                        <!-- CODE -->

                        <div class="col-md-4">

                            <label class="form-label">

                                Code du concours

                                <span class="required">*</span>

                            </label>


                            <div class="field-icon-wrapper">

                                <span class="field-icon">
                                    <i data-lucide="hash"></i>
                                </span>


                                <input type="text"
                                       name="code_concours"
                                       class="form-control"
                                       placeholder="CONC-2026-001"
                                       required>

                            </div>

                        </div>



                        <!-- NOM -->

                        <div class="col-md-8">

                            <label class="form-label">

                                Nom du concours

                                <span class="required">*</span>

                            </label>


                            <div class="field-icon-wrapper">

                                <span class="field-icon">
                                    <i data-lucide="trophy"></i>
                                </span>


                                <input type="text"
                                       name="nom"
                                       class="form-control"
                                       placeholder="Ex : Concours de recrutement 2026"
                                       required>

                            </div>

                        </div>



                        <!-- DESCRIPTION -->

                        <div class="col-12">

                            <label class="form-label">
                                Description
                            </label>


                            <div style="position:relative;">

                                <span class="textarea-icon">

                                    <i data-lucide="align-left"></i>

                                </span>


                                <textarea name="description"
                                          class="form-control textarea-with-icon"
                                          placeholder="Décrivez le concours..."></textarea>

                            </div>

                        </div>


                    </div>



                    <div class="form-section-title mt-4">
                        Période et capacité
                    </div>


                    <div class="row g-4">


                        <!-- DATE DEBUT -->

                        <div class="col-md-4">

                            <label class="form-label">

                                Date de début

                                <span class="required">*</span>

                            </label>


                            <div class="field-icon-wrapper">

                                <span class="field-icon">

                                    <i data-lucide="calendar-days"></i>

                                </span>


                                <input type="date"
                                       id="date_debut"
                                       name="date_debut"
                                       class="form-control"
                                       required>

                            </div>


                            <div class="form-text">
                                Début des inscriptions.
                            </div>

                        </div>



                        <!-- DATE FIN -->

                        <div class="col-md-4">

                            <label class="form-label">

                                Date de fin

                                <span class="required">*</span>

                            </label>


                            <div class="field-icon-wrapper">

                                <span class="field-icon">

                                    <i data-lucide="calendar-check"></i>

                                </span>


                                <input type="date"
                                       id="date_fin"
                                       name="date_fin"
                                       class="form-control"
                                       required>

                            </div>


                            <div class="form-text">
                                Fin des inscriptions.
                            </div>

                        </div>



                        <!-- PLACES -->

                        <div class="col-md-4">

                            <label class="form-label">

                                Nombre de places

                                <span class="required">*</span>

                            </label>


                            <div class="field-icon-wrapper">

                                <span class="field-icon">

                                    <i data-lucide="users"></i>

                                </span>


                                <input type="number"
                                       name="nombre_places"
                                       class="form-control"
                                       min="1"
                                       step="1"
                                       placeholder="100"
                                       required>

                            </div>


                            <div class="form-text">
                                Nombre maximal de places.
                            </div>

                        </div>



                        <!-- STATUT -->

                        <div class="col-md-6">

                            <label class="form-label">

                                Statut

                                <span class="required">*</span>

                            </label>


                            <div class="field-icon-wrapper">

                                <span class="field-icon">

                                    <i data-lucide="circle-check"></i>

                                </span>


                                <select name="statut"
                                        class="form-select"
                                        required>

                                    <option value="">
                                        Sélectionner un statut
                                    </option>

                                    <option value="publie">
                                        Ouvert
                                    </option>

                                    <option value="ferme">
                                        Fermé
                                    </option>

                                    <option value="termine">
                                        Terminé
                                    </option>

                                </select>

                            </div>

                        </div>


                    </div>



                    <!-- INFO DATE -->

                    <div class="date-info">

                        <i data-lucide="info"></i>

                        <div>

                            <strong>Planification du concours</strong>

                            <br>

                            La date de début doit respecter le délai minimum
                            défini par le système et la date de fin doit être
                            postérieure à la date de début.

                        </div>

                    </div>



                    <!-- DATE ERROR -->

                    <div id="dateError"
                         class="date-error mt-3 d-none">

                        <i data-lucide="triangle-alert"></i>

                        <span>
                            La date de début doit être antérieure à la date de fin.
                        </span>

                    </div>


                </div>



                <!-- FOOTER -->

                <div class="form-footer">


                    <div class="footer-info">

                        <i data-lucide="shield-check"
                           style="width:14px;height:14px;vertical-align:-3px;">
                        </i>

                        Les informations seront enregistrées dans le système.

                    </div>


                    <div class="footer-actions">


                        <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminListe"
                           class="btn btn-cancel">

                            <i data-lucide="x"></i>

                            Annuler

                        </a>


                        <button type="submit"
                                id="submitBtn"
                                class="btn btn-primary">

                            <i data-lucide="save"></i>

                            Enregistrer

                        </button>


                    </div>

                </div>


            </div>


        </form>


    </section>


</main>



<!-- =========================================================
     SCRIPTS
     ========================================================= -->

<script src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>


<script>

    /* =========================================================
       THEME
       ========================================================= */

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


    themeToggle.addEventListener(
            "click",
            function () {

                const dark =
                        html.classList.contains("dark");


                localStorage.setItem(
                        "theme",
                        dark ? "light" : "dark"
                );


                appliquerTheme();

            }
    );



    /* =========================================================
       DATES
       ========================================================= */

    const dateDebut =
            document.getElementById("date_debut");

    const dateFin =
            document.getElementById("date_fin");

    const dateError =
            document.getElementById("dateError");

    const submitBtn =
            document.getElementById("submitBtn");


    function formaterDate(date) {

        const annee =
                date.getFullYear();

        const mois =
                String(
                        date.getMonth() + 1
                ).padStart(2, "0");

        const jour =
                String(
                        date.getDate()
                ).padStart(2, "0");


        return annee + "-"
                + mois + "-"
                + jour;

    }


    function ajouterJours(date, jours) {

        const nouvelleDate =
                new Date(date);


        nouvelleDate.setDate(
                nouvelleDate.getDate() + jours
        );


        return nouvelleDate;

    }


    function ajouterMois(date, mois) {

        const nouvelleDate =
                new Date(date);


        nouvelleDate.setMonth(
                nouvelleDate.getMonth() + mois
        );


        return nouvelleDate;

    }


    const aujourdHui =
            new Date();


    const dateMinimum =
            ajouterJours(
                    aujourdHui,
                    4
            );


    const dateMaximum =
            ajouterMois(
                    aujourdHui,
                    7
            );


    const minDate =
            formaterDate(
                    dateMinimum
            );


    const maxDate =
            formaterDate(
                    dateMaximum
            );


    dateDebut.min = minDate;
    dateDebut.max = maxDate;

    dateFin.min = minDate;



    /* =========================================================
       VALIDATION DATES
       ========================================================= */

    function verifierDates() {

        if (!dateDebut.value ||
            !dateFin.value) {

            dateError.classList.add(
                    "d-none"
            );

            submitBtn.disabled = false;

            return;
        }


        const debut =
                new Date(
                        dateDebut.value
                        + "T00:00:00"
                );


        const fin =
                new Date(
                        dateFin.value
                        + "T00:00:00"
                );


        const maintenant =
                new Date();


        const minimum =
                ajouterJours(
                        maintenant,
                        4
                );


        const maximum =
                ajouterMois(
                        maintenant,
                        7
                );


        if (debut < minimum) {

            dateError.querySelector(
                    "span"
            ).textContent =
                    "La date de début doit être au moins 4 jours après aujourd'hui.";


            dateError.classList.remove(
                    "d-none"
            );


            submitBtn.disabled = true;

            return;
        }


        if (debut > maximum) {

            dateError.querySelector(
                    "span"
            ).textContent =
                    "La date de début ne peut pas dépasser 7 mois à partir d'aujourd'hui.";


            dateError.classList.remove(
                    "d-none"
            );


            submitBtn.disabled = true;

            return;
        }


        if (fin <= debut) {

            dateError.querySelector(
                    "span"
            ).textContent =
                    "La date de fin doit être postérieure à la date de début.";


            dateError.classList.remove(
                    "d-none"
            );


            submitBtn.disabled = true;

            return;
        }


        dateError.classList.add(
                "d-none"
        );


        submitBtn.disabled = false;

    }



    dateDebut.addEventListener(
            "change",
            function () {

                if (dateDebut.value) {

                    dateFin.min =
                            dateDebut.value;

                }


                verifierDates();

            }
    );


    dateFin.addEventListener(
            "change",
            function () {

                verifierDates();

            }
    );


    document.getElementById(
            "concoursForm"
    ).addEventListener(
            "submit",
            function (event) {

                verifierDates();


                if (submitBtn.disabled) {

                    event.preventDefault();

                }

            }
    );



    /* =========================================================
       INITIALISATION
       ========================================================= */

    appliquerTheme();

</script>

</body>

</html>