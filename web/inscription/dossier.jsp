<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modele.DossierModele"%>
<%@page import="modele.ConcoursModele"%>
<%@page import="modele.CandidatModele"%>
<%@page import="modele.InscriptionModele"%>

<%
    DossierModele dossier =
            (DossierModele) request.getAttribute("dossier");

    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");

    String erreur = (String) request.getAttribute("erreur");

    String niveauEtude = request.getAttribute("niveau_etude") != null
            ? (String) request.getAttribute("niveau_etude") : "";

    String diplome = request.getAttribute("diplome") != null
            ? (String) request.getAttribute("diplome") : "";

    String anneeDiplome = request.getAttribute("annee_diplome") != null
            ? (String) request.getAttribute("annee_diplome") : "";

    String etablissement = request.getAttribute("etablissement") != null
            ? (String) request.getAttribute("etablissement") : "";

    if (dossier != null) {

        if (niveauEtude.isEmpty() && dossier.getNiveau_etude() != null) {
            niveauEtude = dossier.getNiveau_etude();
        }

        if (diplome.isEmpty() && dossier.getDiplome() != null) {
            diplome = dossier.getDiplome();
        }

        if (anneeDiplome.isEmpty()) {
            anneeDiplome = String.valueOf(dossier.getAnnee_diplome());
        }

        if (etablissement.isEmpty() && dossier.getEtablissement() != null) {
            etablissement = dossier.getEtablissement();
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dossier scolaire - Inscription</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <script src="https://unpkg.com/lucide@latest"></script>

    <style>

        body {
            background: #f5f7fb;
        }

        .page-container {
            max-width: 1000px;
            margin: 40px auto;
        }

        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 25px rgba(0,0,0,.08);
        }

        .card-header {
            background: white;
            border-bottom: 1px solid #eee;
            border-radius: 16px 16px 0 0 !important;
            padding: 25px 30px;
        }

        .form-container {
            padding: 30px;
        }

        .step {
            display: flex;
            gap: 8px;
            margin-bottom: 25px;
        }

        .step-item {
            flex: 1;
            text-align: center;
            padding: 10px;
            border-radius: 8px;
            background: #e9ecef;
            color: #6c757d;
            font-size: 14px;
        }

        .step-item.active {
            background: #0d6efd;
            color: white;
        }

        .info-box {
            background: #eef5ff;
            border-left: 4px solid #0d6efd;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .required {
            color: #dc3545;
        }

    </style>

</head>

<body>

<div class="container page-container">

    <div class="step">

        <div class="step-item">
            1. Candidat
        </div>

        <div class="step-item active">
            2. Dossier
        </div>

        <div class="step-item">
            3. Documents
        </div>

        <div class="step-item">
            4. Confirmation
        </div>

    </div>

    <div class="card">

        <div class="card-header">

            <h3 class="mb-1">

                <i data-lucide="graduation-cap"></i>

                Dossier scolaire

            </h3>

            <p class="text-muted mb-0">

                Renseignez vos informations concernant votre parcours scolaire.

            </p>

        </div>

        <div class="form-container">

            <% if (candidat != null) { %>

                <div class="info-box">

                    <strong>
                        Candidat :
                    </strong>

                    <%= candidat.getNom() %>
                    <%= candidat.getPrenom() %>

                    <% if (concours != null) { %>

                        <br>

                        <strong>
                            Concours :
                        </strong>

                        <%= concours.getId_concours() %>

                    <% } %>

                </div>

            <% } %>

            <% if (erreur != null && !erreur.trim().isEmpty()) { %>

                <div class="alert alert-danger">

                    <i data-lucide="alert-circle"></i>

                    <%= erreur %>

                </div>

            <% } %>

            <form action="<%= request.getContextPath() %>/InscriptionPubliqueServlet"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="dossier">

                <div class="row g-3">

                    <div class="col-md-6">

                        <label class="form-label">

                            Niveau d'étude
                            <span class="required">*</span>

                        </label>

                        <select name="niveau_etude"
                                class="form-select"
                                required>

                            <option value="">
                                -- Sélectionner --
                            </option>

                            <option value="BEPC"
                                <%= "BEPC".equals(niveauEtude) ? "selected" : "" %>>
                                BEPC
                            </option>

                            <option value="BAC"
                                <%= "BAC".equals(niveauEtude) ? "selected" : "" %>>
                                Baccalauréat
                            </option>

                            <option value="BAC+1"
                                <%= "BAC+1".equals(niveauEtude) ? "selected" : "" %>>
                                BAC+1
                            </option>

                            <option value="BAC+2"
                                <%= "BAC+2".equals(niveauEtude) ? "selected" : "" %>>
                                BAC+2
                            </option>

                            <option value="BAC+3"
                                <%= "BAC+3".equals(niveauEtude) ? "selected" : "" %>>
                                BAC+3
                            </option>

                            <option value="BAC+4"
                                <%= "BAC+4".equals(niveauEtude) ? "selected" : "" %>>
                                BAC+4
                            </option>

                            <option value="BAC+5"
                                <%= "BAC+5".equals(niveauEtude) ? "selected" : "" %>>
                                BAC+5
                            </option>

                            <option value="AUTRE"
                                <%= "AUTRE".equals(niveauEtude) ? "selected" : "" %>>
                                Autre
                            </option>

                        </select>

                    </div>

                    <div class="col-md-6">

                        <label class="form-label">

                            Diplôme
                            <span class="required">*</span>

                        </label>

                        <input type="text"
                               name="diplome"
                               class="form-control"
                               value="<%= diplome %>"
                               placeholder="Ex : Baccalauréat"
                               required>

                    </div>

                    <div class="col-md-6">

                        <label class="form-label">

                            Année d'obtention
                            <span class="required">*</span>

                        </label>

                        <input type="number"
                               name="annee_diplome"
                               class="form-control"
                               value="<%= anneeDiplome %>"
                               min="1950"
                               max="<%= java.time.Year.now().getValue() %>"
                               required>

                    </div>

                    <div class="col-md-6">

                        <label class="form-label">

                            Établissement
                            <span class="required">*</span>

                        </label>

                        <input type="text"
                               name="etablissement"
                               class="form-control"
                               value="<%= etablissement %>"
                               placeholder="Nom de l'établissement"
                               required>

                    </div>

                </div>

                <hr class="my-4">

                <div class="d-flex justify-content-between">

                    <a href="<%= request.getContextPath() %>/InscriptionPubliqueServlet?action=candidat"
                       class="btn btn-outline-secondary">

                        <i data-lucide="arrow-left"></i>

                        Retour

                    </a>

                    <button type="submit"
                            class="btn btn-primary">

                        Continuer

                        <i data-lucide="arrow-right"></i>

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<script>
    lucide.createIcons();
</script>

</body>

</html>