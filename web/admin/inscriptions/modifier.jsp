<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="modele.InscriptionModele" %>
<%@ page import="modele.CandidatModele" %>
<%@ page import="modele.ConcoursModele" %>
<%@ page import="modele.DossierModele" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.DocumentModele" %>

<%
    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");

    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    DossierModele dossier =
            (DossierModele) request.getAttribute("dossier");

    List<DocumentModele> documents =
            (List<DocumentModele>) request.getAttribute("documents");

    String erreur =
            (String) request.getAttribute("erreur");

    String succes =
            (String) request.getAttribute("succes");

    String contextPath = request.getContextPath();
%>


<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Validation de candidature - Administration</title>


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
            max-width: 1250px;
        }


        .page-heading {
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
            margin-bottom: 22px;
        }


        .card-header-custom {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 12px;
        }


        .card-header-icon {
            width: 40px;
            height: 40px;
            border-radius: 11px;
            background: var(--primary-soft);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
        }


        .card-header-icon svg {
            width: 20px;
            height: 20px;
        }


        .card-title {
            margin: 0;
            font-size: 17px;
            font-weight: 700;
        }


        .card-subtitle {
            color: var(--muted);
            font-size: 13px;
            margin-top: 2px;
        }


        .card-body-custom {
            padding: 24px;
        }


        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }


        .info-item {
            padding: 16px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 12px;
        }


        .info-label {
            display: block;
            color: var(--muted);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .05em;
            margin-bottom: 6px;
        }


        .info-value {
            font-size: 15px;
            font-weight: 600;
            word-break: break-word;
        }


        .document-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }


        .document-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            padding: 15px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 12px;
        }


        .document-left {
            display: flex;
            align-items: center;
            gap: 13px;
            min-width: 0;
        }


        .document-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--primary-soft);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }


        .document-name {
            font-weight: 700;
            font-size: 14px;
            word-break: break-word;
        }


        .document-meta {
            color: var(--muted);
            font-size: 12px;
            margin-top: 3px;
        }


        .validation-card {
            border: 1px solid #bfdbfe;
            background: #eff6ff;
        }


        html.dark .validation-card {
            background: #172554;
            border-color: #1e40af;
        }


        .validation-body {
            padding: 24px;
        }


        .validation-title {
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 6px;
        }


        .validation-text {
            color: var(--muted);
            margin-bottom: 20px;
        }


        .validation-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }


        .btn-action {
            border-radius: 10px;
            padding: 10px 17px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }


        .btn-action svg {
            width: 17px;
            height: 17px;
        }


        .alert {
            border-radius: 12px;
            border-width: 1px;
        }


        .empty-box {
            text-align: center;
            padding: 55px 25px;
        }


        .empty-icon {
            width: 62px;
            height: 62px;
            border-radius: 17px;
            background: var(--surface-soft);
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
        }


        .empty-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 7px;
        }


        .empty-text {
            color: var(--muted);
            margin-bottom: 20px;
        }


        .rejected-box {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
            border-radius: 12px;
            padding: 18px;
        }


        html.dark .rejected-box {
            background: #450a0a;
            border-color: #7f1d1d;
            color: #fecaca;
        }


        .rejected-title {
            font-weight: 700;
            margin-bottom: 7px;
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

            .card-body-custom,
            .validation-body {
                padding: 18px;
            }

            .document-item {
                align-items: flex-start;
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
           href="<%= contextPath %>/DocumentServlet?action=liste">

            <i data-lucide="files"></i>

            <span>Documents</span>

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

            <div class="page-title">
                Validation de candidature
            </div>

            <div class="breadcrumb-custom">
                Administration / Inscriptions / Validation
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

            <h1 class="heading-title">
                Validation de candidature
            </h1>

            <p class="heading-description">
                Vérifiez les informations du candidat, son dossier et ses documents avant de prendre une décision.
            </p>

        </div>



        <% if (erreur != null && !erreur.trim().isEmpty()) { %>

        <div class="alert alert-danger d-flex align-items-center gap-2">

            <i data-lucide="circle-alert"></i>

            <div>
                <%= erreur %>
            </div>

        </div>

        <% } %>



        <% if (succes != null && !succes.trim().isEmpty()) { %>

        <div class="alert alert-success d-flex align-items-center gap-2">

            <i data-lucide="circle-check"></i>

            <div>
                <%= succes %>
            </div>

        </div>

        <% } %>



        <% if (inscription == null) { %>


        <div class="card-custom">

            <div class="empty-box">

                <div class="empty-icon">

                    <i data-lucide="file-question"></i>

                </div>

                <div class="empty-title">
                    Inscription introuvable
                </div>

                <div class="empty-text">
                    Impossible de charger les informations de cette candidature.
                </div>

                <a href="<%= contextPath %>/InscriptionServlet?action=liste"
                   class="btn btn-primary btn-action">

                    <i data-lucide="arrow-left"></i>

                    Retour aux inscriptions

                </a>

            </div>

        </div>


        <% } else { %>



        <!-- INFORMATIONS INSCRIPTION -->

        <div class="card-custom">

            <div class="card-header-custom">

                <div class="card-header-icon">
                    <i data-lucide="file-signature"></i>
                </div>

                <div>

                    <h2 class="card-title">
                        Informations de l'inscription
                    </h2>

                    <div class="card-subtitle">
                        Référence de la candidature
                    </div>

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
                            Statut
                        </span>

                        <div class="info-value">


                            <%
                                String statut = inscription.getStatut();

                                if ("en_attente".equalsIgnoreCase(statut)) {
                            %>

                            <span class="badge bg-warning text-dark">
                                En attente
                            </span>

                            <%
                                } else if ("valide".equalsIgnoreCase(statut)) {
                            %>

                            <span class="badge bg-success">
                                Validée
                            </span>

                            <%
                                } else if ("rejete".equalsIgnoreCase(statut)) {
                            %>

                            <span class="badge bg-danger">
                                Rejetée
                            </span>

                            <%
                                } else {
                            %>

                            <span class="badge bg-secondary">
                                <%= statut != null ? statut : "-" %>
                            </span>

                            <%
                                }
                            %>


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
                            Date de validation
                        </span>

                        <div class="info-value">

                            <%= inscription.getDate_validation() != null
                                    ? inscription.getDate_validation()
                                    : "Non encore validée" %>

                        </div>

                    </div>


                </div>


            </div>

        </div>



        <!-- CANDIDAT -->

        <div class="card-custom">

            <div class="card-header-custom">

                <div class="card-header-icon">
                    <i data-lucide="user-round"></i>
                </div>

                <div>

                    <h2 class="card-title">
                        Informations du candidat
                    </h2>

                    <div class="card-subtitle">
                        Identité et coordonnées
                    </div>

                </div>

            </div>


            <div class="card-body-custom">


                <% if (candidat != null) { %>


                <div class="info-grid">


                    <div class="info-item">

                        <span class="info-label">
                            Numéro candidat
                        </span>

                        <div class="info-value">
                            <%= candidat.getNumero_candidat() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Nom
                        </span>

                        <div class="info-value">
                            <%= candidat.getNom() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Prénom
                        </span>

                        <div class="info-value">
                            <%= candidat.getPrenom() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Date de naissance
                        </span>

                        <div class="info-value">
                            <%= candidat.getDate_naissance() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Sexe
                        </span>

                        <div class="info-value">
                            <%= candidat.getSexe() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Téléphone
                        </span>

                        <div class="info-value">
                            <%= candidat.getTelephone() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Email
                        </span>

                        <div class="info-value">
                            <%= candidat.getEmail() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Adresse
                        </span>

                        <div class="info-value">
                            <%= candidat.getAdresse() %>
                        </div>

                    </div>


                </div>


                <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Les informations du candidat ne sont pas disponibles.

                </div>


                <% } %>


            </div>

        </div>



        <!-- CONCOURS -->

        <div class="card-custom">

            <div class="card-header-custom">

                <div class="card-header-icon">
                    <i data-lucide="trophy"></i>
                </div>

                <div>

                    <h2 class="card-title">
                        Concours
                    </h2>

                    <div class="card-subtitle">
                        Concours concerné par l'inscription
                    </div>

                </div>

            </div>


            <div class="card-body-custom">


                <% if (concours != null) { %>


                <div class="info-item">

                    <span class="info-label">
                        Nom du concours
                    </span>

                    <div class="info-value">
                        <%= concours.getNom() %>
                    </div>

                </div>


                <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Les informations du concours ne sont pas disponibles.

                </div>


                <% } %>


            </div>

        </div>



        <!-- DOSSIER -->

        <div class="card-custom">

            <div class="card-header-custom">

                <div class="card-header-icon">
                    <i data-lucide="folder-open"></i>
                </div>

                <div>

                    <h2 class="card-title">
                        Dossier de candidature
                    </h2>

                    <div class="card-subtitle">
                        Vérification des informations du dossier
                    </div>

                </div>

            </div>


            <div class="card-body-custom">


                <% if (dossier != null) { %>


                <div class="info-grid">


                    <div class="info-item">

                        <span class="info-label">
                            Niveau d'étude
                        </span>

                        <div class="info-value">
                            <%= dossier.getNiveau_etude() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Diplôme
                        </span>

                        <div class="info-value">
                            <%= dossier.getDiplome() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Année du diplôme
                        </span>

                        <div class="info-value">
                            <%= dossier.getAnnee_diplome() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            Établissement
                        </span>

                        <div class="info-value">
                            <%= dossier.getEtablissement() %>
                        </div>

                    </div>


                    <div class="info-item">

                        <span class="info-label">
                            État du dossier
                        </span>

                        <div class="info-value">


                            <% if (dossier.isComplet()) { %>

                            <span class="badge bg-success">
                                Dossier complet
                            </span>

                            <% } else { %>

                            <span class="badge bg-danger">
                                Dossier incomplet
                            </span>

                            <% } %>


                        </div>

                    </div>


                </div>


                <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Aucun dossier de candidature n'est disponible.

                </div>


                <% } %>


            </div>

        </div>



        <!-- DOCUMENTS -->

        <div class="card-custom">

            <div class="card-header-custom">

                <div class="card-header-icon">
                    <i data-lucide="files"></i>
                </div>

                <div>

                    <h2 class="card-title">
                        Documents déposés
                    </h2>

                    <div class="card-subtitle">
                        Vérification de la conformité des pièces
                    </div>

                </div>

            </div>


            <div class="card-body-custom">


                <% if (documents != null && !documents.isEmpty()) { %>


                <div class="document-list">


                    <% for (DocumentModele document : documents) { %>


                    <div class="document-item">


                        <div class="document-left">


                            <div class="document-icon">

                                <i data-lucide="file-text"></i>

                            </div>


                            <div>

                                <div class="document-name">

                                    <%= document.getNom_original() != null
                                            ? document.getNom_original()
                                            : "-" %>

                                </div>


                                <div class="document-meta">

                                    Type :
                                    <%= document.getType_document() != null
                                            ? document.getType_document()
                                            : "-" %>

                                    &nbsp; • &nbsp;

                                    Extension :
                                    <%= document.getExtension() != null
                                            ? document.getExtension()
                                            : "-" %>

                                </div>

                            </div>


                        </div>


                        <div>


                            <% if (document.isConforme()) { %>

                            <span class="badge bg-success">
                                Conforme
                            </span>

                            <% } else { %>

                            <span class="badge bg-danger">
                                Non conforme
                            </span>

                            <% } %>


                        </div>


                    </div>


                    <% } %>


                </div>


                <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Aucun document déposé.

                </div>


                <% } %>


            </div>

        </div>



        <!-- VALIDATION -->

        <% if ("en_attente".equals(inscription.getStatut())) { %>


        <div class="card-custom validation-card">


            <div class="validation-body">


                <div class="validation-title">
                    Décision administrative
                </div>


                <div class="validation-text">

                    Après avoir vérifié les informations du candidat,
                    le dossier et les documents déposés, vous pouvez
                    valider ou rejeter cette candidature.

                </div>


                <div class="validation-actions">


                    <form method="post"
                          action="<%= contextPath %>/InscriptionServlet"
                          onsubmit="return confirm('Voulez-vous vraiment valider cette candidature ?');">

                        <input type="hidden"
                               name="action"
                               value="valider">

                        <input type="hidden"
                               name="id"
                               value="<%= inscription.getId_inscription() %>">


                        <button type="submit"
                                class="btn btn-success btn-action">

                            <i data-lucide="check-circle-2"></i>

                            Valider la candidature

                        </button>

                    </form>


                    <button type="button"
                            class="btn btn-danger btn-action"
                            data-bs-toggle="modal"
                            data-bs-target="#modalRejet">

                        <i data-lucide="x-circle"></i>

                        Rejeter la candidature

                    </button>


                </div>


            </div>

        </div>


        <% } %>



        <!-- MOTIF DU REJET -->

        <% if ("rejete".equals(inscription.getStatut())
                && inscription.getMotif_rejet() != null
                && !inscription.getMotif_rejet().trim().isEmpty()) { %>


        <div class="rejected-box mb-4">


            <div class="d-flex align-items-center gap-2 mb-2">

                <i data-lucide="circle-x"></i>

                <div class="rejected-title">
                    Candidature rejetée
                </div>

            </div>


            <div>

                <strong>Motif :</strong>

                <%= inscription.getMotif_rejet() %>

            </div>


        </div>


        <% } %>



        <div class="mb-4">

            <a href="<%= contextPath %>/InscriptionServlet?action=liste"
               class="btn btn-outline-secondary btn-action">

                <i data-lucide="arrow-left"></i>

                Retour aux inscriptions

            </a>

        </div>


        <% } %>


    </section>


</main>



<!-- MODAL REJET -->

<div class="modal fade"
     id="modalRejet"
     tabindex="-1"
     aria-labelledby="modalRejetLabel"
     aria-hidden="true">


    <div class="modal-dialog modal-dialog-centered">


        <div class="modal-content">


            <form method="post"
                  action="<%= contextPath %>/InscriptionServlet">


                <div class="modal-header">

                    <h5 class="modal-title"
                        id="modalRejetLabel">

                        Rejeter la candidature

                    </h5>


                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Fermer">
                    </button>

                </div>


                <div class="modal-body">


                    <p class="text-muted">

                        Veuillez indiquer le motif du rejet.
                        Ce motif sera associé à la candidature.

                    </p>


                    <input type="hidden"
                           name="action"
                           value="rejeter">


                    <% if (inscription != null) { %>

                    <input type="hidden"
                           name="id"
                           value="<%= inscription.getId_inscription() %>">

                    <% } %>


                    <div class="mb-3">

                        <label for="motif_rejet"
                               class="form-label fw-semibold">

                            Motif du rejet

                        </label>


                        <textarea
                                class="form-control"
                                id="motif_rejet"
                                name="motif_rejet"
                                rows="5"
                                required
                                placeholder="Saisissez le motif du rejet..."></textarea>

                    </div>


                </div>


                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-outline-secondary"
                            data-bs-dismiss="modal">

                        Annuler

                    </button>


                    <button type="submit"
                            class="btn btn-danger"
                            onclick="return confirm('Voulez-vous vraiment rejeter cette candidature ?');">

                        <i data-lucide="x-circle"></i>

                        Confirmer le rejet

                    </button>

                </div>


            </form>


        </div>

    </div>

</div>



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