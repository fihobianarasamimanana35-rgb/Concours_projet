<%-- 
    Document   : suivi
    Created on : 8 oct. 2026, 11:37:07
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modele.InscriptionModele" %>
<%@ page import="modele.CandidatModele" %>
<%@ page import="modele.ConcoursModele" %>

<%
    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");

    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    String erreur =
            (String) request.getAttribute("erreur");

    String codeSuivi =
            (String) request.getAttribute("code_suivi");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Suivi de candidature</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <script src="https://unpkg.com/lucide@latest"></script>

    <style>

        body {
            background: #f8f9fa;
        }

        .page-container {
            max-width: 850px;
            margin: 60px auto;
        }

        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .header-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: #e7f1ff;
            color: #0d6efd;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .header-icon i {
            width: 34px;
            height: 34px;
        }

        .code-box {
            background: #f8f9fa;
            border: 1px dashed #adb5bd;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .status-box {
            border-radius: 12px;
            padding: 20px;
            background: #f8f9fa;
        }

        .info-label {
            color: #6c757d;
            font-size: 14px;
        }

        .info-value {
            font-weight: 600;
            margin-bottom: 15px;
        }

    </style>

</head>

<body>

<div class="container page-container">

    <div class="card">

        <div class="card-body p-4 p-md-5">

            <!-- TITRE -->

            <div class="text-center mb-4">

                <div class="header-icon">

                    <i data-lucide="search"></i>

                </div>

                <h2 class="fw-bold">
                    Suivre ma candidature
                </h2>

                <p class="text-muted">
                    Entrez votre code de suivi pour consulter
                    l'état de votre candidature.
                </p>

            </div>


            <!-- FORMULAIRE -->

            <form
                method="post"
                action="${pageContext.request.contextPath}/InscriptionPubliqueServlet">

                <input type="hidden"
                       name="action"
                       value="suivi">

                <div class="mb-3">

                    <label for="code_suivi"
                           class="form-label fw-semibold">

                        Code de suivi

                    </label>

                    <input
                        type="text"
                        class="form-control form-control-lg"
                        id="code_suivi"
                        name="code_suivi"
                        value="<%= codeSuivi != null ? codeSuivi : "" %>"
                        placeholder="Exemple : ABC123XYZ"
                        required>

                </div>

                <% if (erreur != null) { %>

                    <div class="alert alert-danger">

                        <i data-lucide="circle-alert"
                           class="me-2"
                           style="width:18px;">
                        </i>

                        <%= erreur %>

                    </div>

                <% } %>

                <div class="d-grid">

                    <button type="submit"
                            class="btn btn-primary btn-lg">

                        <i data-lucide="search"
                           class="me-2"
                           style="width:20px;">
                        </i>

                        Rechercher ma candidature

                    </button>

                </div>

            </form>


            <% if (inscription != null) { %>

                <hr class="my-5">


                <!-- RESULTAT -->

                <div class="mb-4">

                    <h4 class="fw-bold mb-3">

                        <i data-lucide="file-check-2"
                           class="me-2 text-primary">
                        </i>

                        Résultat du suivi

                    </h4>

                </div>


                <!-- CODE -->

                <div class="mb-4">

                    <div class="info-label mb-2">
                        Code de suivi
                    </div>

                    <div class="code-box">

                        <%= inscription.getCode_suivi() %>

                    </div>

                </div>


                <!-- CANDIDAT -->

                <% if (candidat != null) { %>

                    <div class="row">

                        <div class="col-md-6">

                            <div class="info-label">
                                Nom
                            </div>

                            <div class="info-value">
                                <%= candidat.getNom() %>
                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="info-label">
                                Prénom
                            </div>

                            <div class="info-value">
                                <%= candidat.getPrenom() %>
                            </div>

                        </div>

                    </div>

                <% } %>


                <!-- CONCOURS -->

                <% if (concours != null) { %>

                    <div class="mb-3">

                        <div class="info-label">
                            Concours
                        </div>

                        <div class="info-value">
                            <%= concours.getNom()%>
                        </div>

                    </div>

                <% } %>


                <!-- NUMERO INSCRIPTION -->

                <div class="mb-3">

                    <div class="info-label">
                        Numéro d'inscription
                    </div>

                    <div class="info-value">
                        <%= inscription.getNumero_inscription() %>
                    </div>

                </div>


                <!-- DATE -->

                <div class="mb-4">

                    <div class="info-label">
                        Date d'inscription
                    </div>

                    <div class="info-value">
                        <%= inscription.getDate_inscription() %>
                    </div>

                </div>


                <!-- STATUT -->

                <div class="status-box">

                    <div class="info-label mb-2">
                        État de votre candidature
                    </div>

                    <h5 class="mb-0">

                        <%
                            String statut = inscription.getStatut();

                            if (statut == null) {
                                statut = "Inconnu";
                            }
                        %>

                        <%= statut %>

                    </h5>

                </div>

            <% } %>


            <!-- RETOUR -->

            <div class="text-center mt-4">

                <a
                    href="${pageContext.request.contextPath}/InscriptionPubliqueServlet?action=concours"
                    class="btn btn-outline-secondary">

                    <i data-lucide="arrow-left"
                       class="me-2"
                       style="width:18px;">
                    </i>

                    Retour aux concours

                </a>

            </div>

        </div>

    </div>

</div>


<script>

    lucide.createIcons();

</script>

</body>

</html>
