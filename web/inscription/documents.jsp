<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modele.DocumentModele"%>
<%@page import="modele.CandidatModele"%>
<%@page import="modele.ConcoursModele"%>
<%@page import="modele.DossierModele"%>
<%@page import="modele.InscriptionModele"%>

<%
    List<DocumentModele> documents =
            (List<DocumentModele>) request.getAttribute("documents");

    CandidatModele candidat =
            (CandidatModele) request.getAttribute("candidat");

    ConcoursModele concours =
            (ConcoursModele) request.getAttribute("concours");

    DossierModele dossier =
            (DossierModele) request.getAttribute("dossier");

    InscriptionModele inscription =
            (InscriptionModele) request.getAttribute("inscription");

    String erreur = (String) request.getAttribute("erreur");
    String succes = (String) request.getAttribute("succes");


    // ============================================
    // CALCUL DE L'AGE
    // ============================================

    boolean majeur = false;

    if (candidat != null
            && candidat.getDate_naissance() != null
            && !candidat.getDate_naissance().trim().isEmpty()) {

        try {

            java.time.LocalDate naissance =
                    java.time.LocalDate.parse(
                            candidat.getDate_naissance()
                    );

            java.time.LocalDate aujourdHui =
                    java.time.LocalDate.now();

            int age =
                    java.time.Period.between(
                            naissance,
                            aujourdHui
                    ).getYears();

            majeur = age >= 18;

        } catch (Exception e) {

            majeur = false;

        }
    }


    // ============================================
    // DOCUMENTS PRESENTS
    // ============================================

    boolean cinPresent = false;
    boolean copiePresent = false;
    boolean diplomePresent = false;
    boolean photoPresent = false;

    if (documents != null) {

        for (DocumentModele doc : documents) {

            if (doc == null || doc.getType_document() == null) {
                continue;
            }

            switch (doc.getType_document()) {

                case "cin":
                    cinPresent = true;
                    break;

                case "copie":
                    copiePresent = true;
                    break;

                case "diplome_bacc":
                    diplomePresent = true;
                    break;

                case "photo":
                    photoPresent = true;
                    break;
            }
        }
    }

    boolean identitePresente =
            majeur ? cinPresent : copiePresent;

    boolean dossierComplet =
            identitePresente
            && diplomePresent
            && photoPresent;
%>
<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Documents - Inscription</title>

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

        .content {
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

        .document-card {
            border: 1px solid #dee2e6;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            background: white;
        }

        .document-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .status-ok {
            color: #198754;
            font-weight: 600;
        }

        .status-missing {
            color: #dc3545;
            font-weight: 600;
        }

        .required {
            color: #dc3545;
        }

        .info-box {
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

        <div class="step-item">
            1. Candidat
        </div>

        <div class="step-item">
            2. Dossier
        </div>

        <div class="step-item active">
            3. Documents
        </div>

        <div class="step-item">
            4. Confirmation
        </div>

    </div>

    <div class="card">

        <div class="card-header">

            <h3 class="mb-1">

                <i data-lucide="file-check"></i>

                Documents justificatifs

            </h3>

            <p class="text-muted mb-0">

                Déposez les documents nécessaires à votre inscription.

            </p>

        </div>

        <div class="content">

            <% if (concours != null) { %>

                <div class="info-box">

                    <strong>Concours :</strong>

                    <%= concours.getNom() %>

                    <% if (candidat != null) { %>

                        <br>

                        <strong>Candidat :</strong>

                        <%= candidat.getNom() %>
                        <%= candidat.getPrenom() %>

                    <% } %>

                </div>

            <% } %>


            <% if (erreur != null && !erreur.trim().isEmpty()) { %>

                <div class="alert alert-danger">

                    <i data-lucide="alert-circle"></i>

                    <%= erreur %>

                </div>

            <% } %>


            <% if (succes != null && !succes.trim().isEmpty()) { %>

                <div class="alert alert-success">

                    <i data-lucide="check-circle"></i>

                    <%= succes %>

                </div>

            <% } %>


            <!-- DOCUMENT IDENTITE -->

            <div class="document-card">

                <div class="document-header">

                    <div>

                        <h5 class="mb-1">

                            <i data-lucide="contact"></i>

                            <%= majeur ? "Carte d'identité nationale (CIN)"
                                       : "Copie / acte de naissance" %>

                            <span class="required">*</span>

                        </h5>

                        <small class="text-muted">

                            <%= majeur
                                    ? "Document obligatoire pour un candidat majeur."
                                    : "Document obligatoire pour un candidat mineur." %>

                        </small>

                    </div>

                    <div>

                        <% if (identitePresente) { %>

                            <span class="status-ok">

                                <i data-lucide="check-circle"></i>
                                Déposé

                            </span>

                        <% } else { %>

                            <span class="status-missing">

                                <i data-lucide="circle-alert"></i>
                                Manquant

                            </span>

                        <% } %>

                    </div>

                </div>


                <% if (majeur) { %>

                    <form action="<%= request.getContextPath() %>/InscriptionPubliqueServlet"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden"
                               name="action"
                               value="document">

                        <input type="hidden"
                               name="type_document"
                               value="cin">

                        <div class="mb-3">

                            <input type="file"
                                   name="cin"
                                   class="form-control"
                                   accept=".pdf,.jpg,.jpeg,.png"
                                   required>

                        </div>

                        <button type="submit"
                                class="btn btn-primary">

                            <i data-lucide="upload"></i>

                            <%= cinPresent ? "Remplacer le CIN" : "Déposer le CIN" %>

                        </button>

                    </form>

                <% } else { %>

                    <form action="<%= request.getContextPath() %>/InscriptionPubliqueServlet"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden"
                               name="action"
                               value="document">

                        <input type="hidden"
                               name="type_document"
                               value="copie">

                        <div class="mb-3">

                            <input type="file"
                                   name="copie"
                                   class="form-control"
                                   accept=".pdf,.jpg,.jpeg,.png"
                                   required>

                        </div>

                        <button type="submit"
                                class="btn btn-primary">

                            <i data-lucide="upload"></i>

                            <%= copiePresent ? "Remplacer le document"
                                              : "Déposer le document" %>

                        </button>

                    </form>

                <% } %>

            </div>


            <!-- DIPLOME -->

            <div class="document-card">

                <div class="document-header">

                    <div>

                        <h5 class="mb-1">

                            <i data-lucide="graduation-cap"></i>

                            Diplôme / Baccalauréat

                            <span class="required">*</span>

                        </h5>

                        <small class="text-muted">

                            Document justificatif du diplôme déclaré.

                        </small>

                    </div>

                    <div>

                        <% if (diplomePresent) { %>

                            <span class="status-ok">

                                <i data-lucide="check-circle"></i>
                                Déposé

                            </span>

                        <% } else { %>

                            <span class="status-missing">

                                <i data-lucide="circle-alert"></i>
                                Manquant

                            </span>

                        <% } %>

                    </div>

                </div>


                <form action="<%= request.getContextPath() %>/InscriptionPubliqueServlet"
                      method="post"
                      enctype="multipart/form-data">

                    <input type="hidden"
                           name="action"
                           value="document">

                    <input type="hidden"
                           name="type_document"
                           value="diplome_bacc">

                    <div class="mb-3">

                        <input type="file"
                               name="diplome_bacc"
                               class="form-control"
                               accept=".pdf,.jpg,.jpeg,.png"
                               required>

                    </div>

                    <button type="submit"
                            class="btn btn-primary">

                        <i data-lucide="upload"></i>

                        <%= diplomePresent
                                ? "Remplacer le diplôme"
                                : "Déposer le diplôme" %>

                    </button>

                </form>

            </div>


            <!-- PHOTO -->

            <div class="document-card">

                <div class="document-header">

                    <div>

                        <h5 class="mb-1">

                            <i data-lucide="image"></i>

                            Photo d'identité

                            <span class="required">*</span>

                        </h5>

                        <small class="text-muted">

                            Photo récente du candidat.

                        </small>

                    </div>

                    <div>

                        <% if (photoPresent) { %>

                            <span class="status-ok">

                                <i data-lucide="check-circle"></i>
                                Déposée

                            </span>

                        <% } else { %>

                            <span class="status-missing">

                                <i data-lucide="circle-alert"></i>
                                Manquante

                            </span>

                        <% } %>

                    </div>

                </div>


                <form action="<%= request.getContextPath() %>/InscriptionPubliqueServlet"
                      method="post"
                      enctype="multipart/form-data">

                    <input type="hidden"
                           name="action"
                           value="document">

                    <input type="hidden"
                           name="type_document"
                           value="photo">

                    <div class="mb-3">

                        <input type="file"
                               name="photo"
                               class="form-control"
                               accept=".jpg,.jpeg,.png"
                               required>

                    </div>

                    <button type="submit"
                            class="btn btn-primary">

                        <i data-lucide="upload"></i>

                        <%= photoPresent
                                ? "Remplacer la photo"
                                : "Déposer la photo" %>

                    </button>

                </form>

            </div>


            <hr class="my-4">


            <!-- RESUME -->

            <div class="alert <%= dossierComplet
                    ? "alert-success"
                    : "alert-warning" %>">

                <% if (dossierComplet) { %>

                    <i data-lucide="check-circle"></i>

                    <strong>Dossier complet.</strong>

                    Tous les documents obligatoires sont présents.
                    Vous pouvez maintenant valider votre inscription.

                <% } else { %>

                    <i data-lucide="triangle-alert"></i>

                    <strong>Dossier incomplet.</strong>

                    Veuillez déposer tous les documents obligatoires
                    avant de valider votre inscription.

                <% } %>

            </div>


            <div class="d-flex justify-content-between">

                <a href="<%= request.getContextPath() %>/InscriptionPubliqueServlet?action=dossier"
                   class="btn btn-outline-secondary">

                    <i data-lucide="arrow-left"></i>

                    Retour au dossier

                </a>


                <form action="<%= request.getContextPath() %>/InscriptionPubliqueServlet"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="valider">

                    <button type="submit"
                            class="btn btn-success"
                            <%= dossierComplet ? "" : "disabled" %>>

                        <i data-lucide="check"></i>

                        Valider mon dossier

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

<script>
    lucide.createIcons();
</script>

</body>

</html>