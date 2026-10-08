<%-- 
    Document   : liste
    Created on : 3 oct. 2026, 14:01:00
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.ConcoursModele" %>

<%
    List<ConcoursModele> concours =
            (List<ConcoursModele>) request.getAttribute("concours");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <meta name="theme-color" content="#0d6efd">

    <title>Concours disponibles - Suivi Concours</title>

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
            width: 350px;
            height: 350px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
            top: -180px;
            right: -80px;
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

        .section {
            background: var(--bg);
        }

        .section-title {
            color: var(--text);
            letter-spacing: -0.5px;
        }

        .section-description {
            color: var(--text-muted);
        }

        .concours-card {
            height: 100%;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 28px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
        }

        .concours-card:hover {
            transform: translateY(-7px);
            box-shadow: var(--shadow-hover);
            border-color: rgba(13,110,253,0.3);
        }

        .concours-icon {
            width: 54px;
            height: 54px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 15px;
            background: rgba(13,110,253,0.1);
            color: var(--primary);
        }

        .concours-card h5 {
            color: var(--text);
        }

        .concours-card p {
            color: var(--text-muted);
        }

        .info-item {
            color: var(--text-muted);
            font-size: 14px;
        }

        .info-item i {
            color: var(--primary);
        }

        .empty-state {
            border: 1px dashed var(--border);
            border-radius: 20px;
            background: var(--card);
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


<header class="page-header text-white">

    <div class="container py-5">

        <div class="page-header-content py-lg-4">

            <div class="page-label mb-3">

                <i data-lucide="clipboard-list"
                   size="17"></i>

                <span>Concours disponibles</span>

            </div>

            <h1 class="display-5 fw-bold mb-3">
                Découvrez les concours
            </h1>

            <p class="lead opacity-75 mb-0"
               style="max-width:700px;">

                Consultez les informations des concours ouverts
                et choisissez celui auquel vous souhaitez participer.

            </p>

        </div>

    </div>

</header>


<main>

    <section class="section py-5">

        <div class="container py-3">

            <div class="d-flex flex-column flex-md-row
                        justify-content-between
                        align-items-md-center mb-5">

                <div>

                    <span class="text-primary fw-bold small">
                        LISTE DES CONCOURS
                    </span>

                    <h2 class="fw-bold section-title mt-2 mb-2">
                        Concours disponibles
                    </h2>

                    <p class="section-description mb-0">
                        Consultez les concours et leurs conditions.
                    </p>

                </div>

            </div>


            <div class="row g-4">

                <%
                    if (concours != null && !concours.isEmpty()) {

                        for (ConcoursModele c : concours) {
                %>

                <div class="col-md-6 col-xl-4">

                    <div class="concours-card">

                        <div class="d-flex justify-content-between
                                    align-items-start mb-4">

                            <div class="concours-icon">

                                <i data-lucide="award"
                                   size="25"></i>

                            </div>

                            <span class="badge text-bg-primary">

                                <%= c.getStatut() %>

                            </span>

                        </div>

                        <h5 class="fw-bold mb-3">

                            <%= c.getNom() %>

                        </h5>

                        <p class="small mb-4">

                            <%= c.getDescription() != null
                                ? c.getDescription()
                                : "Aucune description disponible." %>

                        </p>

                        <div class="border-top pt-3 mb-4">

                            <div class="info-item d-flex align-items-center
                                        gap-2 mb-2">

                                <i data-lucide="calendar-days"
                                   size="17"></i>

                                <span>
                                    Du <%= c.getDate_debut() %>
                                    au <%= c.getDate_fin() %>
                                </span>

                            </div>

                            <div class="info-item d-flex align-items-center
                                        gap-2">

                                <i data-lucide="users"
                                   size="17"></i>

                                <span>
                                    <%= c.getNombre_places() %> places
                                </span>

                            </div>

                        </div>

                        <a href="${pageContext.request.contextPath}/ConcoursServlet?action=details&id=<%= c.getId_concours() %>"
                           class="btn btn-primary w-100 d-flex
                                  align-items-center
                                  justify-content-center gap-2">

                            Voir les détails

                            <i data-lucide="arrow-right"
                               size="17"></i>

                        </a>

                    </div>

                </div>

                <%
                        }

                    } else {
                %>

                <div class="col-12">

                    <div class="empty-state text-center py-5 px-4">

                        <div class="concours-icon mx-auto mb-4">

                            <i data-lucide="calendar-x"
                               size="28"></i>

                        </div>

                        <h4 class="fw-bold section-title">
                            Aucun concours disponible
                        </h4>

                        <p class="section-description mb-0">
                            Aucun concours n'est actuellement disponible.
                        </p>

                    </div>

                </div>

                <%
                    }
                %>

            </div>

        </div>

    </section>

</main>


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
