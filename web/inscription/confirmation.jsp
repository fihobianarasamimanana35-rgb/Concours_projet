<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modele.CandidatModele"%>
<%@page import="modele.ConcoursModele"%>
<%@page import="modele.DossierModele"%>
<%@page import="modele.InscriptionModele"%>

<%
    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    DossierModele dossier =
            (DossierModele) request.getAttribute("dossier");

    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");
%>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Confirmation de l'inscription</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <script src="https://unpkg.com/lucide@latest"></script>

    <style>

        body {
            background: #f5f7fb;
        }

        .page-container {
            max-width: 900px;
            margin: 50px auto;
        }

        .card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 5px 30px rgba(0,0,0,.08);
        }

        .success-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #d1e7dd;
            color: #198754;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success-icon svg {
            width: 42px;
            height: 42px;
        }

        .header {
            text-align: center;
            padding: 40px 30px 25px;
        }

        .content {
            padding: 10px 35px 35px;
        }

        .info-box {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 12px 0;
            border-bottom: 1px solid #dee2e6;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .label {
            color: #6c757d;
        }

        .value {
            font-weight: 600;
            text-align: right;
        }

        .code-box {
            background: #eef5ff;
            border: 1px solid #b6d4fe;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            margin: 25px 0;
        }

        .tracking-code {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 2px;
            color: #0d6efd;
        }

        .status {
            display: inline-block;
            background: #fff3cd;
            color: #664d03;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        @media (max-width: 576px) {

            .page-container {
                margin: 20px auto;
            }

            .content {
                padding: 10px 20px 25px;
            }

            .info-row {
                flex-direction: column;
                gap: 4px;
            }

            .value {
                text-align: left;
            }

        }

    </style>

</head>

<body>

<div class="container page-container">

    <div class="card">

        <div class="header">

            <div class="success-icon">

                <i data-lucide="check-circle"></i>

            </div>

            <h2>

                Inscription enregistrée !

            </h2>

            <p class="text-muted">

                Votre dossier de candidature a été enregistré avec succès.

            </p>

        </div>


        <div class="content">

            <% if (inscription != null) { %>

                <div class="code-box">

                    <div class="text-muted mb-2">

                        Votre numéro d'inscription

                    </div>

                    <div class="tracking-code">

                        <%= inscription.getNumero_inscription() %>

                    </div>

                    <div class="mt-3 text-muted">

                        Conservez précieusement ce numéro.

                    </div>

                </div>


                <div class="code-box">

                    <div class="text-muted mb-2">

                        Code de suivi

                    </div>

                    <div class="tracking-code">

                        <%= inscription.getCode_suivi() %>

                    </div>

                    <div class="mt-3 text-muted">

                        Ce code vous permettra de suivre votre candidature.

                    </div>

                </div>

            <% } %>


            <h5 class="mt-4 mb-3">

                <i data-lucide="user"></i>

                Informations du candidat

            </h5>


            <div class="info-box">

                <% if (candidat != null) { %>

                    <div class="info-row">

                        <span class="label">
                            Nom complet
                        </span>

                        <span class="value">

                            <%= candidat.getNom() %>
                            <%= candidat.getPrenom() %>

                        </span>

                    </div>

                    <div class="info-row">

                        <span class="label">
                            Téléphone
                        </span>

                        <span class="value">

                            <%= candidat.getTelephone() %>

                        </span>

                    </div>

                    <div class="info-row">

                        <span class="label">
                            E-mail
                        </span>

                        <span class="value">

                            <%= candidat.getEmail() %>

                        </span>

                    </div>

                <% } %>

            </div>


            <h5 class="mb-3">

                <i data-lucide="graduation-cap"></i>

                Concours

            </h5>


            <div class="info-box">

                <% if (concours != null) { %>

                    <div class="info-row">

                        <span class="label">
                            Concours
                        </span>

                        <span class="value">

                            <%= concours.getId_concours()%>

                        </span>

                    </div>

                <% } %>


                <% if (inscription != null) { %>

                    <div class="info-row">

                        <span class="label">
                            Statut
                        </span>

                        <span class="value">

                            <span class="status">

                                <%= inscription.getStatut() %>

                            </span>

                        </span>

                    </div>

                <% } %>

            </div>


            <div class="alert alert-success mt-4">

                <i data-lucide="info"></i>

                <strong>Important :</strong>

                Votre dossier est maintenant complet et votre inscription
                est enregistrée. Gardez votre numéro d'inscription et votre
                code de suivi pour vos prochaines démarches.

            </div>
             <div class="text-center mt-4">

    <a
        href="${pageContext.request.contextPath}/InscriptionPubliqueServlet?action=suivi"
        class="btn btn-primary">

        <i data-lucide="search"
           class="me-2"
           style="width:18px;">
        </i>

        Suivre ma candidature

    </a>

</div>

            <div class="text-center mt-4">

                <a href="<%= request.getContextPath() %>/InscriptionPubliqueServlet?action=concours"
                   class="btn btn-primary">

                    <i data-lucide="home"></i>

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