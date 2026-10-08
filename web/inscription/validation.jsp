<%-- 
    Document   : validation
    Created on : 7 oct. 2026, 11:04:47
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>

<%@ page import="modele.CandidatModele" %>
<%@ page import="modele.InscriptionModele" %>
<%@ page import="modele.DossierModele" %>
<%@ page import="modele.DocumentModele" %>
<%@ page import="modele.ConcoursModele" %>

<%
    String contextPath = request.getContextPath();

    /*
     * ============================================================
     * RECUPERATION DES DONNEES
     * ============================================================
     */

    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    if (candidat == null) {
        candidat =
                (CandidatModele) session.getAttribute("inscription_candidat");
    }

    if (candidat == null) {
        candidat =
                (CandidatModele) session.getAttribute("candidat");
    }


    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");

    if (inscription == null) {
        inscription =
                (InscriptionModele) session.getAttribute("inscription");
    }


    DossierModele dossier =
            (DossierModele) request.getAttribute("dossier");

    if (dossier == null) {
        dossier =
                (DossierModele) session.getAttribute("inscription_dossier");
    }

    if (dossier == null) {
        dossier =
                (DossierModele) session.getAttribute("dossier");
    }


    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    if (concours == null) {
        concours =
                (ConcoursModele) session.getAttribute("inscription_concours");
    }

    if (concours == null) {
        concours =
                (ConcoursModele) session.getAttribute("concours");
    }


    List<DocumentModele> documents =
            (List<DocumentModele>) request.getAttribute("documents");

    if (documents == null) {
        documents =
                (List<DocumentModele>) session.getAttribute("inscription_documents");
    }


    String erreur =
            (String) request.getAttribute("erreur");


    /*
     * ============================================================
     * DETERMINATION MAJEUR / MINEUR
     * ============================================================
     */

    boolean mineur = false;

    if (candidat != null
            && candidat.getDate_naissance() != null
            && !candidat.getDate_naissance().trim().isEmpty()) {

        try {

            String[] parties =
                    candidat.getDate_naissance().split("-");

            if (parties.length == 3) {

                int annee =
                        Integer.parseInt(parties[0]);

                int mois =
                        Integer.parseInt(parties[1]);

                int jour =
                        Integer.parseInt(parties[2]);

                Calendar naissance =
                        Calendar.getInstance();

                naissance.set(
                        annee,
                        mois - 1,
                        jour
                );

                Calendar aujourdHui =
                        Calendar.getInstance();

                int age =
                        aujourdHui.get(Calendar.YEAR)
                        - naissance.get(Calendar.YEAR);

                if (aujourdHui.get(Calendar.MONTH)
                        < naissance.get(Calendar.MONTH)
                        ||
                        (
                            aujourdHui.get(Calendar.MONTH)
                            == naissance.get(Calendar.MONTH)
                            &&
                            aujourdHui.get(Calendar.DAY_OF_MONTH)
                            < naissance.get(Calendar.DAY_OF_MONTH)
                        )
                ) {
                    age--;
                }

                mineur = age < 18;
            }

        } catch (Exception e) {

            mineur = false;
        }
    }
%>

<!DOCTYPE html>

<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Validation - Suivi Concours</title>


    <!-- Bootstrap -->

    <link rel="stylesheet"
          href="<%= contextPath %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">


    <!-- Lucide -->

    <script src="<%= contextPath %>/js/lucide.min.js"></script>


    <style>

        :root {

            --primary:#0d6efd;

            --bg:#ffffff;

            --bg-secondary:#f8f9fa;

            --card:#ffffff;

            --text:#212529;

            --text-muted:#6c757d;

            --border:#e5e7eb;

            --shadow:0 10px 30px rgba(0,0,0,.07);

        }


        [data-theme="dark"] {

            --bg:#0f172a;

            --bg-secondary:#111827;

            --card:#1e293b;

            --text:#f8fafc;

            --text-muted:#94a3b8;

            --border:#334155;

            --shadow:0 10px 30px rgba(0,0,0,.25);

        }


        body {

            background:var(--bg);

            color:var(--text);

        }


        .navbar {

            background:var(--card);

            border-bottom:1px solid var(--border);

        }


        .navbar-brand {

            color:var(--text)!important;

            font-weight:700;

        }


        .theme-btn {

            width:42px;

            height:42px;

            border:1px solid var(--border);

            border-radius:12px;

            background:var(--card);

            color:var(--text);

        }


        .hero {

            background:linear-gradient(
                    135deg,
                    #0d6efd,
                    #0b5ed7,
                    #084298
            );

            color:#fff;

            padding:50px 0 75px;

        }


        .page-card {

            background:var(--card);

            border:1px solid var(--border);

            border-radius:24px;

            box-shadow:var(--shadow);

            padding:30px;

            margin-top:-50px;

        }


        .steps {

            display:flex;

            position:relative;

            margin-bottom:35px;

        }


        .steps:before {

            content:"";

            position:absolute;

            top:22px;

            left:10%;

            right:10%;

            height:3px;

            background:var(--border);

        }


        .step {

            flex:1;

            text-align:center;

            position:relative;

            z-index:1;

        }


        .step-number {

            width:46px;

            height:46px;

            border-radius:50%;

            display:flex;

            align-items:center;

            justify-content:center;

            margin:auto;

            background:var(--bg-secondary);

            border:3px solid var(--border);

            color:var(--text-muted);

            font-weight:700;

        }


        .step.active .step-number {

            background:var(--primary);

            border-color:var(--primary);

            color:#fff;

        }


        .step-label {

            margin-top:8px;

            font-size:.85rem;

            font-weight:600;

            color:var(--text-muted);

        }


        .step.active .step-label {

            color:var(--primary);

        }


        .summary-card {

            border:1px solid var(--border);

            border-radius:18px;

            padding:22px;

            margin-bottom:20px;

        }


        .summary-header {

            display:flex;

            align-items:center;

            gap:12px;

            margin-bottom:20px;

        }


        .summary-icon {

            width:44px;

            height:44px;

            border-radius:12px;

            background:rgba(13,110,253,.1);

            color:var(--primary);

            display:flex;

            align-items:center;

            justify-content:center;

        }


        .summary-header h5 {

            margin:0;

            font-weight:700;

        }


        .data-row {

            display:flex;

            justify-content:space-between;

            gap:20px;

            padding:10px 0;

            border-bottom:1px solid var(--border);

        }


        .data-row:last-child {

            border-bottom:0;

        }


        .data-label {

            color:var(--text-muted);

        }


        .data-value {

            font-weight:600;

            text-align:right;

            word-break:break-word;

        }


        .document-item {

            display:flex;

            align-items:center;

            justify-content:space-between;

            gap:20px;

            padding:12px 0;

            border-bottom:1px solid var(--border);

        }


        .document-item:last-child {

            border-bottom:0;

        }


        .btn {

            border-radius:11px;

            font-weight:600;

            padding:11px 20px;

        }


        footer {

            padding:35px 0;

            color:var(--text-muted);

        }


        @media (max-width:768px) {

            .page-card {

                padding:20px;

            }


            .steps:before {

                left:5%;

                right:5%;

            }


            .step-label {

                font-size:.72rem;

            }


            .step-number {

                width:40px;

                height:40px;

                font-size:.85rem;

            }


            .data-row {

                flex-direction:column;

                gap:4px;

            }


            .data-value {

                text-align:left;

            }


            .document-item {

                align-items:flex-start;

            }

        }

    </style>

</head>


<body>


<!-- ============================================================
     NAVBAR
     ============================================================ -->

<nav class="navbar">

    <div class="container py-2">

        <div class="d-flex justify-content-between align-items-center w-100">

            <a class="navbar-brand d-flex align-items-center gap-2"
               href="<%= contextPath %>/index.jsp">

                <i data-lucide="graduation-cap"></i>

                Suivi Concours

            </a>


            <div class="d-flex gap-2">

                <a href="<%= contextPath %>/index.jsp"
                   class="btn btn-sm btn-outline-primary">

                    <i data-lucide="home"></i>

                    Accueil

                </a>


                <button id="themeToggle"
                        type="button"
                        class="theme-btn">

                    <i data-lucide="moon"></i>

                </button>

            </div>

        </div>

    </div>

</nav>


<!-- ============================================================
     HERO
     ============================================================ -->

<section class="hero">

    <div class="container text-center">

        <i data-lucide="clipboard-check"
           style="width:42px;height:42px;"></i>


        <h1 class="fw-bold mt-3">

            Vérification de votre dossier

        </h1>


        <p class="mb-0 opacity-75">

            Vérifiez toutes les informations avant de confirmer.

        </p>

    </div>

</section>


<!-- ============================================================
     CONTENU
     ============================================================ -->

<main class="container">

    <div class="page-card">


        <!-- ====================================================
             ETAPES
             ==================================================== -->

        <div class="steps">

            <div class="step">

                <div class="step-number">
                    01
                </div>

                <div class="step-label">
                    Candidat
                </div>

            </div>


            <div class="step">

                <div class="step-number">
                    02
                </div>

                <div class="step-label">
                    Dossier
                </div>

            </div>


            <div class="step">

                <div class="step-number">
                    03
                </div>

                <div class="step-label">
                    Documents
                </div>

            </div>


            <div class="step active">

                <div class="step-number">
                    04
                </div>

                <div class="step-label">
                    Validation
                </div>

            </div>


            <div class="step">

                <div class="step-number">
                    05
                </div>

                <div class="step-label">
                    Confirmation
                </div>

            </div>

        </div>


        <!-- ====================================================
             ERREUR
             ==================================================== -->

        <% if (erreur != null && !erreur.trim().isEmpty()) { %>

            <div class="alert alert-danger d-flex align-items-start gap-2">

                <i data-lucide="circle-alert"></i>

                <div>
                    <%= erreur %>
                </div>

            </div>

        <% } %>


        <!-- ====================================================
             TITRE
             ==================================================== -->

        <h3 class="fw-bold mb-1">

            Récapitulatif

        </h3>


        <p class="text-muted mb-4">

            Assurez-vous que toutes les informations sont correctes.

        </p>


        <!-- ====================================================
             CONCOURS
             ==================================================== -->

        <% if (concours != null) { %>

            <div class="summary-card">

                <div class="summary-header">

                    <div class="summary-icon">

                        <i data-lucide="graduation-cap"></i>

                    </div>

                    <h5>
                        Concours sélectionné
                    </h5>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Concours
                    </span>

                    <span class="data-value">

                        <%= concours.getNom() != null
                                ? concours.getNom()
                                : "Non renseigné" %>

                    </span>

                </div>

            </div>

        <% } %>


        <!-- ====================================================
             CANDIDAT
             ==================================================== -->

        <div class="summary-card">

            <div class="summary-header">

                <div class="summary-icon">

                    <i data-lucide="user"></i>

                </div>

                <h5>
                    Informations du candidat
                </h5>

            </div>


            <% if (candidat != null) { %>


                <div class="data-row">

                    <span class="data-label">
                        Numéro candidat
                    </span>

                    <span class="data-value">

                        <%= candidat.getNumero_candidat() != null
                                ? candidat.getNumero_candidat()
                                : "Non attribué" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Nom
                    </span>

                    <span class="data-value">

                        <%= candidat.getNom() != null
                                ? candidat.getNom()
                                : "" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Prénom(s)
                    </span>

                    <span class="data-value">

                        <%= candidat.getPrenom() != null
                                ? candidat.getPrenom()
                                : "" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Date de naissance
                    </span>

                    <span class="data-value">

                        <%= candidat.getDate_naissance() != null
                                ? candidat.getDate_naissance()
                                : "" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Lieu de naissance
                    </span>

                    <span class="data-value">

                        <%= candidat.getLieu_naissance() != null
                                ? candidat.getLieu_naissance()
                                : "" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Sexe
                    </span>

                    <span class="data-value">

                        <%= "M".equals(candidat.getSexe())
                                ? "Masculin"
                                : "F".equals(candidat.getSexe())
                                    ? "Féminin"
                                    : "Non renseigné" %>

                    </span>

                </div>


                <% if (mineur) { %>

                    <div class="data-row">

                        <span class="data-label">
                            Numéro de copie
                        </span>

                        <span class="data-value">

                            <%= candidat.getNumero_copie() != null
                                    ? candidat.getNumero_copie()
                                    : "Non renseigné" %>

                        </span>

                    </div>

                <% } else { %>

                    <div class="data-row">

                        <span class="data-label">
                            CIN
                        </span>

                        <span class="data-value">

                            <%= candidat.getCin() != null
                                    ? candidat.getCin()
                                    : "Non renseigné" %>

                        </span>

                    </div>

                <% } %>


                <div class="data-row">

                    <span class="data-label">
                        Téléphone
                    </span>

                    <span class="data-value">

                        <%= candidat.getTelephone() != null
                                ? candidat.getTelephone()
                                : "" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Email
                    </span>

                    <span class="data-value">

                        <%= candidat.getEmail() != null
                                ? candidat.getEmail()
                                : "" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Adresse
                    </span>

                    <span class="data-value">

                        <%= candidat.getAdresse() != null
                                ? candidat.getAdresse()
                                : "" %>

                    </span>

                </div>


            <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Les informations du candidat sont introuvables.

                </div>


            <% } %>

        </div>


        <!-- ====================================================
             DOSSIER
             ==================================================== -->

        <div class="summary-card">

            <div class="summary-header">

                <div class="summary-icon">

                    <i data-lucide="folder-open"></i>

                </div>

                <h5>
                    Dossier académique
                </h5>

            </div>


            <% if (dossier != null) { %>


                <div class="data-row">

                    <span class="data-label">
                        Niveau d'étude
                    </span>

                    <span class="data-value">

                        <%= dossier.getNiveau_etude() != null
                                ? dossier.getNiveau_etude()
                                : "Non renseigné" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Diplôme
                    </span>

                    <span class="data-value">

                        <%= dossier.getDiplome() != null
                                ? dossier.getDiplome()
                                : "Non renseigné" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Année du diplôme
                    </span>

                    <span class="data-value">

                        <%= dossier.getAnnee_diplome() %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        Établissement
                    </span>

                    <span class="data-value">

                        <%= dossier.getEtablissement() != null
                                ? dossier.getEtablissement()
                                : "Non renseigné" %>

                    </span>

                </div>


                <div class="data-row">

                    <span class="data-label">
                        État du dossier
                    </span>

                    <span class="data-value">

                        <% if (dossier.isComplet()) { %>

                            <span class="badge bg-success">

                                <i data-lucide="check-circle"
                                   style="width:15px;height:15px;"></i>

                                Complet

                            </span>

                        <% } else { %>

                            <span class="badge bg-warning text-dark">

                                <i data-lucide="clock"
                                   style="width:15px;height:15px;"></i>

                                Incomplet

                            </span>

                        <% } %>

                    </span>

                </div>


            <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Les informations du dossier sont introuvables.

                </div>


            <% } %>

        </div>


        <!-- ====================================================
             DOCUMENTS
             ==================================================== -->

        <div class="summary-card">

            <div class="summary-header">

                <div class="summary-icon">

                    <i data-lucide="files"></i>

                </div>

                <h5>
                    Documents déposés
                </h5>

            </div>


            <% if (documents != null && !documents.isEmpty()) { %>


                <% for (DocumentModele document : documents) { %>


                    <div class="document-item">

                        <div class="d-flex align-items-center gap-3">

                            <i data-lucide="file-text"></i>


                            <div>

                                <strong>

                                    <%= document.getType_document() != null
                                            ? document.getType_document()
                                            : "Document" %>

                                </strong>


                                <div class="small text-muted">

                                    <%= document.getNom_original() != null
                                            ? document.getNom_original()
                                            : document.getNom_fichier() != null
                                                ? document.getNom_fichier()
                                                : "Fichier" %>

                                </div>

                            </div>

                        </div>


                        <% if (document.isConforme()) { %>

                            <span class="badge bg-success">

                                Conforme

                            </span>

                        <% } else { %>

                            <span class="badge bg-warning text-dark">

                                En attente de vérification

                            </span>

                        <% } %>

                    </div>


                <% } %>


            <% } else { %>


                <div class="alert alert-warning mb-0">

                    <i data-lucide="triangle-alert"></i>

                    Aucun document n'a encore été déposé.

                </div>


            <% } %>

        </div>


        <!-- ====================================================
             INFORMATION IMPORTANTE
             ==================================================== -->

        <div class="alert alert-primary">

            <div class="d-flex gap-3">

                <i data-lucide="shield-check"></i>

                <div>

                    <strong>
                        Dernière étape
                    </strong>


                    <div class="small mt-1">

                        En cliquant sur « Confirmer mon inscription »,
                        votre dossier sera enregistré et transmis
                        pour vérification par l'administration.

                        <br>

                        <strong>
                            Votre inscription restera en attente
                            jusqu'à sa vérification administrative.
                        </strong>

                    </div>

                </div>

            </div>

        </div>


        <!-- ====================================================
             FORMULAIRE FINAL
             ==================================================== -->

        <form action="<%= contextPath %>/inscriptionPublique"
              method="post"
              id="validationForm">


            <input type="hidden"
                   name="action"
                   value="valider">


            <% if (inscription != null) { %>

                <input type="hidden"
                       name="id_inscription"
                       value="<%= inscription.getId_inscription() %>">

            <% } %>


            <% if (dossier != null) { %>

                <input type="hidden"
                       name="id_dossier"
                       value="<%= dossier.getId_dossier() %>">

            <% } %>


            <!-- =================================================
                 CHECKBOX DE CERTIFICATION
                 ================================================= -->

            <div class="form-check mb-4">

                <input class="form-check-input"
                       type="checkbox"
                       id="confirmation"
                       name="confirmation"
                       value="oui"
                       required>


                <label class="form-check-label"
                       for="confirmation">

                    Je certifie que les informations fournies sont exactes
                    et que les documents déposés sont authentiques.

                </label>

            </div>


            <!-- =================================================
                 BOUTONS
                 ================================================= -->

            <div class="d-flex justify-content-between gap-3">


                <button type="button"
                        onclick="history.back()"
                        class="btn btn-outline-secondary">

                    <i data-lucide="arrow-left"></i>

                    Modifier

                </button>


                <button type="submit"
                        id="submitButton"
                        class="btn btn-primary">

                    Confirmer mon inscription

                    <i data-lucide="check"></i>

                </button>

            </div>


        </form>


    </div>

</main>


<!-- ============================================================
     FOOTER
     ============================================================ -->

<footer>

    <div class="container text-center">

        <small>

            © 2026 Suivi Concours — Plateforme de gestion des concours

        </small>

    </div>

</footer>


<!-- Bootstrap -->

<script src="<%= contextPath %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>


<script>

    /*
     * ============================================================
     * THEME
     * ============================================================
     */

    const savedTheme =
        localStorage.getItem("theme");


    if (savedTheme === "dark") {

        document.documentElement.setAttribute(
            "data-theme",
            "dark"
        );

    }


    const themeToggle =
        document.getElementById("themeToggle");


    if (themeToggle) {

        themeToggle.addEventListener(
            "click",
            function () {

                const current =
                    document.documentElement.getAttribute(
                        "data-theme"
                    );


                if (current === "dark") {

                    document.documentElement.removeAttribute(
                        "data-theme"
                    );

                    localStorage.setItem(
                        "theme",
                        "light"
                    );

                } else {

                    document.documentElement.setAttribute(
                        "data-theme",
                        "dark"
                    );

                    localStorage.setItem(
                        "theme",
                        "dark"
                    );

                }


                if (typeof lucide !== "undefined") {

                    lucide.createIcons();

                }

            }
        );

    }


    /*
     * ============================================================
     * PREVENTION DU DOUBLE ENVOI
     * ============================================================
     */

    const validationForm =
        document.getElementById("validationForm");


    if (validationForm) {

        validationForm.addEventListener(
            "submit",
            function () {

                const checkbox =
                    document.getElementById("confirmation");


                if (!checkbox.checked) {

                    return;

                }


                const button =
                    document.getElementById("submitButton");


                if (button) {

                    button.disabled = true;

                    button.innerHTML =
                        '<span class="spinner-border spinner-border-sm me-2" role="status"></span>' +
                        'Enregistrement...';

                }

            }
        );

    }


    /*
     * ============================================================
     * LUCIDE
     * ============================================================
     */

    if (typeof lucide !== "undefined") {

        lucide.createIcons();

    }

</script>


</body>

</html>