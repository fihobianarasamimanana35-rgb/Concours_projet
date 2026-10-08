
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <meta name="theme-color" content="#0d6efd">

    <title>Suivi Concours</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <style>

        :root {
            --primary: #0d6efd;
            --primary-dark: #0a58ca;
            --bg: #ffffff;
            --bg-secondary: #f8f9fa;
            --card: #ffffff;
            --text: #212529;
            --text-muted: #6c757d;
            --border: #e5e7eb;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.07);
            --shadow-hover: 0 18px 40px rgba(0, 0, 0, 0.11);
        }

        /* =========================
           DARK MODE
        ========================= */

        html.dark {
            --bg: #0f172a;
            --bg-secondary: #111827;
            --card: #1e293b;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --border: #334155;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
            --shadow-hover: 0 18px 40px rgba(0, 0, 0, 0.35);
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            background: var(--bg);
            color: var(--text);
            transition:
                background-color 0.3s ease,
                color 0.3s ease;
        }

        /* =========================
           NAVBAR
        ========================= */

        .navbar {
            background: var(--card) !important;
            border-color: var(--border) !important;
            transition: all 0.3s ease;
        }

        .navbar-brand,
        .nav-link {
            color: var(--text) !important;
        }

        .nav-link {
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .nav-link:hover,
        .nav-link.active {
            color: var(--primary) !important;
        }

        .navbar-toggler {
            border-color: var(--border);
            color: var(--text);
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }

        /* =========================
           THEME BUTTON
        ========================= */

        .theme-btn {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            border: 1px solid var(--border);
            background: var(--card);
            color: var(--text);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.25s ease;
        }

        .theme-btn:hover {
            background: var(--bg-secondary);
            transform: translateY(-2px);
        }

        /* =========================
           HERO
        ========================= */

        .hero {
            position: relative;
            overflow: hidden;
            background:
                radial-gradient(
                    circle at 80% 20%,
                    rgba(255,255,255,0.15),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #0d6efd 0%,
                    #0b5ed7 55%,
                    #084298 100%
                );
        }

        .hero::before {
            content: "";
            position: absolute;
            width: 450px;
            height: 450px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
            top: -220px;
            right: -150px;
        }

        .hero::after {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255,255,255,0.04);
            bottom: -180px;
            left: -100px;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 14px;
            border-radius: 50px;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.18);
            backdrop-filter: blur(8px);
            font-size: 14px;
            font-weight: 500;
        }

        .hero h1 {
            letter-spacing: -1px;
        }

        /* =========================
           HERO CARD
        ========================= */

        .hero-card {
            background: var(--card);
            color: var(--text);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 24px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.18);
            padding: 28px;
        }

        .step-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        .step-icon {
            width: 42px;
            height: 42px;
            min-width: 42px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(13,110,253,0.1);
            color: var(--primary);
        }

        /* =========================
           GENERAL SECTIONS
        ========================= */

        .section {
            background: var(--bg);
        }

        .section-muted {
            background: var(--bg-secondary);
        }

        .section-label {
            display: inline-block;
            color: var(--primary);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .section-title {
            color: var(--text);
            letter-spacing: -0.5px;
        }

        .section-description {
            color: var(--text-muted);
        }

        /* =========================
           SERVICE CARDS
        ========================= */

        .service-card {
            height: 100%;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 28px;
            box-shadow: var(--shadow);
            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease,
                border-color 0.3s ease;
        }

        .service-card:hover {
            transform: translateY(-7px);
            box-shadow: var(--shadow-hover);
            border-color: rgba(13,110,253,0.3);
        }

        .service-icon {
            width: 52px;
            height: 52px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 15px;
            background: rgba(13,110,253,0.1);
            color: var(--primary);
            margin-bottom: 20px;
        }

        .service-card h5 {
            color: var(--text);
        }

        .service-card p {
            color: var(--text-muted);
        }

        /* =========================
           PROCESS
        ========================= */

        .process-card {
            position: relative;
            text-align: center;
        }

        .process-number {
            width: 58px;
            height: 58px;
            margin: auto;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(13,110,253,0.25);
        }

        .process-card h6 {
            color: var(--text);
        }

        .process-card p {
            color: var(--text-muted);
        }

        /* =========================
           CTA
        ========================= */

        .cta {
            position: relative;
            overflow: hidden;
            border-radius: 24px;
            background:
                linear-gradient(
                    135deg,
                    #0d6efd,
                    #084298
                );
        }

        .cta::after {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255,255,255,0.05);
            right: -120px;
            top: -150px;
        }

        .cta-content {
            position: relative;
            z-index: 2;
        }

        /* =========================
           FOOTER
        ========================= */

        footer {
            background: var(--card) !important;
            border-color: var(--border) !important;
        }

        footer,
        footer span,
        footer p,
        footer a {
            color: var(--text-muted);
        }

        footer .brand-text {
            color: var(--text);
        }

        /* =========================
           BUTTONS
        ========================= */

        .btn {
            border-radius: 11px;
            font-weight: 600;
            transition: all 0.25s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        /* =========================
           SCROLL ANIMATION
        ========================= */

        .reveal {
            opacity: 0;
            transform: translateY(25px);
            transition:
                opacity 0.7s ease,
                transform 0.7s ease;
        }

        .reveal.show {
            opacity: 1;
            transform: translateY(0);
        }

        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 991.98px) {

            .navbar-nav {
                padding-top: 15px;
                padding-bottom: 10px;
            }

            .navbar-actions {
                margin-top: 10px;
            }

            .hero {
                text-align: center;
            }

            .hero-buttons {
                justify-content: center;
            }

            .hero-card {
                margin-top: 10px;
            }
        }

        @media (max-width: 575.98px) {

            .hero h1 {
                font-size: 2.25rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .hero-card {
                padding: 22px;
                border-radius: 20px;
            }

            .service-card {
                padding: 22px;
            }

            .cta {
                border-radius: 20px;
            }

            .hero-buttons .btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<!-- =========================
     NAVBAR
========================= -->

<nav class="navbar navbar-expand-lg border-bottom sticky-top">

    <div class="container">

        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold"
           href="${pageContext.request.contextPath}/">

            <i data-lucide="graduation-cap"></i>

            <span>Suivi Concours</span>

        </a>

        <div class="d-flex align-items-center gap-2 d-lg-none">

            <button
                type="button"
                class="theme-btn"
                id="themeToggleMobile"
                aria-label="Changer le thème">

                <i data-lucide="moon"></i>

            </button>

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarMenu"
                aria-controls="navbarMenu"
                aria-expanded="false"
                aria-label="Menu">

                <i data-lucide="menu"></i>

            </button>

        </div>

        <div class="collapse navbar-collapse" id="navbarMenu">

            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">

                <li class="nav-item">

                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/">

                        Accueil

                    </a>

                </li>

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/ConcoursServlet?action=liste">

                        Concours

                    </a>

                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/InscriptionPubliqueServlet?action=suivi"
   class="btn btn-outline-primary">
    <i data-lucide="search"></i>
    Suivi de concours
</a>
                </li>

                <li class="nav-item">

                    <a class="nav-link"
                       href="#fonctionnement">

                        Fonctionnement

                    </a>

                </li>

                <li class="nav-item d-none d-lg-block">

                    <button
                        type="button"
                        class="theme-btn"
                        id="themeToggle"
                        aria-label="Changer le thème">

                        <i data-lucide="moon"></i>

                    </button>

                </li>

                <li class="nav-item ms-lg-2 navbar-actions">

                    <a
                        class="btn btn-primary px-3 d-inline-flex align-items-center gap-2"
                        href="${pageContext.request.contextPath}/admin/login.jsp">

                        <i data-lucide="shield-check"
                           size="18"></i>

                        Administration

                    </a>

                </li>

            </ul>

        </div>

    </div>

</nav>


<!-- =========================
     HERO
========================= -->

<main>

<section class="hero text-white">

    <div class="container py-5">

        <div class="row align-items-center g-5 py-lg-5">

            <div class="col-lg-7 hero-content">

                <div class="hero-badge mb-4">

                    <i data-lucide="badge-check"
                       size="17"></i>

                    <span>
                        Plateforme de gestion des concours
                    </span>

                </div>

                <h1 class="display-4 fw-bold mb-4">

                    Inscrivez-vous à votre concours
                    en toute simplicité.

                </h1>

                <p class="lead mb-4 opacity-75">

                    Consultez les concours disponibles,
                    remplissez votre dossier en ligne,
                    transmettez vos documents et suivez
                    l'état de votre inscription depuis
                    une seule plateforme.

                </p>

                <div class="d-flex flex-wrap gap-3 hero-buttons">

                    <a
                        href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
                        class="btn btn-light btn-lg px-4">

                        <i data-lucide="search"
                           class="me-2"
                           size="19"></i>

                        Consulter les concours

                    </a>

                    <a
                        href="#fonctionnement"
                        class="btn btn-outline-light btn-lg px-4">

                        Découvrir le processus

                        <i data-lucide="arrow-down"
                           class="ms-2"
                           size="18"></i>

                    </a>

                </div>

            </div>


            <div class="col-lg-5">

                <div class="hero-card reveal">

                    <div class="d-flex align-items-center
                                justify-content-between mb-4">

                        <div>

                            <span class="small"
                                  style="color:var(--text-muted);">

                                Inscription en ligne

                            </span>

                            <h5 class="fw-bold mb-0">

                                Simple et rapide

                            </h5>

                        </div>

                        <div class="service-icon mb-0">

                            <i data-lucide="file-check-2"
                               size="27"></i>

                        </div>

                    </div>


                    <div class="step-item mb-4">

                        <div class="step-icon">

                            <i data-lucide="user"
                               size="19"></i>

                        </div>

                        <div>

                            <h6 class="fw-bold mb-1">

                                Vos informations

                            </h6>

                            <p class="small mb-0"
                               style="color:var(--text-muted);">

                                Renseignez vos informations
                                personnelles.

                            </p>

                        </div>

                    </div>


                    <div class="step-item mb-4">

                        <div class="step-icon">

                            <i data-lucide="folder-open"
                               size="19"></i>

                        </div>

                        <div>

                            <h6 class="fw-bold mb-1">

                                Votre dossier

                            </h6>

                            <p class="small mb-0"
                               style="color:var(--text-muted);">

                                Ajoutez les informations
                                nécessaires à votre inscription.

                            </p>

                        </div>

                    </div>


                    <div class="step-item">

                        <div class="step-icon">

                            <i data-lucide="file-check"
                               size="19"></i>

                        </div>

                        <div>

                            <h6 class="fw-bold mb-1">

                                Vérification

                            </h6>

                            <p class="small mb-0"
                               style="color:var(--text-muted);">

                                Suivez l'état de traitement
                                de votre dossier.

                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================
     SERVICES
========================= -->

<section class="section py-5">

    <div class="container py-4">

        <div class="text-center mb-5 reveal">

            <span class="section-label">

                NOS SERVICES

            </span>

            <h2 class="fw-bold mt-2 section-title">

                Une plateforme pensée pour
                simplifier vos démarches

            </h2>

            <p class="section-description mx-auto"
               style="max-width:650px;">

                Toutes les étapes de votre inscription
                sont regroupées dans une seule plateforme.

            </p>

        </div>


        <div class="row g-4">


            <div class="col-md-4 reveal">

                <div class="service-card">

                    <div class="service-icon">

                        <i data-lucide="clipboard-list"
                           size="25"></i>

                    </div>

                    <h5 class="fw-bold">

                        Concours disponibles

                    </h5>

                    <p class="mb-0">

                        Consultez les concours ouverts,
                        leurs dates, leurs conditions
                        et le nombre de places disponibles.

                    </p>

                </div>

            </div>


            <div class="col-md-4 reveal">

                <div class="service-card">

                    <div class="service-icon">

                        <i data-lucide="file-text"
                           size="25"></i>

                    </div>

                    <h5 class="fw-bold">

                        Inscription en ligne

                    </h5>

                    <p class="mb-0">

                        Effectuez votre inscription étape
                        par étape depuis une interface
                        simple et accessible.

                    </p>

                </div>

            </div>


            <div class="col-md-4 reveal">

                <div class="service-card">

                    <div class="service-icon">

                        <i data-lucide="shield-check"
                           size="25"></i>

                    </div>

                    <h5 class="fw-bold">

                        Suivi du dossier

                    </h5>

                    <p class="mb-0">

                        Suivez l'évolution de votre dossier
                        et consultez les informations liées
                        à votre inscription.

                    </p>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================
     PROCESSUS
========================= -->

<section id="fonctionnement"
         class="section-muted py-5">

    <div class="container py-4">

        <div class="text-center mb-5 reveal">

            <span class="section-label">

                PROCESSUS

            </span>

            <h2 class="fw-bold mt-2 section-title">

                Comment fonctionne l'inscription ?

            </h2>

            <p class="section-description">

                Quelques étapes pour suivre votre concours.

            </p>

        </div>


        <div class="row g-4">


            <div class="col-md-3 reveal">

                <div class="process-card">

                    <div class="process-number mb-3">

                        <i data-lucide="search"></i>

                    </div>

                    <h6 class="fw-bold">

                        01. Choisir

                    </h6>

                    <p class="small">

                        Choisissez le concours
                        qui vous intéresse.

                    </p>

                </div>

            </div>


            <div class="col-md-3 reveal">

                <div class="process-card">

                    <div class="process-number mb-3">

                        <i data-lucide="user-round"></i>

                    </div>

                    <h6 class="fw-bold">

                        02. Renseigner

                    </h6>

                    <p class="small">

                        Complétez vos informations
                        personnelles.

                    </p>

                </div>

            </div>


            <div class="col-md-3 reveal">

                <div class="process-card">

                    <div class="process-number mb-3">

                        <i data-lucide="upload"></i>

                    </div>

                    <h6 class="fw-bold">

                        03. Déposer

                    </h6>

                    <p class="small">

                        Déposez les documents
                        demandés.

                    </p>

                </div>

            </div>


            <div class="col-md-3 reveal">

                <div class="process-card">

                    <div class="process-number mb-3">

                        <i data-lucide="badge-check"></i>

                    </div>

                    <h6 class="fw-bold">

                        04. Suivre

                    </h6>

                    <p class="small">

                        Suivez l'état de traitement
                        de votre inscription.

                    </p>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =========================
     CTA
========================= -->

<section class="py-5">

    <div class="container py-3">

        <div class="cta text-white p-4 p-lg-5 reveal">

            <div class="cta-content">

                <div class="row align-items-center">

                    <div class="col-lg-8">

                        <h3 class="fw-bold">

                            Consultez les concours disponibles

                        </h3>

                        <p class="mb-0 opacity-75">

                            Découvrez les concours actuellement
                            disponibles et leurs informations.

                        </p>

                    </div>


                    <div class="col-lg-4 text-lg-end mt-4 mt-lg-0">

                        <a
                            href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
                            class="btn btn-light px-4">

                            Voir les concours

                            <i data-lucide="arrow-right"
                               class="ms-2"
                               size="18"></i>

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>

</main>


<!-- =========================
     FOOTER
========================= -->

<footer class="border-top">

    <div class="container py-4">

        <div class="row align-items-center">

            <div class="col-md-6">

                <div class="d-flex align-items-center gap-2">

                    <i data-lucide="graduation-cap"
                       class="text-primary"></i>

                    <span class="fw-bold brand-text">

                        Suivi Concours

                    </span>

                </div>

                <p class="small mb-0 mt-2">

                    Plateforme de gestion et
                    d'inscription aux concours.

                </p>

            </div>


            <div class="col-md-6 text-md-end mt-3 mt-md-0">

                <a
                    href="${pageContext.request.contextPath}/admin/login.jsp"
                    class="text-decoration-none small">

                    Espace administrateur

                </a>

            </div>

        </div>


        <hr style="border-color:var(--border);">


        <div class="text-center">

            <span class="small">

               Copyright © 2026 Suivi Concours.

            </span>

        </div>

    </div>

</footer>


<!-- =========================
     JAVASCRIPT
========================= -->

<script
    src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js">
</script>

<script
    src="${pageContext.request.contextPath}/js/lucide.min.js">
</script>


<script>

    /* =========================
       LUCIDE
    ========================= */

    function refreshIcons() {

        if (typeof lucide !== "undefined") {

            lucide.createIcons();

        }

    }


    /* =========================
       DARK / LIGHT MODE
    ========================= */

    const html = document.documentElement;

    const themeToggle = document.getElementById("themeToggle");

    const themeToggleMobile =
        document.getElementById("themeToggleMobile");


    function updateThemeIcon() {

        const darkMode =
            html.classList.contains("dark");


        if (themeToggle) {
            
            themeToggle.innerHTML =
                darkMode
                ? '<i data-lucide="sun"></i>'
                : '<i data-lucide="moon"></i>';

        }


        if (themeToggleMobile) {

            themeToggleMobile.innerHTML =
                darkMode
                ? '<i data-lucide="sun"></i>'
                : '<i data-lucide="moon"></i>';

        }

        refreshIcons();

    }


    function applyTheme(theme) {

        if (theme === "dark") {

            html.classList.add("dark");

        } else {

            html.classList.remove("dark");

        }

        localStorage.setItem("theme", theme);

        updateThemeIcon();

    }


    const savedTheme =
        localStorage.getItem("theme");


    if (savedTheme) {

        applyTheme(savedTheme);

    } else {

        const prefersDark =
            window.matchMedia &&
            window.matchMedia(
                "(prefers-color-scheme: dark)"
            ).matches;


        applyTheme(
            prefersDark ? "dark" : "light"
        );

    }


    function toggleTheme() {

        const isDark =
            html.classList.contains("dark");

        applyTheme(
            isDark ? "light" : "dark"
        );

    }


    if (themeToggle) {

        themeToggle.addEventListener(
            "click",
            toggleTheme
        );

    }


    if (themeToggleMobile) {

        themeToggleMobile.addEventListener(
            "click",
            toggleTheme
        );

    }


    /* =========================
       SCROLL REVEAL
    ========================= */

    const revealElements =
        document.querySelectorAll(".reveal");


    const observer =
        new IntersectionObserver(

            function(entries) {

                entries.forEach(
                    function(entry) {

                        if (entry.isIntersecting) {

                            entry.target.classList.add("show");

                            observer.unobserve(
                                entry.target
                            );

                        }

                    }
                );

            },

            {
                threshold: 0.12
            }

        );


    revealElements.forEach(
        function(element) {

            observer.observe(element);

        }
    );


    /* =========================
       ACTIVE NAVBAR
    ========================= */

    const navLinks =
        document.querySelectorAll(
            ".navbar-nav .nav-link"
        );


    navLinks.forEach(
        function(link) {

            link.addEventListener(
                "click",
                function() {

                    navLinks.forEach(
                        function(item) {

                            item.classList.remove(
                                "active"
                            );

                        }
                    );

                    link.classList.add(
                        "active"
                    );

                }
            );

        }
    );


    /* =========================
       INITIAL ICONS
    ========================= */

    refreshIcons();

</script>

</body>

</html>
