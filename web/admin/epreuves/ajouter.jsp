<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modele.ConcoursModele"%>

<%
    List<ConcoursModele> concours =
            (List<ConcoursModele>) request.getAttribute("concours");

    if (concours == null) {
        concours = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Ajouter une épreuve - Suivi Concours</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <style>
        :root {
            --bg: #f6f8fb;
            --surface: #ffffff;
            --surface-soft: #f8fafc;
            --border: #e5e7eb;
            --text: #111827;
            --muted: #6b7280;
            --primary: #2563eb;
            --sidebar: #111827;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #1e293b;
            --border: #334155;
            --text: #f3f4f6;
            --muted: #94a3b8;
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
            background: linear-gradient(135deg, #2563eb, #4f46e5);
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
            transition: .2s;
        }

        .nav-link-admin:hover,
        .nav-link-admin.active {
            background: #1f2937;
            color: #fff;
        }

        .nav-link-admin svg {
            width: 19px;
            height: 19px;
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

        .topbar-title {
            font-weight: 700;
            color: var(--text);
        }

        .admin-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--muted);
            font-size: 14px;
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

        .content {
            padding: 32px;
            max-width: 1200px;
        }

        .breadcrumb-link {
            text-decoration: none;
            color: var(--muted);
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-size: 14px;
            margin-bottom: 18px;
        }

        .breadcrumb-link:hover {
            color: var(--primary);
        }

        .page-title {
            font-size: 28px;
            font-weight: 750;
            margin-bottom: 5px;
            letter-spacing: -.4px;
        }

        .page-subtitle {
            color: var(--muted);
            margin-bottom: 28px;
        }

        .form-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
        }

        .card-header-custom {
            padding: 22px 26px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .header-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        html.dark .header-icon {
            background: #172554;
        }

        .card-header-custom h5 {
            margin: 0;
            font-weight: 700;
        }

        .card-header-custom p {
            margin: 3px 0 0;
            color: var(--muted);
            font-size: 13px;
        }

        .form-body {
            padding: 28px;
        }

        .form-label {
            font-size: 14px;
            font-weight: 650;
            color: var(--text);
            margin-bottom: 8px;
        }

        .form-control,
        .form-select {
            min-height: 46px;
            border-radius: 10px;
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
        }

        textarea.form-control {
            min-height: 120px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,.12);
            background: var(--surface);
            color: var(--text);
        }

        .input-group-text {
            border-color: var(--border);
            background: var(--surface-soft);
            color: var(--muted);
        }

        .form-help {
            color: var(--muted);
            font-size: 12px;
            margin-top: 6px;
        }

        .action-bar {
            margin-top: 30px;
            padding-top: 22px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn {
            border-radius: 10px;
            padding: 10px 17px;
            font-weight: 600;
        }

        .btn-primary {
            background: #2563eb;
            border-color: #2563eb;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;
        }

        .btn-outline-secondary {
            color: var(--text);
            border-color: var(--border);
        }

        .btn-outline-secondary:hover {
            background: var(--surface-soft);
            color: var(--text);
            border-color: var(--border);
        }

        @media(max-width: 992px) {
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

            .content {
                padding: 24px;
            }
        }

        @media(max-width: 576px) {
            .topbar {
                padding: 0 18px;
            }

            .content {
                padding: 18px;
            }

            .admin-badge span {
                display: none;
            }
        }
    </style>
</head>

<body>

<div class="sidebar">

    <div class="brand">
        <div class="brand-icon">
            <i data-lucide="trophy"></i>
        </div>
        <span>Suivi Concours</span>
    </div>

    <nav>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/DashboardServlet">
            <i data-lucide="layout-dashboard"></i>
            <span>Dashboard</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/ConcoursServlet?action=adminListe">
            <i data-lucide="trophy"></i>
            <span>Concours</span>
        </a>

        <a class="nav-link-admin active"
           href="<%= request.getContextPath() %>/EpreuveServlet?action=liste">
            <i data-lucide="file-text"></i>
            <span>Épreuves</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/CandidatServlet?action=liste">
            <i data-lucide="users"></i>
            <span>Candidats</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/InscriptionServlet?action=liste">
            <i data-lucide="clipboard-list"></i>
            <span>Inscriptions</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/DossierServlet?action=liste">
            <i data-lucide="folder-open"></i>
            <span>Dossiers</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/admin/resultats/liste.jsp">
            <i data-lucide="award"></i>
            <span>Résultats</span>
        </a>

        <a class="nav-link-admin"
           href="<%= request.getContextPath() %>/admin/statistiques/index.jsp">
            <i data-lucide="bar-chart-3"></i>
            <span>Statistiques</span>
        </a>

    </nav>

    <a class="logout"
       href="<%= request.getContextPath() %>/LogoutServlet">
        <i data-lucide="log-out"></i>
        <span>Déconnexion</span>
    </a>

</div>

<div class="main">

    <header class="topbar">

        <div class="topbar-title">
            Gestion des épreuves
        </div>

        <div class="d-flex align-items-center gap-3">

            <button type="button"
                    class="theme-btn"
                    id="themeToggle"
                    title="Changer le thème">
                <i data-lucide="moon"></i>
            </button>

            <div class="admin-badge">
                <i data-lucide="shield-check"></i>
                <span>Administrateur</span>
            </div>

        </div>

    </header>

    <main class="content">

        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=liste"
           class="breadcrumb-link">
            <i data-lucide="arrow-left"></i>
            Retour aux épreuves
        </a>

        <h1 class="page-title">
            Ajouter une épreuve
        </h1>

        <p class="page-subtitle">
            Associez une nouvelle épreuve à un concours.
        </p>

        <div class="form-card">

            <div class="card-header-custom">

                <div class="header-icon">
                    <i data-lucide="file-plus-2"></i>
                </div>

                <div>
                    <h5>Informations de l'épreuve</h5>
                    <p>Renseignez les paramètres de la nouvelle épreuve.</p>
                </div>

            </div>

            <div class="form-body">

                <form method="post"
                      action="<%= request.getContextPath() %>/EpreuveServlet?action=ajouter"
                      id="epreuveForm">

                    <div class="row g-4">

                        <div class="col-md-6">

                            <label class="form-label">
                                Concours
                            </label>

                            <select name="id_concours"
                                    class="form-select"
                                    required>

                                <option value="">
                                    Sélectionner un concours
                                </option>

                                <% for (ConcoursModele c : concours) { %>

                                    <option value="<%= c.getId_concours() %>">
                                        <%= c.getCode_concours() %> -
                                        <%= c.getNom() %>
                                    </option>

                                <% } %>

                            </select>

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">
                                Nom de l'épreuve
                            </label>

                            <input type="text"
                                   name="nom"
                                   class="form-control"
                                   maxlength="150"
                                   placeholder="Exemple : Épreuve écrite"
                                   required>

                        </div>

                        <div class="col-12">

                            <label class="form-label">
                                Description
                            </label>

                            <textarea name="description"
                                      class="form-control"
                                      rows="4"
                                      placeholder="Décrivez brièvement le contenu de l'épreuve"></textarea>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label">
                                Heure de l'épreuve
                            </label>

                            <input type="time"
                                   name="date_epreuve"
                                   id="heureEpreuve"
                                   class="form-control"
                                   min="04:00"
                                   max="18:00"
                                   step="60"
                                   required>

                            <div class="form-help">
                                Heure autorisée : 04:00 à 18:00
                            </div>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label">
                                Durée
                            </label>

                            <div class="input-group">

                                <input type="number"
                                       name="duree_minutes"
                                       class="form-control"
                                       min="1"
                                       max="1440"
                                       placeholder="120"
                                       required>

                                <span class="input-group-text">
                                    minutes
                                </span>

                            </div>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label">
                                Coefficient
                            </label>

                            <input type="number"
                                   name="coefficient"
                                   class="form-control"
                                   min="0.1"
                                   step="0.1"
                                   placeholder="1"
                                   required>

                        </div>

                    </div>

                    <div class="action-bar">

                        <a href="<%= request.getContextPath() %>/EpreuveServlet?action=liste"
                           class="btn btn-outline-secondary">
                            Annuler
                        </a>

                        <button type="submit"
                                class="btn btn-primary d-flex align-items-center gap-2">
                            <i data-lucide="save"></i>
                            Enregistrer
                        </button>

                    </div>

                </form>

            </div>

        </div>

    </main>

</div>

<script src="<%= request.getContextPath() %>/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/lucide.min.js"></script>

<script>
    const themeToggle = document.getElementById("themeToggle");

    function applyTheme() {
        const dark = localStorage.getItem("theme") === "dark";

        document.documentElement.classList.toggle("dark", dark);

        themeToggle.innerHTML = dark
            ? '<i data-lucide="sun"></i>'
            : '<i data-lucide="moon"></i>';

        lucide.createIcons();
    }

    applyTheme();

    themeToggle.addEventListener("click", function () {
        const isDark = document.documentElement.classList.contains("dark");

        localStorage.setItem(
            "theme",
            isDark ? "light" : "dark"
        );

        applyTheme();
    });

    document.getElementById("epreuveForm").addEventListener("submit", function(e) {

        const heure = document.querySelector("[name='date_epreuve']").value;

        const duree = parseInt(
            document.querySelector("[name='duree_minutes']").value
        );

        const coefficient = parseFloat(
            document.querySelector("[name='coefficient']").value
        );

        if (!heure) {
            e.preventDefault();
            alert("Veuillez sélectionner l'heure de l'épreuve.");
            return;
        }

        if (heure < "04:00" || heure > "18:00") {
            e.preventDefault();
            alert("L'heure de l'épreuve doit être comprise entre 04:00 et 18:00.");
            return;
        }

        if (duree <= 0) {
            e.preventDefault();
            alert("La durée doit être supérieure à 0 minute.");
            return;
        }

        if (coefficient <= 0) {
            e.preventDefault();
            alert("Le coefficient doit être supérieur à 0.");
            return;
        }
    });
</script>

</body>
</html>