<%-- 
    Document   : details
    Created on : 7 oct. 2026, 08:29:08
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modele.CandidatModele"%>

<%
    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    if (candidat == null) {
        response.sendRedirect(
                request.getContextPath()
                + "/CandidatServlet?action=liste"
        );
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Détails du candidat - Suivi Concours</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <style>

        :root {
            --bg: #f4f7fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
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

            --success: #16a34a;
            --success-soft: rgba(22, 163, 74, .10);

            --shadow-sm: 0 2px 8px rgba(15, 23, 42, .04);
            --shadow-md: 0 8px 30px rgba(15, 23, 42, .07);
        }

        html.dark {
            --bg: #0b1120;
            --surface: #111827;
            --surface-soft: #172033;
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

            --success: #22c55e;
            --success-soft: rgba(34, 197, 94, .14);

            --shadow-sm: 0 2px 8px rgba(0, 0, 0, .20);
            --shadow-md: 0 8px 30px rgba(0, 0, 0, .25);
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

        .sidebar-brand {
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

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            box-shadow:
                0 6px 15px rgba(37, 99, 235, .25);
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

            letter-spacing: .09em;

            padding: 0 12px;

            margin: 20px 0 8px;
        }

        .sidebar a {
            color: #94a3b8;

            text-decoration: none;

            display: flex;
            align-items: center;

            gap: 12px;

            padding: 11px 13px;

            margin-bottom: 3px;

            border-radius: 10px;

            font-size: 13.5px;
            font-weight: 500;

            transition:
                background .2s ease,
                color .2s ease,
                transform .2s ease;
        }

        .sidebar a svg {
            width: 18px;
            height: 18px;

            flex-shrink: 0;
        }

        .sidebar a:hover {
            background: var(--sidebar-hover);
            color: #ffffff;

            transform: translateX(2px);
        }

        .sidebar a.active {
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

        .sidebar-footer {
            margin-top: 22px;
            padding-top: 12px;

            border-top: 1px solid rgba(255,255,255,.08);
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

        .topbar-title {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .topbar-title-icon {
            width: 36px;
            height: 36px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background: var(--primary-soft);
            color: var(--primary);
        }

        .topbar-title-icon svg {
            width: 18px;
            height: 18px;
        }

        .topbar-title-text {
            font-size: 15px;
            font-weight: 700;
        }

        .topbar-subtitle {
            color: var(--muted);
            font-size: 12px;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .theme-btn {
            width: 40px;
            height: 40px;

            display: flex;
            align-items: center;
            justify-content: center;

            border: 1px solid var(--border);

            background: var(--surface);

            color: var(--text-secondary);

            border-radius: 10px;

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

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 9px;

            padding: 6px 10px;

            border: 1px solid var(--border);

            border-radius: 10px;

            color: var(--text-secondary);

            font-size: 13px;
            font-weight: 600;
        }

        .admin-profile-icon {
            width: 30px;
            height: 30px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 8px;

            background: var(--primary-soft);
            color: var(--primary);
        }

        .admin-profile-icon svg {
            width: 16px;
            height: 16px;
        }

        /* =========================================================
           CONTENT
           ========================================================= */

        .content {
            padding: 32px;
            max-width: 1500px;
        }

        .breadcrumb-area {
            margin-bottom: 24px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;

            color: var(--text-secondary);

            border: 1px solid var(--border);

            background: var(--surface);

            border-radius: 9px;

            padding: 9px 13px;

            font-size: 13px;
            font-weight: 600;

            text-decoration: none;

            transition: .2s;
        }

        .back-btn:hover {
            color: var(--primary);
            border-color: var(--primary);
            background: var(--primary-soft);

            transform: translateX(-2px);
        }

        .back-btn svg {
            width: 16px;
            height: 16px;
        }

        .page-heading {
            margin-top: 18px;
        }

        .page-heading h1 {
            font-size: 26px;
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
           CANDIDATE HEADER
           ========================================================= */

        .candidate-card {
            background: var(--surface);

            border: 1px solid var(--border);

            border-radius: 18px;

            box-shadow: var(--shadow-md);

            overflow: hidden;

            margin-bottom: 24px;
        }

        .candidate-banner {
            height: 92px;

            background:
                radial-gradient(
                    circle at 85% 20%,
                    rgba(255,255,255,.18),
                    transparent 35%
                ),
                linear-gradient(
                    135deg,
                    #1d4ed8,
                    #2563eb,
                    #3b82f6
                );
        }

        .candidate-main {
            padding: 0 28px 26px;

            position: relative;
        }

        .candidate-avatar {
            width: 82px;
            height: 82px;

            border-radius: 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: var(--surface);

            color: var(--primary);

            border: 5px solid var(--surface);

            box-shadow:
                0 6px 20px rgba(15, 23, 42, .12);

            position: relative;

            margin-top: -41px;

            margin-bottom: 15px;
        }

        .candidate-avatar svg {
            width: 36px;
            height: 36px;
        }

        .candidate-info {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;

            gap: 20px;
        }

        .candidate-name {
            font-size: 23px;
            font-weight: 750;

            letter-spacing: -.02em;

            margin: 0 0 5px;
        }

        .candidate-number {
            display: inline-flex;
            align-items: center;
            gap: 6px;

            color: var(--muted);

            font-size: 13px;
        }

        .candidate-number svg {
            width: 15px;
            height: 15px;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;

            padding: 8px 12px;

            border-radius: 999px;

            background: var(--success-soft);
            color: var(--success);

            font-size: 12px;
            font-weight: 700;
        }

        .status-dot {
            width: 7px;
            height: 7px;

            border-radius: 50%;

            background: currentColor;
        }

        /* =========================================================
           INFORMATION CARDS
           ========================================================= */

        .section-card {
            background: var(--surface);

            border: 1px solid var(--border);

            border-radius: 16px;

            box-shadow: var(--shadow-sm);

            padding: 24px;

            margin-bottom: 20px;
        }

        .section-header {
            display: flex;
            align-items: center;

            gap: 12px;

            margin-bottom: 20px;
        }

        .section-icon {
            width: 38px;
            height: 38px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background: var(--primary-soft);
            color: var(--primary);

            flex-shrink: 0;
        }

        .section-icon svg {
            width: 18px;
            height: 18px;
        }

        .section-title {
            color: var(--text);

            font-size: 15px;
            font-weight: 750;

            margin: 0 0 2px;
        }

        .section-description {
            color: var(--muted);

            font-size: 12px;

            margin: 0;
        }

        .detail-box {
            height: 100%;

            background: var(--surface-soft);

            border: 1px solid transparent;

            border-radius: 12px;

            padding: 16px 17px;

            transition:
                background .2s ease,
                border-color .2s ease,
                transform .2s ease;
        }

        .detail-box:hover {
            background: var(--surface-hover);

            border-color: var(--border);

            transform: translateY(-1px);
        }

        .detail-label {
            display: flex;
            align-items: center;
            gap: 6px;

            color: var(--muted);

            font-size: 11px;
            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .045em;

            margin-bottom: 8px;
        }

        .detail-value {
            color: var(--text);

            font-size: 15px;
            font-weight: 650;

            word-break: break-word;
        }

        /* =========================================================
           FOOTER ACTIONS
           ========================================================= */

        .page-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            padding-top: 6px;
        }

        .btn {
            border-radius: 9px;

            font-size: 13px;
            font-weight: 600;

            padding: 9px 14px;

            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn svg {
            width: 16px;
            height: 16px;
        }

        .btn-outline-secondary {
            color: var(--text-secondary);

            border-color: var(--border);

            background: var(--surface);
        }

        .btn-outline-secondary:hover {
            color: var(--primary);

            background: var(--primary-soft);

            border-color: var(--primary);
        }

        /* =========================================================
           DARK MODE BOOTSTRAP OVERRIDES
           ========================================================= */

        html.dark .btn-light {
            background: var(--surface);
            color: var(--text);
            border-color: var(--border);
        }

        html.dark .btn-light:hover {
            background: var(--surface-hover);
        }

        html.dark .text-muted {
            color: var(--muted) !important;
        }

        /* =========================================================
           RESPONSIVE
           ========================================================= */

        @media (max-width: 1100px) {

            .content {
                padding: 26px;
            }

        }

        @media (max-width: 992px) {

            .sidebar {
                width: 78px;

                padding: 20px 10px;
            }

            .sidebar-brand {
                justify-content: center;

                padding: 0;

                font-size: 0;
            }

            .sidebar-brand .brand-icon {
                margin: 0;
            }

            .nav-section {
                display: none;
            }

            .sidebar a {
                justify-content: center;

                padding: 12px;

                margin-bottom: 5px;
            }

            .sidebar a span {
                display: none;
            }

            .sidebar-footer {
                margin-top: 18px;
            }

            .main {
                margin-left: 78px;
            }

            .topbar {
                padding: 0 22px;
            }

            .content {
                padding: 24px 20px;
            }

            .candidate-info {
                align-items: flex-start;
                flex-direction: column;
            }

        }

        @media (max-width: 768px) {

            .topbar {
                height: 64px;
            }

            .topbar-subtitle {
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
                padding: 20px 15px;
            }

            .candidate-banner {
                height: 75px;
            }

            .candidate-main {
                padding-left: 20px;
                padding-right: 20px;
            }

            .candidate-avatar {
                width: 72px;
                height: 72px;

                margin-top: -36px;
            }

            .candidate-name {
                font-size: 20px;
            }

            .section-card {
                padding: 19px;
            }

            .page-heading h1 {
                font-size: 22px;
            }

        }

        @media (max-width: 576px) {

            .main {
                margin-left: 0;
            }

            .sidebar {
                display: none;
            }

            .topbar {
                padding: 0 15px;
            }

            .topbar-title-text {
                font-size: 14px;
            }

            .content {
                padding: 18px 13px;
            }

            .page-heading {
                margin-top: 15px;
            }

            .candidate-card {
                border-radius: 14px;
            }

            .candidate-main {
                padding: 0 17px 20px;
            }

            .section-card {
                border-radius: 14px;
                padding: 17px;
            }

            .detail-box {
                padding: 14px;
            }

            .page-actions {
                justify-content: flex-start;
            }

        }

    </style>

</head>

<body>

<!-- =========================================================
     SIDEBAR
     ========================================================= -->

<div class="sidebar">

    <div class="sidebar-brand">

        <div class="brand-icon">

            <i data-lucide="shield-check"></i>

        </div>

        <span>Suivi Concours</span>

    </div>


    <div class="nav-section">
        Administration
    </div>


    <a href="<%= request.getContextPath() %>/DashboardServlet">

        <i data-lucide="layout-dashboard"></i>

        <span>Dashboard</span>

    </a>


    <a href="<%= request.getContextPath() %>/ConcoursServlet?action=adminListe">

        <i data-lucide="trophy"></i>

        <span>Concours</span>

    </a>


    <a href="<%= request.getContextPath() %>/EpreuveServlet?action=liste">

        <i data-lucide="file-text"></i>

        <span>Épreuves</span>

    </a>


    <a class="active"
       href="<%= request.getContextPath() %>/CandidatServlet?action=liste">

        <i data-lucide="users"></i>

        <span>Candidats</span>

    </a>


    <a href="<%= request.getContextPath() %>/InscriptionServlet?action=liste">

        <i data-lucide="clipboard-list"></i>

        <span>Inscriptions</span>

    </a>


    <a href="<%= request.getContextPath() %>/DossierServlet?action=liste">

        <i data-lucide="folder-open"></i>

        <span>Dossiers</span>

    </a>


    <a href="<%= request.getContextPath() %>/admin/resultats/liste.jsp">

        <i data-lucide="award"></i>

        <span>Résultats</span>

    </a>


    <a href="<%= request.getContextPath() %>/admin/statistiques/index.jsp">

        <i data-lucide="bar-chart-3"></i>

        <span>Statistiques</span>

    </a>


    <div class="sidebar-footer">

        <a href="<%= request.getContextPath() %>/LogoutServlet">

            <i data-lucide="log-out"></i>

            <span>Déconnexion</span>

        </a>

    </div>

</div>


<!-- =========================================================
     MAIN
     ========================================================= -->

<div class="main">


    <!-- TOPBAR -->

    <div class="topbar">

        <div class="topbar-title">

            <div class="topbar-title-icon">

                <i data-lucide="users"></i>

            </div>

            <div>

                <div class="topbar-title-text">
                    Gestion des candidats
                </div>

                <div class="topbar-subtitle">
                    Consultation des informations candidat
                </div>

            </div>

        </div>


        <div class="topbar-right">

            <button type="button"
                    class="theme-btn"
                    id="themeToggle"
                    title="Changer le thème">

                <i data-lucide="moon"></i>

            </button>


            <div class="admin-profile">

                <div class="admin-profile-icon">

                    <i data-lucide="shield-check"></i>

                </div>

                <span>Administrateur</span>

            </div>

        </div>

    </div>


    <!-- CONTENT -->

    <div class="content">


        <!-- PAGE HEADER -->

        <div class="breadcrumb-area">

            <a href="<%= request.getContextPath() %>/CandidatServlet?action=liste"
               class="back-btn">

                <i data-lucide="arrow-left"></i>

                Retour aux candidats

            </a>


            <div class="page-heading">

                <h1>
                    Détails du candidat
                </h1>

                <p>
                    Consultez les informations personnelles et administratives du candidat.
                </p>

            </div>

        </div>


        <!-- =====================================================
             CANDIDATE HEADER
             ===================================================== -->

        <div class="candidate-card">

            <div class="candidate-banner"></div>


            <div class="candidate-main">

                <div class="candidate-avatar">

                    <i data-lucide="user"></i>

                </div>


                <div class="candidate-info">

                    <div>

                        <h2 class="candidate-name">

                            <%= candidat.getNom() %>
                            <%= candidat.getPrenom() %>

                        </h2>


                        <div class="candidate-number">

                            <i data-lucide="badge"></i>

                            Candidat

                            <strong>
                                <%= candidat.getNumero_candidat() != null
                                        ? candidat.getNumero_candidat()
                                        : "-" %>
                            </strong>

                        </div>

                    </div>


                    <div class="status-badge">

                        <span class="status-dot"></span>

                        Dossier candidat

                    </div>

                </div>

            </div>

        </div>


        <!-- =====================================================
             INFORMATIONS PERSONNELLES
             ===================================================== -->

        <div class="section-card">

            <div class="section-header">

                <div class="section-icon">

                    <i data-lucide="user-round"></i>

                </div>

                <div>

                    <h3 class="section-title">
                        Informations personnelles
                    </h3>

                    <p class="section-description">
                        Informations d'identification du candidat.
                    </p>

                </div>

            </div>


            <div class="row g-3">


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Numéro candidat
                        </div>

                        <div class="detail-value">

                            <%= candidat.getNumero_candidat() != null
                                    ? candidat.getNumero_candidat()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Nom
                        </div>

                        <div class="detail-value">

                            <%= candidat.getNom() != null
                                    ? candidat.getNom()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Prénom
                        </div>

                        <div class="detail-value">

                            <%= candidat.getPrenom() != null
                                    ? candidat.getPrenom()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Sexe
                        </div>

                        <div class="detail-value">

                            <%= candidat.getSexe() != null
                                    ? candidat.getSexe()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Date de naissance
                        </div>

                        <div class="detail-value">

                            <%= candidat.getDate_naissance() != null
                                    ? candidat.getDate_naissance()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Lieu de naissance
                        </div>

                        <div class="detail-value">

                            <%= candidat.getLieu_naissance() != null
                                    ? candidat.getLieu_naissance()
                                    : "-" %>

                        </div>

                    </div>

                </div>


            </div>

        </div>


        <!-- =====================================================
             COORDONNÉES
             ===================================================== -->

        <div class="section-card">

            <div class="section-header">

                <div class="section-icon">

                    <i data-lucide="contact"></i>

                </div>

                <div>

                    <h3 class="section-title">
                        Coordonnées
                    </h3>

                    <p class="section-description">
                        Informations de contact et documents d'identification.
                    </p>

                </div>

            </div>


            <div class="row g-3">


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            CIN
                        </div>

                        <div class="detail-value">

                            <%= candidat.getCin() != null
                                    ? candidat.getCin()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Téléphone
                        </div>

                        <div class="detail-value">

                            <%= candidat.getTelephone() != null
                                    ? candidat.getTelephone()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Email
                        </div>

                        <div class="detail-value">

                            <%= candidat.getEmail() != null
                                    ? candidat.getEmail()
                                    : "-" %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Adresse
                        </div>

                        <div class="detail-value">

                            <%= candidat.getAdresse() != null
                                    ? candidat.getAdresse()
                                    : "-" %>

                        </div>

                    </div>

                </div>


            </div>

        </div>


        <!-- =====================================================
             INFORMATIONS SYSTÈME
             ===================================================== -->

        <div class="section-card">

            <div class="section-header">

                <div class="section-icon">

                    <i data-lucide="database"></i>

                </div>

                <div>

                    <h3 class="section-title">
                        Informations du système
                    </h3>

                    <p class="section-description">
                        Informations techniques liées à l'enregistrement.
                    </p>

                </div>

            </div>


            <div class="row g-3">


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            ID candidat
                        </div>

                        <div class="detail-value">

                            <%= candidat.getId_candidat() %>

                        </div>

                    </div>

                </div>


                <div class="col-md-6">

                    <div class="detail-box">

                        <div class="detail-label">
                            Date de création
                        </div>

                        <div class="detail-value">

                            <%= candidat.getDate_creation() != null
                                    ? candidat.getDate_creation()
                                    : "-" %>

                        </div>

                    </div>

                </div>


            </div>

        </div>


        <!-- =====================================================
             ACTIONS
             ===================================================== -->

        <div class="page-actions">

            <a href="<%= request.getContextPath() %>/CandidatServlet?action=liste"
               class="btn btn-outline-secondary">

                <i data-lucide="arrow-left"></i>

                Retour à la liste

            </a>

        </div>


    </div>

</div>


<!-- =========================================================
     SCRIPTS
     ========================================================= -->

<script src="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<script src="<%= request.getContextPath() %>/js/lucide.min.js"></script>


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