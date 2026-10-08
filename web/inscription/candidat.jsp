<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modele.ConcoursModele"%>
<%
    ConcoursModele concours = (ConcoursModele) request.getAttribute("concours");

    String erreur = (String) request.getAttribute("erreur");

    String nom = request.getAttribute("nom") != null
            ? (String) request.getAttribute("nom") : "";

    String prenom = request.getAttribute("prenom") != null
            ? (String) request.getAttribute("prenom") : "";

    String dateNaissance = request.getAttribute("date_naissance") != null
            ? (String) request.getAttribute("date_naissance") : "";

    String lieuNaissance = request.getAttribute("lieu_naissance") != null
            ? (String) request.getAttribute("lieu_naissance") : "";

    String sexe = request.getAttribute("sexe") != null
            ? (String) request.getAttribute("sexe") : "";

    String cin = request.getAttribute("cin") != null
            ? (String) request.getAttribute("cin") : "";

    String numeroCopie = request.getAttribute("numero_copie") != null
            ? (String) request.getAttribute("numero_copie") : "";

    String telephone = request.getAttribute("telephone") != null
            ? (String) request.getAttribute("telephone") : "";

    String email = request.getAttribute("email") != null
            ? (String) request.getAttribute("email") : "";

    String adresse = request.getAttribute("adresse") != null
            ? (String) request.getAttribute("adresse") : "";
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Informations du candidat - Inscription</title>

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

        .required {
            color: #dc3545;
        }

        .step {
            display: flex;
            align-items: center;
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

        .contest-box {
            background: #eef5ff;
            border-left: 4px solid #0d6efd;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
    </style>
</head>

<body>

<div class="container page-container">

    <div class="step">
        <div class="step-item active">1. Candidat</div>
        <div class="step-item">2. Dossier</div>
        <div class="step-item">3. Documents</div>
        <div class="step-item">4. Confirmation</div>
    </div>

    <div class="card">

        <div class="card-header">
            <h3 class="mb-1">
                <i data-lucide="user"></i>
                Informations du candidat
            </h3>

            <p class="text-muted mb-0">
                Veuillez renseigner vos informations personnelles.
            </p>
        </div>

        <div class="form-container">

            <% if (concours != null) { %>
                <div class="contest-box">
                    <strong>
                        <i data-lucide="graduation-cap"></i>
                        Concours sélectionné
                    </strong>

                    <div class="mt-2">
                        <%= concours.getId_concours() %>
                    </div>
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

                <input type="hidden" name="action" value="candidat">

                <div class="row g-3">

                    <div class="col-md-6">
                        <label class="form-label">
                            Nom <span class="required">*</span>
                        </label>

                        <input type="text"
                               name="nom"
                               class="form-control"
                               value="<%= nom %>"
                               required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">
                            Prénom <span class="required">*</span>
                        </label>

                        <input type="text"
                               name="prenom"
                               class="form-control"
                               value="<%= prenom %>"
                               required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">
                            Date de naissance <span class="required">*</span>
                        </label>

                        <input type="date"
                               id="date_naissance"
                               name="date_naissance"
                               class="form-control"
                               value="<%= dateNaissance %>"
                               required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">
                            Lieu de naissance <span class="required">*</span>
                        </label>

                        <input type="text"
                               name="lieu_naissance"
                               class="form-control"
                               value="<%= lieuNaissance %>"
                               required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">
                            Sexe <span class="required">*</span>
                        </label>

                        <select name="sexe"
                                class="form-select"
                                required>
                            <option value="">-- Sélectionner --</option>

                            <option value="M"
                                <%= "M".equals(sexe) ? "selected" : "" %>>
                                Masculin
                            </option>

                            <option value="F"
                                <%= "F".equals(sexe) ? "selected" : "" %>>
                                Féminin
                            </option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">
                            Téléphone <span class="required">*</span>
                        </label>

                        <input type="text"
                               name="telephone"
                               class="form-control"
                               placeholder="0321234567"
                               value="<%= telephone %>"
                               required>

                        <small class="text-muted">
                            Exemple : 0321234567
                        </small>
                    </div>

                    <div class="col-12">
                        <label class="form-label">
                            Adresse <span class="required">*</span>
                        </label>

                        <textarea name="adresse"
                                  class="form-control"
                                  rows="2"
                                  required><%= adresse %></textarea>
                    </div>

                    <div class="col-md-6">

                        <label class="form-label">
                            CIN
                        </label>

                        <input type="text"
                               id="cin"
                               name="cin"
                               class="form-control"
                               value="<%= cin %>">

                        <small class="text-muted">
                            Obligatoire pour les candidats majeurs.
                        </small>

                    </div>

                    <div class="col-md-6">

                        <label class="form-label">
                            Numéro de copie
                        </label>

                        <input type="text"
                               id="numero_copie"
                               name="numero_copie"
                               class="form-control"
                               value="<%= numeroCopie %>">

                        <small class="text-muted">
                            Obligatoire pour les candidats mineurs.
                        </small>

                    </div>

                    <div class="col-12">

                        <label class="form-label">
                            Adresse e-mail <span class="required">*</span>
                        </label>

                        <input type="email"
                               name="email"
                               class="form-control"
                               value="<%= email %>"
                               required>

                    </div>

                </div>

                <hr class="my-4">

                <div class="d-flex justify-content-between">

                    <a href="<%= request.getContextPath() %>/InscriptionPubliqueServlet?action=concours"
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

    const dateNaissance = document.getElementById("date_naissance");
    const cin = document.getElementById("cin");
    const numeroCopie = document.getElementById("numero_copie");

    function calculerAge(date) {
        if (!date) return null;

        const naissance = new Date(date);
        const aujourdHui = new Date();

        let age = aujourdHui.getFullYear() - naissance.getFullYear();

        const mois = aujourdHui.getMonth() - naissance.getMonth();

        if (mois < 0 ||
            (mois === 0 && aujourdHui.getDate() < naissance.getDate())) {
            age--;
        }

        return age;
    }

    function actualiserDocumentsIdentite() {

        const age = calculerAge(dateNaissance.value);

        if (age === null) {
            cin.removeAttribute("required");
            numeroCopie.removeAttribute("required");
            return;
        }

        if (age >= 18) {

            cin.setAttribute("required", "required");
            numeroCopie.removeAttribute("required");

        } else {

            numeroCopie.setAttribute("required", "required");
            cin.removeAttribute("required");
        }
    }

    dateNaissance.addEventListener("change", actualiserDocumentsIdentite);

    actualiserDocumentsIdentite();
</script>

</body>
</html>