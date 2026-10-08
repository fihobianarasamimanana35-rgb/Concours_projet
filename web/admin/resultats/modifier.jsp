<%-- 
    Document   : modifier
    Created on : 7 oct. 2026, 09:07:48
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modele.InscriptionModele" %>
<%@ page import="modele.ResultatModele" %>

<%
    String contextPath = request.getContextPath();

    ResultatModele resultat =
            (ResultatModele) request.getAttribute("resultat");

    List<InscriptionModele> inscriptions =
            (List<InscriptionModele>) request.getAttribute("inscriptions");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Modifier un résultat - Suivi Concours</title>

    <link rel="stylesheet"
          href="<%= contextPath %>/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <script src="<%= contextPath %>/js/lucide.min.js"></script>

    <style>

        :root {
            --bg: #f6f8fb;
            --surface: #ffffff;
            --text: #172033;
            --muted: #6b7280;
            --border: #e5e7eb;
            --primary: #2563eb;
            --sidebar: #111827;
        }

        html.dark {
            --bg: #0f172a;
            --surface: #111827;
            --text: #f3f4f6;
            --muted: #9ca3af;
            --border: #1f2937;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--bg);
            color: var(--text);
            font-family: Arial, sans-serif;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: var(--sidebar);
            color: white;
            padding: 24px 16px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 30px;
            padding: 0 10px;
        }

        .nav-link {
            color: #cbd5e1;
            padding: 12px 14px;
            border-radius: 10px;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .nav-link:hover,
        .nav-link.active {
            background: #1f2937;
            color: white;
        }

        .logout {
            position: absolute;
            bottom: 20px;
            left: 16px;
            right: 16px;
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

        .content {
            padding: 32px;
        }

        .page-label {
            color: var(--primary);
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .page-title {
            margin-top: 5px;
            font-weight: 700;
        }

        .page-description {
            color: var(--muted);
        }

        .card-custom {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 28px;
        }

        .form-label {
            font-weight: 600;
        }

        .form-control,
        .form-select {
            border-color: var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 11px 13px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 .2rem rgba(37, 99, 235, .15);
        }

        .theme-btn {
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            border-radius: 10px;
            width: 40px;
            height: 40px;
        }

        @media (max-width: 992px) {

            .sidebar {
                width: 80px;
            }

            .brand span,
            .nav-link span {
                display: none;
            }

            .main {
                margin-left: 80px;
            }
        }

    </style>

</head>

<body>

<aside class="sidebar">

    <div class="brand">
        <i data-lucide="shield-check"></i>
        <span>Suivi Concours</span>
    </div>

    <nav>

        <a href="<%= contextPath %>/DashboardServlet" class="nav-link">
            <i data-lucide="layout-dashboard"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= contextPath %>/ConcoursServlet?action=liste" class="nav-link">
            <i data-lucide="trophy"></i>
            <span>Concours</span>
        </a>

        <a href="<%= contextPath %>/EpreuveServlet?action=liste" class="nav-link">
            <i data-lucide="file-text"></i>
            <span>Épreuves</span>
        </a>

        <a href="<%= contextPath %>/CandidatServlet?action=liste" class="nav-link">
            <i data-lucide="users"></i>
            <span>Candidats</span>
        </a>

        <a href="<%= contextPath %>/InscriptionServlet?action=liste" class="nav-link">
            <i data-lucide="clipboard-list"></i>
            <span>Inscriptions</span>
        </a>

        <a href="<%= contextPath %>/DossierServlet?action=liste" class="nav-link">
            <i data-lucide="folder"></i>
            <span>Dossiers</span>
        </a>

        <a href="<%= contextPath %>/ResultatServlet?action=liste"
           class="nav-link active">
            <i data-lucide="award"></i>
            <span>Résultats</span>
        </a>

        <a href="<%= contextPath %>/StatistiquesServlet?action=data" class="nav-link">
            <i data-lucide="bar-chart-3"></i>
            <span>Statistiques</span>
        </a>

    </nav>

    <div class="logout">

        <a href="<%= contextPath %>/LogoutServlet" class="nav-link">
            <i data-lucide="log-out"></i>
            <span>Déconnexion</span>
        </a>

    </div>

</aside>

<main class="main">

    <header class="topbar">

        <strong>Administration</strong>

        <button class="theme-btn" id="themeToggle">
            <i data-lucide="moon"></i>
        </button>

    </header>

    <section class="content">

        <div class="mb-4">

            <div class="page-label">
                RÉSULTATS
            </div>

            <h1 class="page-title">
                Modifier le résultat
            </h1>

            <p class="page-description">
                Modifiez les informations du résultat sélectionné.
            </p>

        </div>

        <% if (resultat == null) { %>

            <div class="alert alert-danger">
                Résultat introuvable.
            </div>

            <a href="<%= contextPath %>/ResultatServlet?action=liste"
               class="btn btn-primary">
                Retour à la liste
            </a>

        <% } else { %>

            <div class="card-custom">

                <form method="post"
                      action="<%= contextPath %>/ResultatServlet">

                    <input type="hidden"
                           name="action"
                           value="modifier">

                    <input type="hidden"
                           name="id_resultat"
                           value="<%= resultat.getId_resultat() %>">

                    <div class="row g-4">

                        <div class="col-md-6">

                            <label class="form-label">
                                Inscription
                            </label>

                            <select name="id_inscription"
                                    class="form-select"
                                    required>

                                <% if (inscriptions != null) { %>

                                    <% for (InscriptionModele inscription : inscriptions) { %>

                                        <option
                                            value="<%= inscription.getId_inscription()%>"
                                            <%= inscription.getId_inscription() == resultat.getId_inscription()
                                                    ? "selected"
                                                    : "" %>>

                                            Inscription #<%= inscription.getId_inscription() %>

                                        </option>

                                    <% } %>

                                <% } %>

                            </select>

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">
                                Rang
                            </label>

                            <input type="number"
                                   name="rang"
                                   class="form-control"
                                   min="1"
                                   value="<%= resultat.getRang() != null
                                           ? resultat.getRang()
                                           : "" %>">

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">
                                Note finale
                            </label>

                            <input type="number"
                                   name="note_finale"
                                   class="form-control"
                                   step="0.01"
                                   min="0"
                                   value="<%= resultat.getNote_finale() != null
                                           ? resultat.getNote_finale()
                                           : "" %>">

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">
                                Décision
                            </label>

                            <input type="text"
                                   name="decision"
                                   class="form-control"
                                   value="<%= resultat.getDecision() != null
                                           ? resultat.getDecision()
                                           : "" %>">

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">
                                Date de publication
                            </label>

                            <input type="text"
                                   name="date_publication"
                                   class="form-control"
                                   value="<%= resultat.getDate_publication() != null
                                           ? resultat.getDate_publication()
                                           : "" %>">

                        </div>

                        <div class="col-md-6">

                            <label class="form-label d-block">
                                Publication
                            </label>

                            <div class="form-check mt-2">

                                <input class="form-check-input"
                                       type="checkbox"
                                       name="publie"
                                       value="true"
                                       id="publie"
                                       <%= resultat.isPublie()
                                               ? "checked"
                                               : "" %>>

                                <label class="form-check-label" for="publie">
                                    Résultat publié
                                </label>

                            </div>

                        </div>

                    </div>

                    <hr class="my-4">

                    <div class="d-flex justify-content-end gap-2">

                        <a href="<%= contextPath %>/ResultatServlet?action=liste"
                           class="btn btn-outline-secondary">

                            <i data-lucide="arrow-left"
                               style="width:16px;"></i>

                            Annuler

                        </a>

                        <button type="submit"
                                class="btn btn-primary">

                            <i data-lucide="save"
                               style="width:16px;"></i>

                            Enregistrer les modifications

                        </button>

                    </div>

                </form>

            </div>

        <% } %>

    </section>

</main>

<script>

    const html = document.documentElement;
    const themeToggle = document.getElementById("themeToggle");

    if (localStorage.getItem("theme") === "dark") {
        html.classList.add("dark");
    }

    themeToggle.addEventListener("click", function () {

        html.classList.toggle("dark");

        localStorage.setItem(
            "theme",
            html.classList.contains("dark") ? "dark" : "light"
        );

    });

    lucide.createIcons();

</script>

</body>
</html>