<%-- 
    Document   : login
    Created on : 5 oct. 2026, 14:28:48
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administration | Suivi Concours</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/css/bootstrap.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --background: #f8fafc;
            --card: rgba(255,255,255,.92);
            --border: #e2e8f0;
            --text: #0f172a;
            --muted: #64748b;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background:
                radial-gradient(circle at 10% 10%, rgba(37,99,235,.12), transparent 30%),
                radial-gradient(circle at 90% 90%, rgba(99,102,241,.10), transparent 30%),
                var(--background);
            color: var(--text);
        }

        .login-page {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
        }

        .login-wrapper {
            width: 100%;
            max-width: 1050px;
            min-height: 650px;
            display: grid;
            grid-template-columns: 1.05fr .95fr;
            background: var(--card);
            border: 1px solid rgba(226,232,240,.8);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(15,23,42,.12);
            backdrop-filter: blur(20px);
        }

        .login-brand {
            position: relative;
            overflow: hidden;
            padding: 55px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            color: white;
            background:
                radial-gradient(circle at 85% 15%, rgba(255,255,255,.18), transparent 25%),
                linear-gradient(145deg, #1d4ed8 0%, #2563eb 48%, #4338ca 100%);
        }

        .login-brand::before,
        .login-brand::after {
            content: "";
            position: absolute;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,.12);
        }

        .login-brand::before {
            width: 380px;
            height: 380px;
            right: -170px;
            bottom: -160px;
        }

        .login-brand::after {
            width: 220px;
            height: 220px;
            left: -110px;
            top: 42%;
        }

        .brand-content {
            position: relative;
            z-index: 2;
        }

        .brand-logo {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255,255,255,.16);
            border: 1px solid rgba(255,255,255,.2);
            margin-bottom: 30px;
        }

        .brand-title {
            font-size: clamp(2.2rem, 4vw, 3.6rem);
            line-height: 1.05;
            font-weight: 750;
            letter-spacing: -2px;
            margin-bottom: 20px;
        }

        .brand-description {
            max-width: 430px;
            font-size: 1rem;
            line-height: 1.7;
            color: rgba(255,255,255,.78);
        }

        .brand-features {
            position: relative;
            z-index: 2;
            display: grid;
            gap: 14px;
        }

        .brand-feature {
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255,255,255,.9);
            font-size: .9rem;
        }

        .feature-icon {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 9px;
            background: rgba(255,255,255,.12);
        }

        .login-form-area {
            padding: 55px;
            display: flex;
            align-items: center;
        }

        .login-form {
            width: 100%;
            max-width: 410px;
            margin: auto;
        }

        .form-top {
            margin-bottom: 34px;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 7px 11px;
            border-radius: 999px;
            background: #eff6ff;
            color: var(--primary);
            font-size: .75rem;
            font-weight: 700;
            margin-bottom: 16px;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 750;
            letter-spacing: -1px;
            margin-bottom: 9px;
        }

        .form-subtitle {
            color: var(--muted);
            font-size: .95rem;
        }

        .field {
            margin-bottom: 20px;
        }

        .field-label {
            display: block;
            font-size: .82rem;
            font-weight: 650;
            margin-bottom: 8px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            width: 18px;
            height: 18px;
        }

        .form-control {
            min-height: 52px;
            border-radius: 13px;
            border: 1px solid var(--border);
            padding-left: 46px;
            color: var(--text);
            background: #fff;
            box-shadow: none;
        }

        .form-control:focus {
            border-color: #60a5fa;
            box-shadow: 0 0 0 4px rgba(37,99,235,.10);
        }

        .password-toggle {
            position: absolute;
            right: 13px;
            top: 50%;
            transform: translateY(-50%);
            border: 0;
            background: transparent;
            color: #94a3b8;
        }

        .login-button {
            width: 100%;
            min-height: 52px;
            border: 0;
            border-radius: 13px;
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: white;
            font-weight: 700;
            box-shadow: 0 10px 25px rgba(37,99,235,.22);
            transition: .2s ease;
        }

        .login-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 30px rgba(37,99,235,.28);
        }

        .security-note {
            margin-top: 25px;
            padding: 13px 15px;
            border-radius: 12px;
            background: #f8fafc;
            border: 1px solid #eef2f7;
            color: #64748b;
            font-size: .78rem;
            display: flex;
            align-items: center;
            gap: 9px;
        }

        .alert {
            border-radius: 12px;
            font-size: .85rem;
            border: 0;
        }

        @media (max-width: 850px) {
            .login-wrapper {
                grid-template-columns: 1fr;
                max-width: 520px;
            }

            .login-brand {
                min-height: 330px;
                padding: 35px;
            }

            .brand-features {
                display: none;
            }

            .login-form-area {
                padding: 40px 30px;
            }
        }

        @media (max-width: 480px) {
            .login-page {
                padding: 12px;
            }

            .login-wrapper {
                border-radius: 20px;
            }

            .login-brand {
                padding: 30px 24px;
            }

            .login-form-area {
                padding: 35px 22px;
            }
        }
    </style>
</head>

<body>

<div class="login-page">

    <div class="login-wrapper">

        <section class="login-brand">

            <div class="brand-content">

                <div class="brand-logo">
                    <i data-lucide="shield-check"></i>
                </div>

                <div class="brand-title">
                    Suivi<br>
                    Concours
                </div>

                <p class="brand-description">
                    Plateforme centralisée de gestion, de suivi et de publication
                    des concours de recrutement.
                </p>

            </div>

            <div class="brand-features">

                <div class="brand-feature">
                    <span class="feature-icon">
                        <i data-lucide="layout-dashboard"></i>
                    </span>
                    Administration centralisée
                </div>

                <div class="brand-feature">
                    <span class="feature-icon">
                        <i data-lucide="users"></i>
                    </span>
                    Gestion des candidats
                </div>

                <div class="brand-feature">
                    <span class="feature-icon">
                        <i data-lucide="file-check-2"></i>
                    </span>
                    Suivi automatique des inscriptions
                </div>

            </div>

        </section>

        <section class="login-form-area">

            <form class="login-form"
                  method="post"
                  action="${pageContext.request.contextPath}/AuthentificationServlet">

                <div class="form-top">

                    <div class="eyebrow">
                        <i data-lucide="lock-keyhole" width="14"></i>
                        ESPACE ADMINISTRATION
                    </div>

                    <h1 class="form-title">
                        Bon retour.
                    </h1>

                    <p class="form-subtitle">
                        Connectez-vous pour accéder à votre espace d'administration.
                    </p>

                </div>

                <% if ("error".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger mb-4">
                        Identifiants incorrects. Vérifiez votre adresse e-mail et votre mot de passe.
                    </div>
                <% } %>

                <% if ("access".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-warning mb-4">
                        Vous n'avez pas les droits nécessaires pour accéder à cette page.
                    </div>
                <% } %>

                <div class="field">

                    <label class="field-label" for="email">
                        Adresse e-mail
                    </label>

                    <div class="input-wrapper">

                        <i class="input-icon" data-lucide="mail"></i>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            class="form-control"
                            placeholder="admin@suiviconcours.mg"
                            autocomplete="email"
                            required>

                    </div>

                </div>

                <div class="field">

                    <label class="field-label" for="password">
                        Mot de passe
                    </label>

                    <div class="input-wrapper">

                        <i class="input-icon" data-lucide="key-round"></i>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-control"
                            placeholder="Votre mot de passe"
                            autocomplete="current-password"
                            required>

                        <button
                            type="button"
                            class="password-toggle"
                            id="togglePassword"
                            aria-label="Afficher le mot de passe">

                            <i data-lucide="eye"></i>

                        </button>

                    </div>

                </div>

                <button type="submit" class="login-button">
                    <span>Accéder au tableau de bord</span>
                    <i data-lucide="arrow-right" width="18"></i>
                </button>

                <div class="security-note">
                    <i data-lucide="shield" width="16"></i>
                    Accès réservé aux administrateurs autorisés.
                </div>

            </form>

        </section>

    </div>

</div>

<script src="${pageContext.request.contextPath}/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/lucide.min.js"></script>

<script>
    lucide.createIcons();

    const password = document.getElementById("password");
    const togglePassword = document.getElementById("togglePassword");

    togglePassword.addEventListener("click", function () {
        const isPassword = password.type === "password";
        password.type = isPassword ? "text" : "password";

        togglePassword.innerHTML = isPassword
            ? '<i data-lucide="eye-off"></i>'
            : '<i data-lucide="eye"></i>';

        lucide.createIcons();
    });
</script>

</body>
</html>
