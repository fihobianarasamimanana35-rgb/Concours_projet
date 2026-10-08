<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modele.ConcoursModele" %>

<%
    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    if (concours == null) {

        response.sendRedirect(
            request.getContextPath()
            + "/ConcoursServlet?action=adminListe"
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

    <title>Modifier un concours - Suivi Concours</title>

    <link href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        :root {
            --bg: #f5f7fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
            --text: #172033;
            --muted: #6b7280;
            --border: #e5e7eb;
            --sidebar: #111827;
            --sidebar-hover: #1f2937;
            --primary: #2563eb;
            --primary-soft: #eff6ff;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1f2937;
            --text: #f3f4f6;
            --muted: #9ca3af;
            --border: #374151;
            --sidebar: #020617;
            --sidebar-hover: #1f2937;
            --primary: #3b82f6;
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

        /* SIDEBAR */

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
            background: var(--sidebar);
            padding: 22px 16px;
            z-index: 1000;
        }

        .brand {
            height: 52px;
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 0 12px;
            color: #ffffff;
            font-size: 19px;
            font-weight: 700;
            margin-bottom: 24px;
        }

        .brand-icon {
            width: 35px;
            height: 35px;
            border-radius: 10px;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(37, 99, 235, .25);
        }

        .nav-section {
            color: #6b7280;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            padding: 0 12px;
            margin: 18px 0 8px;
            letter-spacing: .08em;
        }

        .nav-link-admin {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 13px;
            margin-bottom: 4px;
            color: #9ca3af;
            text-decoration: none;
            border-radius: 10px;
            font-size: 14px;
            transition: all .2s ease;
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
            background: #2563eb;
            color: #ffffff;
            box-shadow: 0 6px 16px rgba(37, 99, 235, .20);
        }

        .logout {
            position: absolute;
            left: 16px;
            right: 16px;
            bottom: 18px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 13px;
            color: #9ca3af;
            text-decoration: none;
            border-radius: 10px;
            font-size: 14px;
        }

        .logout:hover {
            background: var(--sidebar-hover);
            color: #ffffff;
        }

        /* MAIN */

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
            font-size: 17px;
            font-weight: 700;
        }

        .page-subtitle {
            color: var(--muted);
            font-size: 12px;
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
        }

        .theme-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        .content {
            padding: 32px;
            max-width: 1200px;
        }

        /* PAGE HEADER */

        .breadcrumb-custom {
            color: var(--muted);
            font-size: 13px;
            margin-bottom: 8px;
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
            font-size: 28px;
            font-weight: 750;
            letter-spacing: -.02em;
            margin-bottom: 5px;
        }

        .page-heading p {
            color: var(--muted);
            margin: 0;
        }

        /* FORM */

        .form-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 17px;
            overflow: hidden;
        }

        .card-header-custom {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: var(--primary-soft);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-header-custom h5 {
            margin: 0;
            font-size: 16px;
            font-weight: 700;
        }

        .card-header-custom p {
            margin: 4px 0 0;
            color: var(--muted);
            font-size: 12px;
        }

        .form-body {
            padding: 28px 24px;
        }

        .form-label {
            font-weight: 650;
            font-size: 13px;
            color: var(--text);
            margin-bottom: 8px;
        }

        .required {
            color: #dc2626;
        }

        .form-control,
        .form-select {
            min-height: 45px;
            background: var(--surface);
            color: var(--text);
            border: 1px solid var(--border);
            border-radius: 9px;
        }

        .form-control::placeholder {
            color: var(--muted);
        }

        textarea.form-control {
            min-height: 125px;
            resize: vertical;
        }

        .form-control:focus,
        .form-select:focus {
            background: var(--surface);
            color: var(--text);
            border-color: var(--primary);
            box-shadow: 0 0 0 .2rem rgba(37, 99, 235, .12);
        }

        .form-text {
            color: var(--muted);
            font-size: 11px;
            margin-top: 6px;
        }

        .readonly-box {
            min-height: 45px;
            display: flex;
            align-items: center;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 9px;
            padding: 10px 13px;
            color: var(--muted);
            font-size: 13px;
        }

        .field-icon {
            color: var(--primary);
            margin-right: 7px;
        }

        .form-footer {
            padding: 20px 24px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        .btn {
            border-radius: 9px;
            font-weight: 600;
        }

        .btn-primary {
            background: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;
        }

        .btn-light {
            background: var(--surface);
            color: var(--text);
            border-color: var(--border);
        }

        .btn-light:hover {
            background: var(--surface-soft);
            color: var(--text);
        }

        /* ALERT */

        .date-alert {
            border-radius: 10px;
            border: 1px solid #fecaca;
            font-size: 13px;
        }

        /* RESPONSIVE */

        @media (max-width: 992px) {

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

            .content {
                padding: 25px;
            }
        }

        @media (max-width: 576px) {

            .topbar {
                padding: 0 15px;
            }

            .content {
                padding: 20px 15px;
            }

            .page-heading h1 {
                font-size: 24px;
            }

            .form-body {
                padding: 22px 18px;
            }

            .form-footer {
                flex-direction: column-reverse;
                align-items: stretch;
            }

            .form-footer .btn {
                width: 100%;
                justify-content: center;
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

<main class="main">

    <header class="topbar">

        <div>

            <div class="page-title">
                Concours
            </div>

            <div class="page-subtitle">
                Modification du concours
            </div>

        </div>

        <button type="button"
                id="themeToggle"
                class="theme-btn"
                aria-label="Changer le thème">

            <i data-lucide="moon"></i>

        </button>

    </header>

    <section class="content">

        <div class="breadcrumb-custom">

            <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminListe">
                Concours
            </a>

            <span class="mx-1">/</span>

            Modifier

        </div>

        <div class="page-heading">

            <h1>
                Modifier le concours
            </h1>

            <p>
                Modifiez les informations du concours sélectionné.
            </p>

        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/ConcoursServlet?action=modifier"
              id="concoursForm">

            <input type="hidden"
                   name="id_concours"
                   value="<%= concours.getId_concours() %>">

            <div class="form-card">

                <div class="card-header-custom">

                    <div class="card-icon">
                        <i data-lucide="trophy" size="19"></i>
                    </div>

                    <div>

                        <h5>
                            Informations du concours
                        </h5>

                        <p>
                            Modifiez les informations nécessaires au concours.
                        </p>

                    </div>

                </div>

                <div class="form-body">

                    <div class="row g-4">

                        <div class="col-md-4">

                            <label class="form-label">

                                Code du concours
                                <span class="required">*</span>

                            </label>

                            <input type="text"
                                   name="code_concours"
                                   class="form-control"
                                   value="<%= concours.getCode_concours() %>"
                                   required>

                            <div class="form-text">
                                Identifiant unique du concours.
                            </div>

                        </div>

                        <div class="col-md-8">

                            <label class="form-label">

                                Nom du concours
                                <span class="required">*</span>

                            </label>

                            <input type="text"
                                   name="nom"
                                   class="form-control"
                                   value="<%= concours.getNom() %>"
                                   required>

                        </div>

                        <div class="col-12">

                            <label class="form-label">
                                Description
                            </label>

                            <textarea name="description"
                                      class="form-control"><%= concours.getDescription() == null
                                      ? ""
                                      : concours.getDescription() %></textarea>

                            <div class="form-text">
                                Présentez brièvement l'objectif du concours.
                            </div>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label">

                                Date de début
                                <span class="required">*</span>

                            </label>

                            <input type="date"
                                   id="date_debut"
                                   name="date_debut"
                                   class="form-control"
                                   value="<%= concours.getDate_debut() %>"
                                   required>

                            <div class="form-text">
                                Date de début des inscriptions.
                            </div>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label">

                                Date de fin
                                <span class="required">*</span>

                            </label>

                            <input type="date"
                                   id="date_fin"
                                   name="date_fin"
                                   class="form-control"
                                   value="<%= concours.getDate_fin() %>"
                                   required>

                            <div class="form-text">
                                Date de clôture des inscriptions.
                            </div>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label">

                                Nombre de places
                                <span class="required">*</span>

                            </label>

                            <input type="number"
                                   name="nombre_places"
                                   class="form-control"
                                   min="1"
                                   step="1"
                                   value="<%= concours.getNombre_places() %>"
                                   required>

                            <div class="form-text">
                                Nombre maximal de candidats.
                            </div>

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">

                                Statut
                                <span class="required">*</span>

                            </label>

                            <select name="statut"
                                    class="form-select"
                                    required>

                                <option value="publie"
                                    <%= "ouvert".equalsIgnoreCase(concours.getStatut())
                                            || "publie".equalsIgnoreCase(concours.getStatut())
                                            ? "selected"
                                            : "" %>>
                                    Ouvert
                                </option>

                                <option value="ferme"
                                    <%= "ferme".equalsIgnoreCase(concours.getStatut())
                                            ? "selected"
                                            : "" %>>
                                    Fermé
                                </option>

                                <option value="termine"
                                    <%= "termine".equalsIgnoreCase(concours.getStatut())
                                            ? "selected"
                                            : "" %>>
                                    Terminé
                                </option>

                            </select>

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">
                                Date de création
                            </label>

                            <div class="readonly-box">

                                <i data-lucide="calendar-plus"
                                   size="16"
                                   class="field-icon"></i>

                                <%= concours.getDate_creation() == null
                                        ? "Non disponible"
                                        : concours.getDate_creation() %>

                            </div>

                            <div class="form-text">
                                Cette information ne peut pas être modifiée.
                            </div>

                        </div>

                    </div>

                    <div id="dateError"
                         class="alert alert-danger date-alert mt-4 d-none">

                        La date de début doit être antérieure à la date de fin.

                    </div>

                </div>

                <div class="form-footer">

                    <a href="${pageContext.request.contextPath}/ConcoursServlet?action=adminDetails&id=<%= concours.getId_concours() %>"
                       class="btn btn-light border d-flex align-items-center gap-2">

                        <i data-lucide="arrow-left" size="17"></i>
                        Annuler

                    </a>

                    <button type="submit"
                            id="submitBtn"
                            class="btn btn-primary d-flex align-items-center gap-2">

                        <i data-lucide="save" size="17"></i>

                        Enregistrer les modifications

                    </button>

                </div>

            </div>

        </form>

    </section>

</main>

<script src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>

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
            String(date.getMonth() + 1)
                .padStart(2, "0");

        const jour =
            String(date.getDate())
                .padStart(2, "0");

        return annee + "-" + mois + "-" + jour;
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

    dateDebut.min =
        formaterDate(dateMinimum);

    dateDebut.max =
        formaterDate(dateMaximum);

    function verifierDates() {

        if (!dateDebut.value ||
            !dateFin.value) {

            dateError.classList.add("d-none");
            submitBtn.disabled = false;

            return;
        }

        const debut =
            new Date(
                dateDebut.value + "T00:00:00"
            );

        const fin =
            new Date(
                dateFin.value + "T00:00:00"
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

            dateError.textContent =
                "La date de début doit être au moins 4 jours après aujourd'hui.";

            dateError.classList.remove("d-none");
            submitBtn.disabled = true;

            return;
        }

        if (debut > maximum) {

            dateError.textContent =
                "La date de début ne peut pas dépasser 7 mois à partir d'aujourd'hui.";

            dateError.classList.remove("d-none");
            submitBtn.disabled = true;

            return;
        }

        if (fin <= debut) {

            dateError.textContent =
                "La date de fin doit être postérieure à la date de début.";

            dateError.classList.remove("d-none");
            submitBtn.disabled = true;

            return;
        }

        dateError.classList.add("d-none");
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

    document.getElementById("concoursForm")
        .addEventListener(
            "submit",
            function(event) {

                verifierDates();

                if (submitBtn.disabled) {
                    event.preventDefault();
                }

            }
        );

    appliquerTheme();

    verifierDates();

</script>

</body>
</html>