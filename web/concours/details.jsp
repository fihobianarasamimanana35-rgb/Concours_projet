<%-- 
    Document   : details
    Created on : 3 oct. 2026, 14:01:09
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modele.ConcoursModele" %>

<%
    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <meta name="theme-color" content="#0d6efd">

    <title>Détails du concours - Suivi Concours</title>

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
        }

        html.dark {
            --bg: #0f172a;
            --bg-secondary: #111827;
            --card: #1e293b;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --border: #334155;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            background: var(--bg);
            color: var(--text);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .navbar {
            background: var(--card) !important;
            border-color: var(--border) !important;
        }

        .navbar-brand,
        .nav-link {
            color: var(--text) !important;
        }

        .nav-link {
            font-weight: 500;
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

        .page-header {
            position: relative;
            overflow: hidden;
            background: linear-gradient(
                135deg,
                #0d6efd 0%,
                #0b5ed7 55%,
                #084298 100%
            );
        }

        .page-header::before {
            content: "";
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
            top: -220px;
            right: -100px;
        }

        .page-header-content {
            position: relative;
            z-index: 2;
        }

        .page-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 14px;
            border-radius: 50px;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.18);
            font-size: 13px;
            font-weight: 500;
        }

        .content-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            box-shadow: var(--shadow);
        }

        .content-card h3,
        .content-card h5 {
            color: var(--text);
        }

        .content-card p {
            color: var(--text-muted);
        }

        .info-box {
            background: var(--bg-secondary);
            border: 1px solid var(--border);
            border-radius: 15px;
            padding: 18px;
            height: 100%;
        }

        .info-icon {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: rgba(13,110,253,0.1);
            color: var(--primary);
            margin-bottom: 12px;
        }

        .info-label {
            color: var(--text-muted);
            font-size: 13px;
            margin-bottom: 4px;
        }

        .info-value {
            color: var(--text);
            font-weight: 600;
        }

        .notice {
            background: rgba(13,110,253,0.08);
            border: 1px solid rgba(13,110,253,0.15);
            border-radius: 15px;
            color: var(--text);
        }

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

        .btn {
            border-radius: 11px;
            font-weight: 600;
            transition: all 0.25s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        @media (max-width: 991.98px) {

            .navbar-nav {
                padding-top: 15px;
                padding-bottom: 10px;
            }

        }
    </style>

</head>

<body>

<nav class="navbar navbar-expand-lg border-bottom sticky-top">

    <div class="container">

        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold"
           href="${pageContext.request.contextPath}/">

            <i data-lucide="graduation-cap"></i>

            <span>Suivi Concours</span>

        </a>

        <div class="d-flex align-items-center gap-2 d-lg-none">

            <button type="button"
                    class="theme-btn"
                    id="themeToggleMobile"
                    aria-label="Changer le thème">

                <i data-lucide="moon"></i>

            </button>

            <button class="navbar-toggler"
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

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/">

                        Accueil

                    </a>

                </li>

                <li class="nav-item">

                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/ConcoursServlet?action=liste">

                        Concours

                    </a>

                </li>

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/#fonctionnement">

                        Fonctionnement

                    </a>

                </li>

                <li class="nav-item d-none d-lg-block">

                    <button type="button"
                            class="theme-btn"
                            id="themeToggle"
                            aria-label="Changer le thème">

                        <i data-lucide="moon"></i>

                    </button>

                </li>

                <li class="nav-item ms-lg-2">

                    <a class="btn btn-primary px-3 d-inline-flex align-items-center gap-2"
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


<%
    if (concours != null) {
%>

<header class="page-header text-white">

    <div class="container py-5">

        <div class="page-header-content py-lg-4">

            <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
               class="text-white text-decoration-none d-inline-flex
                      align-items-center gap-2 mb-4">

                <i data-lucide="arrow-left"
                   size="17"></i>

                Retour aux concours

            </a>

            <div class="page-label mb-3">

                <i data-lucide="award"
                   size="17"></i>

                <span>Détails du concours</span>

            </div>

            <h1 class="display-5 fw-bold mb-3">

                <%= concours.getNom() %>

            </h1>

            <p class="lead opacity-75 mb-0">

                Consultez toutes les informations avant
                de commencer votre inscription.

            </p>

        </div>

    </div>

</header>


<main>

    <section class="py-5">

        <div class="container">

            <div class="row g-4">

                <div class="col-lg-8">

                    <div class="content-card p-4 p-lg-5">

                        <div class="d-flex justify-content-between
                                    align-items-start mb-4">

                            <div>

                                <span class="text-primary fw-bold small">
                                    PRÉSENTATION
                                </span>

                                <h3 class="fw-bold mt-2 mb-0">
                                    À propos du concours
                                </h3>

                            </div>

                            <span class="badge text-bg-primary">

                                <%= concours.getStatut() %>

                            </span>

                        </div>

                        <p class="lh-lg mb-0">

                            <%= concours.getDescription() != null
                                ? concours.getDescription()
                                : "Aucune description disponible pour ce concours." %>

                        </p>

                    </div>

                </div>


                <div class="col-lg-4">

                    <div class="content-card p-4">

                        <h5 class="fw-bold mb-4">
                            Informations
                        </h5>

                        <div class="info-box mb-3">

                            <div class="info-icon">

                                <i data-lucide="calendar-days"
                                   size="21"></i>

                            </div>

                            <div class="info-label">
                                Période
                            </div>

                            <div class="info-value">

                                <%= concours.getDate_debut() %>

                                <span class="text-muted">
                                    au
                                </span>

                                <%= concours.getDate_fin() %>

                            </div>

                        </div>

                        <div class="info-box">

                            <div class="info-icon">

                                <i data-lucide="users"
                                   size="21"></i>

                            </div>

                            <div class="info-label">
                                Nombre de places
                            </div>

                            <div class="info-value">

                                <%= concours.getNombre_places() %>

                            </div>

                        </div>

                    </div>

                </div>


                <div class="col-12">

                    <div class="content-card p-4 p-lg-5">

                        <div class="row align-items-center g-4">

                            <div class="col-lg-8">

                                <div class="d-flex gap-3">

                                    <div class="text-primary">

                                        <i data-lucide="info"
                                           size="26"></i>

                                    </div>

                                    <div>

                                        <h5 class="fw-bold">
                                            Avant de commencer
                                        </h5>

                                        <p class="mb-0">

                                            Préparez vos informations
                                            personnelles et les documents
                                            nécessaires à votre inscription.

                                        </p>

                                    </div>

                                </div>

                            </div>

                            <div class="col-lg-4 text-lg-end">
<a href="${pageContext.request.contextPath}/inscriptionPublique?action=commencer&id_concours=<%= concours.getId_concours() %>"
   class="btn btn-primary">
    <i data-lucide="user-plus"></i>
    S'inscrire à ce concours
</a>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>

</main>

<%
    } else {
%>

<main>

    <section class="py-5">

        <div class="container">

            <div class="content-card text-center p-5">

                <div class="info-icon mx-auto mb-4">

                    <i data-lucide="triangle-alert"
                       size="28"></i>

                </div>

                <h3 class="fw-bold">
                    Concours introuvable
                </h3>

                <p>
                    Le concours demandé n'existe pas ou n'est plus disponible.
                </p>

                <a href="${pageContext.request.contextPath}/ConcoursServlet?action=liste"
                   class="btn btn-primary px-4">

                    <i data-lucide="arrow-left"
                       class="me-2"
                       size="17"></i>

                    Retour aux concours

                </a>

            </div>

        </div>

    </section>

</main>

<%
    }
%>


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
                    Plateforme de gestion et d'inscription aux concours.
                </p>

            </div>

            <div class="col-md-6 text-md-end mt-3 mt-md-0">

                <a href="${pageContext.request.contextPath}/admin/login.jsp"
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


<script src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>

<script>

    function refreshIcons() {

        if (typeof lucide !== "undefined") {

            lucide.createIcons();

        }

    }

    const html = document.documentElement;

    const themeToggle =
        document.getElementById("themeToggle");

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
            window.matchMedia("(prefers-color-scheme: dark)").matches;

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

    refreshIcons();

</script>

</body>

</html>